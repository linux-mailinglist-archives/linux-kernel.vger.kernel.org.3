Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5A255EFAB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 22:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiF1Ugh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 16:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiF1Ugg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:36:36 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A4E1D0DD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656448593; x=1687984593;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LLpjV/n09Le7C4sSxRt4nmp7B4TOejGA02DeFSXr69Y=;
  b=dgN01lFYNB8soZxqtbgwuF5dUfIF6TnnazMJmeyd23XWS1J1lgHvEx1f
   MATaopOfiSp7yQ6gpdM8Vtg6q/5p4Hk2/TNNRiAEJNdO6+0JdEIukI5eW
   X4mz8vAxm97N+injbwvTzX2j97/C2EYlEJxeXxk1y/aPeuwh6amIlgqGd
   9/HPpG+FufwPvRVbqeBiCDhA+Zgf11/QBf0VrSvrajZ7xaSOC2lYjCNSL
   dlh4/gyGBjlXSZAnbC7AqIWSdg0vYJYf0knU4qbOPHNzYhnE/3F4muro1
   S920y5P5xM+9me0LwHo+Sa0WOaZv8sYLgIet6DdnwhB/34VrxZhOnji9P
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="262251646"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="262251646"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 13:36:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="917319796"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jun 2022 13:36:31 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o6Hwl-000Aas-6f;
        Tue, 28 Jun 2022 20:36:31 +0000
Date:   Wed, 29 Jun 2022 04:36:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [zx2c4:master 9/10] ERROR: modpost: "wake_up_state"
 [drivers/char/hw_random/rng-core.ko] undefined!
Message-ID: <202206290408.ua4IX9mh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/linux.git master
head:   9b3548a2475866d26bdeee84d62eecf1bc94d22a
commit: 78223ae64136d911588115c6c317a31305100ce4 [9/10] ath9k: let sleep be interrupted when unregistering hwrng
config: i386-randconfig-a003-20220627 (https://download.01.org/0day-ci/archive/20220629/202206290408.ua4IX9mh-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project df18167ac56d05f2ab55f9d874aee7ab6d5bc9a2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/linux.git/commit/?id=78223ae64136d911588115c6c317a31305100ce4
        git remote add zx2c4 https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/linux.git
        git fetch --no-tags zx2c4 master
        git checkout 78223ae64136d911588115c6c317a31305100ce4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "wake_up_state" [drivers/char/hw_random/rng-core.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
