Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F19250E228
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242160AbiDYNp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbiDYNpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:45:12 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3034927F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650894126; x=1682430126;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=gr9qFS67bb8wweSq9xKEh6k8ZkaKSH29scaY6jGCNKA=;
  b=D+CoBejZW5vXbwz4WKX5m5Xyv8HBLzC2j3dIavp8pDgMCJaZe5mhXsp6
   HUeJzmmtf0OsV2H293xCSI2LL19BeSoStJyznvkTbJO+yaPacrb9XaZt3
   uRnJkuRzLfnnBhaMagk2Su/r3BTffZC4mXbPo4TEEz2UNya8wvOzP3kcT
   tCZbnwAU0Iqy5K8t6VB7DSCjdMz0HmsyE7KNIoGpC0C6NoygnzJHUS65I
   sVI7yoQtSjmeK4ONAdLG5BgOpw6pkdsC0rYLcFDRinBHXtb3mwuCuARDi
   Tka7BwctoqPgWpaaHAWLL5HIQLo4w6NtTnDYmxP0AQjDKzTrtmIgoeKa7
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="247177064"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="247177064"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 06:42:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="649700497"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Apr 2022 06:42:04 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niyyZ-0002Xq-UT;
        Mon, 25 Apr 2022 13:42:03 +0000
Date:   Mon, 25 Apr 2022 21:41:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 29/44]
 fs/netfs/crypto.c:76:10: warning: comparison of distinct pointer types
 ('typeof (len) (aka 'unsigned int and 'typeof (((1UL) << 12) - offset) (aka
 'unsigned long
Message-ID: <202204252127.hel9AE2b-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-=
maple
head:   931e50676c6598d0eda1954ead465519ff91874d
commit: 030bb8e418ec7ca1b1411ccc9b4528311880388f [29/44] netfs: Decrypt enc=
rypted content
config: mips-randconfig-r022-20220425 (https://download.01.org/0day-ci/arch=
ive/20220425/202204252127.hel9AE2b-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 1cddcf=
dc3c683b393df1a5c9063252eb60e52818)
reproduce (this is a W=3D1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/=
make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/030bb8e418ec7ca=
1b1411ccc9b4528311880388f
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/lin=
ux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout 030bb8e418ec7ca1b1411ccc9b4528311880388f
        # save the config file
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=3D=
1 ARCH=3Dmips=20

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/netfs/crypto.c:76:10: warning: comparison of distinct pointer types (=
'typeof (len) (aka 'unsigned int and 'typeof (((1UL) << 12) - offset) (aka =
'unsigned long
   seg =3D min(len, PAGE_SIZE - offset);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:45:19: note: expanded from macro 'min'
   #define min(x, y) __careful_cmp(x, y, <)
   ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: expanded from macro '__careful_cmp'
   __builtin_choose_expr(__safe_cmp(x, y), ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:26:4: note: expanded from macro '__safe_cmp'
   (__typecheck(x, y) && __no_side_effects(x, y))
   ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:20:28: note: expanded from macro '__typecheck'
   =3D=3D (typeof(y)
   ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   fatal error: error in backend: Nested variants found in inline asm strin=
g: ' .set push
   .set mips64r2
   .if ( 0x00 ) !=3D -1)) 0x00 ) !=3D -1)) : ($( static struct ftrace_branc=
h_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_=
branch"))) __if_trace =3D $( .func =3D __func__, .file =3D "arch/mips/inclu=
de/asm/bitops.h", .line =3D 103, $); 0x00 ) !=3D -1)) : $))) ) && ( 0 ); .s=
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
   0. Program arguments: clang -Wp,-MMD,fs/netfs/.crypto.o.d -nostdinc -Iar=
ch/mips/include -I./arch/mips/include/generated -Iinclude -I./include -Iarc=
h/mips/include/uapi -I./arch/mips/include/generated/uapi -Iinclude/uapi -I.=
/include/generated/uapi -include include/linux/compiler-version.h -include =
include/linux/kconfig.h -include include/linux/compiler_types.h -D__KERNEL_=
_ -DVMLINUX_LOAD_ADDRESS=3D0xffffffff84000000 -DLINKER_LOAD_ADDRESS=3D0x840=
00000 -DDATAOFFSET=3D0 -Qunused-arguments -fmacro-prefix-map=3D=3D -DKBUILD=
_EXTRA_WARN1 -Wall -Wundef -Werror=3Dstrict-prototypes -Wno-trigraphs -fno-=
strict-aliasing -fno-common -fshort-wchar -fno-PIE -Werror=3Dimplicit-funct=
ion-declaration -Werror=3Dimplicit-int -Werror=3Dreturn-type -Wno-format-se=
curity -std=3Dgnu11 --target=3Dmipsel-linux -fintegrated-as -Werror=3Dunkno=
wn-warning-option -Werror=3Dignored-optimization-argument -mno-check-zero-d=
ivision -mabi=3D32 -G 0 -mno-abicalls -fno-pic -pipe -msoft-float -DGAS_HAS=
_SET_HARDFLOAT -Wa,-msoft-float -ffreestanding -EL -fno-stack-check -march=
=3Dmips32r2 -Wa,--trap -DTOOLCHAIN_SUPPORTS_VIRT -Iarch/mips/include/asm/ma=
ch-ingenic -Iarch/mips/include/asm/mach-generic -Iarch/mips/include/asm/mac=
h-generic -fno-asynchronous-unwind-tables -fno-delete-null-pointer-checks -=
Wno-frame-address -Wno-address-of-packed-member -Os -Wframe-larger-than=3D1=
024 -fstack-protector -Wimplicit-fallthrough -Wno-gnu -Wno-unused-but-set-v=
ariable -Wno-unused-const-variable -fno-stack-clash-protection -pg -Wdeclar=
ation-after-statement -Wvla -Wno-pointer-sign -Wcast-function-type -fno-str=
ict-overflow -fno-stack-check -Werror=3Ddate-time -Werror=3Dincompatible-po=
inter-types -Wextra -Wunused -Wno-unused-parameter -Wmissing-declarations -=
Wmissing-format-attribute -Wmissing-prototypes -Wold-style-definition -Wmis=
sing-include-dirs -Wunused-but-set-variable -Wunused-const-variable -Wno-mi=
ssing-field-initializers -Wno-sign-compare -Wno-type-limits -Wno-shift-nega=
tive-value -I fs/netfs -I ./fs/netfs -ffunction-sections -fdata-sections -D=
KBUILD_MODFILE=3D"fs/netfs/netfs" -DKBUILD_BASENAME=3D"crypto" -DKBUILD_MOD=
NAME=3D"netfs" -D__KBUILD_MODNAME=3Dkmod_netfs -c -o fs/netfs/crypto.o fs/n=
etfs/crypto.c
   1. <eof> parser at end of file
   2. Code generation
   3. Running pass 'Function Pass Manager' on module 'fs/netfs/crypto.c'.
   4. Running pass 'Mips Assembly Printer' on function '@netfs_decrypt'
   #0 0x000055991084aa2f Signals.cpp:0:0
   #1 0x0000559910848854 llvm::sys::CleanupOnSignal(unsigned long) (/opt/cr=
oss/clang-1cddcfdc3c/bin/clang-15+0x34bf854)
   #2 0x0000559910787cf7 llvm::CrashRecoveryContext::HandleExit(int) (/opt/=
cross/clang-1cddcfdc3c/bin/clang-15+0x33fecf7)
   #3 0x0000559910840e8e llvm::sys::Process::Exit(int, bool) (/opt/cross/cl=
