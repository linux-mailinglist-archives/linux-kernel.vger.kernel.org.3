Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B3A54FC49
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 19:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiFQRhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 13:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382854AbiFQRhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 13:37:03 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28BC381B5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 10:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655487421; x=1687023421;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=A0mH88Eu9d8YJdtFruQngDThFuGnpYD5jAp7cMyF/ck=;
  b=NNXx5GMFo418Wi+CMmyE6Z821RYOxna6vz3m/gfW+gF8xjrkscMataNT
   pY3gShjQxyW4b8vuEANBkp4eZHA5G7CRM7O61xZiYsYDx9mfxaJFqGsQf
   Zg7fEPg0Lv1CD8Lis9Q6K+BYR4wCuMpKj4LpAV5SnkW6I5VQie6G9x/fR
   jj0K7UXuGCRN2nwt8lZVlFV7q9MVQEXevb614qylbM3lDHseKeQTGDJs9
   ICdz1rU0/Khr56Zbs8U5/doMx+2fpfOuKOybK5ftoQXgk38qTwvyOIUoW
   M+3ww0FmtWWk4HDBvVXrxepcJ1WDIfHm3NRDYkI244ipgeJv7rtvkcjho
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="278276986"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="278276986"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 06:41:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="536825754"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 17 Jun 2022 06:41:43 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2CEI-000PTv-L5;
        Fri, 17 Jun 2022 13:41:42 +0000
Date:   Fri, 17 Jun 2022 21:40:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [morse:mpam/snapshot/v5.18 113/146]
 drivers/platform/mpam/mpam_devices.c:1823:34: warning: variable 'mbwu_state'
 set but not used
Message-ID: <202206172134.hLhEJMjm-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v5.18
head:   bac90d25cbdee0fc233b9b1c47d5b6f44101a384
commit: b14b450aa8048b7f426d01386d754ab6a398fa96 [113/146] arm_mpam: Track bandwidth counter state for overflow and power management
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220617/202206172134.hLhEJMjm-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?id=b14b450aa8048b7f426d01386d754ab6a398fa96
        git remote add morse https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
        git fetch --no-tags morse mpam/snapshot/v5.18
        git checkout b14b450aa8048b7f426d01386d754ab6a398fa96
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/platform/mpam/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/platform/mpam/mpam_devices.c: In function '__destroy_component_cfg':
>> drivers/platform/mpam/mpam_devices.c:1823:34: warning: variable 'mbwu_state' set but not used [-Wunused-but-set-variable]
    1823 |         struct msmon_mbwu_state *mbwu_state;
         |                                  ^~~~~~~~~~


vim +/mbwu_state +1823 drivers/platform/mpam/mpam_devices.c

  1818	
  1819	static void __destroy_component_cfg(struct mpam_component *comp)
  1820	{
  1821		unsigned long flags;
  1822		struct mpam_msc_ris *ris;
> 1823		struct msmon_mbwu_state *mbwu_state;
  1824	
  1825		kfree(comp->cfg);
  1826		list_for_each_entry(ris, &comp->ris, comp_list) {
  1827			spin_lock(&ris->msc->lock);
  1828			spin_lock_irqsave(&ris->msc->mon_sel_lock, flags);
  1829			mbwu_state = ris->mbwu_state;
  1830			ris->mbwu_state = NULL;
  1831			spin_unlock_irqrestore(&ris->msc->mon_sel_lock, flags);
  1832			spin_unlock(&ris->msc->lock);
  1833	
  1834			kfree(ris->mbwu_state);
  1835		}
  1836	}
  1837	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
