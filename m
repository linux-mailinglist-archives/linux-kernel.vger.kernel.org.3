Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56425209DC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 02:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbiEJASJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 20:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbiEJASH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 20:18:07 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC351CB07
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 17:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652141645; x=1683677645;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hvivBOMURoOlEvywiMdH/R9syCqU9RZm9mRpf/b4dV4=;
  b=j1v3zeH4iPrVMPbVVBemJEAI2EPEO2oGm8Ltyw8IH8w58huk5wJVh9ex
   3plsYcQCxoGVZLeBDrgXTGGg8gGhCZZ58c6sKuhj8nx/KBHRPI7V2ArFh
   O007nHAfjyuqfoFqcx7dBmtgitxsDXmkMl36/tAtt8Devcfv7GD9t5hon
   wu0AEDYS6tANlM5Eu1Kt2dFPhwIZ8D6G3/m06WLPoiiAgmlS/G+tNXo9t
   pmE2NPez/+cFC4o0aopVoIsErKfJd8yDlZODheJQCj8qQj+99uHhpalPN
   A8PjKCrNMgrs8vpIfUmN776Q0FjOpWvJDlVwUZ29iQ9zqSntyuLELgFSv
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="251254116"
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="251254116"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 17:14:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="552199612"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 09 May 2022 17:14:04 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noDVr-000H2i-6T;
        Tue, 10 May 2022 00:14:03 +0000
Date:   Tue, 10 May 2022 08:13:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Gomez <dagmcr@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: drivers/rtc/rtc-rx6110.c:384:34: warning: 'rx6110_spi_of_match'
 defined but not used
Message-ID: <202205100826.fdvQ2tpG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9be9ed2612b5aedb52a2c240edb1630b6b743cb6
commit: f9bf089a70aab6baac745843b44c152084848f5e rtc: rx6110: declare missing of table
date:   3 years ago
config: i386-randconfig-r026-20220509 (https://download.01.org/0day-ci/archive/20220510/202205100826.fdvQ2tpG-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f9bf089a70aab6baac745843b44c152084848f5e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f9bf089a70aab6baac745843b44c152084848f5e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/crypto/ drivers/rtc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/rtc/rtc-rx6110.c:384:34: warning: 'rx6110_spi_of_match' defined but not used [-Wunused-const-variable=]
     384 | static const struct of_device_id rx6110_spi_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~


vim +/rx6110_spi_of_match +384 drivers/rtc/rtc-rx6110.c

   383	
 > 384	static const struct of_device_id rx6110_spi_of_match[] = {
   385		{ .compatible = "epson,rx6110" },
   386		{ },
   387	};
   388	MODULE_DEVICE_TABLE(of, rx6110_spi_of_match);
   389	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