ang-1cddcfdc3c/bin/clang-15+0x34b7e8e)
   #4 0x000055990e44a5db (/opt/cross/clang-1cddcfdc3c/bin/clang-15+0x10c15d=
b)
   #5 0x000055991078e81c llvm::report_fatal_error(llvm::Twine const&, bool)=
 (/opt/cross/clang-1cddcfdc3c/bin/clang-15+0x340581c)
   #6 0x00005599114c4a30 llvm::AsmPrinter::emitInlineAsm(llvm::MachineInstr=
 const (/opt/cross/clang-1cddcfdc3c/bin/clang-15+0x413ba30)
   #7 0x00005599114c0932 llvm::AsmPrinter::emitFunctionBody() (/opt/cross/c=
lang-1cddcfdc3c/bin/clang-15+0x4137932)
   #8 0x000055990eed8f77 llvm::MipsAsmPrinter::runOnMachineFunction(llvm::M=
achineFunction&) (/opt/cross/clang-1cddcfdc3c/bin/clang-15+0x1b4ff77)
   #9 0x000055990fbbaf8d llvm::MachineFunctionPass::runOnFunction(llvm::Fun=
ction&) (.part.53) MachineFunctionPass.cpp:0:0
   #10 0x0000559910001597 llvm::FPPassManager::runOnFunction(llvm::Function=
&) (/opt/cross/clang-1cddcfdc3c/bin/clang-15+0x2c78597)
   #11 0x0000559910001711 llvm::FPPassManager::runOnModule(llvm::Module&) (=
/opt/cross/clang-1cddcfdc3c/bin/clang-15+0x2c78711)
   #12 0x000055991000228f llvm::legacy::PassManagerImpl::run(llvm::Module&)=
 (/opt/cross/clang-1cddcfdc3c/bin/clang-15+0x2c7928f)
   #13 0x0000559910b7534f clang::EmitBackendOutput(clang::DiagnosticsEngine=
