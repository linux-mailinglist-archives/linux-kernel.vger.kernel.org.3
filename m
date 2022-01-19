Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9ED493348
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 04:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351183AbiASDBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 22:01:25 -0500
Received: from mga01.intel.com ([192.55.52.88]:51838 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345120AbiASDBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 22:01:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642561276; x=1674097276;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LpDDqcLWvx9STEeHS9LKkhCj24vYjwM75fXz9eN/N4s=;
  b=UBm/+FgrgFYeknciRW61euJTn4I4++rwnd4/qC2baavovAQRqDYTbMqm
   tTUaqGD99xhEJW+68b/Tib18a19b4jPt94TZGoN45znAjf2u8Rb7mzMh6
   ajFbxbcqXsgVtRivOjxZk+eIUSazpRR7KF6cSzBVepwQPNuPRshY7lK8X
   8/GiHoceSajehoEwOFkmpHjk3q2pjtM+D7lfKMImkpePiScSiP4vlV5Zn
   +KOYCRT4cVzhH24Zzp0/6OpnKbKa5s64xwnK50ot2cC0ZQSLbBjpM6TRb
   2HARBqVRWjEgA/WhsOhVQCjDpelY4mVaEgvRuT52KqvbZoJc5PveHvcPq
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="269356721"
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="269356721"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 19:01:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="625727306"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 18 Jan 2022 19:01:15 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nA1Dm-000DBg-HB; Wed, 19 Jan 2022 03:01:14 +0000
Date:   Wed, 19 Jan 2022 11:00:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik@protonmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [asahilinux:bits/070-audio 6/10] sound/soc/apple/mca.c:210:23:
 error: implicit declaration of function 'FIELD_PREP'
Message-ID: <202201191010.ccJSermy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/070-audio
head:   63a99f1a44208593f5a423b5378824abc2246988
commit: 3bd1b7277353e3c32b737543b6e95de54f11600e [6/10] ASoC: apple-mca: Add platform driver for Apple SoCs
config: csky-allyesconfig (https://download.01.org/0day-ci/archive/20220119/202201191010.ccJSermy-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/3bd1b7277353e3c32b737543b6e95de54f11600e
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/070-audio
        git checkout 3bd1b7277353e3c32b737543b6e95de54f11600e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=csky SHELL=/bin/bash

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
