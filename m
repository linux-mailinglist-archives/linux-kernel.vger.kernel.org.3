Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B9E52F8BB
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 06:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349199AbiEUEkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 00:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236814AbiEUEkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 00:40:32 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404291796F5
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 21:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653108031; x=1684644031;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6PZr/f/1YX1eU26k+uW6bas9qtd+gUc5gjxYlOHqvjY=;
  b=F6QTHXZubl7dzoQkhf05r36FfRktmaYLD8bv+Ogyzwmcl/MrUo9yAkp7
   /bbBOlZNQgtUnWqVOW/8C9UW8ootyEOmiUr7LlbZN/23XGL+x92fg3+9Z
   p+QWNnDe26c4h3ih+u6OCbd2IWc0sRpNCjSB01fT7tHzO9kGchLdnteVk
   F1yB5i1+u4ZkF3PkM3MvIoXyFRLka47sOYKWpPp8uTuuop6tBUA9cpYw2
   iz6NJ7zGjTBwUK+Eu3rVs8RxWRiC5tfMI1TNSitADP4UmUdljfx2dXz5b
   50eTGmybpMgmSA0icgM9J0fQnKC7MuK/rfSUFARRz8bGPuahLufTEsmjq
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="333432723"
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="333432723"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 21:40:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="899651205"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 20 May 2022 21:40:29 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsGuj-0005wG-5X;
        Sat, 21 May 2022 04:40:29 +0000
Date:   Sat, 21 May 2022 12:40:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [congwang:sch_bpf 2/2] ERROR: modpost: "qdisc_lookup_rcu"
 [net/sched/sch_bpf.ko] undefined!
Message-ID: <202205211231.rVPE9dhv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/congwang/linux.git sch_bpf
head:   b03bbda26c041cf6e7593eadce50ef2fa4853a0c
commit: b03bbda26c041cf6e7593eadce50ef2fa4853a0c [2/2] net_sched: introduce eBPF based Qdisc
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20220521/202205211231.rVPE9dhv-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/congwang/linux/commit/b03bbda26c041cf6e7593eadce50ef2fa4853a0c
        git remote add congwang https://github.com/congwang/linux.git
        git fetch --no-tags congwang sch_bpf
        git checkout b03bbda26c041cf6e7593eadce50ef2fa4853a0c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "qdisc_lookup_rcu" [net/sched/sch_bpf.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
