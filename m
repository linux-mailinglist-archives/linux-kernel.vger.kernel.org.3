Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8090E476668
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 00:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbhLOXS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 18:18:26 -0500
Received: from mga04.intel.com ([192.55.52.120]:32459 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231739AbhLOXSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 18:18:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639610305; x=1671146305;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xQ26BUz+k4fhasysACi2E4Vhe5JYva74KMEDxEUm2T8=;
  b=IehdJ2BcVQRNmDe9+E5XxNLrww6n6N/ypvVump0CBBfFK6WLKRrfnp1y
   +WKBsVQtp3ZN6eAwv2+Hi8Hhjj5NnxD+eR+RVTaiCP+Oc7oFrKjpwByp3
   ps/k8l98FosOaJe0fxu3VWj/91Hdu/skszZtdAhZ8SD5HuEHBcxHBWcou
   BFsyEnPQ3iVVRpgn38G864WsjdPAC2OUvAJ9RZy8a8i/Ysa4HB3OpAx6C
   ZFoauXW6Iy7b80lF3qHdkiKZlGiZm7vU6EwavFlC4ppsd9BIg8Wm0BMiC
   +sh3dL5iHM3i6VYntwkC6PG5gN2zQyEyi2TuUheFNl1C2gVhzVDoignuZ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="238096634"
X-IronPort-AV: E=Sophos;i="5.88,209,1635231600"; 
   d="scan'208";a="238096634"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 15:18:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,209,1635231600"; 
   d="scan'208";a="682694788"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 15 Dec 2021 15:18:23 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxdXS-0002TL-OR; Wed, 15 Dec 2021 23:18:22 +0000
Date:   Thu, 16 Dec 2021 07:18:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik@protonmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [asahilinux:touchpad/wip 65/82] sound/soc/apple/mca.c:649:6:
 warning: no previous prototype for 'apple_mca_release_dma_chans'
Message-ID: <202112160704.pOSNBaTM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux touchpad/wip
head:   a2281d64fdbcbab0dae68c6ea75bd5b548332e06
commit: 69522c02d34bab7ab9e5da1a294a7387e9ca5f8c [65/82] ASoC: apple-mca: Add platform driver for Apple SoCs
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20211216/202112160704.pOSNBaTM-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/69522c02d34bab7ab9e5da1a294a7387e9ca5f8c
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux touchpad/wip
        git checkout 69522c02d34bab7ab9e5da1a294a7387e9ca5f8c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash drivers/clk/ drivers/dma/ sound/soc/apple/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   sound/soc/apple/mca.c: In function 'mca_configure_serdes':
   sound/soc/apple/mca.c:210:23: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
     210 |         serdes_conf = FIELD_PREP(SERDES_CONF_NCHANS, max(slots, 1) - 1);
         |                       ^~~~~~~~~~
   sound/soc/apple/mca.c: In function 'mca_set_runtime_hwparams':
   sound/soc/apple/mca.c:528:37: warning: unused variable 'rtd' [-Wunused-variable]
     528 |         struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
         |                                     ^~~
   sound/soc/apple/mca.c: At top level:
>> sound/soc/apple/mca.c:649:6: warning: no previous prototype for 'apple_mca_release_dma_chans' [-Wmissing-prototypes]
     649 | void apple_mca_release_dma_chans(struct mca_data *mca)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> sound/soc/apple/mca.c:664:6: warning: no previous prototype for 'apple_mca_put_clks' [-Wmissing-prototypes]
     664 | void apple_mca_put_clks(struct mca_data *mca)
         |      ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/apple_mca_release_dma_chans +649 sound/soc/apple/mca.c

   648	
 > 649	void apple_mca_release_dma_chans(struct mca_data *mca)
   650	{
   651		int i;
   652		struct mca_route *route;
   653	
   654		list_for_each_entry(route, &mca->routes, list) {
   655			for_each_pcm_streams(i) {
   656				if (!route->chan[i])
   657					continue;
   658				dma_release_channel(route->chan[i]);
   659				route->chan[i] = NULL;
   660			}
   661		}
   662	}
   663	
 > 664	void apple_mca_put_clks(struct mca_data *mca)
   665	{
   666		struct mca_route *route;
   667		int i;
   668	
   669		list_for_each_entry(route, &mca->routes, list) {
   670			if (!route->clk_parent)
   671				continue;
   672			//clk_rate_exclusive_put(route->clk_parent);
   673			route->clk_parent = NULL;
   674		}
   675	
   676		for (i = 0; i < mca->nclusters; i++) {
   677			if (!mca->clk_parents[i])
   678				continue;
   679			clk_put(mca->clk_parents[i]);
   680			mca->clk_parents[i] = NULL;
   681		}
   682	}
   683	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
