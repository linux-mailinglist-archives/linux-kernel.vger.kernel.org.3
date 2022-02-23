Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307544C0CCE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 07:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238495AbiBWGxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 01:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236710AbiBWGxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 01:53:50 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB3A6E4D8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 22:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645599202; x=1677135202;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=XU8gNNDy/NJx5hzNXDkcONb2EFBQvcya9JsRWrMFnOY=;
  b=Qa4TwAY5p0XcQg0qR9+1iesZmMTrUrlSgl38sCMcfWksdnmJvWM0Jw8w
   SG39HK1Eb1lGtdKsIhmAFzLta8V/J3bpklaNg1nfV7d4tWHrkLS3KmRVI
   3mqGjCGTDPQCXSdjVmJTaya/QKdEArkwLbFA1ZN2VNK90xP+YRCukwQMC
   348bWU1dJuhA9ET4Jaj4Woee0bzMsoOfXt7wArDeokdUNWjUEzbK+vGGD
   zKMlntQS72905sBHTHKck3X6r8/eh6iCbk3G7p46Rn7LXDaygZl6yDbYw
   S5corEm5++IlutzhYmjugxeZ9h5B4ikKI93dkFbbvWMB53FHBcrWlQwhD
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="250724658"
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="250724658"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 22:53:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="491085758"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 22 Feb 2022 22:53:19 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMlWY-00016B-DN; Wed, 23 Feb 2022 06:53:18 +0000
Date:   Wed, 23 Feb 2022 14:52:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [amir73il:ovl-watch 2/24] fs/notify/inotify/inotify_user.c:118:28:
 warning: unused function 'inotify_arg_to_flags'
Message-ID: <202202231434.f5eizpSk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/amir73il/linux ovl-watch
head:   21ca33321c28021209bde9516383467c623d6200
commit: 4474523c7154076f086e044c43111717ab2afa9e [2/24] fsnotify: move inot=
ify control flags to mark flags
config: mips-randconfig-r001-20220221 (https://download.01.org/0day-ci/arch=
ive/20220223/202202231434.f5eizpSk-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc=
04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=3D1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/=
make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/amir73il/linux/commit/4474523c7154076f086e044c=
43111717ab2afa9e
        git remote add amir73il https://github.com/amir73il/linux
        git fetch --no-tags amir73il ovl-watch
        git checkout 4474523c7154076f086e044c43111717ab2afa9e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=3D=
1 O=3Dbuild_dir ARCH=3Dmips SHELL=3D/bin/bash fs/notify/inotify/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/notify/inotify/inotify_user.c:118:28: warning: unused function 'inoti=
fy_arg_to_flags'
   static inline unsigned int inotify_arg_to_flags(u32 arg)
   ^
   fatal error: error in backend: Nested variants found in inline asm strin=
g: '.if ( 0x00 ) !=3D -1)) 0x00 ) !=3D -1)) : ($( static struct ftrace_bran=
ch_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace=
_branch"))) __if_trace =3D $( .func =3D __func__, .file =3D "arch/mips/incl=
ude/asm/barrier.h", .line =3D 16, $); 0x00 ) !=3D -1)) : $))) ) && ( (1 << =
0) ); .set push; .set mips64r2; .rept (1 - (0x00 =3D=3D 0x04)); sync 0x00; =
=2Eendr; .set pop; .else; ; .endif'
   PLEASE submit a bug report to https://github.com/llvm/llvm-project/issue=
s/ and include the crash backtrace, preprocessed source, and associated run=
 script.
   Stack dump:
   0. Program arguments: clang -Wp,-MMD,fs/notify/inotify/.inotify_user.o.d=
 -nostdinc -Iarch/mips/include -I./arch/mips/include/generated -Iinclude -I=
=2E/include -Iarch/mips/include/uapi -I./arch/mips/include/generated/uapi -=
Iinclude/uapi -I./include/generated/uapi -include include/linux/compiler-ve=
rsion.h -include include/linux/kconfig.h -include include/linux/compiler_ty=
pes.h -D__KERNEL__ -DVMLINUX_LOAD_ADDRESS=3D0xffffffff81100000 -DLINKER_LOA=
D_ADDRESS=3D0xffffffff81100000 -DDATAOFFSET=3D0 -Qunused-arguments -fmacro-=
prefix-map=3D=3D -DKBUILD_EXTRA_WARN1 -Wall -Wundef -Werror=3Dstrict-protot=
ypes -Wno-trigraphs -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE=
 -Werror=3Dimplicit-function-declaration -Werror=3Dimplicit-int -Werror=3Dr=
