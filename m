Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B50D516E38
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 12:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384697AbiEBKjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 06:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384718AbiEBKjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 06:39:04 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929C41095
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 03:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651487734; x=1683023734;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=zme2bzTcTZV/5vtvzNRcSb+yOsr8qbK1hibOHo76+wI=;
  b=TwW4slbPcg0UnVy3ku0x2uK49WvQrZ2KFXABJaQLohPofJ/H7OVdzYtX
   Jt7H7a9GgxKqZ2HOv1q2cpZ155zZPihAtbxNEIzFQSjStA+nBndDV4YmT
   T3XV7JXlqFIyI5RZAFvjyCCO2PqaZeq+ESZK5Z1D+RLLG3G1JBH/MSysR
   XccCVHVs9hcLyRG7QZC0hW886/s77ueKsU/OG5yTTiaA6o+r3/ktr5vcf
   ojoDIdCce6Ay2MoBlIUC3UJtO3qPd9GKsahE8wz2GiWOcFnWl1XBUnWIj
   OwCVvUbM+Q3dFYwntcEee9oGPLi9L6FIoTvZcAkzf1f52rQ9W3+J3mG+T
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="267334078"
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="267334078"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 03:35:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="516014895"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 02 May 2022 03:35:32 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlTOt-0009UR-G2;
        Mon, 02 May 2022 10:35:31 +0000
Date:   Mon, 2 May 2022 18:35:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:axboe/linux-block/for-5.19/io_uring-pbuf 48/89]
 fs/io_uring.c:8498:6: warning: unused variable 'i'
Message-ID: <202205021814.miF011yS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/for-5.=
19/io_uring-pbuf
head:   086401d42d41ebb636d9293288494033cbf9ba10
commit: 5e45690a1cb8cb591ccf4a517cdd6ad6cb369ac4 [48/89] io_uring: store SC=
M state in io_fixed_file->file_ptr
config: mips-randconfig-r015-20220501 (https://download.01.org/0day-ci/arch=
ive/20220502/202205021814.miF011yS-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 09325d=
36061e42b495d1f4c7e933e260eac260ed)
reproduce (this is a W=3D1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/=
make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/5e45690a1cb8cb5=
91ccf4a517cdd6ad6cb369ac4
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/lin=
ux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/for-5.19/io=
_uring-pbuf
        git checkout 5e45690a1cb8cb591ccf4a517cdd6ad6cb369ac4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=3D=
1 O=3Dbuild_dir ARCH=3Dmips SHELL=3D/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/io_uring.c:8498:6: warning: unused variable 'i'
   int i;
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
VMLINUX_LOAD_ADDRESS=3D0xffffffff84000000 -DLINKER_LOAD_ADDRESS=3D0x8400000=
0 -DDATAOFFSET=3D0 -Qunused-arguments -fmacro-prefix-map=3D=3D -DKBUILD_EXT=
RA_WARN1 -Wall -Wundef -Werror=3Dstrict-prototypes -Wno-trigraphs -fno-stri=
ct-aliasing -fno-common -fshort-wchar -fno-PIE -Werror=3Dimplicit-function-=
declaration -Werror=3Dimplicit-int -Werror=3Dreturn-type -Wno-format-securi=
ty -std=3Dgnu11 --target=3Dmips-linux -fintegrated-as -Werror=3Dunknown-war=
ning-option -Werror=3Dignored-optimization-argument -mno-check-zero-divisio=
n -mabi=3D32 -G 0 -mno-abicalls -fno-pic -pipe -msoft-float -DGAS_HAS_SET_H=
ARDFLOAT -Wa,-msoft-float -ffreestanding -EB -fno-stack-check -march=3Dmips=
32 -Wa,--trap -DTOOLCHAIN_SUPPORTS_VIRT -Iarch/mips/include/asm/mach-ath25 =
-Iarch/mips/include/asm/mach-generic -fno-asynchronous-unwind-tables -fno-d=
elete-null-pointer-checks -Wno-frame-address -Wno-address-of-packed-member =
-O2 -Wframe-larger-than=3D1024 -fno-stack-protector -Wimplicit-fallthrough =
-Wno-gnu -Wno-unused-but-set-variable -Wno-unused-const-variable -fno-stack=
-clash-protection -pg -Wdeclaration-after-statement -Wvla -Wno-pointer-sign=
 -Wcast-function-type -fno-strict-overflow -fno-stack-check -Werror=3Ddate-=
time -Werror=3Dincompatible-pointer-types -Wextra -Wunused -Wno-unused-para=
meter -Wmissing-declarations -Wmissing-format-attribute -Wmissing-prototype=
s -Wold-style-definition -Wmissing-include-dirs -Wunused-but-set-variable -=
Wunused-const-variable -Wno-missing-field-initializers -Wno-sign-compare -W=
no-type-limits -Wno-shift-negative-value -I fs -I ./fs -DKBUILD_MODFILE=3D"=
fs/io_uring" -DKBUILD_BASENAME=3D"io_uring" -DKBUILD_MODNAME=3D"io_uring" -=
D__KBUILD_MODNAME=3Dkmod_io_uring -c -o fs/io_uring.o fs/io_uring.c
   1. <eof> parser at end of file
   2. Code generation
   3. Running pass 'Function Pass Manager' on module 'fs/io_uring.c'.
   4. Running pass 'Mips Assembly Printer' on function '@io_uring_cancel_ge=
neric'
   #0 0x000055fc440b0cdf Signals.cpp:0:0
   #1 0x000055fc440aeb04 llvm::sys::CleanupOnSignal(unsigned long) (/opt/cr=
oss/clang-09325d3606/bin/clang-15+0x34b1b04)
   #2 0x000055fc43fedf17 llvm::CrashRecoveryContext::HandleExit(int) (/opt/=
