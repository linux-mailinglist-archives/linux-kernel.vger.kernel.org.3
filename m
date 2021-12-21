Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8AB47C4D5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240295AbhLURRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:17:01 -0500
Received: from mga09.intel.com ([134.134.136.24]:4456 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240285AbhLURQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:16:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640107019; x=1671643019;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IFDWg1QnMHEW+1kgWM0jrUfEP4GIANB+qKGijyGGPSQ=;
  b=cA9HF0XAr+KBhmqiPTUQWzfjP5TjpR/dBFWOdzZrDiDHEeTK2sJAENb3
   SLJNENmFjxi1YeT55mEtxcNo+R1gfr/zJ+qweA02Q+l07dDBcE5r3TIdt
   2xJ+Akd1+pu/qrxL9z8i7IIa9aL9HhbiCB1nEvj9xPMM2iQkGrNiv1tXa
   GnDZ5AD0rFf3FtL9F3fMXcM9KaUdncSbAEsFHVRRgSx8YBwqKHxgAEWvG
   TV/9IBpZmN2GukbaOep9osu4+ihG+DgLrI56QEwIaANMGMUjAoM/gnCvO
   RYy90ixZVWs11eHNcfAgDHQ4N/B/DLV9JRL/VIoDVgERp9AGtyxvFUtVR
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="240246475"
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="240246475"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 09:15:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="508149106"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 21 Dec 2021 09:15:01 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzij6-0009Eu-Ub; Tue, 21 Dec 2021 17:15:00 +0000
Date:   Wed, 22 Dec 2021 01:14:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [frederic-dynticks:preempt/arm-v4 2/5] lib/Kconfig.debug:536:error:
 recursive dependency detected!
Message-ID: <202112220052.Go2LhCpb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git preempt/arm-v4
head:   6fc1c7e3d83c4e06b019b041894d9bb25f37ac6c
commit: 44d4846a007823ebf184ef1861a37362a43c6434 [2/5] arm64: implement support for static call trampolines
config: arm64-randconfig-r022-20211220
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 6c2bf01270a8a52b7986d5c49eaa7ad1c7083ec5)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git/commit/?id=44d4846a007823ebf184ef1861a37362a43c6434
        git remote add frederic-dynticks https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
        git fetch --no-tags frederic-dynticks preempt/arm-v4
        git checkout 44d4846a007823ebf184ef1861a37362a43c6434
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=arm64  randconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=arm64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> lib/Kconfig.debug:536:error: recursive dependency detected!
   lib/Kconfig.debug:536: symbol DEBUG_FS is selected by ZSMALLOC_STAT
   mm/Kconfig:705: symbol ZSMALLOC_STAT depends on ZSMALLOC
   mm/Kconfig:694: symbol ZSMALLOC is selected by ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
   mm/Kconfig:644: symbol ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is part of choice <choice>
   mm/Kconfig:618: choice <choice> contains symbol <choice>
   mm/Kconfig:618: choice <choice> contains symbol ZSWAP
   mm/Kconfig:534: symbol ZSWAP depends on CRYPTO
   crypto/Kconfig:16: symbol CRYPTO is selected by SND_SOC_CROS_EC_CODEC
   sound/soc/codecs/Kconfig:583: symbol SND_SOC_CROS_EC_CODEC is selected by SND_SOC_AMD_RV_RT5682_MACH
   sound/soc/amd/Kconfig:32: symbol SND_SOC_AMD_RV_RT5682_MACH depends on GPIOLIB
   drivers/gpio/Kconfig:14: symbol GPIOLIB is selected by CEC_GPIO
   drivers/media/cec/platform/Kconfig:43: symbol CEC_GPIO depends on PREEMPTION
   kernel/Kconfig.preempt:92: symbol PREEMPTION is selected by PREEMPT_BUILD
   kernel/Kconfig.preempt:9: symbol PREEMPT_BUILD is selected by PREEMPT_DYNAMIC
   kernel/Kconfig.preempt:96: symbol PREEMPT_DYNAMIC depends on HAVE_PREEMPT_DYNAMIC
   arch/Kconfig:1266: symbol HAVE_PREEMPT_DYNAMIC depends on HAVE_STATIC_CALL
   arch/Kconfig:1259: symbol HAVE_STATIC_CALL is selected by LTO_CLANG_THIN
   arch/Kconfig:697: symbol LTO_CLANG_THIN is part of choice <choice>
   arch/Kconfig:663: choice <choice> contains symbol LTO_CLANG_FULL
   arch/Kconfig:678: symbol LTO_CLANG_FULL is part of choice HAS_LTO_CLANG
   arch/Kconfig:649: symbol HAS_LTO_CLANG depends on GCOV_KERNEL
   kernel/gcov/Kconfig:4: symbol GCOV_KERNEL depends on DEBUG_FS
   For a resolution refer to Documentation/kbuild/kconfig-language.rst
   subsection "Kconfig recursive dependency limitations"


vim +536 lib/Kconfig.debug

