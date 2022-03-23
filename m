Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAB04E52CD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 14:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244161AbiCWNKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 09:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244147AbiCWNKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 09:10:02 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AA626573
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 06:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648040912; x=1679576912;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=i1O7g1/0dKBggLIHefOqOvGFhlN5lRiK17nkgLtYtdE=;
  b=a3x2m4SX7xZOj90igaanh7ipksQL31xOJOy1l67WW/+ZRuA59j1JfoR9
   sJ2wm3T4XOUtQO+GY7uUupq9rk5i1dWTLIU4a4V89kgieQyG91WhrGPM3
   QUK8skOX1/3wgt4tVRzwV+R7LSXfUMrDNYlg/kUy31RMlaajpG3oTDnva
   F1dNoCVNCybr5JY0lEETaXINfFGsNKXRnRMhXH7J/v4Ig3YF70o+TX2BV
   XoDS2NCusz+8VCzuDvB3PBHY32FNvTXYk/BaVPqAzDeWsNlN0rO9LwNik
   vrJ4X3WzQ3R+Z8cQB4KHDsyTdr4xBe1/i2v9u7L4brXdluAZ2TjFXuAcO
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="245578520"
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="245578520"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 06:08:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="544186349"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 23 Mar 2022 06:08:30 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nX0iz-000K4n-Jw; Wed, 23 Mar 2022 13:08:29 +0000
Date:   Wed, 23 Mar 2022 21:08:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [intel-tdx:guest-rebased 5/83] ./usr/include/misc/tdx.h:39:2: error:
 unknown type name 'size_t'
Message-ID: <202203232011.Qp6mjB89-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-rebased
head:   2445b5e99855f3c241a44d2777a74a777f56048c
commit: a7b0255d5b64842244f1957e33eb514d8f82866f [5/83] platform/x86: intel_tdx_attest: Add TDX Guest attestation interface driver
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220323/202203232011.Qp6mjB89-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 902f4708fe1d03b0de7e5315ef875006a6adc319)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/a7b0255d5b64842244f1957e33eb514d8f82866f
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-rebased
        git checkout a7b0255d5b64842244f1957e33eb514d8f82866f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
>> ./usr/include/misc/tdx.h:38:11: error: expected ';' at end of declaration list
           void *buf __user;
                    ^
                    ;
>> ./usr/include/misc/tdx.h:39:2: error: unknown type name 'size_t'
           size_t len;
           ^
   2 errors generated.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
