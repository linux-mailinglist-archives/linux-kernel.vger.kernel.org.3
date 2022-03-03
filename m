Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1294CB98F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 09:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiCCIuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 03:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbiCCItq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:49:46 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95C6163071
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 00:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646297336; x=1677833336;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ynipcZ74M85A03dBzCI3LyLTYzhxnPdSRkmFTLt5DVo=;
  b=dpvUmPxZJPMJ0+6eap8ZQ5XTtaI0BZ24o1gf/9+B1wPpf+tGfKHLMFDk
   IGKEWRPRA7quR+peK3gXnMAuUIycYRZeoUyfrPCU+klyrz0CE7hyfoLxg
   uB4l19BuQ9zWS7EpKaCdHOckGBrf+rMaHFkI/E3MU8bYZWFq6OjHdAUAj
   DldPyZFCGvogIar2xz5ZPidGoCuxztpWceXQBMrf9VrxuCxkT8d1CWNaj
   jAk93vO3U2cSbnJpvLOLnFo7DbnneaPejOELLNJWkLidvfE9dHsOnZKBE
   tCVu3ppO4tnGn1aDsMJRl3XAyRTpI7M/eDamEIimDnKlL1PxYbg1wbWDQ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="253346955"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="253346955"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 00:48:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="594319122"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 03 Mar 2022 00:48:54 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPh8i-0000Kb-EY; Thu, 03 Mar 2022 08:48:48 +0000
Date:   Thu, 3 Mar 2022 16:48:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Boris Kolpackov <boris@codesynthesis.com>
Subject: [masahiroy:kbuild 9/9] include/uapi/sound/asound.h:570:14: error:
 conflicting types for '__pad_before_uframe'; have 'char[0]'