eturn-type -Wno-format-security -std=3Dgnu89 --target=3Dmips64el-linux -fin=
tegrated-as -Werror=3Dunknown-warning-option -Werror=3Dignored-optimization=
-argument -mabi=3D64 -G 0 -mno-abicalls -fno-pic -pipe -msoft-float -DGAS_H=
AS_SET_HARDFLOAT -Wa,-msoft-float -ffreestanding -EL -fno-stack-check -Wa,-=
-trap -Wa,-march=3Docteon -DTOOLCHAIN_SUPPORTS_VIRT -Iarch/mips/include/asm=
/mach-cavium-octeon -Iarch/mips/include/asm/mach-generic -fno-asynchronous-=
unwind-tables -fno-delete-null-pointer-checks -Wno-frame-address -Wno-addre=
ss-of-packed-member -Os -Wframe-larger-than=3D2048 -fno-stack-protector -Wi=
mplicit-fallthrough -Wno-gnu -mno-global-merge -Wno-unused-but-set-variable=
 -Wno-unused-const-variable -fomit-frame-pointer -ftrivial-auto-var-init=3D=
pattern -fno-stack-clash-protection -Wdeclaration-after-statement -Wvla -Wn=
o-pointer-sign -Wcast-function-type -Wno-array-bounds -fno-strict-overflow =
-fno-stack-check -Werror=3Ddate-time -Werror=3Dincompatible-pointer-types -=
Wextra -Wunused -Wno-unused-parameter -Wmissing-declarations -Wmissing-form=
at-attribute -Wmissing-prototypes -Wold-style-definition -Wmissing-include-=
dirs -Wunused-but-set-variable -Wunused-const-variable -Wno-missing-field-i=
nitializers -Wno-sign-compare -Wno-type-limits -fsanitize=3Dshift -fsanitiz=
e=3Dbool -fsanitize=3Denum -fsanitize-coverage=3Dtrace-pc -I fs/notify/inot=
ify -I ./fs/notify/inotify -DKBUILD_MODFILE=3D"fs/notify/inotify/inotify_us=
er" -DKBUILD_BASENAME=3D"inotify_user" -DKBUILD_MODNAME=3D"inotify_user" -D=
__KBUILD_MODNAME=3Dkmod_inotify_user -c -o fs/notify/inotify/inotify_user.o=
 fs/notify/inotify/inotify_user.c
   1. <eof> parser at end of file
   2. Code generation
   3. Running pass 'Function Pass Manager' on module 'fs/notify/inotify/ino=
tify_user.c'.
   4. Running pass 'Mips Assembly Printer' on function '@__se_sys_inotify_a=
dd_watch'
   #0 0x00005591b2448d7f Signals.cpp:0:0
   #1 0x00005591b2446c5c llvm::sys::CleanupOnSignal(unsigned long) (/opt/cr=
oss/clang-d271fc04d5/bin/clang-15+0x348ec5c)
   #2 0x00005591b2386fd7 llvm::CrashRecoveryContext::HandleExit(int) (/opt/=
cross/clang-d271fc04d5/bin/clang-15+0x33cefd7)
   #3 0x00005591b243f30e llvm::sys::Process::Exit(int, bool) (/opt/cross/cl=
ang-d271fc04d5/bin/clang-15+0x348730e)
   #4 0x00005591b006accb (/opt/cross/clang-d271fc04d5/bin/clang-15+0x10b2cc=
b)
   #5 0x00005591b238da8c llvm::report_fatal_error(llvm::Twine const&, bool)=
 (/opt/cross/clang-d271fc04d5/bin/clang-15+0x33d5a8c)
   #6 0x00005591b30975c0 llvm::AsmPrinter::emitInlineAsm(llvm::MachineInstr=
 const (/opt/cross/clang-d271fc04d5/bin/clang-15+0x40df5c0)
   #7 0x00005591b30934f4 llvm::AsmPrinter::emitFunctionBody() (/opt/cross/c=
lang-d271fc04d5/bin/clang-15+0x40db4f4)
   #8 0x00005591b0ad4887 llvm::MipsAsmPrinter::runOnMachineFunction(llvm::M=
achineFunction&) (/opt/cross/clang-d271fc04d5/bin/clang-15+0x1b1c887)
   #9 0x00005591b179154d llvm::MachineFunctionPass::runOnFunction(llvm::Fun=
ction&) (.part.53) MachineFunctionPass.cpp:0:0
   #10 0x00005591b1bd8807 llvm::FPPassManager::runOnFunction(llvm::Function=
&) (/opt/cross/clang-d271fc04d5/bin/clang-15+0x2c20807)
   #11 0x00005591b1bd8981 llvm::FPPassManager::runOnModule(llvm::Module&) (=
/opt/cross/clang-d271fc04d5/bin/clang-15+0x2c20981)
   #12 0x00005591b1bd94ff llvm::legacy::PassManagerImpl::run(llvm::Module&)=
 (/opt/cross/clang-d271fc04d5/bin/clang-15+0x2c214ff)
   #13 0x00005591b2763147 clang::EmitBackendOutput(clang::DiagnosticsEngine=
