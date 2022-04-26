Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FCE510B75
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 23:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355530AbiDZVnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 17:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346480AbiDZVnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 17:43:12 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F1E2193
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651009202; x=1682545202;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=8PJocHdQIU0L3qCnGMuHYqmEYMHIJBX1KbzqKywx+2E=;
  b=Y1Jk8HUjRqfFvLIzOxMom/WPA+rwrhQ6Po9fxSaJL8p3qllSnjSet4oQ
   aLuxIH6vz9H/9D4ZabArXY7EVJdgyEQziZx9BwaTO8HXZ0EX8kGZlAMKM
   takdJew1vTt9HuDRR4suoiNG68CROeTKmWe30wDqZR7ikyN8mX+VrSW4O
   TXyLEEBsSUgCsHt02D13hufwe8MJBaF30+1E6tyNYyvHPDms9VayfAkon
   8KDmUeCz4vNg24G42NByCJqr4nfZvV0+Cof0kBZvfvuJYVfXltaJwRULS
   /+hHiNV6qLnLb5WBwjzj2oqr6YcLGMiWkOWKJVMcG1ZYghYNGbIgbbCYW
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="263321056"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="263321056"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 14:40:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="705242830"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 26 Apr 2022 14:40:01 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njSue-00041z-FO;
        Tue, 26 Apr 2022 21:40:00 +0000
Date:   Wed, 27 Apr 2022 05:39:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [axboe-block:io_uring-flags2 48/74] fs/io_uring.c:7388:28: warning:
 unused function 'io_file_from_index'
Message-ID: <202204270552.OzdnvA4W-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.g=
it io_uring-flags2
head:   bfbad055dcd5655d2258b97e8db1653e5109739f
commit: 5e45690a1cb8cb591ccf4a517cdd6ad6cb369ac4 [48/74] io_uring: store SC=
M state in io_fixed_file->file_ptr
config: mips-randconfig-r003-20220426 (https://download.01.org/0day-ci/arch=
ive/20220427/202204270552.OzdnvA4W-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 1cddcf=
dc3c683b393df1a5c9063252eb60e52818)
reproduce (this is a W=3D1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/=
make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block=
=2Egit/commit/?id=3D5e45690a1cb8cb591ccf4a517cdd6ad6cb369ac4
        git remote add axboe-block https://git.kernel.org/pub/scm/linux/ker=
nel/git/axboe/linux-block.git
        git fetch --no-tags axboe-block io_uring-flags2
        git checkout 5e45690a1cb8cb591ccf4a517cdd6ad6cb369ac4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=3D=
1 O=3Dbuild_dir ARCH=3Dmips SHELL=3D/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/io_uring.c:8498:6: warning: unused variable 'i'
   int i;
   ^
>> fs/io_uring.c:7388:28: warning: unused function 'io_file_from_index'
   static inline struct file io_ring_ctx
   ^
   fatal error: error in backend: Nested variants found in inline asm strin=
g: ' .set push
   .set mips64r2
   .if ( 0x00 ) !=3D -1)) 0x00 ) !=3D -1)) : ($( static struct ftrace_branc=
h_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_=
branch"))) __if_trace =3D $( .func =3D __func__, .file =3D "arch/mips/inclu=
de/asm/atomic.h", .line =3D 155, $); 0x00 ) !=3D -1)) : $))) ) && ( 0 ); .s=
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
   0. Program arguments: clang -Wp,-MMD,fs/.io_uring.o.d -nostdinc -Iarch/m=
ips/include -I./arch/mips/include/generated -Iinclude -I./include -Iarch/mi=
ps/include/uapi -I./arch/mips/include/generated/uapi -Iinclude/uapi -I./inc=
lude/generated/uapi -include include/linux/compiler-version.h -include incl=
ude/linux/kconfig.h -include include/linux/compiler_types.h -D__KERNEL__ -D=
VMLINUX_LOAD_ADDRESS=3D0xffffffff80060000 -DLINKER_LOAD_ADDRESS=3D0x8006000=
0 -DDATAOFFSET=3D0 -Qunused-arguments -fmacro-prefix-map=3D=3D -DKBUILD_EXT=
RA_WARN1 -Wall -Wundef -Werror=3Dstrict-prototypes -Wno-trigraphs -fno-stri=
ct-aliasing -fno-common -fshort-wchar -fno-PIE -Werror=3Dimplicit-function-=
declaration -Werror=3Dimplicit-int -Werror=3Dreturn-type -Wno-format-securi=
ty -std=3Dgnu11 --target=3Dmips-linux -fintegrated-as -Werror=3Dunknown-war=
ning-option -Werror=3Dignored-optimization-argument -mno-check-zero-divisio=
n -mabi=3D32 -G 0 -mno-abicalls -fno-pic -pipe -msoft-float -DGAS_HAS_SET_H=
ARDFLOAT -Wa,-msoft-float -ffreestanding -EB -fno-stack-check -march=3Dmips=
32r2 -Wa,--trap -DTOOLCHAIN_SUPPORTS_VIRT -Iarch/mips/include/asm/mach-ath7=
9 -Iarch/mips/include/asm/mach-generic -fno-asynchronous-unwind-tables -fno=
-delete-null-pointer-checks -Wno-frame-address -Wno-address-of-packed-membe=
r -O2 -Wframe-larger-than=3D1024 -fstack-protector -Wimplicit-fallthrough -=
Wno-gnu -Wno-unused-but-set-variable -Wno-unused-const-variable -fno-stack-=
clash-protection -pg -Wdeclaration-after-statement -Wvla -Wno-pointer-sign =
-Wcast-function-type -fno-strict-overflow -fno-stack-check -Werror=3Ddate-t=
ime -Werror=3Dincompatible-pointer-types -Wextra -Wunused -Wno-unused-param=
eter -Wmissing-declarations -Wmissing-format-attribute -Wmissing-prototypes=
 -Wold-style-definition -Wmissing-include-dirs -Wunused-but-set-variable -W=
unused-const-variable -Wno-missing-field-initializers -Wno-sign-compare -Wn=
o-type-limits -Wno-shift-negative-value -I fs -I ./fs -DKBUILD_MODFILE=3D"f=
s/io_uring" -DKBUILD_BASENAME=3D"io_uring" -DKBUILD_MODNAME=3D"io_uring" -D=
__KBUILD_MODNAME=3Dkmod_io_uring -c -o fs/io_uring.o fs/io_uring.c
   1. <eof> parser at end of file
   2. Code generation
   3. Running pass 'Function Pass Manager' on module 'fs/io_uring.c'.
   4. Running pass 'Mips Assembly Printer' on function '@io_uring_cancel_ge=
neric'
   #0 0x000055798c800a2f Signals.cpp:0:0
   #1 0x000055798c7fe854 llvm::sys::CleanupOnSignal(unsigned long) (/opt/cr=
oss/clang-1cddcfdc3c/bin/clang-15+0x34bf854)
   #2 0x000055798c73dcf7 llvm::CrashRecoveryContext::HandleExit(int) (/opt/=
cross/clang-1cddcfdc3c/bin/clang-15+0x33fecf7)
   #3 0x000055798c7f6e8e llvm::sys::Process::Exit(int, bool) (/opt/cross/cl=
