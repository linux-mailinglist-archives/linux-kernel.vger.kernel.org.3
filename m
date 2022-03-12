Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9191D4D6F47
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 14:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbiCLNth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 08:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbiCLNtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 08:49:36 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFE24132A
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 05:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647092911; x=1678628911;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pktZjBrmCLIoDX7PEJiMf940Ias3pHV3h3Lksk4acnU=;
  b=bFcKynMCrbBWHjXYfKrQU9Y7gDEeZer7rMrEdsYzhDazrCdhuQu3F6Ih
   0TpQK3aSMMIUEExl7ifW3MGh2iG6AA4UqmgN1Egrz9KpYaDjyt+lUmZPu
   6nFLAUEenUY2k4Z0lgLENBusy5smV7wjKxmxpUxqeklfAKok85p7dXMzz
   sHwefeh7M3QDFjqjzMNGTb8h5kehL6Y7dO9N5MCeTmERh5a1qWN0iiGCr
   Z78yCRSp+OyL+/DVVsn7MKQ1wLdf7Rp0HxFFw9JJWTzUGopCcTO/TZi7M
   pEkho2NMRO9hyAz9Bl1V7mvdbff8CCre/ZPpmb8ZI/hinzdiJgWNOa89l
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="236396116"
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="236396116"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2022 05:48:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="782163804"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 12 Mar 2022 05:48:29 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nT26f-0007v5-53; Sat, 12 Mar 2022 13:48:29 +0000
Date:   Sat, 12 Mar 2022 21:48:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Youghandhar Chintala <youghand@codeaurora.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: [ammarfaizi2-block:netdev/net-next/master 41/77] ERROR: modpost:
 "ieee80211_sta_restart" [net/mac80211/mac80211.ko] undefined!
Message-ID: <202203122112.fsBABwhb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block netdev/net-next/master
head:   625788b5844511cf4c30cffa7fa0bc3a69cebc82
commit: 7d352ccf1e9935b5222ca84e8baeb07a0c8f94b9 [41/77] mac80211: Add support to trigger sta disconnect on hardware restart
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20220312/202203122112.fsBABwhb-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/7d352ccf1e9935b5222ca84e8baeb07a0c8f94b9
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block netdev/net-next/master
        git checkout 7d352ccf1e9935b5222ca84e8baeb07a0c8f94b9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "ieee80211_sta_restart" [net/mac80211/mac80211.ko] undefined!

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
