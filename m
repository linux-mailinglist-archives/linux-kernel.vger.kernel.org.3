Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF3D5244DC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 07:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349900AbiELF0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 01:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238423AbiELF0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 01:26:37 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87BF3C708
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 22:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652333196; x=1683869196;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8V92TNSmtJ/th+9WHqd0K1I+YhEv+oyeIcZciouWzTU=;
  b=TB6BYD94FWQDuggZOprttI4ZSQIJ4rmMKEBn+MDkgfmQ9vtSQvQY/cxp
   2kvu9okuDJfM7mAfItpoU97fQymWra471iwzkgu9AiTSRW6i1v6fLwJia
   +q/iq2HNibE3IoYhMmtGaWgByiSjA02jhh2blul5H8WEtrwqf+wje2THL
   ZlWNMLyyIsVZ6WQokBYsF792kdQLBXd1Te8MvF6tD1uTPFAoFSi/hpsJn
   EwkR1bXPG+7kb9R+usMQko1HjDuXtYbq8NPYFUqJ0N4qSAolHEmniBUNO
   I7D+36LTTD9+AU303dNOGk6WyFCblzAkeQwtOFvNS8zQgbs0+dgvLT8IY
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="295140962"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="295140962"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 22:26:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="658457239"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 11 May 2022 22:26:35 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1np1LO-000Jyb-QB;
        Thu, 12 May 2022 05:26:34 +0000
Date:   Thu, 12 May 2022 13:26:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: drivers/power/supply/ltc4162-l-charger.c:912:34: warning:
 'ltc4162l_of_match' defined but not used
Message-ID: <202205121341.cUtTcrOF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   feb9c5e19e913b53cb536a7aa7c9f20107bb51ec
commit: cd900f181ad6b548a8feded5dd224f789f09b1c6 power/supply: Add ltc4162-l-charger
date:   1 year, 4 months ago
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220512/202205121341.cUtTcrOF-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cd900f181ad6b548a8feded5dd224f789f09b1c6
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout cd900f181ad6b548a8feded5dd224f789f09b1c6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/power/supply/ltc4162-l-charger.c:912:34: warning: 'ltc4162l_of_match' defined but not used [-Wunused-const-variable=]
     912 | static const struct of_device_id ltc4162l_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~


vim +/ltc4162l_of_match +912 drivers/power/supply/ltc4162-l-charger.c

   911	
 > 912	static const struct of_device_id ltc4162l_of_match[] = {
   913		{ .compatible = "lltc,ltc4162-l", },
   914		{ },
   915	};
   916	MODULE_DEVICE_TABLE(of, ltc4162l_of_match);
   917	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
