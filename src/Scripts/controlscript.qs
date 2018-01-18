//特殊文字列の取得結果を確認するスクリプト
//
// 例
// > setup -v --script controlscript.qs


//コンストラクタ（必須）
function Controller()
{
  console.log("ProductName:" + installer.value("ProductName"))
  console.log("ProductVersion:" + installer.value("ProductVersion"))
  console.log("Title:" + installer.value("Title"))
  console.log("Publisher:" + installer.value("Publisher"))
  console.log("Url:" + installer.value("Url"))
  console.log("StartMenuDir:" + installer.value("StartMenuDir"))
  console.log("TargetDir:" + installer.value("TargetDir"))
  console.log("DesktopDir:" + installer.value("DesktopDir"))
  console.log("os:" + installer.value("os"))
  console.log("RootDir:" + installer.value("RootDir"))
  console.log("HomeDir:" + installer.value("HomeDir"))
  console.log("ApplicationsDir:" + installer.value("ApplicationsDir"))
  console.log("ApplicationsDirX86:" + installer.value("ApplicationsDirX86"))
  console.log("ApplicationsDirX64:" + installer.value("ApplicationsDirX64"))
  console.log("InstallerDirPath:" + installer.value("InstallerDirPath"))
  console.log("InstallerFilePath:" + installer.value("InstallerFilePath"))
  console.log("UserStartMenuProgramsPath:" + installer.value("UserStartMenuProgramsPath"))
  console.log("AllUsersStartMenuProgramsPath:" + installer.value("AllUsersStartMenuProgramsPath"))
}