cross/clang-09325d3606/bin/clang-15+0x33f0f17)
   #3 0x000055fc440a713e llvm::sys::Process::Exit(int, bool) (/opt/cross/cl=
ang-09325d3606/bin/clang-15+0x34aa13e)
   #4 0x000055fc41cbf28b (/opt/cross/clang-09325d3606/bin/clang-15+0x10c228=
b)
   #5 0x000055fc43ff4a4c llvm::report_fatal_error(llvm::Twine const&, bool)=
 (/opt/cross/clang-09325d3606/bin/clang-15+0x33f7a4c)
   #6 0x000055fc44d33540 llvm::AsmPrinter::emitInlineAsm(llvm::MachineInstr=
 const (/opt/cross/clang-09325d3606/bin/clang-15+0x4136540)
   #7 0x000055fc44d2f442 llvm::AsmPrinter::emitFunctionBody() (/opt/cross/c=
lang-09325d3606/bin/clang-15+0x4132442)
   #8 0x000055fc427533f7 llvm::MipsAsmPrinter::runOnMachineFunction(llvm::M=
achineFunction&) (/opt/cross/clang-09325d3606/bin/clang-15+0x1b563f7)
   #9 0x000055fc4343a6ad llvm::MachineFunctionPass::runOnFunction(llvm::Fun=
ction&) (.part.53) MachineFunctionPass.cpp:0:0
   #10 0x000055fc438832c7 llvm::FPPassManager::runOnFunction(llvm::Function=
&) (/opt/cross/clang-09325d3606/bin/clang-15+0x2c862c7)
   #11 0x000055fc43883441 llvm::FPPassManager::runOnModule(llvm::Module&) (=
/opt/cross/clang-09325d3606/bin/clang-15+0x2c86441)
   #12 0x000055fc43883fbf llvm::legacy::PassManagerImpl::run(llvm::Module&)=
 (/opt/cross/clang-09325d3606/bin/clang-15+0x2c86fbf)
   #13 0x000055fc443dd37f clang::EmitBackendOutput(clang::DiagnosticsEngine=
&, clang::HeaderSearchOptions const&, clang::CodeGenOptions const&, clang::=
TargetOptions const&, clang::LangOptions const&, llvm::StringRef, clang::Ba=
ckendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<l=
lvm::raw_pwrite_stream> >) (/opt/cross/clang-09325d3606/bin/clang-15+0x37e0=
37f)
   #14 0x000055fc4505ccd1 clang::BackendConsumer::HandleTranslationUnit(cla=
ng::ASTContext&) (/opt/cross/clang-09325d3606/bin/clang-15+0x445fcd1)
   #15 0x000055fc45be2ac1 clang::ParseAST(clang::Sema&, bool, bool) (/opt/c=