ang-1cddcfdc3c/bin/clang-15+0x34b7e8e)
   #4 0x000055798a4005db (/opt/cross/clang-1cddcfdc3c/bin/clang-15+0x10c15d=
b)
   #5 0x000055798c74481c llvm::report_fatal_error(llvm::Twine const&, bool)=
 (/opt/cross/clang-1cddcfdc3c/bin/clang-15+0x340581c)
   #6 0x000055798d47aa30 llvm::AsmPrinter::emitInlineAsm(llvm::MachineInstr=
 const (/opt/cross/clang-1cddcfdc3c/bin/clang-15+0x413ba30)
   #7 0x000055798d476932 llvm::AsmPrinter::emitFunctionBody() (/opt/cross/c=
lang-1cddcfdc3c/bin/clang-15+0x4137932)
   #8 0x000055798ae8ef77 llvm::MipsAsmPrinter::runOnMachineFunction(llvm::M=
achineFunction&) (/opt/cross/clang-1cddcfdc3c/bin/clang-15+0x1b4ff77)
   #9 0x000055798bb70f8d llvm::MachineFunctionPass::runOnFunction(llvm::Fun=
ction&) (.part.53) MachineFunctionPass.cpp:0:0
   #10 0x000055798bfb7597 llvm::FPPassManager::runOnFunction(llvm::Function=
&) (/opt/cross/clang-1cddcfdc3c/bin/clang-15+0x2c78597)
   #11 0x000055798bfb7711 llvm::FPPassManager::runOnModule(llvm::Module&) (=
/opt/cross/clang-1cddcfdc3c/bin/clang-15+0x2c78711)
   #12 0x000055798bfb828f llvm::legacy::PassManagerImpl::run(llvm::Module&)=
 (/opt/cross/clang-1cddcfdc3c/bin/clang-15+0x2c7928f)
   #13 0x000055798cb2b34f clang::EmitBackendOutput(clang::DiagnosticsEngine=
&, clang::HeaderSearchOptions const&, clang::CodeGenOptions const&, clang::=
TargetOptions const&, clang::LangOptions const&, llvm::StringRef, clang::Ba=
ckendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<l=
lvm::raw_pwrite_stream> >) (/opt/cross/clang-1cddcfdc3c/bin/clang-15+0x37ec=
34f)
   #14 0x000055798d79fe11 clang::BackendConsumer::HandleTranslationUnit(cla=
ng::ASTContext&) (/opt/cross/clang-1cddcfdc3c/bin/clang-15+0x4460e11)
   #15 0x000055798e30e6b1 clang::ParseAST(clang::Sema&, bool, bool) (/opt/c=
