Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2854B3441
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 11:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbiBLKj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 05:39:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbiBLKjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 05:39:47 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D97726561
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 02:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644662383; x=1676198383;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=IYrk9y2jLb238Dngg+0eR8eEyR0nRrvF7fRVKu/5dhM=;
  b=D9Xg1PCh1Am/4vrY5sTa25kPnjPjBLSZ0ryWxLEOVUeA/fvym8R3jToL
   4UpoXA5YDk8UCLyo+YE/dA/1k/gPV6g6Fbrq6WlVT6yyNCg+5HFUxBDw3
   QrA76am8rrXU0qxaa5Ph5G6c1f+wQMh+K2mIydxGtl7SWrSg1/cbEZMcS
   Jx7rVPdbEoW4mO2QHQu4lpCMf5qP0Ba8bJ48L5BKmCTo7SugfLM3wBA84
   cPw8D/jeRAHg0yeCExdqzToNJCWpcdn/ElH4VrPwmvrhAu2wWLHkrLtT8
   oWp6I07UQs1N+cRj7RvjoInf3uaYpgFaICxzfBUiKn8IsTXrZnl5oQ9j0
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="230511975"
X-IronPort-AV: E=Sophos;i="5.88,363,1635231600"; 
   d="scan'208";a="230511975"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2022 02:39:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,363,1635231600"; 
   d="scan'208";a="586614434"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 12 Feb 2022 02:39:41 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIpob-00061L-0x; Sat, 12 Feb 2022 10:39:41 +0000
Date:   Sat, 12 Feb 2022 18:38:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: fs/ext4/super.c:2173:1: warning: unused function 'ctx_clear_flags'
Message-ID: <202202121524.strwjtrg-lkp@intel.com>
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

