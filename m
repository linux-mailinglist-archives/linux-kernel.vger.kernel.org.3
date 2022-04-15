Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C44502654
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 09:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351190AbiDOHqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 03:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239824AbiDOHqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 03:46:42 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D2AB1ABF
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 00:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650008654; x=1681544654;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Zzy7IjHzF/d3dWzhZcg1MSqdh9BcQaNe/RFRNggj9i0=;
  b=Y4vtF37KwfjCBDdeDZK3py+bNFtRbLL/U3NtTglNlwBJ6pryLPlCRe8F
   akt2XRsqUyI0pY6O8/aoIRhU4OY6NTyXmcGma6JP17FA2nDrHEAE5jXBp
   om6t9cmB8Ft9cFs+vH88+p020/bAZ36zbDLl8B6jyqZ/E5JAFW35oK824
   m8CmEPvkTDA/+OBSXw5QBfXxGJjKDeplyvg9vGtpbRif4zskE1snfwrP4
   koVuRW5L0GfL1Bf4RiTaCVg5++LGYQt+gzLg/cJDlqfxvdbTrhoonZ9pQ
   H6roKAVLIXGIuDeguRCPblCBPkucM3Ca5qdNPO5YVcvkULcZ6lsFZhyfh
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="243045601"
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="243045601"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 00:44:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="508853336"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 15 Apr 2022 00:44:09 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfGcj-0001jt-1j;
        Fri, 15 Apr 2022 07:44:09 +0000
Date:   Fri, 15 Apr 2022 15:43:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhipeng Xie <xiezhipeng1@huawei.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: [peterz-queue:perf/wip.self 1/2] kernel/events/internal.h:119:12:
 warning: unused function 'data_page_nr'
