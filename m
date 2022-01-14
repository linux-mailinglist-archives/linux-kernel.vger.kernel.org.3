Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D6648EF9E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 19:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244054AbiANSEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 13:04:23 -0500
Received: from mga17.intel.com ([192.55.52.151]:62728 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235383AbiANSEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 13:04:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642183462; x=1673719462;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KfHCf+CAWf1npqThs9yzRu/PDCFapC6NYruwlljGzYY=;
  b=J09GQEpNpjUoSsCUQM007+uBNWss+czrYmbNQ6soqCBZ4xkhNsDb41sr
   OrfmNMWKMPQxosoCtyYqMJwvcE6aWzfW3GjPMwbJRUSKsYJrvEOwrowqE
   2944CrDtOekylwazK2WEmeE1sIjOWVSkkMfoGrt4mi57sXK2N35gYxSFZ
   EJkdOS68QYpc8k52z9J/i5iTcxA+cuxapg491+Er96Hx/frh5mGPzvxjy
   tEPh2jAZBgDXm0tkJ3fsD8l1rBZbgeOoqcwaHUV4l1PDJqHshFP6qkOyG
   ZD8l+Cf44wsuA5Z6h6a83BenkQB0VaJ56olmgkE578Rz1fs+JPkubvkpa
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="224986283"
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="224986283"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 10:04:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="624432428"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 14 Jan 2022 10:04:18 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8Qvx-0008rv-Jg; Fri, 14 Jan 2022 18:04:17 +0000
Date:   Sat, 15 Jan 2022 02:03:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hverkuil-media-tree:for-v5.18f 82/82]
 drivers/media/platform/aspeed-video.c:1836:30: warning: format '%p' expects
 argument of type 'void *', but argument 4 has type 'dma_addr_t' {aka
 'unsigned int'}
Message-ID: <202201150143.t4kto0kZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/hverkuil/media_tree.git for-v5.18f
head:   97dd85f0caf1ad96c275147583c46f8ee12308fc
commit: 97dd85f0caf1ad96c275147583c46f8ee12308fc [82/82] f
config: nios2-allyesconfig (https://download.01.org/0day-ci/archive/20220115/202201150143.t4kto0kZ-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add hverkuil-media-tree git://linuxtv.org/hverkuil/media_tree.git
        git fetch --no-tags hverkuil-media-tree for-v5.18f
        git checkout 97dd85f0caf1ad96c275147583c46f8ee12308fc
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash drivers/media/platform/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from drivers/media/platform/aspeed-video.c:9:
   drivers/media/platform/aspeed-video.c: In function 'aspeed_video_init':
>> drivers/media/platform/aspeed-video.c:1836:30: warning: format '%p' expects argument of type 'void *', but argument 4 has type 'dma_addr_t' {aka 'unsigned int'} [-Wformat=]
    1836 |         dev_info(video->dev, "alloc mem size(%d) at %pad for jpeg header\n",
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:150:58: note: in expansion of macro 'dev_fmt'
     150 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                          ^~~~~~~
   drivers/media/platform/aspeed-video.c:1836:9: note: in expansion of macro 'dev_info'
    1836 |         dev_info(video->dev, "alloc mem size(%d) at %pad for jpeg header\n",
         |         ^~~~~~~~
   drivers/media/platform/aspeed-video.c:1836:54: note: format string is defined here
    1836 |         dev_info(video->dev, "alloc mem size(%d) at %pad for jpeg header\n",
         |                                                     ~^
         |                                                      |
         |                                                      void *
         |                                                     %d


vim +1836 drivers/media/platform/aspeed-video.c

  1780	
  1781	static int aspeed_video_init(struct aspeed_video *video)
  1782	{
  1783		int irq;
  1784		int rc;
  1785		struct device *dev = video->dev;
  1786	
  1787		irq = irq_of_parse_and_map(dev->of_node, 0);
  1788		if (!irq) {
  1789			dev_err(dev, "Unable to find IRQ\n");
  1790			return -ENODEV;
  1791		}
  1792	
  1793		rc = devm_request_threaded_irq(dev, irq, NULL, aspeed_video_irq,
  1794					       IRQF_ONESHOT, DEVICE_NAME, video);
  1795		if (rc < 0) {
  1796			dev_err(dev, "Unable to request IRQ %d\n", irq);
  1797			return rc;
  1798		}
  1799		dev_info(video->dev, "irq %d\n", irq);
  1800	
  1801		video->eclk = devm_clk_get(dev, "eclk");
  1802		if (IS_ERR(video->eclk)) {
  1803			dev_err(dev, "Unable to get ECLK\n");
  1804			return PTR_ERR(video->eclk);
  1805		}
  1806	
  1807		rc = clk_prepare(video->eclk);
  1808		if (rc)
  1809			return rc;
  1810	
  1811		video->vclk = devm_clk_get(dev, "vclk");
  1812		if (IS_ERR(video->vclk)) {
  1813			dev_err(dev, "Unable to get VCLK\n");
  1814			rc = PTR_ERR(video->vclk);
  1815			goto err_unprepare_eclk;
  1816		}
  1817	
  1818		rc = clk_prepare(video->vclk);
  1819		if (rc)
  1820			goto err_unprepare_eclk;
  1821	
  1822		of_reserved_mem_device_init(dev);
  1823	
  1824		rc = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
  1825		if (rc) {
  1826			dev_err(dev, "Failed to set DMA mask\n");
  1827			goto err_release_reserved_mem;
  1828		}
  1829	
  1830		if (!aspeed_video_alloc_buf(video, &video->jpeg,
  1831					    VE_JPEG_HEADER_SIZE)) {
  1832			dev_err(dev, "Failed to allocate DMA for JPEG header\n");
  1833			rc = -ENOMEM;
  1834			goto err_release_reserved_mem;
  1835		}
> 1836		dev_info(video->dev, "alloc mem size(%d) at %pad for jpeg header\n",
  1837			 VE_JPEG_HEADER_SIZE, video->jpeg.dma);
  1838	
  1839		aspeed_video_init_jpeg_table(video->jpeg.virt, video->yuv420);
  1840	
  1841		return 0;
  1842	
  1843	err_release_reserved_mem:
  1844		of_reserved_mem_device_release(dev);
  1845		clk_unprepare(video->vclk);
  1846	err_unprepare_eclk:
  1847		clk_unprepare(video->eclk);
  1848	
  1849		return rc;
  1850	}
  1851	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
