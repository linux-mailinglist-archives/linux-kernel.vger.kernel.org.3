Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971D8565640
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbiGDMzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbiGDMzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:55:38 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FEDBB6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 05:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656939332; x=1688475332;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6BrhjcQ2KruHo6v9x5F682Uz2m5xh8U4lbSpllYYhak=;
  b=GrApPHzZO+lNELYUE1uUgmSj+8avo7R1wh2FGXfsXjE0ZVhNNl4qlXr9
   2VIsLa9kds1xhOdzB/9jdroiAMi8fK3wvzaQ2Xv2ujg49jHWIpfzgQLE0
   yM8ijbA+nxbFiwp24GksSG0S+Sg4UKd8faswvaWZHG3d9Eahmr6zLtvqp
   WaTDiCPKz2MMzoBnxODVCKkO06Q25uvD7Dez0LZNsx6r39QRFiB31trGZ
   fyvuAwr5mYjakn9o7gzO53aMYtIjOgRbJUpcKEM8AKYAM8hKStsl7WPJZ
   btgRjkKyFICxkZ5dmH5vSgv7tmKx5VWDQA8W1WYabIooIgCOh0ynPVFkH
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="263546747"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="263546747"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 05:55:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="542581665"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 04 Jul 2022 05:55:30 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8Lbt-000HtH-PJ;
        Mon, 04 Jul 2022 12:55:29 +0000
Date:   Mon, 4 Jul 2022 20:55:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [stable:linux-5.15.y 7794/8135] arch/x86/kernel/cpu/bugs.o: warning:
 objtool: spectre_v2_user_select_mitigation()+0x2da: unreachable instruction
Message-ID: <202207042056.89dtC67G-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
head:   545aecd229613138d6db54fb2b5221faca10137f
commit: 0853f905e48b92dcf27a8d931104c9aac10de191 [7794/8135] x86/cpu: Elide KCSAN for cpu_has() and friends
config: x86_64-randconfig-a006-20220704 (https://download.01.org/0day-ci/archive/20220704/202207042056.89dtC67G-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=0853f905e48b92dcf27a8d931104c9aac10de191
        git remote add stable https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
        git fetch --no-tags stable linux-5.15.y
        git checkout 0853f905e48b92dcf27a8d931104c9aac10de191
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/cpu/bugs.o: warning: objtool: spectre_v2_user_select_mitigation()+0x2da: unreachable instruction

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
