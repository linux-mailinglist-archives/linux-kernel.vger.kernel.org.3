Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4AA47B998
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 06:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbhLUFiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 00:38:50 -0500
Received: from mga18.intel.com ([134.134.136.126]:15027 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232873AbhLUFis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 00:38:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640065128; x=1671601128;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TxYqsm5Ua0dPFeLnveetUwHEA57fIEMpYAvyjeYmbHc=;
  b=XumWO7DovcbjoxFJkCAzpwzd/jabZpohvP6QXgBujYKIi84BsW0NyVrB
   RpiZU4suviZkYTziGshbqyfqVsvHKRj0VRFfF4Eps5+TRy77NdXr0b1sj
   KlZcHXow6mGAJL23DAZx1mEpWNtNrOgvYvE213NpWP6NbIR0H0ZDSVyQb
   4I2Tq0DLG6AN546yWhsIwgTSlhkyw0S3bFSw5dqchvyT5/RAeLzQmYMQt
   ywxAAcMh/uYXuVIu9+Le/iZ4z924vqLS13Yu/LSc/mWUuy8M0WiEle6WS
   MANSzFmvDp+tg5KhXkgZiRnZpAu6Ymezdz5hGzmqyZHOgOUc1T/ZX4gJk
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="227181192"
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="227181192"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 21:38:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="570103568"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 20 Dec 2021 21:38:46 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzXrJ-0008jj-SA; Tue, 21 Dec 2021 05:38:45 +0000
Date:   Tue, 21 Dec 2021 13:37:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik@protonmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sven Peter <sven@svenpeter.dev>
Subject: [asahilinux:asahi-with-new-nvme 12/34] sound/soc/apple/mca.c:210:23:
 error: implicit declaration of function 'FIELD_PREP'
Message-ID: <202112211335.csVK7tOM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux asahi-with-new-nvme
head:   675e4ce8d8355827d6ee1f2fadff9fd9598348c7
commit: 4ca8fc34261576f2b4c9908ae273d7871d30e198 [12/34] ASoC: apple-mca: Add platform driver for Apple SoCs
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20211221/202112211335.csVK7tOM-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/4ca8fc34261576f2b4c9908ae273d7871d30e198
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux asahi-with-new-nvme
        git checkout 4ca8fc34261576f2b4c9908ae273d7871d30e198
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash sound/soc/apple/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   sound/soc/apple/mca.c: In function 'mca_configure_serdes':
>> sound/soc/apple/mca.c:210:23: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
     210 |         serdes_conf = FIELD_PREP(SERDES_CONF_NCHANS, max(slots, 1) - 1);
         |                       ^~~~~~~~~~
   sound/soc/apple/mca.c: In function 'mca_set_runtime_hwparams':
   sound/soc/apple/mca.c:528:37: warning: unused variable 'rtd' [-Wunused-variable]
     528 |         struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
         |                                     ^~~
   sound/soc/apple/mca.c: At top level:
   sound/soc/apple/mca.c:649:6: warning: no previous prototype for 'apple_mca_release_dma_chans' [-Wmissing-prototypes]
     649 | void apple_mca_release_dma_chans(struct mca_data *mca)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/apple/mca.c:664:6: warning: no previous prototype for 'apple_mca_put_clks' [-Wmissing-prototypes]
     664 | void apple_mca_put_clks(struct mca_data *mca)
         |      ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/FIELD_PREP +210 sound/soc/apple/mca.c

   204	
   205	static int mca_configure_serdes(struct mca_data *mca, int cluster, int serdes_unit,
   206					unsigned int mask, int slots, int slot_width)
   207	{
   208		u32 serdes_conf;
   209	
 > 210		serdes_conf = FIELD_PREP(SERDES_CONF_NCHANS, max(slots, 1) - 1);
   211	
   212		switch (slot_width) {
   213		case 16:
   214			serdes_conf |= SERDES_CONF_WIDTH_16BIT;
   215			break;
   216		case 20:
   217			serdes_conf |= SERDES_CONF_WIDTH_20BIT;
   218			break;
   219		case 24:
   220			serdes_conf |= SERDES_CONF_WIDTH_24BIT;
   221			break;
   222		case 32:
   223			serdes_conf |= SERDES_CONF_WIDTH_32BIT;
   224			break;
   225		default:
   226			goto err;
   227		}
   228	
   229		mca_modify(mca, cluster,
   230			serdes_unit + REG_SERDES_CONF,
   231			SERDES_CONF_WIDTH_MASK | SERDES_CONF_NCHANS, serdes_conf);
   232		mca_poke(mca, cluster,
   233			serdes_unit + REG_SERDES_CHANMASK,
   234			~((u32) mask));
   235	
   236		return 0;
   237	
   238	err:
   239		dev_err(mca->dev, "unsupported SERDES configuration requested (mask=0x%x slots=%d slot_width=%d)\n",
   240				mask, slots, slot_width);
   241		return -EINVAL;
   242	}
   243	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