6210b6402f582b Changbin Du    2019-12-06  492  
6dfc06651b3d29 Dave Hansen    2013-07-01  493  config MAGIC_SYSRQ
6dfc06651b3d29 Dave Hansen    2013-07-01  494  	bool "Magic SysRq key"
6dfc06651b3d29 Dave Hansen    2013-07-01  495  	depends on !UML
6dfc06651b3d29 Dave Hansen    2013-07-01  496  	help
6dfc06651b3d29 Dave Hansen    2013-07-01  497  	  If you say Y here, you will have some control over the system even
6dfc06651b3d29 Dave Hansen    2013-07-01  498  	  if the system crashes for example during kernel debugging (e.g., you
6dfc06651b3d29 Dave Hansen    2013-07-01  499  	  will be able to flush the buffer cache to disk, reboot the system
6dfc06651b3d29 Dave Hansen    2013-07-01  500  	  immediately or dump some status information). This is accomplished
6dfc06651b3d29 Dave Hansen    2013-07-01  501  	  by pressing various keys while holding SysRq (Alt+PrintScreen). It
6dfc06651b3d29 Dave Hansen    2013-07-01  502  	  also works on a serial console (on PC hardware at least), if you
6dfc06651b3d29 Dave Hansen    2013-07-01  503  	  send a BREAK and then within 5 seconds a command keypress. The
f8998c226587fb Hans Holmberg  2017-03-16  504  	  keys are documented in <file:Documentation/admin-guide/sysrq.rst>.
f8998c226587fb Hans Holmberg  2017-03-16  505  	  Don't say Y unless you really know what this hack does.
8446f1d391f3d2 Ingo Molnar    2005-09-06  506  
8eaede49dfdc1f Ben Hutchings  2013-10-07  507  config MAGIC_SYSRQ_DEFAULT_ENABLE
8eaede49dfdc1f Ben Hutchings  2013-10-07  508  	hex "Enable magic SysRq key functions by default"
8eaede49dfdc1f Ben Hutchings  2013-10-07  509  	depends on MAGIC_SYSRQ
8eaede49dfdc1f Ben Hutchings  2013-10-07  510  	default 0x1
8eaede49dfdc1f Ben Hutchings  2013-10-07  511  	help
8eaede49dfdc1f Ben Hutchings  2013-10-07  512  	  Specifies which SysRq key functions are enabled by default.
8eaede49dfdc1f Ben Hutchings  2013-10-07  513  	  This may be set to 1 or 0 to enable or disable them all, or
f8998c226587fb Hans Holmberg  2017-03-16  514  	  to a bitmask as described in Documentation/admin-guide/sysrq.rst.
8eaede49dfdc1f Ben Hutchings  2013-10-07  515  
732dbf3a6104a3 Felix Fietkau  2016-12-22  516  config MAGIC_SYSRQ_SERIAL
732dbf3a6104a3 Felix Fietkau  2016-12-22  517  	bool "Enable magic SysRq key over serial"
732dbf3a6104a3 Felix Fietkau  2016-12-22  518  	depends on MAGIC_SYSRQ
732dbf3a6104a3 Felix Fietkau  2016-12-22  519  	default y
732dbf3a6104a3 Felix Fietkau  2016-12-22  520  	help
732dbf3a6104a3 Felix Fietkau  2016-12-22  521  	  Many embedded boards have a disconnected TTL level serial which can
732dbf3a6104a3 Felix Fietkau  2016-12-22  522  	  generate some garbage that can lead to spurious false sysrq detects.
732dbf3a6104a3 Felix Fietkau  2016-12-22  523  	  This option allows you to decide whether you want to enable the
732dbf3a6104a3 Felix Fietkau  2016-12-22  524  	  magic SysRq key.
732dbf3a6104a3 Felix Fietkau  2016-12-22  525  
68af43173d3fce Dmitry Safonov 2020-03-02  526  config MAGIC_SYSRQ_SERIAL_SEQUENCE
68af43173d3fce Dmitry Safonov 2020-03-02  527  	string "Char sequence that enables magic SysRq over serial"
68af43173d3fce Dmitry Safonov 2020-03-02  528  	depends on MAGIC_SYSRQ_SERIAL
68af43173d3fce Dmitry Safonov 2020-03-02  529  	default ""
68af43173d3fce Dmitry Safonov 2020-03-02  530  	help
68af43173d3fce Dmitry Safonov 2020-03-02  531  	  Specifies a sequence of characters that can follow BREAK to enable
68af43173d3fce Dmitry Safonov 2020-03-02  532  	  SysRq on a serial console.
68af43173d3fce Dmitry Safonov 2020-03-02  533  
d3394b3d51828d Dmitry Safonov 2020-03-06  534  	  If unsure, leave an empty string and the option will not be enabled.
d3394b3d51828d Dmitry Safonov 2020-03-06  535  
ec29a5c197e6ef Changbin Du    2019-12-06 @536  config DEBUG_FS
ec29a5c197e6ef Changbin Du    2019-12-06  537  	bool "Debug Filesystem"
ec29a5c197e6ef Changbin Du    2019-12-06  538  	help
ec29a5c197e6ef Changbin Du    2019-12-06  539  	  debugfs is a virtual file system that kernel developers use to put
ec29a5c197e6ef Changbin Du    2019-12-06  540  	  debugging files into.  Enable this option to be able to read and
ec29a5c197e6ef Changbin Du    2019-12-06  541  	  write to these files.
ec29a5c197e6ef Changbin Du    2019-12-06  542  
ec29a5c197e6ef Changbin Du    2019-12-06  543  	  For detailed documentation on the debugfs API, see
ec29a5c197e6ef Changbin Du    2019-12-06  544  	  Documentation/filesystems/.
ec29a5c197e6ef Changbin Du    2019-12-06  545  
ec29a5c197e6ef Changbin Du    2019-12-06  546  	  If unsure, say N.
ec29a5c197e6ef Changbin Du    2019-12-06  547  

:::::: The code at line 536 was first introduced by commit
:::::: ec29a5c197e6ef88fd94a2f3ea087037ae8acc21 kernel-hacking: move DEBUG_FS to 'Generic Kernel Debugging Instruments'

:::::: TO: Changbin Du <changbin.du@gmail.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
