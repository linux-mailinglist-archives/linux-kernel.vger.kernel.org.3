Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF614E37F4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 05:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbiCVEbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 00:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236427AbiCVEbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 00:31:20 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C6F186C9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 21:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647923393; x=1679459393;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=+vZF8mD3EtUV+YWqAgVvtqCMdtdZsAaFJbUF+BnC+I0=;
  b=GIxP5O1ph1jwEhmyCV5LE5wi6SvQHkeunqBrVfMePnxtkbWb3fqWgqtt
   gRG4FCRfkgUF4KN4ly/jfo9V8+aANt92r/nHyDZV6utPTqFd73A+x/bIA
   EyY4jgLm0iLb/TUioR8or+tfnFK/ZVLmakM6LCu66bVa8tBZsxyiY9crE
   Od5NyB+wRt/fap1EqI7QfG+gSeIE6ZHDGEpFltAlWiAxPIVicvg0/dMHV
   hzwXMuilSQQCZXN/Y0+Fks/iiIcwZbmqTYdmtnFj4Rq9MJzuXosz+JANj
   vG2sULWT8QX23J5DrMQ5ZP8yQdajzD255BqMgVd1OHbtOmZN00pSAsqlB
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="318428029"
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="318428029"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 21:29:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="518718737"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 21 Mar 2022 21:29:51 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWW9X-000ITm-24; Tue, 22 Mar 2022 04:29:51 +0000
Date:   Tue, 22 Mar 2022 12:29:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jgunthorpe:iommufd 7/13]
 drivers/iommu/iommufd/io_pagetable.c:486:14: warning: comparison of distinct
 pointer types ('typeof (iova) (aka 'unsigned long and 'typeof (length - 1)
 (aka 'unsigned int
Message-ID: <202203221253.Vhpboxoj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jgunthorpe/linux iommufd
head:   fc388f906088fe5f5f2db6a36931e00124f52042
commit: 1af524ce30ddf820ec974c8635d3299caefc72ed [7/13] iommufd: Data struc=
ture to provide IOVA to PFN mapping
config: mips-randconfig-c004-20220322 (https://download.01.org/0day-ci/arch=
ive/20220322/202203221253.Vhpboxoj-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 85e9b2=
687a13d1908aa86d1b89c5ce398a06cd39)
reproduce (this is a W=3D1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/=
make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/jgunthorpe/linux/commit/1af524ce30ddf820ec974c=
8635d3299caefc72ed
        git remote add jgunthorpe https://github.com/jgunthorpe/linux
        git fetch --no-tags jgunthorpe iommufd
        git checkout 1af524ce30ddf820ec974c8635d3299caefc72ed
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=3D=
1 ARCH=3Dmips=20

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/iommu/iommufd/io_pagetable.c:486:14: warning: comparison of dist=
inct pointer types ('typeof (iova) (aka 'unsigned long and 'typeof (length =
- 1) (aka 'unsigned int
   WARN_ON(check_add_overflow(iova, length - 1, &last_iova)))
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:66:15: note: expanded from macro 'check_add_ove=
rflow'
   (void) (&__a =3D=3D &__b); ~~~~ ^ ~~~~
   include/asm-generic/bug.h:121:25: note: expanded from macro 'WARN_ON'
   int __ret_warn_on =3D ^~~~~~~~~
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( , ## __VA_ARGS__) ) )
   ^~~~
   include/linux/compiler.h:58:52: note: expanded from macro '__trace_if_va=
r'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) (cond) : __trac=
e_if_value(cond))
   ^~~~
>> drivers/iommu/iommufd/io_pagetable.c:486:14: warning: comparison of dist=
inct pointer types ('typeof (iova) (aka 'unsigned long and 'typeof (length =
- 1) (aka 'unsigned int
   WARN_ON(check_add_overflow(iova, length - 1, &last_iova)))
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:66:15: note: expanded from macro 'check_add_ove=
rflow'
   (void) (&__a =3D=3D &__b); ~~~~ ^ ~~~~
   include/asm-generic/bug.h:121:25: note: expanded from macro 'WARN_ON'
   int __ret_warn_on =3D ^~~~~~~~~
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( , ## __VA_ARGS__) ) )
   ^~~~
   include/linux/compiler.h:58:61: note: expanded from macro '__trace_if_va=
r'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) (cond) : __trac=
e_if_value(cond))
   ^~~~
>> drivers/iommu/iommufd/io_pagetable.c:486:14: warning: comparison of dist=
inct pointer types ('typeof (iova) (aka 'unsigned long and 'typeof (length =
- 1) (aka 'unsigned int
   WARN_ON(check_add_overflow(iova, length - 1, &last_iova)))
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:66:15: note: expanded from macro 'check_add_ove=
rflow'
   (void) (&__a =3D=3D &__b); ~~~~ ^ ~~~~
   include/asm-generic/bug.h:121:25: note: expanded from macro 'WARN_ON'
   int __ret_warn_on =3D ^~~~~~~~~
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( , ## __VA_ARGS__) ) )
   ^~~~
   include/linux/compiler.h:58:86: note: expanded from macro '__trace_if_va=
r'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) (cond) : __trac=
e_if_value(cond))
   ^~~~
   include/linux/compiler.h:69:3: note: expanded from macro '__trace_if_val=
ue'
   (cond) ^~~~
   fatal error: error in backend: Nested variants found in inline asm strin=
g: ' .set push
   .set mips64r2
   .if ( 0x00 ) !=3D -1)) 0x00 ) !=3D -1)) : ($( static struct ftrace_branc=
h_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_=
branch"))) __if_trace =3D $( .func =3D __func__, .file =3D "arch/mips/inclu=
de/asm/atomic.h", .line =3D 156, $); 0x00 ) !=3D -1)) : $))) ) && ( 0 ); .s=
et push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif
   1: ll $1, $2 # atomic_fetch_sub
   subu $0, $1, $3
   sc $0, $2
   beqz $0, 1b
   .set pop
   move $0, $1
   '
   PLEASE submit a bug report to https://github.com/llvm/llvm-project/issue=
s/ and include the crash backtrace, preprocessed source, and associated run=
 script.
   Stack dump:
   0. Program arguments: clang -Wp,-MMD,drivers/iommu/iommufd/.io_pagetable=
=2Eo.d -nostdinc -Iarch/mips/include -I./arch/mips/include/generated -Iincl=
ude -I./include -Iarch/mips/include/uapi -I./arch/mips/include/generated/ua=
pi -Iinclude/uapi -I./include/generated/uapi -include include/linux/compile=
r-version.h -include include/linux/kconfig.h -include include/linux/compile=
r_types.h -D__KERNEL__ -DVMLINUX_LOAD_ADDRESS=3D0xffffffff84000000 -DLINKER=
_LOAD_ADDRESS=3D0x84000000 -DDATAOFFSET=3D0 -Qunused-arguments -fmacro-pref=
ix-map=3D=3D -DKBUILD_EXTRA_WARN1 -Wall -Wundef -Werror=3Dstrict-prototypes=
 -Wno-trigraphs -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE -We=
rror=3Dimplicit-function-declaration -Werror=3Dimplicit-int -Werror=3Dretur=
n-type -Wno-format-security -std=3Dgnu89 --target=3Dmips-linux -fintegrated=
-as -Werror=3Dunknown-warning-option -Werror=3Dignored-optimization-argumen=
t -mno-check-zero-division -mabi=3D32 -G 0 -mno-abicalls -fno-pic -pipe -ms=
oft-float -DGAS_HAS_SET_HARDFLOAT -Wa,-msoft-float -ffreestanding -EB -fno-=
stack-check -march=3Dmips32 -Wa,-mips32 -Wa,--trap -DTOOLCHAIN_SUPPORTS_VIR=
T -Iarch/mips/include/asm/mach-bcm63xx/ -Iarch/mips/include/asm/mach-generi=
c -fno-asynchronous-unwind-tables -fno-delete-null-pointer-checks -Wno-fram=
e-address -Wno-address-of-packed-member -Os -Wframe-larger-than=3D1024 -fno=
-stack-protector -Wimplicit-fallthrough -Wno-gnu -mno-global-merge -Wno-unu=
sed-but-set-variable -Wno-unused-const-variable -ftrivial-auto-var-init=3Dp=
attern -fno-stack-clash-protection -pg -Wdeclaration-after-statement -Wvla =
-Wno-pointer-sign -Wcast-function-type -Wno-array-bounds -fno-strict-overfl=
ow -fno-stack-check -Werror=3Ddate-time -Werror=3Dincompatible-pointer-type=
s -Wextra -Wunused -Wno-unused-parameter -Wmissing-declarations -Wmissing-f=
ormat-attribute -Wmissing-prototypes -Wold-style-definition -Wmissing-inclu=
de-dirs -Wunused-but-set-variable -Wunused-const-variable -Wno-missing-fiel=
d-initializers -Wno-sign-compare -Wno-type-limits -fsanitize=3Darray-bounds=
 -fsanitize=3Dshift -fsanitize=3Dinteger-divide-by-zero -fsanitize-coverage=
=3Dtrace-pc -I drivers/iommu/iommufd -I ./drivers/iommu/iommufd -DKBUILD_MO=
DFILE=3D"drivers/iommu/iommufd/iommufd" -DKBUILD_BASENAME=3D"io_pagetable" =
-DKBUILD_MODNAME=3D"iommufd" -D__KBUILD_MODNAME=3Dkmod_iommufd -c -o driver=
s/iommu/iommufd/io_pagetable.o drivers/iommu/iommufd/io_pagetable.c
   1. <eof> parser at end of file
   2. Code generation
   3. Running pass 'Function Pass Manager' on module 'drivers/iommu/iommufd=
/io_pagetable.c'.
   4. Running pass 'Mips Assembly Printer' on function '@iopt_map_user_page=
s'
   #0 0x00005635c4ce26bf Signals.cpp:0:0
   #1 0x00005635c4ce059c llvm::sys::CleanupOnSignal(unsigned long) (/opt/cr=
oss/clang-85e9b2687a/bin/clang-15+0x349f59c)
   #2 0x00005635c4c1ffc7 llvm::CrashRecoveryContext::HandleExit(int) (/opt/=
cross/clang-85e9b2687a/bin/clang-15+0x33defc7)
   #3 0x00005635c4cd8c4e llvm::sys::Process::Exit(int, bool) (/opt/cross/cl=