Hi Lukas,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git =
master
head:   83e396641110663d3c7bb25b9bc0c6a750359ecf
commit: 4437992be7ca3ac5dd0a62cad10357112d4fb43e ext4: remove lazytime/nola=
zytime mount options handled by MS_LAZYTIME
date:   7 weeks ago
config: mips-randconfig-r005-20220211 (https://download.01.org/0day-ci/arch=
ive/20220212/202202121524.strwjtrg-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f6685f=
774697c85d6a352dcea013f46a99f9fe31)
reproduce (this is a W=3D1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/=
make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/commit/?id=3D4437992be7ca3ac5dd0a62cad10357112d4fb43e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/gi=
t/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 4437992be7ca3ac5dd0a62cad10357112d4fb43e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=3D=
1 O=3Dbuild_dir ARCH=3Dmips SHELL=3D/bin/bash fs/ext4/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/ext4/super.c:2173:1: warning: unused function 'ctx_clear_flags'
   EXT4_SET_CTX(flags);
   ^
   fs/ext4/super.c:2161:20: note: expanded from macro 'EXT4_SET_CTX'
   static inline void ctx_clear_##name(struct ext4_fs_context ^
   <scratch space>:84:1: note: expanded from here
   ctx_clear_flags
   ^
   fs/ext4/super.c:2173:1: warning: unused function 'ctx_test_flags'
   fs/ext4/super.c:2167:34: note: expanded from macro 'EXT4_SET_CTX'
   static inline unsigned long ^
   <scratch space>:87:1: note: expanded from here
   ctx_test_flags
   ^
   fs/ext4/super.c:2176:1: warning: unused function 'ctx_clear_mount_flags'
   EXT4_SET_CTX(mount_flags);
   ^
   fs/ext4/super.c:2161:20: note: expanded from macro 'EXT4_SET_CTX'
   static inline void ctx_clear_##name(struct ext4_fs_context ^
   <scratch space>:108:1: note: expanded from here
   ctx_clear_mount_flags
   ^
   fs/ext4/super.c:2176:1: warning: unused function 'ctx_test_mount_flags'
   fs/ext4/super.c:2167:34: note: expanded from macro 'EXT4_SET_CTX'
   static inline unsigned long ^
   <scratch space>:111:1: note: expanded from here
   ctx_test_mount_flags
   ^
   fatal error: error in backend: Nested variants found in inline asm strin=
g: ' .set push
   .set mips64r2
   .if ( 0x00 ) !=3D -1)) 0x00 ) !=3D -1)) : ($( static struct ftrace_branc=
h_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_=
branch"))) __if_trace =3D $( .func =3D __func__, .file =3D "arch/mips/inclu=
de/asm/bitops.h", .line =3D 105, $); 0x00 ) !=3D -1)) : $))) ) && ( 0 ); .s=
et push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif
   1: ll $0, $1
   or $0, $2
   sc $0, $1
   beqz $0, 1b
   .set pop
   '
   PLEASE submit a bug report to https://github.com/llvm/llvm-project/issue=
s/ and include the crash backtrace, preprocessed source, and associated run=
 script.
   Stack dump:
   0. Program arguments: clang -Wp,-MMD,fs/ext4/.super.o.d -nostdinc -Iarch=
/mips/include -I./arch/mips/include/generated -Iinclude -I./include -Iarch/=
mips/include/uapi -I./arch/mips/include/generated/uapi -Iinclude/uapi -I./i=
nclude/generated/uapi -include include/linux/compiler-version.h -include in=
clude/linux/kconfig.h -include include/linux/compiler_types.h -D__KERNEL__ =
-DVMLINUX_LOAD_ADDRESS=3D0xffffffff84000000 -DLINKER_LOAD_ADDRESS=3D0x84000=
000 -DDATAOFFSET=3D0 -Qunused-arguments -fmacro-prefix-map=3D=3D -DKBUILD_E=
XTRA_WARN1 -Wall -Wundef -Werror=3Dstrict-prototypes -Wno-trigraphs -fno-st=
rict-aliasing -fno-common -fshort-wchar -fno-PIE -Werror=3Dimplicit-functio=
n-declaration -Werror=3Dimplicit-int -Werror=3Dreturn-type -Wno-format-secu=
rity -std=3Dgnu89 --target=3Dmipsel-linux -fintegrated-as -Werror=3Dunknown=
-warning-option -Werror=3Dignored-optimization-argument -mno-check-zero-div=
ision -mabi=3D32 -G 0 -mno-abicalls -fno-pic -pipe -msoft-float -DGAS_HAS_S=
ET_HARDFLOAT -Wa,-msoft-float -ffreestanding -EL -fno-stack-check -march=3D=
mips32 -Wa,-mips32 -Wa,--trap -DTOOLCHAIN_SUPPORTS_VIRT -Iarch/mips/include=
/asm/mach-bmips/ -Iarch/mips/include/asm/mach-generic -fno-asynchronous-unw=
ind-tables -fno-delete-null-pointer-checks -Wno-frame-address -Wno-address-=
of-packed-member -O2 -Wframe-larger-than=3D1024 -fno-stack-protector -Wimpl=
icit-fallthrough -Wno-gnu -mno-global-merge -Wno-unused-but-set-variable -W=
no-unused-const-variable -ftrivial-auto-var-init=3Dzero -enable-trivial-aut=
o-var-init-zero-knowing-it-will-be-removed-from-clang -fno-stack-clash-prot=
ection -pg -Wdeclaration-after-statement -Wvla -Wno-pointer-sign -Wno-array=
-bounds -fno-strict-overflow -fno-stack-check -Werror=3Ddate-time -Werror=
=3Dincompatible-pointer-types -Wextra -Wunused -Wno-unused-parameter -Wmiss=
ing-declarations -Wmissing-format-attribute -Wmissing-prototypes -Wold-styl=
e-definition -Wmissing-include-dirs -Wunused-but-set-variable -Wunused-cons=
t-variable -Wno-missing-field-initializers -Wno-sign-compare -Wno-type-limi=
ts -I fs/ext4 -I ./fs/ext4 -ffunction-sections -fdata-sections -DKBUILD_MOD=
FILE=3D"fs/ext4/ext4" -DKBUILD_BASENAME=3D"super" -DKBUILD_MODNAME=3D"ext4"=
 -D__KBUILD_MODNAME=3Dkmod_ext4 -c -o fs/ext4/super.o fs/ext4/super.c
   1. <eof> parser at end of file
   2. Code generation
   3. Running pass 'Function Pass Manager' on module 'fs/ext4/super.c'.
   4. Running pass 'Mips Assembly Printer' on function '@ext4_read_bh_nowai=
t'
   #0 0x000056373747f14f Signals.cpp:0:0
   #1 0x000056373747d02c llvm::sys::CleanupOnSignal(unsigned long) (/opt/cr=
oss/clang-c7eb846345/bin/clang-15+0x347a02c)
   #2 0x00005637373bd2c7 llvm::CrashRecoveryContext::HandleExit(int) (/opt/=
cross/clang-c7eb846345/bin/clang-15+0x33ba2c7)
   #3 0x00005637374756de llvm::sys::Process::Exit(int, bool) (/opt/cross/cl=