&, clang::HeaderSearchOptions const&, clang::CodeGenOptions const&, clang::=
TargetOptions const&, clang::LangOptions const&, llvm::StringRef, clang::Ba=
ckendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<l=
lvm::raw_pwrite_stream> >) (/opt/cross/clang-1cddcfdc3c/bin/clang-15+0x37ec=
34f)
   #14 0x00005599117e9e11 clang::BackendConsumer::HandleTranslationUnit(cla=
ng::ASTContext&) (/opt/cross/clang-1cddcfdc3c/bin/clang-15+0x4460e11)
   #15 0x00005599123586b1 clang::ParseAST(clang::Sema&, bool, bool) (/opt/c=
ross/clang-1cddcfdc3c/bin/clang-15+0x4fcf6b1)
   #16 0x00005599117e94d5 clang::CodeGenAction::ExecuteAction() (/opt/cross=
/clang-1cddcfdc3c/bin/clang-15+0x44604d5)
   #17 0x00005599111d8be1 clang::FrontendAction::Execute() (/opt/cross/clan=
g-1cddcfdc3c/bin/clang-15+0x3e4fbe1)
   #18 0x000055991116d5aa clang::CompilerInstance::ExecuteAction(clang::Fro=
ntendAction&) (/opt/cross/clang-1cddcfdc3c/bin/clang-15+0x3de45aa)
   #19 0x00005599112a02db (/opt/cross/clang-1cddcfdc3c/bin/clang-15+0x3f172=
db)
   #20 0x000055990e44bb8c cc1_main(llvm::ArrayRef<char char (/opt/cross/cla=
ng-1cddcfdc3c/bin/clang-15+0x10c2b8c)
   #21 0x000055990e44885b ExecuteCC1Tool(llvm::SmallVectorImpl<char driver.=
cpp:0:0
   #22 0x0000559910ffe5e5 void llvm::function_ref<void ()>::callback_fn<cla=
ng::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::StringR=
ef> >, std::__cxx11::basic_string<char, std::char_traits<char>, std::alloca=
tor<char> const::'lambda'()>(long) Job.cpp:0:0
   #23 0x0000559910787bb3 llvm::CrashRecoveryContext::RunSafely(llvm::funct=
ion_ref<void ()>) (/opt/cross/clang-1cddcfdc3c/bin/clang-15+0x33febb3)
   #24 0x0000559910ffeede clang::driver::CC1Command::Execute(llvm::ArrayRef=
<llvm::Optional<llvm::StringRef> >, std::__cxx11::basic_string<char, std::c=
har_traits<char>, std::allocator<char> const (.part.216) Job.cpp:0:0
   #25 0x0000559910fd2757 clang::driver::Compilation::ExecuteCommand(clang:=
:driver::Command const&, clang::driver::Command const (/opt/cross/clang-1cd=
dcfdc3c/bin/clang-15+0x3c49757)
   #26 0x0000559910fd3137 clang::driver::Compilation::ExecuteJobs(clang::dr=
iver::JobList const&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) const (/opt/cross/clang-1cddcfdc3c/bin/clang-15+0x3c4a137)
   #27 0x0000559910fdcc59 clang::driver::Driver::ExecuteCompilation(clang::=
driver::Compilation&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) (/opt/cross/clang-1cddcfdc3c/bin/clang-15+0x3c53c59)
   #28 0x000055990e394a0f main (/opt/cross/clang-1cddcfdc3c/bin/clang-15+0x=
100ba0f)
   #29 0x00007f60dc3a97fd __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x237fd)
   #30 0x000055990e44837a _start (/opt/cross/clang-1cddcfdc3c/bin/clang-15+=
0x10bf37a)
   clang-15: error: clang frontend command failed with exit code 70 (use -v=
 to see invocation)
   clang version 15.0.0 (git://gitmirror/llvm_project 1cddcfdc3c683b393df1a=
5c9063252eb60e52818)
   Target: mipsel-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-1cddcfdc3c/bin
   clang-15: note: diagnostic msg:
   Makefile arch fs include kernel nr_bisected scripts source usr


vim +76 fs/netfs/crypto.c

777536e6af57bec David Howells 2021-07-01  45 =20
777536e6af57bec David Howells 2021-07-01  46  /*
777536e6af57bec David Howells 2021-07-01  47   * Populate a scatterlist fro=
m folios in an xarray.
777536e6af57bec David Howells 2021-07-01  48   */
777536e6af57bec David Howells 2021-07-01  49  static int netfs_xarray_to_sg=
list(struct xarray *xa, loff_t pos, size_t len,
777536e6af57bec David Howells 2021-07-01  50  				  struct scatterlist *sg,=
 unsigned int n_sg)
