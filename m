Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28DA502E55
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 19:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243446AbiDORiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 13:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242834AbiDORh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 13:37:58 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B43856227
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 10:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650044128; x=1681580128;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=EMqivfg9xpNKZGkOLhRQmmtDxJn1awCaP9k6wtINBes=;
  b=F+48JkqDwFWdpHpltNl+HGOx6wyer5dpT86q7F6L7m6Uzgx8kmNAaa9q
   DcAKujeqnn5fSBTqHK5MwkBUnXN6trU3yGL1nk4dk5kLoDUUFC3X55uqt
   thDrPPYbOiIOgY5XKj6In9YSuUCZdBeiakmC32t+y533mhAPKFJyj3qi3
   M8shFdZixk1o5GaT5d2IYQiWhxNpjU6zpjxVZegFjKgByvJo0iVC3+sFI
   mSeBjUxaOfP53Vx1/ECjuC13DQdmhTucncA7Xhg1kw8Cp+AJK+4G0vOwB
   ylJq6By9f/xlFevZKWfsDxuVvpOu6uyCzb0Am0kUCDJ/oyPNni0V31aAX
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="263373582"
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="263373582"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 10:35:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="591699664"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 15 Apr 2022 10:35:26 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfPqv-0002EN-EH;
        Fri, 15 Apr 2022 17:35:25 +0000
Date:   Sat, 16 Apr 2022 01:35:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wei Xiao <xiaowei66@huawei.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [mcgrof:sysctl-testing 18/18] kernel/trace/ftrace.c:3068:13:
 warning: unused function 'ftrace_startup_sysctl'
