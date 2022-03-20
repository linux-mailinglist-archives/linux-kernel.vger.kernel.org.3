Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6E64E1C04
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 15:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245247AbiCTOWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 10:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbiCTOWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 10:22:51 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C34F1DA7F
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 07:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647786088; x=1679322088;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=n+vDeIztEIKwxUD3DxkT4crd72pzYlpQpx2xbAzEtGI=;
  b=XxispKVDKQCGLLlw5wlYxfyF5HY4RxLqJ2vozMkRMK6Ps4EUfQrgpp6P
   AXfs47yG/xDfWnUeKwEqoU8Tc7RIC1u6G1DIZs/h2axsHPX1RUVNwe2yc
   /M/PFXgdgJbbJ81OtCkE4yCHWj+1630+wRHjPODfmvcGp5luOshkXZj36
   Psv0T9JBZJddsyn5IfySNqNJRTYoipi7TcAUJIQXNf3L8Zpxo0jun3wsG
   L3LG2qFhOcPB57joEzq2VTu58NWGZXmeO2ahto7nQ6O65JwjNaTTzr1HT
   tBL7Xc+q9v1O5eev709WX4mDmGYzMM5pJbOS9DDowANwvr1HkHO21QT1L
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10291"; a="320604075"
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="320604075"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2022 07:21:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="542889558"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 20 Mar 2022 07:21:26 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVwQv-000Gys-MN; Sun, 20 Mar 2022 14:21:25 +0000
Date:   Sun, 20 Mar 2022 22:20:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>, Phil Sutter <phil@nwl.cc>
Subject: ERROR: modpost: "nf_conntrack_net_id" [net/netfilter/nft_ct.ko]
 undefined!
Message-ID: <202203202244.ksI5JHVO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/0day-ci/linux/commits/UPDATE-20220320-063014/Phil-Sutter/netfilter-conntrack-Add-and-use-nf_ct_set_auto_assign_helper_warned/20220303-050505
head:   6da9aa33806ac1acc20a7e05e3197618b75e3049
commit: 6da9aa33806ac1acc20a7e05e3197618b75e3049 netfilter: conntrack: Add and use nf_ct_set_auto_assign_helper_warned()
date:   16 hours ago
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20220320/202203202244.ksI5JHVO-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/6da9aa33806ac1acc20a7e05e3197618b75e3049
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review UPDATE-20220320-063014/Phil-Sutter/netfilter-conntrack-Add-and-use-nf_ct_set_auto_assign_helper_warned/20220303-050505
        git checkout 6da9aa33806ac1acc20a7e05e3197618b75e3049
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "nf_conntrack_net_id" [net/netfilter/nft_ct.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
