Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A296E4C21FE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 04:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiBXDBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 22:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiBXDBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 22:01:32 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF53246362
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 19:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645671662; x=1677207662;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=QjZ3a0pDMNCCV8ex67cI6VzkWVxTr38vLMB7xSKTFEY=;
  b=J+i7YFCx5kePrUm0R7Ge8nKj7NIIsb4kL3+sVwJCc7q08H8kLDWOLEe8
   MD41DtW4OqyTl0LB2vBayGriCxOdjXLEb+8+wGSaA39HIEjkK4S7HIr9R
   thXIcpHYsHT8lFsehkBV6Cv16VRn6dr+YVZ8/WlZ4vFa885stLrESa5Iw
   WIToRBneTOJ8n/wj5dXJ6LKBLL7Q5HOuDurTHbfhV0V3amb873IwgXIst
   ft09zlmxcYtVXZD0vOzMKKYKpN0CVajORlynKgzJLsp6+zc2/1/Ius1PK
   WjzVcp2Ph3JH+XsFamcX8xmOf+83/j5OljodkaV2Ahq4lR8IjIez+7f2M
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="312854214"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="312854214"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 19:01:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="784480938"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 23 Feb 2022 19:01:00 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nN4NH-00029d-El; Thu, 24 Feb 2022 03:00:59 +0000
Date:   Thu, 24 Feb 2022 10:59:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: [kdave-btrfs-devel:for-next-20220222 101/120]
 fs/btrfs/super.c:75:13: warning: unused function 'btrfs_state_to_string'
Message-ID: <202202241019.HFKHBOYe-lkp@intel.com>
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

tree:   https://github.com/kdave/btrfs-devel.git for-next-20220222
head:   4653d7e3d6f656d9234d8a2b84fe9aa872f17c1b
commit: 0504e61564dfa41e88e74b2f2510697746a186fc [101/120] btrfs: add fs st=
ate details to error messages
config: mips-randconfig-r021-20220224 (https://download.01.org/0day-ci/arch=
ive/20220224/202202241019.HFKHBOYe-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc=
04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=3D1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/=
make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/kdave/btrfs-devel/commit/0504e61564dfa41e88e74=
b2f2510697746a186fc
        git remote add kdave-btrfs-devel https://github.com/kdave/btrfs-dev=
el.git
        git fetch --no-tags kdave-btrfs-devel for-next-20220222
        git checkout 0504e61564dfa41e88e74b2f2510697746a186fc
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=3D=
1 O=3Dbuild_dir ARCH=3Dmips SHELL=3D/bin/bash drivers/gpu/drm/msm/ fs/btrfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/btrfs/super.c:75:13: warning: unused function 'btrfs_state_to_string'
   static void btrfs_state_to_string(const struct btrfs_fs_info char
   ^
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
   0. Program arguments: clang -Wp,-MMD,fs/btrfs/.super.o.d -nostdinc -Iarc=
h/mips/include -I./arch/mips/include/generated -Iinclude -I./include -Iarch=
/mips/include/uapi -I./arch/mips/include/generated/uapi -Iinclude/uapi -I./=
include/generated/uapi -include include/linux/compiler-version.h -include i=
nclude/linux/kconfig.h -include include/linux/compiler_types.h -D__KERNEL__=
 -DVMLINUX_LOAD_ADDRESS=3D0xffffffff84000000 -DLINKER_LOAD_ADDRESS=3D0x8400=
0000 -DDATAOFFSET=3D0 -Qunused-arguments -fmacro-prefix-map=3D=3D -DKBUILD_=
EXTRA_WARN1 -Wall -Wundef -Werror=3Dstrict-prototypes -Wno-trigraphs -fno-s=
trict-aliasing -fno-common -fshort-wchar -fno-PIE -Werror=3Dimplicit-functi=
on-declaration -Werror=3Dimplicit-int -Werror=3Dreturn-type -Wno-format-sec=
urity -std=3Dgnu89 --target=3Dmipsel-linux -fintegrated-as -Werror=3Dunknow=
n-warning-option -Werror=3Dignored-optimization-argument -mno-check-zero-di=
vision -mabi=3D32 -G 0 -mno-abicalls -fno-pic -pipe -msoft-float -DGAS_HAS_=
SET_HARDFLOAT -Wa,-msoft-float -ffreestanding -EL -fno-stack-check -march=
=3Dmips32 -Wa,--trap -DTOOLCHAIN_SUPPORTS_VIRT -Iarch/mips/include/asm/mach=
-ralink -Iarch/mips/include/asm/mach-ralink/mt7620 -Iarch/mips/include/asm/=
mach-generic -fno-asynchronous-unwind-tables -fno-delete-null-pointer-check=
s -Wno-frame-address -Wno-address-of-packed-member -Os -Wframe-larger-than=
=3D1024 -fno-stack-protector -Wimplicit-fallthrough -Wno-gnu -mno-global-me=
rge -Wno-unused-but-set-variable -Wno-unused-const-variable -ftrivial-auto-=
var-init=3Dpattern -fno-stack-clash-protection -pg -Wdeclaration-after-stat=
ement -Wvla -Wno-pointer-sign -Wcast-function-type -Wno-array-bounds -fno-s=
trict-overflow -fno-stack-check -Werror=3Ddate-time -Werror=3Dincompatible-=
pointer-types -Wextra -Wunused -Wno-unused-parameter -Wmissing-declarations=
 -Wmissing-format-attribute -Wmissing-prototypes -Wold-style-definition -Wm=
issing-include-dirs -Wunused-but-set-variable -Wunused-const-variable -Wno-=
missing-field-initializers -Wno-sign-compare -Wno-type-limits -Wextra -Wunu=
sed -Wno-unused-parameter -Wmissing-declarations -Wmissing-format-attribute=
 -Wmissing-prototypes -Wold-style-definition -Wmissing-include-dirs -Wunuse=
d-but-set-variable -Wunused-const-variable -Wno-missing-field-initializers =
-Wno-sign-compare -Wno-type-limits -I fs/btrfs -I ./fs/btrfs -ffunction-sec=
tions -fdata-sections -DKBUILD_MODFILE=3D"fs/btrfs/btrfs" -DKBUILD_BASENAME=
=3D"super" -DKBUILD_MODNAME=3D"btrfs" -D__KBUILD_MODNAME=3Dkmod_btrfs -c -o=
 fs/btrfs/super.o fs/btrfs/super.c
   1. <eof> parser at end of file
   2. Code generation
   3. Running pass 'Function Pass Manager' on module 'fs/btrfs/super.c'.
   4. Running pass 'Mips Assembly Printer' on function '@__btrfs_handle_fs_=
error'
   #0 0x00005610db1c7d7f Signals.cpp:0:0
   #1 0x00005610db1c5c5c llvm::sys::CleanupOnSignal(unsigned long) (/opt/cr=
oss/clang-d271fc04d5/bin/clang-15+0x348ec5c)
   #2 0x00005610db105fd7 llvm::CrashRecoveryContext::HandleExit(int) (/opt/=
cross/clang-d271fc04d5/bin/clang-15+0x33cefd7)
   #3 0x00005610db1be30e llvm::sys::Process::Exit(int, bool) (/opt/cross/cl=
