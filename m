Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D275771E6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 00:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbiGPWaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 18:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiGPWaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 18:30:01 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6AA1A071;
        Sat, 16 Jul 2022 15:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658010600; x=1689546600;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vdVrKIqLKuu781c8bGUbY3U5ko4MozA4QmJy7sX3wbk=;
  b=j9YDRMEGFsLXawTnZmODfgEHkOwKPgdXQ90DvWtw1d+nIblu+nSwZ5an
   OxXWa0wBr+zoGqD9HlS36YtRmus/8764dNhFEajJKOY4qCFbWdL4eMQ5S
   wChd53t4pYnnUN3QDfrtSxSgzKkn/8fiwGVJn7C7CpDYLunpm8ZwRK9Qr
   CHx8qsPhrqftGlNVfWA8QZtK7ketRTVRL6Xb7TdrudP1AX/wgkCMR8dOO
   ztmi9b9KtCUNHRpEuBalc9K9XU6nplgsj8k9ZgTT/4at0wU2UgnUNKKeX
   Dgcg6bOnOTYaykISXKND47czcnFkt3pbn9OSLTbijFc/pniPCvV+aceoD
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="284766490"
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="284766490"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 15:30:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="739041817"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 16 Jul 2022 15:29:57 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCqIO-0002Ek-D7;
        Sat, 16 Jul 2022 22:29:56 +0000
Date:   Sun, 17 Jul 2022 06:29:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shreeya Patel <shreeya.patel@collabora.com>, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, dmitry.osipenko@collabora.com,
        Zhigang.Shi@liteon.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        krisman@collabora.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, alvaro.soliverez@collabora.com,
        andy.shevchenko@gmail.com,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: Re: [PATCH v9 2/2] iio: light: Add support for ltrf216a sensor
Message-ID: <202207170630.lcfpHu8v-lkp@intel.com>
References: <20220715111626.1066513-3-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715111626.1066513-3-shreeya.patel@collabora.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shreeya,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v5.19-rc6 next-20220715]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shreeya-Patel/Add-LTRF216A-Driver/20220716-210741
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: s390-randconfig-r023-20220717 (https://download.01.org/0day-ci/archive/20220717/202207170630.lcfpHu8v-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 07022e6cf9b5b3baa642be53d0b3c3f1c403dbfd)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/6db354952f0013dd461d2338761ef8ae3399f2d8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Shreeya-Patel/Add-LTRF216A-Driver/20220716-210741
        git checkout 6db354952f0013dd461d2338761ef8ae3399f2d8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/iio/light/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/iio/light/ltrf216a.c:19:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from drivers/iio/light/ltrf216a.c:19:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from drivers/iio/light/ltrf216a.c:19:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:609:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:617:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:625:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:634:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:643:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:652:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> drivers/iio/light/ltrf216a.c:188:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (on) {
               ^~
   drivers/iio/light/ltrf216a.c:199:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/iio/light/ltrf216a.c:188:2: note: remove the 'if' if its condition is always true
           if (on) {
           ^~~~~~~~
   drivers/iio/light/ltrf216a.c:186:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   13 warnings generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for DRM_DP_AUX_BUS
   Depends on HAS_IOMEM && DRM && OF
   Selected by
   - DRM_MSM && HAS_IOMEM && DRM && (ARCH_QCOM || SOC_IMX5 || COMPILE_TEST && COMMON_CLK && IOMMU_SUPPORT && (QCOM_OCMEM || QCOM_OCMEM && (QCOM_LLCC || QCOM_LLCC && (QCOM_COMMAND_DB || QCOM_COMMAND_DB


vim +188 drivers/iio/light/ltrf216a.c

   182	
   183	static int ltrf216a_set_power_state(struct ltrf216a_data *data, bool on)
   184	{
   185		struct device *dev = &data->client->dev;
   186		int ret;
   187	
 > 188		if (on) {
   189			ret = pm_runtime_resume_and_get(dev);
   190			if (ret) {
   191				dev_err(dev, "failed to resume runtime PM: %d\n", ret);
   192				return ret;
   193			}
   194		} else {
   195			pm_runtime_mark_last_busy(dev);
   196			pm_runtime_put_autosuspend(dev);
   197		}
   198	
   199		return ret;
   200	}
   201	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
