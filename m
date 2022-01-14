Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3FD48E9A2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 13:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240955AbiANMGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 07:06:49 -0500
Received: from mga06.intel.com ([134.134.136.31]:27871 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234308AbiANMGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 07:06:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642162007; x=1673698007;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ZIUhOU6Sid5WCVgLjNUyWgAAMX091A50+A0U4vTzbbE=;
  b=PJt8IeUgQzmA5+M+dkO+MZ1DxDa/b9tFaTsdPTefowU54CUXkDfN+Mpy
   RsxDqtXSP7ajT/mQWZk9qSGGP5JD2MV0kWC7/2T99i9TO9WcUWvB3Z1lt
   ouBNIfPJaDr+Mu8TvJkglY4C6zlqiieDxLQfGkEyZu5Yoe/yGQAu7AlVN
   0dMaNFU+Wwpk9vk7xY/3SsdaPStCn1dxuFHE8magnOXs6KvuR10/J+Y7k
   JpVhbczxXoe4diQ0CMk9k+xPT+Oql6EC7hHoV8bXpe8GdoPBOdtCbJ4St
   bnaZTwSt+qh8dRU3UKgOaX5zE8QyShhsD+CZICj6qG6vt0fgdCntuz3Nz
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="304965316"
X-IronPort-AV: E=Sophos;i="5.88,288,1635231600"; 
   d="scan'208";a="304965316"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 04:06:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,288,1635231600"; 
   d="scan'208";a="624307278"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 14 Jan 2022 04:06:45 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8LLw-0008V5-PX; Fri, 14 Jan 2022 12:06:44 +0000
Date:   Fri, 14 Jan 2022 20:06:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yuntao Wang <ytcoode@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, 0day robot <lkp@intel.com>
Subject: kernel/trace/trace_dynevent.c:258:17: warning: unused variable
 'entry'
Message-ID: <202201142023.gC8Ssh5U-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/0day-ci/linux/commits/UPDATE-20220114-091212/Yun=
tao-Wang/tracing-Use-trace_create_file-to-simplify-creation-of-tracefs-entr=
y/20220114-002617
head:   a6d78c971730a1847fa557309f42851ca421b71c
commit: a6d78c971730a1847fa557309f42851ca421b71c tracing: Use trace_create_=
file() to simplify creation of tracefs entries
date:   11 hours ago
config: mips-randconfig-r015-20220113 (https://download.01.org/0day-ci/arch=
ive/20220114/202201142023.gC8Ssh5U-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 82c8ac=
a93488730ce8f66101e0f3538f14b551dd)
reproduce (this is a W=3D1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/=
make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/0day-ci/linux/commit/a6d78c971730a1847fa557309=
f42851ca421b71c
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review UPDATE-20220114-091212/Yuntao-Wang=
/tracing-Use-trace_create_file-to-simplify-creation-of-tracefs-entry/202201=
14-002617
        git checkout a6d78c971730a1847fa557309f42851ca421b71c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=3D=
1 O=3Dbuild_dir ARCH=3Dmips SHELL=3D/bin/bash kernel/trace/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/trace/trace_dynevent.c:258:17: warning: unused variable 'entry'
   struct dentry
   ^
   fatal error: error in backend: Nested variants found in inline asm strin=
g: ' .set push
   .set mips64r2
   .if ( 0x00 ) !=3D -1)) 0x00 ) !=3D -1)) : ($( static struct ftrace_branc=
h_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_=
branch"))) __if_trace =3D $( .func =3D __func__, .file =3D "arch/mips/inclu=
de/asm/atomic.h", .line =3D 156, $); 0x00 ) !=3D -1)) : $))) ) && ( 0 ); .s=
et push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif
   1: ll $0, $1 # atomic_add
   addu $0, $2
   sc $0, $1
   beqz $0, 1b
   .set pop
   '
   PLEASE submit a bug report to https://github.com/llvm/llvm-project/issue=
s/ and include the crash backtrace, preprocessed source, and associated run=
 script.
   Stack dump:
   0. Program arguments: clang -Wp,-MMD,kernel/trace/.trace_dynevent.o.d -n=
ostdinc -Iarch/mips/include -I./arch/mips/include/generated -Iinclude -I./i=
nclude -Iarch/mips/include/uapi -I./arch/mips/include/generated/uapi -Iincl=
ude/uapi -I./include/generated/uapi -include include/linux/compiler-version=
=2Eh -include include/linux/kconfig.h -include include/linux/compiler_types=
=2Eh -D__KERNEL__ -DVMLINUX_LOAD_ADDRESS=3D0xffffffff84000000 -DLINKER_LOAD=
_ADDRESS=3D0x84000000 -DDATAOFFSET=3D0 -Qunused-arguments -fmacro-prefix-ma=
p=3D=3D -DKBUILD_EXTRA_WARN1 -Wall -Wundef -Werror=3Dstrict-prototypes -Wno=
-trigraphs -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE -Werror=
=3Dimplicit-function-declaration -Werror=3Dimplicit-int -Werror=3Dreturn-ty=
pe -Wno-format-security -std=3Dgnu89 --target=3Dmipsel-linux -fintegrated-a=
s -Werror=3Dunknown-warning-option -Werror=3Dignored-optimization-argument =
-mno-check-zero-division -mabi=3D32 -G 0 -mno-abicalls -fno-pic -pipe -msof=
t-float -DGAS_HAS_SET_HARDFLOAT -Wa,-msoft-float -ffreestanding -EL -fno-st=
ack-check -march=3Dmips32 -Wa,--trap -DTOOLCHAIN_SUPPORTS_VIRT -Iarch/mips/=
include/asm/mach-db1x00 -Iarch/mips/include/asm/mach-au1x00 -Iarch/mips/inc=
lude/asm/mach-generic -fno-asynchronous-unwind-tables -fno-delete-null-poin=
ter-checks -Wno-frame-address -Wno-address-of-packed-member -O2 -Wframe-lar=
ger-than=3D1024 -fstack-protector -Wimplicit-fallthrough -Wno-gnu -mno-glob=
al-merge -Wno-unused-but-set-variable -Wno-unused-const-variable -fomit-fra=
me-pointer -fno-stack-clash-protection -falign-functions=3D64 -Wdeclaration=
-after-statement -Wvla -Wno-pointer-sign -Wno-array-bounds -fno-strict-over=
flow -fno-stack-check -Werror=3Ddate-time -Werror=3Dincompatible-pointer-ty=
pes -Wextra -Wunused -Wno-unused-parameter -Wmissing-declarations -Wmissing=
-format-attribute -Wmissing-prototypes -Wold-style-definition -Wmissing-inc=
lude-dirs -Wunused-but-set-variable -Wunused-const-variable -Wno-missing-fi=
eld-initializers -Wno-sign-compare -Wno-type-limits -I kernel/trace -I ./ke=
rnel/trace -ffunction-sections -fdata-sections -DKBUILD_MODFILE=3D"kernel/t=
race/trace_dynevent" -DKBUILD_BASENAME=3D"trace_dynevent" -DKBUILD_MODNAME=
=3D"trace_dynevent" -D__KBUILD_MODNAME=3Dkmod_trace_dynevent -c -o kernel/t=
race/trace_dynevent.o kernel/trace/trace_dynevent.c
   1. <eof> parser at end of file
   2. Code generation
   3. Running pass 'Function Pass Manager' on module 'kernel/trace/trace_dy=
nevent.c'.
   4. Running pass 'Mips Assembly Printer' on function '@trace_event_dyn_tr=
y_get_ref'
   #0 0x000055d9791aa5cf Signals.cpp:0:0
   #1 0x000055d9791a84ac llvm::sys::CleanupOnSignal(unsigned long) (/opt/cr=
oss/clang-82c8aca934/bin/clang-14+0x340f4ac)
   #2 0x000055d9790ec337 llvm::CrashRecoveryContext::HandleExit(int) (/opt/=
cross/clang-82c8aca934/bin/clang-14+0x3353337)
   #3 0x000055d9791a0b5e llvm::sys::Process::Exit(int, bool) (/opt/cross/cl=