Message-ID: <202204160113.5Pvywod8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git sy=
sctl-testing
head:   7cde53da38a3ea00d75ef6a6ab06fa85b80bcf87
commit: 7cde53da38a3ea00d75ef6a6ab06fa85b80bcf87 [18/18] ftrace: move sysct=
l_ftrace_enabled to ftrace.c
config: mips-randconfig-c004-20220414 (https://download.01.org/0day-ci/arch=
ive/20220416/202204160113.5Pvywod8-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6b7e6e=
a489f6dd45a9b0da9ac20871560917b9b0)
reproduce (this is a W=3D1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/=
make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/=
commit/?id=3D7cde53da38a3ea00d75ef6a6ab06fa85b80bcf87
        git remote add mcgrof https://git.kernel.org/pub/scm/linux/kernel/g=
it/mcgrof/linux.git
        git fetch --no-tags mcgrof sysctl-testing
        git checkout 7cde53da38a3ea00d75ef6a6ab06fa85b80bcf87
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=3D=
1 O=3Dbuild_dir ARCH=3Dmips SHELL=3D/bin/bash kernel/trace/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/trace/ftrace.c:297:5: warning: no previous prototype for function=
 '__register_ftrace_function'
   int __register_ftrace_function(struct ftrace_ops
   ^
   kernel/trace/ftrace.c:297:1: note: declare 'static' if the function is n=
ot intended to be used outside of this translation unit
   int __register_ftrace_function(struct ftrace_ops
   ^
   static
   kernel/trace/ftrace.c:340:5: warning: no previous prototype for function=
 '__unregister_ftrace_function'
   int __unregister_ftrace_function(struct ftrace_ops
   ^
   kernel/trace/ftrace.c:340:1: note: declare 'static' if the function is n=
ot intended to be used outside of this translation unit
   int __unregister_ftrace_function(struct ftrace_ops
   ^
   static
   kernel/trace/ftrace.c:3922:15: warning: no previous prototype for functi=
on 'arch_ftrace_match_adjust'
   char Makefile arch certs crypto drivers fs include init ipc kernel lib m=
m net scripts security sound source usr virt __weak arch_ftrace_match_adjus=
t(char const char
   ^
   kernel/trace/ftrace.c:3922:1: note: declare 'static' if the function is =
not intended to be used outside of this translation unit
   char Makefile arch certs crypto drivers fs include init ipc kernel lib m=
m net scripts security sound source usr virt __weak arch_ftrace_match_adjus=
t(char const char
   ^
   static
>> kernel/trace/ftrace.c:3068:13: warning: unused function 'ftrace_startup_=
sysctl'
   static void ftrace_startup_sysctl(void)
   ^
>> kernel/trace/ftrace.c:3086:13: warning: unused function 'ftrace_shutdown=
_sysctl'
   static void ftrace_shutdown_sysctl(void)
   ^
>> kernel/trace/ftrace.c:7912:13: warning: unused function 'is_permanent_op=
s_registered'
   static bool is_permanent_ops_registered(void)
   ^
   fatal error: error in backend: Nested variants found in inline asm strin=
g: ' .set push
   .set mips64r2
   .if ( 0x00 ) !=3D -1)) 0x00 ) !=3D -1)) : ($( static struct ftrace_branc=
h_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_=
branch"))) __if_trace =3D $( .func =3D __func__, .file =3D "arch/mips/inclu=
de/asm/atomic.h", .line =3D 155, $); 0x00 ) !=3D -1)) : $))) ) && ( 0 ); .s=
et push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif
   1: ll $1, $2 # atomic_add_return
   addu $0, $1, $3
   sc $0, $2
   beqz $0, 1b
   addu $0, $1, $3
   .set pop
   '
   PLEASE submit a bug report to https://github.com/llvm/llvm-project/issue=
s/ and include the crash backtrace, preprocessed source, and associated run=
 script.
   Stack dump:
   0. Program arguments: clang -Wp,-MMD,kernel/trace/.ftrace.o.d -nostdinc =
-Iarch/mips/include -I./arch/mips/include/generated -Iinclude -I./include -=
Iarch/mips/include/uapi -I./arch/mips/include/generated/uapi -Iinclude/uapi=
 -I./include/generated/uapi -include include/linux/compiler-version.h -incl=
ude include/linux/kconfig.h -include include/linux/compiler_types.h -D__KER=
NEL__ -DVMLINUX_LOAD_ADDRESS=3D0xffffffff84000000 -DLINKER_LOAD_ADDRESS=3D0=
x84000000 -DDATAOFFSET=3D0 -Qunused-arguments -fmacro-prefix-map=3D=3D -DKB=
UILD_EXTRA_WARN1 -Wall -Wundef -Werror=3Dstrict-prototypes -Wno-trigraphs -=
fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE -Werror=3Dimplicit-f=
unction-declaration -Werror=3Dimplicit-int -Werror=3Dreturn-type -Wno-forma=
t-security -std=3Dgnu11 --target=3Dmips-linux -fintegrated-as -Werror=3Dunk=
nown-warning-option -Werror=3Dignored-optimization-argument -mno-check-zero=
-division -mabi=3D32 -G 0 -mno-abicalls -fno-pic -pipe -msoft-float -DGAS_H=
AS_SET_HARDFLOAT -Wa,-msoft-float -ffreestanding -EB -fno-stack-check -marc=
h=3Dmips32r2 -Wa,--trap -DTOOLCHAIN_SUPPORTS_VIRT -Iarch/mips/include/asm/m=
ach-ath79 -Iarch/mips/include/asm/mach-generic -fno-asynchronous-unwind-tab=
les -fno-delete-null-pointer-checks -Wno-frame-address -Wno-address-of-pack=
ed-member -O2 -Wframe-larger-than=3D1024 -fstack-protector -Wimplicit-fallt=
hrough -Wno-gnu -mno-global-merge -Wno-unused-but-set-variable -Wno-unused-=
const-variable -fno-stack-clash-protection -Wdeclaration-after-statement -W=
vla -Wno-pointer-sign -Wcast-function-type -fno-strict-overflow -fno-stack-=
check -Werror=3Ddate-time -Werror=3Dincompatible-pointer-types -Wextra -Wun=
used -Wno-unused-parameter -Wmissing-declarations -Wmissing-format-attribut=
e -Wmissing-prototypes -Wold-style-definition -Wmissing-include-dirs -Wunus=
ed-but-set-variable -Wunused-const-variable -Wno-missing-field-initializers=
 -Wno-sign-compare -Wno-type-limits -Wno-shift-negative-value -gsplit-dwarf=
 -gdwarf-5 -I kernel/trace -I ./kernel/trace -ffunction-sections -fdata-sec=
tions -DKBUILD_MODFILE=3D"kernel/trace/libftrace" -DKBUILD_BASENAME=3D"ftra=
ce" -DKBUILD_MODNAME=3D"libftrace" -D__KBUILD_MODNAME=3Dkmod_libftrace -c -=
o kernel/trace/ftrace.o kernel/trace/ftrace.c
   1. <eof> parser at end of file
   2. Code generation
   3. Running pass 'Function Pass Manager' on module 'kernel/trace/ftrace.c=
'.
   4. Running pass 'Mips Assembly Printer' on function '@profile_graph_entr=
y'
   #0 0x00005562159e0a7f Signals.cpp:0:0
   #1 0x00005562159de8a4 llvm::sys::CleanupOnSignal(unsigned long) (/opt/cr=
oss/clang-6b7e6ea489/bin/clang-15+0x34f18a4)
   #2 0x000055621591e087 llvm::CrashRecoveryContext::HandleExit(int) (/opt/=
cross/clang-6b7e6ea489/bin/clang-15+0x3431087)
   #3 0x00005562159d6ede llvm::sys::Process::Exit(int, bool) (/opt/cross/cl=
ang-6b7e6ea489/bin/clang-15+0x34e9ede)
   #4 0x00005562135aa92b (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x10bd92=
b)
   #5 0x0000556215924bac llvm::report_fatal_error(llvm::Twine const&, bool)=
 (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x3437bac)
   #6 0x0000556216654260 llvm::AsmPrinter::emitInlineAsm(llvm::MachineInstr=
 const (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x4167260)
   #7 0x0000556216650162 llvm::AsmPrinter::emitFunctionBody() (/opt/cross/c=