ang-c7eb846345/bin/clang-15+0x34726de)
   #4 0x00005637350ab9fb (/opt/cross/clang-c7eb846345/bin/clang-15+0x10a89f=
b)
   #5 0x00005637373c3d7c llvm::report_fatal_error(llvm::Twine const&, bool)=
 (/opt/cross/clang-c7eb846345/bin/clang-15+0x33c0d7c)
   #6 0x00005637380d0420 llvm::AsmPrinter::emitInlineAsm(llvm::MachineInstr=
 const (/opt/cross/clang-c7eb846345/bin/clang-15+0x40cd420)
   #7 0x00005637380cc354 llvm::AsmPrinter::emitFunctionBody() (/opt/cross/c=
lang-c7eb846345/bin/clang-15+0x40c9354)
   #8 0x0000563735b17077 llvm::MipsAsmPrinter::runOnMachineFunction(llvm::M=
achineFunction&) (/opt/cross/clang-c7eb846345/bin/clang-15+0x1b14077)
   #9 0x00005637367cf98d llvm::MachineFunctionPass::runOnFunction(llvm::Fun=
ction&) (.part.53) MachineFunctionPass.cpp:0:0
   #10 0x0000563736c10617 llvm::FPPassManager::runOnFunction(llvm::Function=
&) (/opt/cross/clang-c7eb846345/bin/clang-15+0x2c0d617)
   #11 0x0000563736c10791 llvm::FPPassManager::runOnModule(llvm::Module&) (=
/opt/cross/clang-c7eb846345/bin/clang-15+0x2c0d791)
   #12 0x0000563736c1130f llvm::legacy::PassManagerImpl::run(llvm::Module&)=
 (/opt/cross/clang-c7eb846345/bin/clang-15+0x2c0e30f)
   #13 0x00005637377972b7 clang::EmitBackendOutput(clang::DiagnosticsEngine=
&, clang::HeaderSearchOptions const&, clang::CodeGenOptions const&, clang::=
TargetOptions const&, clang::LangOptions const&, llvm::StringRef, clang::Ba=
ckendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<l=
lvm::raw_pwrite_stream> >) (/opt/cross/clang-c7eb846345/bin/clang-15+0x3794=
2b7)
   #14 0x00005637383e97c3 clang::BackendConsumer::HandleTranslationUnit(cla=
ng::ASTContext&) (/opt/cross/clang-c7eb846345/bin/clang-15+0x43e67c3)
   #15 0x0000563738ec04e9 clang::ParseAST(clang::Sema&, bool, bool) (/opt/c=
ross/clang-c7eb846345/bin/clang-15+0x4ebd4e9)
   #16 0x00005637383e85ff clang::CodeGenAction::ExecuteAction() (/opt/cross=
/clang-c7eb846345/bin/clang-15+0x43e55ff)
   #17 0x0000563737de55b1 clang::FrontendAction::Execute() (/opt/cross/clan=