ang-82c8aca934/bin/clang-14+0x3407b5e)
   #4 0x000055d976e1e8bb (/opt/cross/clang-82c8aca934/bin/clang-14+0x10858b=
b)
   #5 0x000055d9790f2dec llvm::report_fatal_error(llvm::Twine const&, bool)=
 (/opt/cross/clang-82c8aca934/bin/clang-14+0x3359dec)
   #6 0x000055d979dcfd57 llvm::AsmPrinter::emitInlineAsm(llvm::MachineInstr=
 const (/opt/cross/clang-82c8aca934/bin/clang-14+0x4036d57)
   #7 0x000055d979dcbcb4 llvm::AsmPrinter::emitFunctionBody() (/opt/cross/c=
lang-82c8aca934/bin/clang-14+0x4032cb4)
   #8 0x000055d97787af17 llvm::MipsAsmPrinter::runOnMachineFunction(llvm::M=
achineFunction&) (/opt/cross/clang-82c8aca934/bin/clang-14+0x1ae1f17)
   #9 0x000055d97851b91d llvm::MachineFunctionPass::runOnFunction(llvm::Fun=
ction&) (.part.53) MachineFunctionPass.cpp:0:0
   #10 0x000055d9789542f7 llvm::FPPassManager::runOnFunction(llvm::Function=
