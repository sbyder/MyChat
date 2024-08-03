// 接收拼接params的路径,返回实际路径和params数据
// 如: parseRouterPathAndParams("pages/routerPages/loginPage?title=登陆")
// 返回{routerpath: "pages/routerPages/loginPage", routerparams:{title:"登陆"}}

export function parseRouterPathAndParams(url:string) {
  const [routerpath, routerParamsString] = url.split('?');
  const routerparams = {};

  if (routerParamsString) {
    const paramsArray = routerParamsString.split('&');
    paramsArray.forEach(param => {
      const [key, value] = param.split('=');
      if (key && value) {
        routerparams[key] = decodeURIComponent(value);
      }
    });
  }

  return {
    routerpath,
    routerparams
  };
}