777536e6af57bec David Howells 2021-07-01  51  {
777536e6af57bec David Howells 2021-07-01  52  	struct scatterlist *p =3D sg;
777536e6af57bec David Howells 2021-07-01  53  	struct folio *folio =3D NULL;
777536e6af57bec David Howells 2021-07-01  54  	size_t seg, offset, skip =3D=
 0;
777536e6af57bec David Howells 2021-07-01  55  	loff_t start =3D pos;
777536e6af57bec David Howells 2021-07-01  56  	pgoff_t index =3D start >> P=
AGE_SHIFT;
777536e6af57bec David Howells 2021-07-01  57  	int j;
777536e6af57bec David Howells 2021-07-01  58 =20
777536e6af57bec David Howells 2021-07-01  59  	XA_STATE(xas, xa, index);
777536e6af57bec David Howells 2021-07-01  60 =20
777536e6af57bec David Howells 2021-07-01  61  	sg_init_table(sg, n_sg);
777536e6af57bec David Howells 2021-07-01  62 =20
777536e6af57bec David Howells 2021-07-01  63  	rcu_read_lock();
777536e6af57bec David Howells 2021-07-01  64 =20
777536e6af57bec David Howells 2021-07-01  65  	xas_for_each(&xas, folio, UL=
ONG_MAX) {
777536e6af57bec David Howells 2021-07-01  66  		if (xas_retry(&xas, folio))
777536e6af57bec David Howells 2021-07-01  67  			continue;
777536e6af57bec David Howells 2021-07-01  68  		if (WARN_ON(xa_is_value(fol=
io)) || WARN_ON(folio_test_hugetlb(folio)))
777536e6af57bec David Howells 2021-07-01  69  			break;
777536e6af57bec David Howells 2021-07-01  70  		for (j =3D (folio_index(fol=
io) < index) ? index - folio_index(folio) : 0;
777536e6af57bec David Howells 2021-07-01  71  		     j < folio_nr_pages(fol=
io); j++
777536e6af57bec David Howells 2021-07-01  72  		     ) {
777536e6af57bec David Howells 2021-07-01  73  			struct page *subpage =3D f=
olio_file_page(folio, j);
777536e6af57bec David Howells 2021-07-01  74 =20
777536e6af57bec David Howells 2021-07-01  75  			offset =3D (pos + skip) & =
~PAGE_MASK;
777536e6af57bec David Howells 2021-07-01 @76  			seg =3D min(len, PAGE_SIZE=
 - offset);
777536e6af57bec David Howells 2021-07-01  77 =20
777536e6af57bec David Howells 2021-07-01  78  			sg_set_page(p++, subpage, =
seg, offset);
777536e6af57bec David Howells 2021-07-01  79 =20
777536e6af57bec David Howells 2021-07-01  80  			len -=3D seg;
777536e6af57bec David Howells 2021-07-01  81  			skip +=3D seg;
777536e6af57bec David Howells 2021-07-01  82  			if (len =3D=3D 0)
777536e6af57bec David Howells 2021-07-01  83  				break;
777536e6af57bec David Howells 2021-07-01  84  		}
777536e6af57bec David Howells 2021-07-01  85  		if (len =3D=3D 0)
777536e6af57bec David Howells 2021-07-01  86  			break;
777536e6af57bec David Howells 2021-07-01  87  	}
777536e6af57bec David Howells 2021-07-01  88 =20
777536e6af57bec David Howells 2021-07-01  89  	rcu_read_unlock();
777536e6af57bec David Howells 2021-07-01  90  	if (len > 0) {
777536e6af57bec David Howells 2021-07-01  91  		kdebug("*** Insufficient so=
urce (%zx)", len);
777536e6af57bec David Howells 2021-07-01  92  		//WARN_ON(len > 0);
777536e6af57bec David Howells 2021-07-01  93  		return -EIO;
777536e6af57bec David Howells 2021-07-01  94  	}
777536e6af57bec David Howells 2021-07-01  95 =20
777536e6af57bec David Howells 2021-07-01  96  	sg_mark_end(p - 1);
777536e6af57bec David Howells 2021-07-01  97  	return p - sg;
777536e6af57bec David Howells 2021-07-01  98  }
777536e6af57bec David Howells 2021-07-01  99 =20

:::::: The code at line 76 was first introduced by commit
:::::: 777536e6af57becf14b8f4f34007ed3e3a95c911 netfs: Perform content encr=
yption

:::::: TO: David Howells <dhowells@redhat.com>
:::::: CC: David Howells <dhowells@redhat.com>

--=20
0-DAY CI Kernel Test Service
https://01.org/lkp