&) (/opt/cross/clang-82c8aca934/bin/clang-14+0x2bbb2f7)
   #11 0x000055d978954471 llvm::FPPassManager::runOnModule(llvm::Module&) (=
/opt/cross/clang-82c8aca934/bin/clang-14+0x2bbb471)
   #12 0x000055d97895574f llvm::legacy::PassManagerImpl::run(llvm::Module&)=
 (/opt/cross/clang-82c8aca934/bin/clang-14+0x2bbc74f)
   #13 0x000055d9794b999a clang::EmitBackendOutput(clang::DiagnosticsEngine=
&, clang::HeaderSearchOptions const&, clang::CodeGenOptions const&, clang::=
TargetOptions const&, clang::LangOptions const&, llvm::StringRef, clang::Ba=
ckendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<l=
lvm::raw_pwrite_stream> >) (/opt/cross/clang-82c8aca934/bin/clang-14+0x3720=
99a)
   #14 0x000055d97a0e43e3 clang::BackendConsumer::HandleTranslationUnit(cla=
ng::ASTContext&) (/opt/cross/clang-82c8aca934/bin/clang-14+0x434b3e3)
   #15 0x000055d97abe8789 clang::ParseAST(clang::Sema&, bool, bool) (/opt/c=
ross/clang-82c8aca934/bin/clang-14+0x4e4f789)
   #16 0x000055d97a0e323f clang::CodeGenAction::ExecuteAction() (/opt/cross=
/clang-82c8aca934/bin/clang-14+0x434a23f)
   #17 0x000055d979ae6c91 clang::FrontendAction::Execute() (/opt/cross/clan=
g-82c8aca934/bin/clang-14+0x3d4dc91)
   #18 0x000055d979a7e7ba clang::CompilerInstance::ExecuteAction(clang::Fro=
ntendAction&) (/opt/cross/clang-82c8aca934/bin/clang-14+0x3ce57ba)
   #19 0x000055d979baad8b (/opt/cross/clang-82c8aca934/bin/clang-14+0x3e11d=
8b)
   #20 0x000055d976e1f604 cc1_main(llvm::ArrayRef<char char (/opt/cross/cla=
ng-82c8aca934/bin/clang-14+0x1086604)
   #21 0x000055d976e1cb4b ExecuteCC1Tool(llvm::SmallVectorImpl<char driver.=
cpp:0:0
   #22 0x000055d97991a8d5 void llvm::function_ref<void ()>::callback_fn<cla=