ang-85e9b2687a/bin/clang-15+0x3497c4e)
   #4 0x00005635c28dd18b (/opt/cross/clang-85e9b2687a/bin/clang-15+0x109c18=
b)
   #5 0x00005635c4c26aec llvm::report_fatal_error(llvm::Twine const&, bool)=
 (/opt/cross/clang-85e9b2687a/bin/clang-15+0x33e5aec)
   #6 0x00005635c5943880 llvm::AsmPrinter::emitInlineAsm(llvm::MachineInstr=
 const (/opt/cross/clang-85e9b2687a/bin/clang-15+0x4102880)
   #7 0x00005635c593f744 llvm::AsmPrinter::emitFunctionBody() (/opt/cross/c=
lang-85e9b2687a/bin/clang-15+0x40fe744)
   #8 0x00005635c33587a7 llvm::MipsAsmPrinter::runOnMachineFunction(llvm::M=
achineFunction&) (/opt/cross/clang-85e9b2687a/bin/clang-15+0x1b177a7)
   #9 0x00005635c4022cbd llvm::MachineFunctionPass::runOnFunction(llvm::Fun=
ction&) (.part.53) MachineFunctionPass.cpp:0:0
   #10 0x00005635c446a857 llvm::FPPassManager::runOnFunction(llvm::Function=
