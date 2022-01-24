Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E25497C90
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 11:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236921AbiAXKAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 05:00:18 -0500
Received: from mga09.intel.com ([134.134.136.24]:3992 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236758AbiAXKAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 05:00:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643018416; x=1674554416;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8ZtgxDRx3fUV+CngGbHk3eUFk2f4ASHYid1O0vcIdRM=;
  b=cEZjhjQVI0GgAyyZzMkceAc1VjDrVfguKPnjn813YStv/S7ctRqCxP63
   1FAY12pjYZehbN0BazsuoBYXDMhwHxBD0jN6mgChsMw0o7dX7DFH+XA/2
   gJ7ORv6TwfwN299QpScxnFRI70wM4vRVDYoYIC1Kh0/EF9ZAEKMTkMKVC
   VKLQiJMXZneeXFwBw5kgDfNMmjhlbF57XQFZ/aMHadgrOm20zLj1OvpHY
   +FtHv3Oj/1ls8hA8KsPSp2Om2oxpC6XNfhoISBMjvu8BcYg6C3OzGD68V
   fTKe82E4VzxfBOaNf/eaREHESRZlvNMv73+a4/bY6eKYA8pv5vnYJRSMH
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245791947"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245791947"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 01:59:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="596743441"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jan 2022 01:59:29 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBw8G-000I9A-OH; Mon, 24 Jan 2022 09:59:28 +0000
Date:   Mon, 24 Jan 2022 17:58:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Walker Chen <walker.chen@starfivetech.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>,
        Michael Yan <michael.yan@starfivetech.com>,
        Jenny Zhang <jenny.zhang@starfivetech.com>
Subject: [esmil:visionfive 48/63] sound/soc/starfive/i2svad.h:238:6: warning:
 no previous prototype for 'i2svad_pcm_push_tx'
Message-ID: <202201241754.z6jBG4qf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   fdbe623707a8f3f9b9d2cb3c4c240299a12b8302
commit: 20e1533986c528bed5da7a0957f828337d17d47d [48/63] ASoC: starfive: Add StarFive JH7100 audio drivers
config: xtensa-randconfig-r031-20220124 (https://download.01.org/0day-ci/archive/20220124/202201241754.z6jBG4qf-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/esmil/linux/commit/20e1533986c528bed5da7a0957f828337d17d47d
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout 20e1533986c528bed5da7a0957f828337d17d47d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash sound/soc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from sound/soc/starfive/i2svad.c:20:
>> sound/soc/starfive/i2svad.h:238:6: warning: no previous prototype for 'i2svad_pcm_push_tx' [-Wmissing-prototypes]
     238 | void i2svad_pcm_push_tx(struct i2svad_dev *dev) { }
         |      ^~~~~~~~~~~~~~~~~~
>> sound/soc/starfive/i2svad.h:239:6: warning: no previous prototype for 'i2svad_pcm_pop_rx' [-Wmissing-prototypes]
     239 | void i2svad_pcm_pop_rx(struct i2svad_dev *dev) { }
         |      ^~~~~~~~~~~~~~~~~
>> sound/soc/starfive/i2svad.h:240:5: warning: no previous prototype for 'i2svad_pcm_register' [-Wmissing-prototypes]
     240 | int i2svad_pcm_register(struct platform_device *pdev)
         |     ^~~~~~~~~~~~~~~~~~~


vim +/i2svad_pcm_push_tx +238 sound/soc/starfive/i2svad.h

   232	
   233	#if IS_ENABLED(CONFIG_SND_STARFIVE_I2SVAD_PCM)
   234	void i2svad_pcm_push_tx(struct i2svad_dev *dev);
   235	void i2svad_pcm_pop_rx(struct i2svad_dev *dev);
   236	int i2svad_pcm_register(struct platform_device *pdev);
   237	#else
 > 238	void i2svad_pcm_push_tx(struct i2svad_dev *dev) { }
 > 239	void i2svad_pcm_pop_rx(struct i2svad_dev *dev) { }
 > 240	int i2svad_pcm_register(struct platform_device *pdev)
   241	{
   242		return -EINVAL;
   243	}
   244	#endif
   245	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
