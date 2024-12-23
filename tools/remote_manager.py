import requests
from steward_utils import OmniToolResult

class RemoteToolManager:
    '''
    RemoteToolManager is a tool manager that can call tools on a remote server, which can provide more flexibility and scalability.
    '''
    def __init__(self, tool_api_url:str, access_token:str):
        self.tool_api_url = tool_api_url
        self.access_token = access_token
        self.kwargs = {"access_token": self.access_token}
        self._initialized = False
        self.timeout = 10

    @property
    def tool_names(self):
        if not self._initialized:
            self.initialize()
        return self._tool_names

    def initialize(self):
        response = requests.post(f"{self.tool_api_url}", json={"action_type":"json", **self.kwargs}, timeout=self.timeout)
        self._json = response.json()
        response = requests.post(f"{self.tool_api_url}", json={"action_type":"list", **self.kwargs}, timeout=self.timeout)
        self._tool_names = response.json()
        self._initialized = True

    def call(self, tool_name:str, params:dict):
        response = requests.post(f"{self.tool_api_url}", json={"tool_name": tool_name, "tool_params": params, "action_type":"call", **self.kwargs}, timeout=self.timeout)
        call_res = response.json()
        if isinstance(call_res, dict) and call_res.get("is_tool_result"):
            return OmniToolResult(**call_res)
        else:
            return call_res
    
    def json(self):
        if not self._initialized:
            self.initialize()
        return self._json