&) (/opt/cross/clang-85e9b2687a/bin/clang-15+0x2c29857)
   #11 0x00005635c446a9d1 llvm::FPPassManager::runOnModule(llvm::Module&) (=
/opt/cross/clang-85e9b2687a/bin/clang-15+0x2c299d1)
   #12 0x00005635c446b54f llvm::legacy::PassManagerImpl::run(llvm::Module&)=
 (/opt/cross/clang-85e9b2687a/bin/clang-15+0x2c2a54f)
   #13 0x00005635c5001f47 clang::EmitBackendOutput(clang::DiagnosticsEngine=
&, clang::HeaderSearchOptions const&, clang::CodeGenOptions const&, clang::=
TargetOptions const&, clang::LangOptions const&, llvm::StringRef, clang::Ba=
ckendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<l=
lvm::raw_pwrite_stream> >) (/opt/cross/clang-85e9b2687a/bin/clang-15+0x37c0=
f47)
   #14 0x00005635c5c642e3 clang::BackendConsumer::HandleTranslationUnit(cla=
ng::ASTContext&) (/opt/cross/clang-85e9b2687a/bin/clang-15+0x44232e3)
   #15 0x00005635c6777b71 clang::ParseAST(clang::Sema&, bool, bool) (/opt/c=
ross/clang-85e9b2687a/bin/clang-15+0x4f36b71)
   #16 0x00005635c5c639c5 clang::CodeGenAction::ExecuteAction() (/opt/cross=
/clang-85e9b2687a/bin/clang-15+0x44229c5)
   #17 0x00005635c565cec1 clang::FrontendAction::Execute() (/opt/cross/clan=
g-85e9b2687a/bin/clang-15+0x3e1bec1)
   #18 0x00005635c55f2d1a clang::CompilerInstance::ExecuteAction(clang::Fro=