ross/clang-1cddcfdc3c/bin/clang-15+0x4fcf6b1)
   #16 0x000055798d79f4d5 clang::CodeGenAction::ExecuteAction() (/opt/cross=
/clang-1cddcfdc3c/bin/clang-15+0x44604d5)
   #17 0x000055798d18ebe1 clang::FrontendAction::Execute() (/opt/cross/clan=
g-1cddcfdc3c/bin/clang-15+0x3e4fbe1)
   #18 0x000055798d1235aa clang::CompilerInstance::ExecuteAction(clang::Fro=
ntendAction&) (/opt/cross/clang-1cddcfdc3c/bin/clang-15+0x3de45aa)
   #19 0x000055798d2562db (/opt/cross/clang-1cddcfdc3c/bin/clang-15+0x3f172=
db)
   #20 0x000055798a401b8c cc1_main(llvm::ArrayRef<char char (/opt/cross/cla=
ng-1cddcfdc3c/bin/clang-15+0x10c2b8c)
   #21 0x000055798a3fe85b ExecuteCC1Tool(llvm::SmallVectorImpl<char driver.=
cpp:0:0
   #22 0x000055798cfb45e5 void llvm::function_ref<void ()>::callback_fn<cla=
ng::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::StringR=
ef> >, std::__cxx11::basic_string<char, std::char_traits<char>, std::alloca=
tor<char> const::'lambda'()>(long) Job.cpp:0:0
   #23 0x000055798c73dbb3 llvm::CrashRecoveryContext::RunSafely(llvm::funct=
ion_ref<void ()>) (/opt/cross/clang-1cddcfdc3c/bin/clang-15+0x33febb3)
   #24 0x000055798cfb4ede clang::driver::CC1Command::Execute(llvm::ArrayRef=
<llvm::Optional<llvm::StringRef> >, std::__cxx11::basic_string<char, std::c=
har_traits<char>, std::allocator<char> const (.part.216) Job.cpp:0:0
   #25 0x000055798cf88757 clang::driver::Compilation::ExecuteCommand(clang:=
:driver::Command const&, clang::driver::Command const (/opt/cross/clang-1cd=
dcfdc3c/bin/clang-15+0x3c49757)
   #26 0x000055798cf89137 clang::driver::Compilation::ExecuteJobs(clang::dr=
iver::JobList const&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) const (/opt/cross/clang-1cddcfdc3c/bin/clang-15+0x3c4a137)
   #27 0x000055798cf92c59 clang::driver::Driver::ExecuteCompilation(clang::=
driver::Compilation&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) (/opt/cross/clang-1cddcfdc3c/bin/clang-15+0x3c53c59)
   #28 0x000055798a34aa0f main (/opt/cross/clang-1cddcfdc3c/bin/clang-15+0x=
100ba0f)
   #29 0x00007f87e39be7fd __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x237fd)
   #30 0x000055798a3fe37a _start (/opt/cross/clang-1cddcfdc3c/bin/clang-15+=
0x10bf37a)
   clang-15: error: clang frontend command failed with exit code 70 (use -v=
 to see invocation)
   clang version 15.0.0 (git://gitmirror/llvm_project 1cddcfdc3c683b393df1a=
5c9063252eb60e52818)
   Target: mips-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-1cddcfdc3c/bin
   clang-15: note: diagnostic msg:
   Makefile arch certs crypto drivers fs include init ipc kernel lib mm nr_=
bisected scripts security sound source usr virt


vim +/io_file_from_index +7388 fs/io_uring.c

dafecf19e25f9b Pavel Begunkov 2021-02-28  7387 =20
65e19f54d29cd8 Jens Axboe     2019-10-26 @7388  static inline struct file *=
io_file_from_index(struct io_ring_ctx *ctx,
65e19f54d29cd8 Jens Axboe     2019-10-26  7389  					      int index)
09bb839434bd84 Jens Axboe     2019-03-13  7390  {
aeca241b0bdd83 Pavel Begunkov 2021-04-11  7391  	struct io_fixed_file *slot=
 =3D io_fixed_file_slot(&ctx->file_table, index);
7b29f92da377c3 Jens Axboe     2021-03-12  7392 =20
a04b0ac0cb64fc Pavel Begunkov 2021-04-01  7393  	return (struct file *) (sl=
ot->file_ptr & FFS_MASK);
65e19f54d29cd8 Jens Axboe     2019-10-26  7394  }
65e19f54d29cd8 Jens Axboe     2019-10-26  7395 =20

:::::: The code at line 7388 was first introduced by commit
:::::: 65e19f54d29cd8559ce60cfd0d751bef7afbdc5c io_uring: support for large=
r fixed file sets

:::::: TO: Jens Axboe <axboe@kernel.dk>
:::::: CC: Jens Axboe <axboe@kernel.dk>

--=20
0-DAY CI Kernel Test Service
https://01.org/lkp