ang-d271fc04d5/bin/clang-15+0x348730e)
   #4 0x00005610d8de9ccb (/opt/cross/clang-d271fc04d5/bin/clang-15+0x10b2cc=
b)
   #5 0x00005610db10ca8c llvm::report_fatal_error(llvm::Twine const&, bool)=
 (/opt/cross/clang-d271fc04d5/bin/clang-15+0x33d5a8c)
   #6 0x00005610dbe165c0 llvm::AsmPrinter::emitInlineAsm(llvm::MachineInstr=
 const (/opt/cross/clang-d271fc04d5/bin/clang-15+0x40df5c0)
   #7 0x00005610dbe124f4 llvm::AsmPrinter::emitFunctionBody() (/opt/cross/c=
lang-d271fc04d5/bin/clang-15+0x40db4f4)
   #8 0x00005610d9853887 llvm::MipsAsmPrinter::runOnMachineFunction(llvm::M=
achineFunction&) (/opt/cross/clang-d271fc04d5/bin/clang-15+0x1b1c887)
   #9 0x00005610da51054d llvm::MachineFunctionPass::runOnFunction(llvm::Fun=
ction&) (.part.53) MachineFunctionPass.cpp:0:0
   #10 0x00005610da957807 llvm::FPPassManager::runOnFunction(llvm::Function=
&) (/opt/cross/clang-d271fc04d5/bin/clang-15+0x2c20807)
   #11 0x00005610da957981 llvm::FPPassManager::runOnModule(llvm::Module&) (=
/opt/cross/clang-d271fc04d5/bin/clang-15+0x2c20981)
   #12 0x00005610da9584ff llvm::legacy::PassManagerImpl::run(llvm::Module&)=
 (/opt/cross/clang-d271fc04d5/bin/clang-15+0x2c214ff)
   #13 0x00005610db4e2147 clang::EmitBackendOutput(clang::DiagnosticsEngine=
&, clang::HeaderSearchOptions const&, clang::CodeGenOptions const&, clang::=
TargetOptions const&, clang::LangOptions const&, llvm::StringRef, clang::Ba=
ckendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<l=
lvm::raw_pwrite_stream> >) (/opt/cross/clang-d271fc04d5/bin/clang-15+0x37ab=
147)
   #14 0x00005610dc130693 clang::BackendConsumer::HandleTranslationUnit(cla=