ntendAction&) (/opt/cross/clang-85e9b2687a/bin/clang-15+0x3db1d1a)
   #19 0x00005635c57227bb (/opt/cross/clang-85e9b2687a/bin/clang-15+0x3ee17=
bb)
   #20 0x00005635c28de73c cc1_main(llvm::ArrayRef<char char (/opt/cross/cla=
ng-85e9b2687a/bin/clang-15+0x109d73c)
   #21 0x00005635c28db40b ExecuteCC1Tool(llvm::SmallVectorImpl<char driver.=
cpp:0:0
   #22 0x00005635c548a0a5 void llvm::function_ref<void ()>::callback_fn<cla=
ng::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::StringR=
ef> >, std::__cxx11::basic_string<char, std::char_traits<char>, std::alloca=
tor<char> const::'lambda'()>(long) Job.cpp:0:0
   #23 0x00005635c4c1fe83 llvm::CrashRecoveryContext::RunSafely(llvm::funct=
ion_ref<void ()>) (/opt/cross/clang-85e9b2687a/bin/clang-15+0x33dee83)
   #24 0x00005635c548a99e clang::driver::CC1Command::Execute(llvm::ArrayRef=
<llvm::Optional<llvm::StringRef> >, std::__cxx11::basic_string<char, std::c=
har_traits<char>, std::allocator<char> const (.part.216) Job.cpp:0:0
   #25 0x00005635c545f2e7 clang::driver::Compilation::ExecuteCommand(clang:=
:driver::Command const&, clang::driver::Command const (/opt/cross/clang-85e=
9b2687a/bin/clang-15+0x3c1e2e7)
   #26 0x00005635c545fcc7 clang::driver::Compilation::ExecuteJobs(clang::dr=
iver::JobList const&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) const (/opt/cross/clang-85e9b2687a/bin/clang-15+0x3c1ecc7)
   #27 0x00005635c5469369 clang::driver::Driver::ExecuteCompilation(clang::=
driver::Compilation&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) (/opt/cross/clang-85e9b2687a/bin/clang-15+0x3c28369)
   #28 0x00005635c282891f main (/opt/cross/clang-85e9b2687a/bin/clang-15+0x=
fe791f)
   #29 0x00007fab4e98fd0a __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x26d0a)
   #30 0x00005635c28daf2a _start (/opt/cross/clang-85e9b2687a/bin/clang-15+=
0x1099f2a)
   clang-15: error: clang frontend command failed with exit code 70 (use -v=
 to see invocation)
   clang version 15.0.0 (git://gitmirror/llvm_project 85e9b2687a13d1908aa86=
d1b89c5ce398a06cd39)
   Target: mips-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-85e9b2687a/bin
   clang-15: note: diagnostic msg:
   Makefile arch drivers include kernel mm net nr_bisected scripts source u=
sr


vim +486 drivers/iommu/iommufd/io_pagetable.c

   468=09
   469	/**
   470	 * iopt_unaccess_pages() - Undo iopt_access_pages
   471	 * @iopt: io_pagetable to act on
   472	 * @iova: Starting IOVA
   473	 * @length:- Number of bytes to access
   474	 *
   475	 * Return the struct page's. The caller must stop accessing them bef=
ore calling
   476	 * this. The iova/length must exactly match the one provided to acce=
ss_pages.
   477	 */
   478	void iopt_unaccess_pages(struct io_pagetable *iopt, unsigned long io=
va,
   479				 size_t length)
   480	{
   481		unsigned long cur_iova =3D iova;
   482		unsigned long last_iova;
   483		struct iopt_area *area;
   484=09
   485		if (WARN_ON(!length) ||
 > 486		    WARN_ON(check_add_overflow(iova, length - 1, &last_iova)))
   487			return;
   488=09
   489		down_read(&iopt->iova_rwsem);
   490		for (area =3D iopt_area_iter_first(iopt, iova, last_iova); area;
   491		     area =3D iopt_area_iter_next(area, iova, last_iova)) {
   492			unsigned long last =3D min(last_iova, iopt_area_last_iova(area));
   493			int num_users;
   494=09
   495			iopt_pages_remove_user(area->pages,
   496					       iopt_area_iova_to_index(area, cur_iova),
   497					       iopt_area_iova_to_index(area, last));
   498			if (last =3D=3D last_iova)
   499				break;
   500			cur_iova =3D last + 1;
   501			num_users =3D atomic_dec_return(&area->num_users);
   502			WARN_ON(num_users < 0);
   503		}
   504		up_read(&iopt->iova_rwsem);
   505	}
   506=09

--=20
0-DAY CI Kernel Test Service
https://01.org/lkp