&, clang::HeaderSearchOptions const&, clang::CodeGenOptions const&, clang::=
TargetOptions const&, clang::LangOptions const&, llvm::StringRef, clang::Ba=
ckendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<l=
lvm::raw_pwrite_stream> >) (/opt/cross/clang-d271fc04d5/bin/clang-15+0x37ab=
147)
   #14 0x00005591b33b1693 clang::BackendConsumer::HandleTranslationUnit(cla=
ng::ASTContext&) (/opt/cross/clang-d271fc04d5/bin/clang-15+0x43f9693)
   #15 0x00005591b3e8c6e9 clang::ParseAST(clang::Sema&, bool, bool) (/opt/c=
ross/clang-d271fc04d5/bin/clang-15+0x4ed46e9)
   #16 0x00005591b33b04cf clang::CodeGenAction::ExecuteAction() (/opt/cross=
/clang-d271fc04d5/bin/clang-15+0x43f84cf)
   #17 0x00005591b2db3561 clang::FrontendAction::Execute() (/opt/cross/clan=
g-d271fc04d5/bin/clang-15+0x3dfb561)
   #18 0x00005591b2d49faa clang::CompilerInstance::ExecuteAction(clang::Fro=
ntendAction&) (/opt/cross/clang-d271fc04d5/bin/clang-15+0x3d91faa)
   #19 0x00005591b2e77cbb (/opt/cross/clang-d271fc04d5/bin/clang-15+0x3ebfc=
bb)
   #20 0x00005591b006c27c cc1_main(llvm::ArrayRef<char char (/opt/cross/cla=
ng-d271fc04d5/bin/clang-15+0x10b427c)
   #21 0x00005591b0068f4b ExecuteCC1Tool(llvm::SmallVectorImpl<char driver.=
cpp:0:0
   #22 0x00005591b2be2d95 void llvm::function_ref<void ()>::callback_fn<cla=
ng::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::StringR=
ef> >, std::__cxx11::basic_string<char, std::char_traits<char>, std::alloca=
tor<char> const::'lambda'()>(long) Job.cpp:0:0
   #23 0x00005591b2386e93 llvm::CrashRecoveryContext::RunSafely(llvm::funct=
ion_ref<void ()>) (/opt/cross/clang-d271fc04d5/bin/clang-15+0x33cee93)
   #24 0x00005591b2be368e clang::driver::CC1Command::Execute(llvm::ArrayRef=
<llvm::Optional<llvm::StringRef> >, std::__cxx11::basic_string<char, std::c=
har_traits<char>, std::allocator<char> const (.part.216) Job.cpp:0:0
   #25 0x00005591b2bb8267 clang::driver::Compilation::ExecuteCommand(clang:=
:driver::Command const&, clang::driver::Command const (/opt/cross/clang-d27=
1fc04d5/bin/clang-15+0x3c00267)
   #26 0x00005591b2bb8c47 clang::driver::Compilation::ExecuteJobs(clang::dr=
iver::JobList const&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) const (/opt/cross/clang-d271fc04d5/bin/clang-15+0x3c00c47)
   #27 0x00005591b2bc22f9 clang::driver::Driver::ExecuteCompilation(clang::=
driver::Compilation&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) (/opt/cross/clang-d271fc04d5/bin/clang-15+0x3c0a2f9)
   #28 0x00005591aff9163f main (/opt/cross/clang-d271fc04d5/bin/clang-15+0x=
fd963f)
   #29 0x00007ff1b56bbd0a __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x26d0a)
   #30 0x00005591b0068a6a _start (/opt/cross/clang-d271fc04d5/bin/clang-15+=
0x10b0a6a)
   clang-15: error: clang frontend command failed with exit code 70 (use -v=
 to see invocation)
   clang version 15.0.0 (git://gitmirror/llvm_project d271fc04d5b97b12e6b79=
7c6067d3c96a8d7470e)
   Target: mips64el-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-d271fc04d5/bin
   clang-15: note: diagnostic msg:
   Makefile arch fs include kernel nr_bisected scripts source usr


vim +/inotify_arg_to_flags +118 fs/notify/inotify/inotify_user.c

   117=09
 > 118	static inline unsigned int inotify_arg_to_flags(u32 arg)
   119	{
   120		unsigned int flags =3D 0;
   121=09
   122		if (arg & IN_EXCL_UNLINK)
   123			flags |=3D FSNOTIFY_MARK_FLAG_EXCL_UNLINK;
   124		if (arg & IN_ONESHOT)
   125			flags |=3D FSNOTIFY_MARK_FLAG_IN_ONESHOT;
   126=09
   127		return flags;
   128	}
   129=09

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