ross/clang-09325d3606/bin/clang-15+0x4fe5ac1)
   #16 0x000055fc4505c395 clang::CodeGenAction::ExecuteAction() (/opt/cross=
/clang-09325d3606/bin/clang-15+0x445f395)
   #17 0x000055fc44a44751 clang::FrontendAction::Execute() (/opt/cross/clan=
g-09325d3606/bin/clang-15+0x3e47751)
   #18 0x000055fc449d8d0a clang::CompilerInstance::ExecuteAction(clang::Fro=
ntendAction&) (/opt/cross/clang-09325d3606/bin/clang-15+0x3ddbd0a)
   #19 0x000055fc44b0bc6b (/opt/cross/clang-09325d3606/bin/clang-15+0x3f0ec=
6b)
   #20 0x000055fc41cc083c cc1_main(llvm::ArrayRef<char char (/opt/cross/cla=
ng-09325d3606/bin/clang-15+0x10c383c)
   #21 0x000055fc41cbd50b ExecuteCC1Tool(llvm::SmallVectorImpl<char driver.=
cpp:0:0
   #22 0x000055fc44867d95 void llvm::function_ref<void ()>::callback_fn<cla=
ng::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::StringR=
ef> >, std::__cxx11::basic_string<char, std::char_traits<char>, std::alloca=
tor<char> const::'lambda'()>(long) Job.cpp:0:0
   #23 0x000055fc43feddd3 llvm::CrashRecoveryContext::RunSafely(llvm::funct=
ion_ref<void ()>) (/opt/cross/clang-09325d3606/bin/clang-15+0x33f0dd3)
   #24 0x000055fc4486868e clang::driver::CC1Command::Execute(llvm::ArrayRef=
<llvm::Optional<llvm::StringRef> >, std::__cxx11::basic_string<char, std::c=
har_traits<char>, std::allocator<char> const (.part.216) Job.cpp:0:0
   #25 0x000055fc4483aa17 clang::driver::Compilation::ExecuteCommand(clang:=
:driver::Command const&, clang::driver::Command const (/opt/cross/clang-093=
25d3606/bin/clang-15+0x3c3da17)
   #26 0x000055fc4483b3f7 clang::driver::Compilation::ExecuteJobs(clang::dr=
iver::JobList const&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) const (/opt/cross/clang-09325d3606/bin/clang-15+0x3c3e3f7)
   #27 0x000055fc448448ea clang::driver::Driver::ExecuteCompilation(clang::=
driver::Compilation&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) (/opt/cross/clang-09325d3606/bin/clang-15+0x3c478ea)
   #28 0x000055fc41c0994f main (/opt/cross/clang-09325d3606/bin/clang-15+0x=
100c94f)
   #29 0x00007f969d4be7fd __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x237fd)
   #30 0x000055fc41cbd02a _start (/opt/cross/clang-09325d3606/bin/clang-15+=
0x10c002a)
   clang-15: error: clang frontend command failed with exit code 70 (use -v=
 to see invocation)
   clang version 15.0.0 (git://gitmirror/llvm_project 09325d36061e42b495d1f=
4c7e933e260eac260ed)
   Target: mips-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-09325d3606/bin
   clang-15: note: diagnostic msg:
   Makefile arch block certs crypto drivers fs include init ipc kernel lib =
mm nr_bisected scripts security sound source usr virt


vim +/i +8498 fs/io_uring.c

9123c8ffce1610 Pavel Begunkov   2021-06-14  8495 =20
fff4db76be297b Pavel Begunkov   2021-04-25  8496  static void __io_sqe_file=
s_unregister(struct io_ring_ctx *ctx)
1ad555c6ae6e28 Bijan Mottahedeh 2021-01-15  8497  {
1f59bc0f18cf46 Pavel Begunkov   2022-04-06 @8498  	int i;
1f59bc0f18cf46 Pavel Begunkov   2022-04-06  8499 =20

:::::: The code at line 8498 was first introduced by commit
:::::: 1f59bc0f18cf46abe27ea18cfa4cb7f1b4166896 io_uring: don't scm-account=
 for non af_unix sockets

:::::: TO: Pavel Begunkov <asml.silence@gmail.com>
:::::: CC: Jens Axboe <axboe@kernel.dk>

--=20
0-DAY CI Kernel Test Service
https://01.org/lkp
