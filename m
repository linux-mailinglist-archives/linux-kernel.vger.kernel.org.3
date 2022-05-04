Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0606051A213
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 16:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351269AbiEDOYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 10:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345701AbiEDOYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 10:24:43 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123941C928
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 07:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651674067; x=1683210067;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HK/bGwrK7gNN26AiISjyYadi0tg1LKA4bEkzY6KdU80=;
  b=TU8B0RGkbm0WEEOLmw4YLxtH6QgUTJG2TH8X4dl4Xxi+9Tv77d6pYXHX
   5yIHbLXA1VTmJUAMOZGY6CVElpHSvVK31gz+n3m0CvBxF7tv+xJ7VRmky
   n7kkH/hqyRvMsi7dHt46bxIfE/yzoL4QO/GLnOyST/rErX7xBBaB0s4WB
   TqIXGVayyuiKNi9dtOM1dCftpUwVSgkaajTfifojVMRpxjHNiqd72GpCF
   JdTh1qLke4C0vjwOPxgqpryVuPHZxSWotW3pdVvgEvMEftwWVLllQ2gWf
   /D+MTZMNwgNitqWL/anHMZufKLdAPE8o6m2ref3JEgPFq+31buVymECLO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="266621736"
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; 
   d="scan'208";a="266621736"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 07:21:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; 
   d="scan'208";a="517047072"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 04 May 2022 07:21:05 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmFsG-000BRP-Fp;
        Wed, 04 May 2022 14:21:04 +0000
Date:   Wed, 4 May 2022 22:20:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [andersson:wip/sc8180x-next-20220502 6/29] mips64el-linux-ld:
 dp_hpd.c:undefined reference to `typec_mux_unregister'
Message-ID: <202205042205.Iqy6XSFU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/andersson/kernel wip/sc8180x-next-20220502
head:   6199153320a3b7d1dce23ad1ea4d894a86793cb6
commit: be6e31f126bed33f684250905b79d76f7664d985 [6/29] drm/msm/dp: Add typec_mux implementation
config: mips-randconfig-r005-20220501 (https://download.01.org/0day-ci/archive/20220504/202205042205.Iqy6XSFU-lkp@intel.com/config)
compiler: mips64el-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/andersson/kernel/commit/be6e31f126bed33f684250905b79d76f7664d985
        git remote add andersson https://github.com/andersson/kernel
        git fetch --no-tags andersson wip/sc8180x-next-20220502
        git checkout be6e31f126bed33f684250905b79d76f7664d985
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/nvmem/layerscape-sfp.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/fpga/fpga-mgr.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/fpga/altera-cvp.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/fpga/socfpga.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/fpga/socfpga-a10.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/fpga/zynq-fpga.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/fpga/zynqmp-fpga.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/fpga/versal-fpga.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/fpga/altera-pr-ip-core.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/fpga/altera-pr-ip-core-plat.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/fsi/fsi-core.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/fsi/fsi-master-hub.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/fsi/fsi-master-aspeed.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/fsi/fsi-master-gpio.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/fsi/fsi-sbefifo.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/fsi/fsi-occ.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/tee/tee_core.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/tee/tee_shm.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/tee/tee_shm_pool.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/mux/core.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/mux/mmio.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/siox/siox-core.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/gnss/core.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/interconnect/core.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/interconnect/bulk.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/interconnect/imx/imx.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/interconnect/imx/imx8mn.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/counter/counter-core.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/counter/counter-sysfs.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/counter/counter-chrdev.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/counter/104-quad-8.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/counter/interrupt-cnt.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/counter/stm32-timer-cnt.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/counter/stm32-lptimer-cnt.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/counter/ftm-quaddec.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/counter/microchip-tcb-capture.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/counter/intel-qep.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/most/core.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/most/configfs.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/peci/core.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/peci/request.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/peci/device.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/peci/sysfs.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/peci/cpu.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/peci/controller/peci-aspeed.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `virt/lib/irqbypass.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/pci/pci.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/pci/pci-generic.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `lib/argv_split.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `lib/bootconfig.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `lib/buildid.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `lib/cmdline.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `lib/cpumask.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `lib/ctype.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `lib/dec_and_lock.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `lib/decompress.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `lib/decompress_unlzo.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `lib/decompress_unxz.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `lib/extable.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `lib/fdt.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `lib/fdt_ro.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `lib/fdt_rw.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `lib/fdt_wip.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `lib/flex_proportions.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `lib/idr.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `lib/is_single_threaded.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `lib/klist.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `lib/kobject.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `lib/kobject_uevent.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `lib/logic_pio.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `lib/memcat_p.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `lib/nmi_backtrace.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `lib/nodemask.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `lib/plist.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `lib/radix-tree.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `lib/ratelimit.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `lib/rbtree.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `lib/seq_buf.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `lib/sha1.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `lib/show_mem.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `lib/siphash.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `lib/string.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `lib/timerqueue.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `lib/vsprintf.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `lib/xarray.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/fw/lib/cmdline.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/lib/delay.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/lib/mips-atomic.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/math-emu/dp_flong.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/math-emu/dp_sqrt.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/math-emu/dp_tlong.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/math-emu/sp_flong.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/math-emu/sp_sqrt.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/math-emu/sp_tlong.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: drivers/gpu/drm/msm/dp/dp_hpd.o: in function `dp_hpd_unregister_typec_mux':
   dp_hpd.c:(.text+0xc0): undefined reference to `typec_mux_unregister'
   mips64el-linux-ld: drivers/gpu/drm/msm/dp/dp_hpd.o: in function `dp_hpd_mux_set':
   dp_hpd.c:(.text+0xf8): undefined reference to `typec_mux_get_drvdata'
   mips64el-linux-ld: drivers/gpu/drm/msm/dp/dp_hpd.o: in function `dp_hpd_get':
   dp_hpd.c:(.text+0x30c): undefined reference to `typec_mux_register'
>> mips64el-linux-ld: dp_hpd.c:(.text+0x34c): undefined reference to `typec_mux_unregister'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
