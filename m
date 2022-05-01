Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A3C5168A7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 00:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356804AbiEAWeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 18:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbiEAWd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 18:33:57 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7339627162
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 15:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651444230; x=1682980230;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iTpaTEN2r/J6s4XisfUsH2CvcJKBnF900FPluiBMKy4=;
  b=Bkri5DB8ZgdG8/M5hqip6MFx8SRl2pKWXcchPZi7mRtrl3kSmf4M+x9u
   uhBXVhVHfU0zRbh/XI2wkVPrb7CcP7X8IW59oQ0Q81Ba4W5Y1LL/ugEvy
   Ej35mGINR8TmOkZizUNQSZ5VW3Nm2GDF9WN6vuHPs/KMluBe4VrV0fedc
   bhlHk3nf6dK7Bn2JA4UPnFYJWTKS4BfP/zvYMKRI8RMcDrMgIzqYY20Ai
   MAq/Jimcx1xYPQGzWO4ARHt6VX4oTCY5CY+PekqjorpqVTIFW3OmXxowK
   yRTYrJ4MnKCku7u31vL0zNfm+plXPPxWtaIS+gvMXeGaF6VjMf/2Rk11I
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="265918893"
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="265918893"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2022 15:30:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="733153395"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 01 May 2022 15:30:28 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlI5E-00095r-03;
        Sun, 01 May 2022 22:30:28 +0000
Date:   Mon, 2 May 2022 06:29:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leonardo Bras <leobras@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: ld.lld: error: inline assembly requires more registers than
 available at line 523
Message-ID: <202205020637.JVJo3blw-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   672c0c5173427e6b3e2a9bbb7be51ceeec78093a
commit: ba1f77c546966c12d86220d078e5838dcaeab348 x86/kvm: Fix compilation warning in non-x86_64 builds
date:   2 months ago
config: i386-randconfig-a012-20220502 (https://download.01.org/0day-ci/archive/20220502/202205020637.JVJo3blw-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 09325d36061e42b495d1f4c7e933e260eac260ed)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ba1f77c546966c12d86220d078e5838dcaeab348
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ba1f77c546966c12d86220d078e5838dcaeab348
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: inline assembly requires more registers than available at line 523
>> ld.lld: error: inline assembly requires more registers than available at line 523

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