ng::ASTContext&) (/opt/cross/clang-d271fc04d5/bin/clang-15+0x43f9693)
   #15 0x00005610dcc0b6e9 clang::ParseAST(clang::Sema&, bool, bool) (/opt/c=
ross/clang-d271fc04d5/bin/clang-15+0x4ed46e9)
   #16 0x00005610dc12f4cf clang::CodeGenAction::ExecuteAction() (/opt/cross=
/clang-d271fc04d5/bin/clang-15+0x43f84cf)
   #17 0x00005610dbb32561 clang::FrontendAction::Execute() (/opt/cross/clan=
g-d271fc04d5/bin/clang-15+0x3dfb561)
   #18 0x00005610dbac8faa clang::CompilerInstance::ExecuteAction(clang::Fro=
ntendAction&) (/opt/cross/clang-d271fc04d5/bin/clang-15+0x3d91faa)
   #19 0x00005610dbbf6cbb (/opt/cross/clang-d271fc04d5/bin/clang-15+0x3ebfc=
bb)
   #20 0x00005610d8deb27c cc1_main(llvm::ArrayRef<char char (/opt/cross/cla=
ng-d271fc04d5/bin/clang-15+0x10b427c)
   #21 0x00005610d8de7f4b ExecuteCC1Tool(llvm::SmallVectorImpl<char driver.=
cpp:0:0
   #22 0x00005610db961d95 void llvm::function_ref<void ()>::callback_fn<cla=
ng::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::StringR=
ef> >, std::__cxx11::basic_string<char, std::char_traits<char>, std::alloca=
tor<char> const::'lambda'()>(long) Job.cpp:0:0
   #23 0x00005610db105e93 llvm::CrashRecoveryContext::RunSafely(llvm::funct=
ion_ref<void ()>) (/opt/cross/clang-d271fc04d5/bin/clang-15+0x33cee93)
   #24 0x00005610db96268e clang::driver::CC1Command::Execute(llvm::ArrayRef=
<llvm::Optional<llvm::StringRef> >, std::__cxx11::basic_string<char, std::c=
har_traits<char>, std::allocator<char> const (.part.216) Job.cpp:0:0
   #25 0x00005610db937267 clang::driver::Compilation::ExecuteCommand(clang:=
:driver::Command const&, clang::driver::Command const (/opt/cross/clang-d27=
1fc04d5/bin/clang-15+0x3c00267)
   #26 0x00005610db937c47 clang::driver::Compilation::ExecuteJobs(clang::dr=
iver::JobList const&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) const (/opt/cross/clang-d271fc04d5/bin/clang-15+0x3c00c47)
   #27 0x00005610db9412f9 clang::driver::Driver::ExecuteCompilation(clang::=
driver::Compilation&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) (/opt/cross/clang-d271fc04d5/bin/clang-15+0x3c0a2f9)
   #28 0x00005610d8d1063f main (/opt/cross/clang-d271fc04d5/bin/clang-15+0x=
fd963f)
   #29 0x00007f19de2c2d0a __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x26d0a)
   #30 0x00005610d8de7a6a _start (/opt/cross/clang-d271fc04d5/bin/clang-15+=
0x10b0a6a)
   clang-15: error: clang frontend command failed with exit code 70 (use -v=
 to see invocation)
   clang version 15.0.0 (git://gitmirror/llvm_project d271fc04d5b97b12e6b79=
7c6067d3c96a8d7470e)
   Target: mipsel-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-d271fc04d5/bin
   clang-15: note: diagnostic msg:
   Makefile arch drivers fs include kernel nr_bisected scripts source usr


vim +/btrfs_state_to_string +75 fs/btrfs/super.c

    71=09
    72	/*
    73	 * Fill @buf with string describing exceptional filesystem state.
    74	 */
  > 75	static void btrfs_state_to_string(const struct btrfs_fs_info *info, =
char *buf)
    76	{
    77		unsigned int states_printed =3D 0;
    78		char *curr =3D buf;
    79=09
    80		memcpy(curr, STATE_STRING_PREFACE, sizeof(STATE_STRING_PREFACE));
    81		curr +=3D sizeof(STATE_STRING_PREFACE) - 1;
    82=09
    83		/* If more states are reported, update MAX_STATE_CHARS also */
    84		if (test_bit(BTRFS_FS_STATE_ERROR, &info->fs_state)) {
    85			*curr++ =3D 'E';
    86			states_printed++;
    87		}
    88=09
    89		if (test_bit(BTRFS_FS_STATE_TRANS_ABORTED, &info->fs_state)) {
    90			*curr++ =3D 'X';
    91			states_printed++;
    92		}
    93=09
    94		/* If no states were printed, reset the buffer */
    95		if (!states_printed)
    96			curr =3D buf;
    97=09
    98		WARN_ON_ONCE(states_printed > MAX_STATE_CHARS);
    99=09
   100		*curr++ =3D 0;
   101	}
   102=09

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
