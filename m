Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93EE497D2E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 11:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237134AbiAXK3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 05:29:39 -0500
Received: from mga14.intel.com ([192.55.52.115]:22651 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233982AbiAXK3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 05:29:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643020178; x=1674556178;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=daLP+rgqWynhNuFdT/Qj6qmZPrVmeIgmjO0+r7cxsZ4=;
  b=HaqLzzmcLVgLaf9jGxgjxbzHXFeXmHEOQFMHfc4ZGM/7IGYJqZH9FlcN
   s2uP5BG6AtZPmm4+P003smpxjO+9J7kVy/OLmaST8JIF52hXko2BTIFxL
   ZSaGCKh/sKOxFq3sDR8A6IQnfcytH7g8g66CnfKJBvhei3/6JkB5Gy3dx
   k5/OPuNwEkHPcpfmz1DwNt7bE6Yy4dUuKa+ZthcgyAOIjg3iDvwxsa+JT
   rZi2G3iYdW0XvIylzBb3hzoK2k6gFSZc+8kU54Y5bYU0ZicSYOXNSQZvQ
   qCvPilKVXIJpnPBlzXMZMJBoVnc2fU0QKKIvXaZFOfndSCjnh2GEHgClD
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="246232448"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="246232448"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 02:29:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="562609565"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 24 Jan 2022 02:29:36 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBwbP-000IBq-PY; Mon, 24 Jan 2022 10:29:35 +0000
Date:   Mon, 24 Jan 2022 18:29:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Walker Chen <walker.chen@starfivetech.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>,
        Michael Yan <michael.yan@starfivetech.com>,
        Jenny Zhang <jenny.zhang@starfivetech.com>
Subject: [esmil:visionfive 48/63] sound/soc/starfive/spdif.h:145:6: warning:
 no previous prototype for 'sf_spdif_pcm_push_tx'
Message-ID: <202201241838.ABa6OLrH-lkp@intel.com>
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
config: sparc-randconfig-r014-20220124 (https://download.01.org/0day-ci/archive/20220124/202201241838.ABa6OLrH-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/esmil/linux/commit/20e1533986c528bed5da7a0957f828337d17d47d
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout 20e1533986c528bed5da7a0957f828337d17d47d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc SHELL=/bin/bash sound/soc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from sound/soc/starfive/spdif.c:21:
>> sound/soc/starfive/spdif.h:145:6: warning: no previous prototype for 'sf_spdif_pcm_push_tx' [-Wmissing-prototypes]
     145 | void sf_spdif_pcm_push_tx(struct sf_spdif_dev *dev) { }
         |      ^~~~~~~~~~~~~~~~~~~~
>> sound/soc/starfive/spdif.h:146:6: warning: no previous prototype for 'sf_spdif_pcm_pop_rx' [-Wmissing-prototypes]
     146 | void sf_spdif_pcm_pop_rx(struct sf_spdif_dev *dev) { }
         |      ^~~~~~~~~~~~~~~~~~~
>> sound/soc/starfive/spdif.h:147:5: warning: no previous prototype for 'sf_spdif_pcm_register' [-Wmissing-prototypes]
     147 | int sf_spdif_pcm_register(struct platform_device *pdev)
         |     ^~~~~~~~~~~~~~~~~~~~~
--
   In file included from sound/soc/starfive/pwmdac.c:19:
>> sound/soc/starfive/pwmdac.h:145:6: warning: no previous prototype for 'sf_pwmdac_pcm_push_tx' [-Wmissing-prototypes]
     145 | void sf_pwmdac_pcm_push_tx(struct sf_pwmdac_dev *dev) { }
         |      ^~~~~~~~~~~~~~~~~~~~~
>> sound/soc/starfive/pwmdac.h:146:6: warning: no previous prototype for 'sf_pwmdac_pcm_pop_rx' [-Wmissing-prototypes]
     146 | void sf_pwmdac_pcm_pop_rx(struct sf_pwmdac_dev *dev) { }
         |      ^~~~~~~~~~~~~~~~~~~~
>> sound/soc/starfive/pwmdac.h:147:5: warning: no previous prototype for 'sf_pwmdac_pcm_register' [-Wmissing-prototypes]
     147 | int sf_pwmdac_pcm_register(struct platform_device *pdev)
         |     ^~~~~~~~~~~~~~~~~~~~~~


vim +/sf_spdif_pcm_push_tx +145 sound/soc/starfive/spdif.h

   139	
   140	#if IS_ENABLED(CONFIG_SND_STARFIVE_SPDIF_PCM)
   141	void sf_spdif_pcm_push_tx(struct sf_spdif_dev *dev);
   142	void sf_spdif_pcm_pop_rx(struct sf_spdif_dev *dev);
   143	int sf_spdif_pcm_register(struct platform_device *pdev);
   144	#else
 > 145	void sf_spdif_pcm_push_tx(struct sf_spdif_dev *dev) { }
 > 146	void sf_spdif_pcm_pop_rx(struct sf_spdif_dev *dev) { }
 > 147	int sf_spdif_pcm_register(struct platform_device *pdev)
   148	{
   149		return -EINVAL;
   150	}
   151	#endif
   152	
   153	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
