Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7671E49C80C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240302AbiAZKwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:52:53 -0500
Received: from mga01.intel.com ([192.55.52.88]:19403 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240328AbiAZKwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:52:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643194370; x=1674730370;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vK8S3U4ZMTunCKxUMp3DknqdR/8wZMDXhn4ijOgZxow=;
  b=d0rsmH6I5iPjakYGEPtAeyJ9/JMPKEHRFgCo7z4hU49roT+GT/ZLqeCP
   7OIvgOcnPzDuqGUNR3uXHu2F68pGUk4CSy1GSJDALSBHUQZCNyYKfpJZu
   Kih6ES6ynDquNsJe554UUsZAOzPdfEN+FfhbnXisGmf7RpxNXelte8agG
   qyJKptAeSYNERybIvh9SBvsCAfOomRVA8n/GuoCFFVeWokhuklcxdN1zj
   PEiD/U34rup914GlZQdHyVJjd4xE2uQhSr+v+Q5VReCu3WaBM67EtBE7y
   MqZB7hdoRfIb2ybuL29pdyospGJ/+Epy4aSkeTgSLFCi2LGVpRnHCBPWE
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="270976033"
X-IronPort-AV: E=Sophos;i="5.88,317,1635231600"; 
   d="scan'208";a="270976033"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 02:52:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,317,1635231600"; 
   d="scan'208";a="477447050"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 26 Jan 2022 02:52:47 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCfux-000L66-5N; Wed, 26 Jan 2022 10:52:47 +0000
Date:   Wed, 26 Jan 2022 18:52:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [morse:mpam/snapshot/v5.16 91/137]
 drivers/platform/mpam/mpam_devices.c:230:5: warning: no previous prototype
 for 'mpam_msc_drv_remove'
Message-ID: <202201261848.Ojsmqjmk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v5.16
head:   364c1c42b229912132e1615c2ce15be7154e2156
commit: 166780f7cb6bac22a4707a368a2580bc6899e38f [91/137] arm_mpam: Add probe/remove for mpam msc driver and kbuild boiler plate
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220126/202201261848.Ojsmqjmk-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?id=166780f7cb6bac22a4707a368a2580bc6899e38f
        git remote add morse https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
        git fetch --no-tags morse mpam/snapshot/v5.16
        git checkout 166780f7cb6bac22a4707a368a2580bc6899e38f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/platform/mpam/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/platform/mpam/mpam_devices.c:230:5: warning: no previous prototype for 'mpam_msc_drv_remove' [-Wmissing-prototypes]
     230 | int mpam_msc_drv_remove(struct platform_device *pdev)
         |     ^~~~~~~~~~~~~~~~~~~


vim +/mpam_msc_drv_remove +230 drivers/platform/mpam/mpam_devices.c

   229	
 > 230	int mpam_msc_drv_remove(struct platform_device *pdev)
   231	{
   232		struct mpam_msc *msc = platform_get_drvdata(pdev);
   233	
   234		if (!msc)
   235			return 0;
   236	
   237		mutex_lock(&mpam_list_lock);
   238		mpam_num_msc--;
   239		platform_set_drvdata(pdev, NULL);
   240		list_del_rcu(&msc->glbl_list);
   241		synchronize_rcu();
   242		mutex_unlock(&mpam_list_lock);
   243	
   244		return 0;
   245	}
   246	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