Message-ID: <202203031649.dopk5HXO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git kbuild
head:   55de8686df7ed2b5237867b130e30c728bbd9db4
commit: 55de8686df7ed2b5237867b130e30c728bbd9db4 [9/9] kconfig: change .config format to use =n instead of "is not set"
config: arc-randconfig-r003-20220303 (https://download.01.org/0day-ci/archive/20220303/202203031649.dopk5HXO-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git/commit/?id=55de8686df7ed2b5237867b130e30c728bbd9db4
        git remote add masahiroy https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
        git fetch --no-tags masahiroy kbuild
        git checkout 55de8686df7ed2b5237867b130e30c728bbd9db4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/base/regmap/ drivers/rtc/ drivers/soundwire/ lib/lzo/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from arch/arc/include/uapi/asm/byteorder.h:14,
                    from include/asm-generic/bitops/le.h:6,
                    from arch/arc/include/asm/bitops.h:192,
                    from include/linux/bitops.h:33,
                    from include/linux/log2.h:12,
                    from kernel/bounds.c:13:
>> include/linux/byteorder/big_endian.h:8:2: warning: #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN [-Wcpp]
       8 | #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN
         |  ^~~~~~~
--
   In file included from arch/arc/include/uapi/asm/byteorder.h:14,
                    from include/asm-generic/bitops/le.h:6,
                    from arch/arc/include/asm/bitops.h:192,
                    from include/linux/bitops.h:33,
                    from include/linux/log2.h:12,
                    from include/asm-generic/div64.h:55,
                    from ./arch/arc/include/generated/asm/div64.h:1,
                    from include/linux/math.h:5,
                    from include/linux/math64.h:6,
                    from include/linux/time64.h:5,
                    from include/linux/restart_block.h:10,
                    from include/linux/thread_info.h:14,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/rcupdate.h:27,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/rtc/rtc-fsl-ftm-alarm.c:10:
>> include/linux/byteorder/big_endian.h:8:2: warning: #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN [-Wcpp]
       8 | #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN
         |  ^~~~~~~
   drivers/rtc/rtc-fsl-ftm-alarm.c:315:36: warning: 'ftm_imx_acpi_ids' defined but not used [-Wunused-const-variable=]
     315 | static const struct acpi_device_id ftm_imx_acpi_ids[] = {
         |                                    ^~~~~~~~~~~~~~~~
--
   In file included from arch/arc/include/uapi/asm/byteorder.h:14,
                    from include/asm-generic/bitops/le.h:6,
                    from arch/arc/include/asm/bitops.h:192,
                    from include/linux/bitops.h:33,
                    from include/linux/kernel.h:22,
                    from include/linux/clk.h:13,
                    from drivers/rtc/rtc-omap.c:13:
>> include/linux/byteorder/big_endian.h:8:2: warning: #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN [-Wcpp]
       8 | #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN
         |  ^~~~~~~
   drivers/rtc/rtc-omap.c:410:5: warning: no previous prototype for 'omap_rtc_power_off_program' [-Wmissing-prototypes]
     410 | int omap_rtc_power_off_program(struct device *dev)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from arch/arc/include/uapi/asm/byteorder.h:14,
                    from include/asm-generic/bitops/le.h:6,
                    from arch/arc/include/asm/bitops.h:192,
                    from include/linux/bitops.h:33,
                    from include/linux/log2.h:12,
                    from include/asm-generic/div64.h:55,
                    from ./arch/arc/include/generated/asm/div64.h:1,
                    from include/linux/math.h:5,
                    from include/linux/delay.h:22,
                    from drivers/soundwire/stream.c:8:
>> include/linux/byteorder/big_endian.h:8:2: warning: #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN [-Wcpp]
       8 | #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN
         |  ^~~~~~~
   In file included from include/sound/asound.h:24,
                    from include/sound/pcm.h:11,
                    from include/sound/soc.h:23,
                    from drivers/soundwire/stream.c:16:
>> include/uapi/sound/asound.h:570:14: error: conflicting types for '__pad_before_uframe'; have 'char[0]'
     570 | typedef char __pad_before_uframe[0];
         |              ^~~~~~~~~~~~~~~~~~~
   include/uapi/sound/asound.h:565:14: note: previous declaration of '__pad_before_uframe' with type '__pad_before_uframe' {aka 'char[4]'}
     565 | typedef char __pad_before_uframe[sizeof(__u64) - sizeof(snd_pcm_uframes_t)];
         |              ^~~~~~~~~~~~~~~~~~~
>> include/uapi/sound/asound.h:571:14: error: conflicting types for '__pad_after_uframe'; have 'char[4]'
     571 | typedef char __pad_after_uframe[sizeof(__u64) - sizeof(snd_pcm_uframes_t)];
         |              ^~~~~~~~~~~~~~~~~~
   include/uapi/sound/asound.h:566:14: note: previous declaration of '__pad_after_uframe' with type '__pad_after_uframe' {aka 'char[0]'}
     566 | typedef char __pad_after_uframe[0];
         |              ^~~~~~~~~~~~~~~~~~
--
   In file included from arch/arc/include/uapi/asm/byteorder.h:14,
                    from include/asm-generic/bitops/le.h:6,
                    from arch/arc/include/asm/bitops.h:192,
                    from include/linux/bitops.h:33,
                    from include/linux/kernel.h:22,
                    from include/linux/clk.h:13,
                    from drivers/base/regmap/regmap-mmio.c:7:
>> include/linux/byteorder/big_endian.h:8:2: warning: #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN [-Wcpp]
       8 | #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN
         |  ^~~~~~~
   drivers/base/regmap/regmap-mmio.c: In function 'regmap_mmio_gen_context':
>> drivers/base/regmap/regmap-mmio.c:348:9: error: duplicate case value
     348 |         case REGMAP_ENDIAN_NATIVE:
         |         ^~~~
   drivers/base/regmap/regmap-mmio.c:300:9: note: previously used here
     300 |         case REGMAP_ENDIAN_NATIVE:
         |         ^~~~
--
   In file included from arch/arc/include/uapi/asm/byteorder.h:14,
                    from include/asm-generic/bitops/le.h:6,
                    from arch/arc/include/asm/bitops.h:192,
                    from include/linux/bitops.h:33,
                    from include/linux/log2.h:12,
                    from include/asm-generic/div64.h:55,
                    from ./arch/arc/include/generated/asm/div64.h:1,
                    from include/linux/math.h:5,
                    from include/linux/math64.h:6,
                    from include/linux/time.h:6,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from lib/lzo/lzo1x_compress.c:15:
>> include/linux/byteorder/big_endian.h:8:2: warning: #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN [-Wcpp]
       8 | #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN
         |  ^~~~~~~
   In file included from lib/lzo/lzo1x_compress.c:19:
>> lib/lzo/lzodefs.h:33:2: error: #error "conflicting endian definitions"
      33 | #error "conflicting endian definitions"
         |  ^~~~~
--
   In file included from arch/arc/include/uapi/asm/byteorder.h:14,
                    from include/asm-generic/bitops/le.h:6,
                    from arch/arc/include/asm/bitops.h:192,
                    from include/linux/bitops.h:33,
                    from include/linux/log2.h:12,
                    from kernel/bounds.c:13:
>> include/linux/byteorder/big_endian.h:8:2: warning: #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN [-Wcpp]
       8 | #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN
         |  ^~~~~~~
   In file included from arch/arc/include/uapi/asm/byteorder.h:14,
                    from include/asm-generic/bitops/le.h:6,
                    from arch/arc/include/asm/bitops.h:192,
                    from include/linux/bitops.h:33,
                    from include/linux/log2.h:12,
                    from include/asm-generic/div64.h:55,
                    from ./arch/arc/include/generated/asm/div64.h:1,
                    from include/linux/math.h:5,
                    from include/linux/math64.h:6,
                    from include/linux/time64.h:5,
                    from include/linux/restart_block.h:10,
                    from include/linux/thread_info.h:14,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/rcupdate.h:27,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from arch/arc/kernel/asm-offsets.c:6:
>> include/linux/byteorder/big_endian.h:8:2: warning: #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN [-Wcpp]
       8 | #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN
         |  ^~~~~~~


vim +570 include/uapi/sound/asound.h

80fe7430c708595 Arnd Bergmann 2018-04-24  568  
80fe7430c708595 Arnd Bergmann 2018-04-24  569  #if defined(__BYTE_ORDER) ? __BYTE_ORDER == __LITTLE_ENDIAN : defined(__LITTLE_ENDIAN)
80fe7430c708595 Arnd Bergmann 2018-04-24 @570  typedef char __pad_before_uframe[0];
80fe7430c708595 Arnd Bergmann 2018-04-24 @571  typedef char __pad_after_uframe[sizeof(__u64) - sizeof(snd_pcm_uframes_t)];
80fe7430c708595 Arnd Bergmann 2018-04-24  572  #endif
80fe7430c708595 Arnd Bergmann 2018-04-24  573  

:::::: The code at line 570 was first introduced by commit
:::::: 80fe7430c7085951d1246d83f638cc17e6c0be36 ALSA: add new 32-bit layout for snd_pcm_mmap_status/control

:::::: TO: Arnd Bergmann <arnd@arndb.de>
:::::: CC: Arnd Bergmann <arnd@arndb.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