Message-ID: <202204151530.OGcSofvs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git pe=
rf/wip.self
head:   f1d67e1a09eeba97cd3f849659d5e5f42628b40b
commit: 4b2def7729bd01b55ffb35992f6d01e3e5a8c808 [1/2] perf/core: Fix perf_=
mmap fail when CONFIG_PERF_USE_VMALLOC enabled
config: mips-randconfig-c004-20220414 (https://download.01.org/0day-ci/arch=
ive/20220415/202204151530.OGcSofvs-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6b7e6e=
a489f6dd45a9b0da9ac20871560917b9b0)
reproduce (this is a W=3D1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/=
make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/=
commit/?id=3D4b2def7729bd01b55ffb35992f6d01e3e5a8c808
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/ke=
rnel/git/peterz/queue.git
        git fetch --no-tags peterz-queue perf/wip.self
        git checkout 4b2def7729bd01b55ffb35992f6d01e3e5a8c808
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=3D=
1 O=3Dbuild_dir ARCH=3Dmips SHELL=3D/bin/bash kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from kernel/events/callchain.c:15:
>> kernel/events/internal.h:119:12: warning: unused function 'data_page_nr'
   static int data_page_nr(struct perf_buffer
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
   0. Program arguments: clang -Wp,-MMD,kernel/events/.callchain.o.d -nostd=
inc -Iarch/mips/include -I./arch/mips/include/generated -Iinclude -I./inclu=
de -Iarch/mips/include/uapi -I./arch/mips/include/generated/uapi -Iinclude/=
uapi -I./include/generated/uapi -include include/linux/compiler-version.h -=
include include/linux/kconfig.h -include include/linux/compiler_types.h -D_=
_KERNEL__ -DVMLINUX_LOAD_ADDRESS=3D0xffffffff84000000 -DLINKER_LOAD_ADDRESS=
=3D0x84000000 -DDATAOFFSET=3D0 -Qunused-arguments -fmacro-prefix-map=3D=3D =
-DKBUILD_EXTRA_WARN1 -Wall -Wundef -Werror=3Dstrict-prototypes -Wno-trigrap=
hs -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE -Werror=3Dimplic=
it-function-declaration -Werror=3Dimplicit-int -Werror=3Dreturn-type -Wno-f=
ormat-security -std=3Dgnu11 --target=3Dmips-linux -fintegrated-as -Werror=
=3Dunknown-warning-option -Werror=3Dignored-optimization-argument -mno-chec=
k-zero-division -mabi=3D32 -G 0 -mno-abicalls -fno-pic -pipe -msoft-float -=
DGAS_HAS_SET_HARDFLOAT -Wa,-msoft-float -ffreestanding -EB -fno-stack-check=
 -march=3Dmips32r2 -Wa,--trap -DTOOLCHAIN_SUPPORTS_VIRT -Iarch/mips/include=
/asm/mach-ath79 -Iarch/mips/include/asm/mach-generic -fno-asynchronous-unwi=
nd-tables -fno-delete-null-pointer-checks -Wno-frame-address -Wno-address-o=
f-packed-member -O2 -Wframe-larger-than=3D1024 -fstack-protector -Wimplicit=
-fallthrough -Wno-gnu -Wno-unused-but-set-variable -Wno-unused-const-variab=
le -fno-stack-clash-protection -pg -Wdeclaration-after-statement -Wvla -Wno=
-pointer-sign -Wcast-function-type -fno-strict-overflow -fno-stack-check -W=
error=3Ddate-time -Werror=3Dincompatible-pointer-types -Wextra -Wunused -Wn=
o-unused-parameter -Wmissing-declarations -Wmissing-format-attribute -Wmiss=
ing-prototypes -Wold-style-definition -Wmissing-include-dirs -Wunused-but-s=
et-variable -Wunused-const-variable -Wno-missing-field-initializers -Wno-si=
gn-compare -Wno-type-limits -Wno-shift-negative-value -gsplit-dwarf -gdwarf=
-5 -I kernel/events -I ./kernel/events -ffunction-sections -fdata-sections =
-DKBUILD_MODFILE=3D"kernel/events/callchain" -DKBUILD_BASENAME=3D"callchain=
" -DKBUILD_MODNAME=3D"callchain" -D__KBUILD_MODNAME=3Dkmod_callchain -c -o =
kernel/events/callchain.o kernel/events/callchain.c
   1. <eof> parser at end of file
   2. Code generation
   3. Running pass 'Function Pass Manager' on module 'kernel/events/callcha=
in.c'.
   4. Running pass 'Mips Assembly Printer' on function '@get_callchain_buff=
ers'
   #0 0x000055dd1484ea7f Signals.cpp:0:0
   #1 0x000055dd1484c8a4 llvm::sys::CleanupOnSignal(unsigned long) (/opt/cr=
oss/clang-6b7e6ea489/bin/clang-15+0x34f18a4)
   #2 0x000055dd1478c087 llvm::CrashRecoveryContext::HandleExit(int) (/opt/=
cross/clang-6b7e6ea489/bin/clang-15+0x3431087)
   #3 0x000055dd14844ede llvm::sys::Process::Exit(int, bool) (/opt/cross/cl=
ang-6b7e6ea489/bin/clang-15+0x34e9ede)
   #4 0x000055dd1241892b (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x10bd92=
b)
   #5 0x000055dd14792bac llvm::report_fatal_error(llvm::Twine const&, bool)=
 (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x3437bac)
   #6 0x000055dd154c2260 llvm::AsmPrinter::emitInlineAsm(llvm::MachineInstr=
 const (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x4167260)
   #7 0x000055dd154be162 llvm::AsmPrinter::emitFunctionBody() (/opt/cross/c=
lang-6b7e6ea489/bin/clang-15+0x4163162)
   #8 0x000055dd12e9ed07 llvm::MipsAsmPrinter::runOnMachineFunction(llvm::M=
achineFunction&) (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x1b43d07)
   #9 0x000055dd13b7a47d llvm::MachineFunctionPass::runOnFunction(llvm::Fun=
ction&) (.part.53) MachineFunctionPass.cpp:0:0
   #10 0x000055dd13fc4457 llvm::FPPassManager::runOnFunction(llvm::Function=
&) (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x2c69457)
   #11 0x000055dd13fc45d1 llvm::FPPassManager::runOnModule(llvm::Module&) (=
