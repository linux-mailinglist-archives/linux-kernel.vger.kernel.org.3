Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3184EE3F0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 00:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242382AbiCaWXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 18:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241788AbiCaWXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 18:23:17 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A96D247C06
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 15:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648765290; x=1680301290;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SmAhzdczCQr2mFfZTR4WT2nndIx1sPUm8+3tEgqCMwk=;
  b=TYIltZU6Ts98gej7X5E8SF+EwwiFqZ7k7IGKdL5+GlM/0+W8xqEXOoSp
   GR6HZiwlScXqV+uXOusdarOPR/QUNNGvina7ED1FX6D5EGKNbYLl4pfIU
   nreMDx6b19Sgbeo7t9cbxG+3/ZDCmk8uq4FCJ/RUvyKa6JbacJrUcfERu
   3Vg/UN508L4xKQa6UjqR8Nj/9xP+oeeBpgH5Uqb566V/QjA2CJS+fOU7Q
   ExFpXaq+zzknvuy4byTJAXcFMyNkA+JihB0v+bTzNHc1Gy2MBst/g2cPo
   xmNCV1rkMs/hNxkBR5TXEBFbIEVIWD0Hk4XAWLLKxsFWi5MUDHEfmAkWR
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10303"; a="346418040"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="346418040"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 15:21:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="788586084"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 31 Mar 2022 15:21:28 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1na3AV-0000hZ-Q5;
        Thu, 31 Mar 2022 22:21:27 +0000
Date:   Fri, 1 Apr 2022 06:20:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Youghandhar Chintala <youghand@codeaurora.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: ld.lld: error: undefined symbol: ieee80211_sta_restart
Message-ID: <202204010615.CBtHI0Bf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Youghandhar,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e729dbe8ea1c6145ae7b9efd6a00a5613746d3b0
commit: 7d352ccf1e9935b5222ca84e8baeb07a0c8f94b9 mac80211: Add support to trigger sta disconnect on hardware restart
date:   3 weeks ago
config: hexagon-randconfig-r045-20220331 (https://download.01.org/0day-ci/archive/20220401/202204010615.CBtHI0Bf-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 881350a92d821d4f8e4fa648443ed1d17e251188)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7d352ccf1e9935b5222ca84e8baeb07a0c8f94b9
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 7d352ccf1e9935b5222ca84e8baeb07a0c8f94b9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: ieee80211_sta_restart
   >>> referenced by util.c
   >>>               mac80211/util.o:(ieee80211_reconfig) in archive net/built-in.a
   >>> referenced by util.c
   >>>               mac80211/util.o:(ieee80211_reconfig) in archive net/built-in.a

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