lang-6b7e6ea489/bin/clang-15+0x4163162)
   #8 0x0000556214030d07 llvm::MipsAsmPrinter::runOnMachineFunction(llvm::M=
achineFunction&) (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x1b43d07)
   #9 0x0000556214d0c47d llvm::MachineFunctionPass::runOnFunction(llvm::Fun=
ction&) (.part.53) MachineFunctionPass.cpp:0:0
   #10 0x0000556215156457 llvm::FPPassManager::runOnFunction(llvm::Function=
&) (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x2c69457)
   #11 0x00005562151565d1 llvm::FPPassManager::runOnModule(llvm::Module&) (=
/opt/cross/clang-6b7e6ea489/bin/clang-15+0x2c695d1)
   #12 0x000055621515714f llvm::legacy::PassManagerImpl::run(llvm::Module&)=
 (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x2c6a14f)
   #13 0x0000556215d0b4c6 clang::EmitBackendOutput(clang::DiagnosticsEngine=
&, clang::HeaderSearchOptions const&, clang::CodeGenOptions const&, clang::=
TargetOptions const&, clang::LangOptions const&, llvm::StringRef, clang::Ba=
ckendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<l=
lvm::raw_pwrite_stream> >) (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x381e=
4c6)
   #14 0x0000556216974ca3 clang::BackendConsumer::HandleTranslationUnit(cla=
ng::ASTContext&) (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x4487ca3)
   #15 0x00005562174a8a01 clang::ParseAST(clang::Sema&, bool, bool) (/opt/c=
ross/clang-6b7e6ea489/bin/clang-15+0x4fbba01)
   #16 0x0000556216974395 clang::CodeGenAction::ExecuteAction() (/opt/cross=
/clang-6b7e6ea489/bin/clang-15+0x4487395)
   #17 0x000055621636a831 clang::FrontendAction::Execute() (/opt/cross/clan=
g-6b7e6ea489/bin/clang-15+0x3e7d831)
   #18 0x00005562162ffb1a clang::CompilerInstance::ExecuteAction(clang::Fro=
ntendAction&) (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x3e12b1a)
   #19 0x000055621643163b (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x3f446=
3b)
   #20 0x00005562135abedc cc1_main(llvm::ArrayRef<char char (/opt/cross/cla=
ng-6b7e6ea489/bin/clang-15+0x10beedc)
   #21 0x00005562135a8bab ExecuteCC1Tool(llvm::SmallVectorImpl<char driver.=
cpp:0:0
   #22 0x00005562161923f5 void llvm::function_ref<void ()>::callback_fn<cla=
ng::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::StringR=
ef> >, std::__cxx11::basic_string<char, std::char_traits<char>, std::alloca=
tor<char> const::'lambda'()>(long) Job.cpp:0:0
   #23 0x000055621591df43 llvm::CrashRecoveryContext::RunSafely(llvm::funct=
ion_ref<void ()>) (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x3430f43)
   #24 0x0000556216192cee clang::driver::CC1Command::Execute(llvm::ArrayRef=
<llvm::Optional<llvm::StringRef> >, std::__cxx11::basic_string<char, std::c=
har_traits<char>, std::allocator<char> const (.part.216) Job.cpp:0:0
   #25 0x0000556216166de7 clang::driver::Compilation::ExecuteCommand(clang:=
:driver::Command const&, clang::driver::Command const (/opt/cross/clang-6b7=
e6ea489/bin/clang-15+0x3c79de7)
   #26 0x00005562161677c7 clang::driver::Compilation::ExecuteJobs(clang::dr=
iver::JobList const&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) const (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x3c7a7c7)
   #27 0x0000556216170e19 clang::driver::Driver::ExecuteCompilation(clang::=
driver::Compilation&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x3c83e19)
   #28 0x00005562134f5d2f main (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x=
1008d2f)
   #29 0x00007fc6ba6eb7fd __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x237fd)
   #30 0x00005562135a86ca _start (/opt/cross/clang-6b7e6ea489/bin/clang-15+=
