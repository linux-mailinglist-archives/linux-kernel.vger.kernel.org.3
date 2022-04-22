Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3773650BDAD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386738AbiDVQ6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449927AbiDVQ5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:57:49 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259CFE7A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650646495; x=1682182495;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yZNBnSuynarGRjzVvsGb3f57oeFuePokaCkVYDt1K1s=;
  b=MnHVpwJ5GvgUqs6pp+hibIPc2bu0zUem/PAK7i448yVeAO5GTpRV3pzt
   fvYIMR/o0lM+UC8Q+jGZioddlGtyTusSWun9VCBYJ9gZT8Ai1Kv5YsMBV
   l75aqsi54X62kykaSoo3Ee+ydwabKd01G2vLwwkXENax3niCgEISPKdc6
   QegkRJgoF5ulDM27rbwnNzDsTabddEcf4KSSezaE02k0e2w3Ng7m++puh
   QDENBQGnWPwuF1ZDPK1hJdkpX1TkPkaCZsM1QO0UYrBGHEZh6LKicnSRj
   SX4ZiNvvdSSs9BPLOjxfi5/BKhWCL7Bku1oSQ5auAT9/hMDc8rna1xob2
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="263574899"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="263574899"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 09:54:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="534471896"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 22 Apr 2022 09:54:50 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhwYU-000AMY-1w;
        Fri, 22 Apr 2022 16:54:50 +0000
Date:   Sat, 23 Apr 2022 00:54:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chenyang Li <lichenyang@loongson.cn>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dan Carpenter <error27@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, devel@linuxdriverproject.org
Cc:     kbuild-all@lists.01.org, Yi Li <liyi@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/4] drm/loongson: Add DRM Driver for Loongson 7A1000
 bridge chip
Message-ID: <202204230030.kZgmTGOQ-lkp@intel.com>
References: <20220422081416.682625-1-lichenyang@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422081416.682625-1-lichenyang@loongson.cn>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chenyang,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on drm/drm-next]
[also build test WARNING on v5.18-rc3 next-20220422]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Chenyang-Li/drm-loongson-Add-DRM-Driver-for-Loongson-7A1000-bridge-chip/20220422-161914
base:   git://anongit.freedesktop.org/drm/drm drm-next
config: arm-randconfig-s031-20220422 (https://download.01.org/0day-ci/archive/20220423/202204230030.kZgmTGOQ-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/intel-lab-lkp/linux/commit/e9a9964d58e6cc797a113fa47f54583c10908d63
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Chenyang-Li/drm-loongson-Add-DRM-Driver-for-Loongson-7A1000-bridge-chip/20220422-161914
        git checkout e9a9964d58e6cc797a113fa47f54583c10908d63
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash drivers/gpu/drm/loongson/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/loongson/loongson_drv.c:91:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/loongson/loongson_drv.c:99:5: sparse: sparse: symbol 'loongson_modeset_init' was not declared. Should it be static?

vim +/__iomem +91 drivers/gpu/drm/loongson/loongson_drv.c

    36	
    37	static int loongson_device_init(struct drm_device *dev)
    38	{
    39		struct loongson_device *ldev = to_loongson_device(dev);
    40		struct pci_dev *pdev = to_pci_dev(dev->dev);
    41		struct pci_dev *gpu_pdev;
    42		resource_size_t aper_base;
    43		resource_size_t aper_size;
    44		resource_size_t mmio_base;
    45		resource_size_t mmio_size;
    46		int ret;
    47	
    48		/* GPU MEM */
    49		/* We need get 7A-gpu pci device information for ldev->gpu_pdev */
    50		/* dev->pdev save 7A-dc pci device information */
    51		gpu_pdev = pci_get_device(PCI_VENDOR_ID_LOONGSON,
    52					  PCI_DEVICE_ID_LOONGSON_GPU, NULL);
    53		ret = pci_enable_device(gpu_pdev);
    54		if (ret)
    55			return ret;
    56		pci_set_drvdata(gpu_pdev, dev);
    57	
    58		aper_base = pci_resource_start(gpu_pdev, 2);
    59		aper_size = pci_resource_len(gpu_pdev, 2);
    60		ldev->vram_start = aper_base;
    61		ldev->vram_size = aper_size;
    62	
    63		if (!devm_request_mem_region(dev->dev, ldev->vram_start,
    64					     ldev->vram_size, "loongson_vram")) {
    65			drm_err(dev, "Can't reserve VRAM\n");
    66			return -ENXIO;
    67		}
    68	
    69		/* DC MEM */
    70		mmio_base = pci_resource_start(pdev, 0);
    71		mmio_size = pci_resource_len(pdev, 0);
    72		ldev->mmio = devm_ioremap(dev->dev, mmio_base, mmio_size);
    73		if (!ldev->mmio) {
    74			drm_err(dev, "Cannot map mmio region\n");
    75			return -ENOMEM;
    76		}
    77	
    78		if (!devm_request_mem_region(dev->dev, mmio_base,
    79					     mmio_size, "loongson_mmio")) {
    80			drm_err(dev, "Can't reserve mmio registers\n");
    81			return -ENOMEM;
    82		}
    83	
    84		/* DC IO */
    85		ldev->io = devm_ioremap(dev->dev, LS7A_CHIPCFG_REG_BASE, 0xf);
    86		if (!ldev->io)
    87			return -ENOMEM;
    88	
    89		ldev->num_crtc = 2;
    90	
  > 91		drm_info(dev, "DC mmio base 0x%llx size 0x%llx io 0x%llx\n",
    92			 mmio_base, mmio_size, *(u64 *)ldev->io);
    93		drm_info(dev, "GPU vram start = 0x%x size = 0x%x\n",
    94			 ldev->vram_start, ldev->vram_size);
    95	
    96		return 0;
    97	}
    98	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