/opt/cross/clang-6b7e6ea489/bin/clang-15+0x2c695d1)
   #12 0x000055dd13fc514f llvm::legacy::PassManagerImpl::run(llvm::Module&)=
 (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x2c6a14f)
   #13 0x000055dd14b794c6 clang::EmitBackendOutput(clang::DiagnosticsEngine=
&, clang::HeaderSearchOptions const&, clang::CodeGenOptions const&, clang::=
TargetOptions const&, clang::LangOptions const&, llvm::StringRef, clang::Ba=
ckendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<l=
lvm::raw_pwrite_stream> >) (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x381e=
4c6)
   #14 0x000055dd157e2ca3 clang::BackendConsumer::HandleTranslationUnit(cla=
ng::ASTContext&) (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x4487ca3)
   #15 0x000055dd16316a01 clang::ParseAST(clang::Sema&, bool, bool) (/opt/c=
ross/clang-6b7e6ea489/bin/clang-15+0x4fbba01)
   #16 0x000055dd157e2395 clang::CodeGenAction::ExecuteAction() (/opt/cross=
/clang-6b7e6ea489/bin/clang-15+0x4487395)
   #17 0x000055dd151d8831 clang::FrontendAction::Execute() (/opt/cross/clan=
g-6b7e6ea489/bin/clang-15+0x3e7d831)
   #18 0x000055dd1516db1a clang::CompilerInstance::ExecuteAction(clang::Fro=
ntendAction&) (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x3e12b1a)
   #19 0x000055dd1529f63b (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x3f446=
3b)
   #20 0x000055dd12419edc cc1_main(llvm::ArrayRef<char char (/opt/cross/cla=
ng-6b7e6ea489/bin/clang-15+0x10beedc)
   #21 0x000055dd12416bab ExecuteCC1Tool(llvm::SmallVectorImpl<char driver.=
cpp:0:0
   #22 0x000055dd150003f5 void llvm::function_ref<void ()>::callback_fn<cla=
ng::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::StringR=
ef> >, std::__cxx11::basic_string<char, std::char_traits<char>, std::alloca=
tor<char> const::'lambda'()>(long) Job.cpp:0:0
   #23 0x000055dd1478bf43 llvm::CrashRecoveryContext::RunSafely(llvm::funct=
ion_ref<void ()>) (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x3430f43)
   #24 0x000055dd15000cee clang::driver::CC1Command::Execute(llvm::ArrayRef=
<llvm::Optional<llvm::StringRef> >, std::__cxx11::basic_string<char, std::c=
har_traits<char>, std::allocator<char> const (.part.216) Job.cpp:0:0
   #25 0x000055dd14fd4de7 clang::driver::Compilation::ExecuteCommand(clang:=
:driver::Command const&, clang::driver::Command const (/opt/cross/clang-6b7=
e6ea489/bin/clang-15+0x3c79de7)
   #26 0x000055dd14fd57c7 clang::driver::Compilation::ExecuteJobs(clang::dr=
iver::JobList const&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) const (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x3c7a7c7)
   #27 0x000055dd14fdee19 clang::driver::Driver::ExecuteCompilation(clang::=
driver::Compilation&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x3c83e19)
   #28 0x000055dd12363d2f main (/opt/cross/clang-6b7e6ea489/bin/clang-15+0x=
1008d2f)
   #29 0x00007f18176877fd __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x237fd)
   #30 0x000055dd124166ca _start (/opt/cross/clang-6b7e6ea489/bin/clang-15+=
0x10bb6ca)
   clang-15: error: clang frontend command failed with exit code 70 (use -v=
 to see invocation)
   clang version 15.0.0 (git://gitmirror/llvm_project 6b7e6ea489f6dd45a9b0d=
a9ac20871560917b9b0)
   Target: mips-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-6b7e6ea489/bin
   clang-15: note: diagnostic msg:
   Makefile arch include kernel nr_bisected scripts source usr


vim +/data_page_nr +119 kernel/events/internal.h

   118=09
 > 119	static int data_page_nr(struct perf_buffer *rb)
   120	{
   121		return rb->nr_pages << page_order(rb);
   122	}
   123=09

--=20
0-DAY CI Kernel Test Service
https://01.org/lkp