0x10bb6ca)
   clang-15: error: clang frontend command failed with exit code 70 (use -v=
 to see invocation)
   clang version 15.0.0 (git://gitmirror/llvm_project 6b7e6ea489f6dd45a9b0d=
a9ac20871560917b9b0)
   Target: mips-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-6b7e6ea489/bin
   clang-15: note: diagnostic msg:
   Makefile arch certs crypto drivers fs include init ipc kernel lib mm net=
 scripts security sound source usr virt


vim +/ftrace_startup_sysctl +3068 kernel/trace/ftrace.c

3d0833953e1b98 Steven Rostedt           2008-05-12  3067 =20
e309b41dd65aa9 Ingo Molnar              2008-05-12 @3068  static void ftrac=
e_startup_sysctl(void)
b0fc494fae96a7 Steven Rostedt           2008-05-12  3069  {
1619dc3f8f555e Pratyush Anand           2015-03-06  3070  	int command;
1619dc3f8f555e Pratyush Anand           2015-03-06  3071 =20
4eebcc81a33fbc Steven Rostedt           2008-05-12  3072  	if (unlikely(ftr=
ace_disabled))
4eebcc81a33fbc Steven Rostedt           2008-05-12  3073  		return;
4eebcc81a33fbc Steven Rostedt           2008-05-12  3074 =20
d61f82d06672f5 Steven Rostedt           2008-05-12  3075  	/* Force update =
next time */
d61f82d06672f5 Steven Rostedt           2008-05-12  3076  	saved_ftrace_fun=
c =3D NULL;
60a7ecf42661f2 Steven Rostedt           2008-11-05  3077  	/* ftrace_start_=
up is true if we want ftrace running */
1619dc3f8f555e Pratyush Anand           2015-03-06  3078  	if (ftrace_start=
_up) {
1619dc3f8f555e Pratyush Anand           2015-03-06  3079  		command =3D FTR=
ACE_UPDATE_CALLS;
1619dc3f8f555e Pratyush Anand           2015-03-06  3080  		if (ftrace_grap=
h_active)
1619dc3f8f555e Pratyush Anand           2015-03-06  3081  			command |=3D F=
TRACE_START_FUNC_RET;
524a38682573b2 Steven Rostedt (Red Hat  2015-03-06  3082) 		ftrace_startup_=
enable(command);
1619dc3f8f555e Pratyush Anand           2015-03-06  3083  	}
b0fc494fae96a7 Steven Rostedt           2008-05-12  3084  }
b0fc494fae96a7 Steven Rostedt           2008-05-12  3085 =20
e309b41dd65aa9 Ingo Molnar              2008-05-12 @3086  static void ftrac=
e_shutdown_sysctl(void)
b0fc494fae96a7 Steven Rostedt           2008-05-12  3087  {
1619dc3f8f555e Pratyush Anand           2015-03-06  3088  	int command;
1619dc3f8f555e Pratyush Anand           2015-03-06  3089 =20
4eebcc81a33fbc Steven Rostedt           2008-05-12  3090  	if (unlikely(ftr=
ace_disabled))
4eebcc81a33fbc Steven Rostedt           2008-05-12  3091  		return;
4eebcc81a33fbc Steven Rostedt           2008-05-12  3092 =20
60a7ecf42661f2 Steven Rostedt           2008-11-05  3093  	/* ftrace_start_=
up is true if ftrace is running */
1619dc3f8f555e Pratyush Anand           2015-03-06  3094  	if (ftrace_start=
_up) {
1619dc3f8f555e Pratyush Anand           2015-03-06  3095  		command =3D FTR=
ACE_DISABLE_CALLS;
1619dc3f8f555e Pratyush Anand           2015-03-06  3096  		if (ftrace_grap=
h_active)
1619dc3f8f555e Pratyush Anand           2015-03-06  3097  			command |=3D F=
TRACE_STOP_FUNC_RET;
1619dc3f8f555e Pratyush Anand           2015-03-06  3098  		ftrace_run_upda=
te_code(command);
1619dc3f8f555e Pratyush Anand           2015-03-06  3099  	}
b0fc494fae96a7 Steven Rostedt           2008-05-12  3100  }
b0fc494fae96a7 Steven Rostedt           2008-05-12  3101 =20

:::::: The code at line 3068 was first introduced by commit
:::::: e309b41dd65aa953f86765eeeecc941d8e1e8b8f ftrace: remove notrace

:::::: TO: Ingo Molnar <mingo@elte.hu>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

--=20
0-DAY CI Kernel Test Service
https://01.org/lkp