g-c7eb846345/bin/clang-15+0x3de25b1)
   #18 0x0000563737d7c05a clang::CompilerInstance::ExecuteAction(clang::Fro=
ntendAction&) (/opt/cross/clang-c7eb846345/bin/clang-15+0x3d7905a)
   #19 0x0000563737ea9ceb (/opt/cross/clang-c7eb846345/bin/clang-15+0x3ea6c=
eb)
   #20 0x00005637350acfac cc1_main(llvm::ArrayRef<char char (/opt/cross/cla=
ng-c7eb846345/bin/clang-15+0x10a9fac)
   #21 0x00005637350a9c7b ExecuteCC1Tool(llvm::SmallVectorImpl<char driver.=
cpp:0:0
   #22 0x0000563737c13585 void llvm::function_ref<void ()>::callback_fn<cla=
ng::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::StringR=
ef> >, std::__cxx11::basic_string<char, std::char_traits<char>, std::alloca=
tor<char> const::'lambda'()>(long) Job.cpp:0:0
   #23 0x00005637373bd183 llvm::CrashRecoveryContext::RunSafely(llvm::funct=
ion_ref<void ()>) (/opt/cross/clang-c7eb846345/bin/clang-15+0x33ba183)
   #24 0x0000563737c13e7e clang::driver::CC1Command::Execute(llvm::ArrayRef=
<llvm::Optional<llvm::StringRef> >, std::__cxx11::basic_string<char, std::c=
har_traits<char>, std::allocator<char> const (.part.216) Job.cpp:0:0
   #25 0x0000563737be8a77 clang::driver::Compilation::ExecuteCommand(clang:=
:driver::Command const&, clang::driver::Command const (/opt/cross/clang-c7e=
b846345/bin/clang-15+0x3be5a77)
   #26 0x0000563737be9457 clang::driver::Compilation::ExecuteJobs(clang::dr=
iver::JobList const&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) const (/opt/cross/clang-c7eb846345/bin/clang-15+0x3be6457)
   #27 0x0000563737bf2ae9 clang::driver::Driver::ExecuteCompilation(clang::=
driver::Compilation&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) (/opt/cross/clang-c7eb846345/bin/clang-15+0x3befae9)
   #28 0x0000563734fd23ff main (/opt/cross/clang-c7eb846345/bin/clang-15+0x=
fcf3ff)
   #29 0x00007f9d5663bd0a __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x26d0a)
   #30 0x00005637350a979a _start (/opt/cross/clang-c7eb846345/bin/clang-15+=
0x10a679a)
   clang-15: error: clang frontend command failed with exit code 70 (use -v=
 to see invocation)
   clang version 15.0.0 (git://gitmirror/llvm_project c7eb84634519e6497be42=
f5fe323f9a04ed67127)
   Target: mipsel-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-c7eb846345/bin
   clang-15: note: diagnostic msg:
   Makefile arch drivers fs include kernel scripts source usr


vim +/ctx_clear_flags +2173 fs/ext4/super.c

6e47a3cc68fc525 Lukas Czerner 2021-10-27  2172 =20
6e47a3cc68fc525 Lukas Czerner 2021-10-27 @2173  EXT4_SET_CTX(flags);
6e47a3cc68fc525 Lukas Czerner 2021-10-27  2174  EXT4_SET_CTX(mount_opt);
6e47a3cc68fc525 Lukas Czerner 2021-10-27  2175  EXT4_SET_CTX(mount_opt2);
6e47a3cc68fc525 Lukas Czerner 2021-10-27  2176  EXT4_SET_CTX(mount_flags);
6e47a3cc68fc525 Lukas Czerner 2021-10-27  2177 =20

:::::: The code at line 2173 was first introduced by commit
:::::: 6e47a3cc68fc525428297a00524833361ebbb0e9 ext4: get rid of super bloc=
k and sbi from handle_mount_ops()

:::::: TO: Lukas Czerner <lczerner@redhat.com>
:::::: CC: Theodore Ts'o <tytso@mit.edu>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