ng::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::StringR=
ef> >, std::__cxx11::basic_string<char, std::char_traits<char>, std::alloca=
tor<char> const::'lambda'()>(long) Job.cpp:0:0
   #23 0x000055d9790ec1f3 llvm::CrashRecoveryContext::RunSafely(llvm::funct=
ion_ref<void ()>) (/opt/cross/clang-82c8aca934/bin/clang-14+0x33531f3)
   #24 0x000055d97991b1ce clang::driver::CC1Command::Execute(llvm::ArrayRef=
<llvm::Optional<llvm::StringRef> >, std::__cxx11::basic_string<char, std::c=
har_traits<char>, std::allocator<char> const (.part.216) Job.cpp:0:0
   #25 0x000055d9798f19f7 clang::driver::Compilation::ExecuteCommand(clang:=
:driver::Command const&, clang::driver::Command const (/opt/cross/clang-82c=
8aca934/bin/clang-14+0x3b589f7)
   #26 0x000055d9798f23d7 clang::driver::Compilation::ExecuteJobs(clang::dr=
iver::JobList const&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) const (/opt/cross/clang-82c8aca934/bin/clang-14+0x3b593d7)
   #27 0x000055d9798fbd19 clang::driver::Driver::ExecuteCompilation(clang::=
driver::Compilation&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) (/opt/cross/clang-82c8aca934/bin/clang-14+0x3b62d19)
   #28 0x000055d976d470df main (/opt/cross/clang-82c8aca934/bin/clang-14+0x=
fae0df)
   #29 0x00007f98e437cd0a __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x26d0a)
   #30 0x000055d976e1c66a _start (/opt/cross/clang-82c8aca934/bin/clang-14+=
0x108366a)
   clang-14: error: clang frontend command failed with exit code 70 (use -v=
 to see invocation)
   clang version 14.0.0 (git://gitmirror/llvm_project 82c8aca93488730ce8f66=
101e0f3538f14b551dd)
   Target: mipsel-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-82c8aca934/bin
   clang-14: note: diagnostic msg:
   Makefile arch include kernel nr_bisected scripts source usr


vim +/entry +258 kernel/trace/trace_dynevent.c

5448d44c38557f Masami Hiramatsu 2018-11-05  254 =20
5448d44c38557f Masami Hiramatsu 2018-11-05  255  /* Make a tracefs interfac=
e for controlling dynamic events */
5448d44c38557f Masami Hiramatsu 2018-11-05  256  static __init int init_dyn=
amic_event(void)
5448d44c38557f Masami Hiramatsu 2018-11-05  257  {
5448d44c38557f Masami Hiramatsu 2018-11-05 @258  	struct dentry *entry;
22c36b18263426 Wei Yang         2020-07-12  259  	int ret;
5448d44c38557f Masami Hiramatsu 2018-11-05  260 =20
22c36b18263426 Wei Yang         2020-07-12  261  	ret =3D tracing_init_dent=
ry();
22c36b18263426 Wei Yang         2020-07-12  262  	if (ret)
5448d44c38557f Masami Hiramatsu 2018-11-05  263  		return 0;
5448d44c38557f Masami Hiramatsu 2018-11-05  264 =20
a6d78c971730a1 Yuntao Wang      2022-01-14  265  	trace_create_file("dynami=
c_events", TRACE_MODE_WRITE, NULL,
5448d44c38557f Masami Hiramatsu 2018-11-05  266  			  NULL, &dynamic_events=
_ops);
5448d44c38557f Masami Hiramatsu 2018-11-05  267 =20
5448d44c38557f Masami Hiramatsu 2018-11-05  268  	return 0;
5448d44c38557f Masami Hiramatsu 2018-11-05  269  }
5448d44c38557f Masami Hiramatsu 2018-11-05  270  fs_initcall(init_dynamic_e=
vent);
86c5426baddae9 Tom Zanussi      2020-01-29  271 =20

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
