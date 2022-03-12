Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9C74D6ED1
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 14:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbiCLN3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 08:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiCLN3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 08:29:38 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB561DA53
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 05:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647091711; x=1678627711;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lN2zXVmtYoxNKXB19+1YdjQmuTD84Gfz+wwuT706X30=;
  b=jnk/NubPRkfIAohpYv7U7ZkavIZxbXcGe73d/RBECKmNWtLsO5cglGin
   +FNyxwjxlm2E7L4E9xWI0w+K1SwduGeR4AJdfdkQCNkpHyXubyaUO2b4+
   9+tC9qRyiUztehcuk5kJARbrhcaRTlq3cL5cWBTnj8pxbLuxeoVW+hLtz
   HWLa69jVQSpAPgKkFK6JIVjKNlasExULKYpLhoQRl0HrPJTioOXTDt4DM
   O5L9omRmuPulRowWeHSDFvqtbX1dbBmzlLV4lRfD8/EIBqp+beJA6B6V7
   bHk7p27cwyJMWCfCf+eHq6PCqB6UuWrk+WO89wRmiJ8H1Awdiqj+IAvrb
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="255742901"
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="255742901"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2022 05:28:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="597413002"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 12 Mar 2022 05:28:29 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nT1nI-0007u3-Oo; Sat, 12 Mar 2022 13:28:28 +0000
Date:   Sat, 12 Mar 2022 21:27:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Youghandhar Chintala <youghand@codeaurora.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: [ammarfaizi2-block:netdev/net-next/master 41/77] ERROR: modpost:
 "ieee80211_sta_restart" [net/mac80211/mac80211.ko] undefined!
Message-ID: <202203122147.Q0VtHIf0-lkp@intel.com>
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
config: mips-malta_defconfig (https://download.01.org/0day-ci/archive/20220312/202203122147.Q0VtHIf0-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 43f668b98e8d87290fc6bbf5ed13c3ab542e3497)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/7d352ccf1e9935b5222ca84e8baeb07a0c8f94b9
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block netdev/net-next/master
        git checkout 7d352ccf1e9935b5222ca84e8baeb07a0c8f94b9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "ieee80211_sta_restart" [net/mac80211/mac80211.ko] undefined!

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
