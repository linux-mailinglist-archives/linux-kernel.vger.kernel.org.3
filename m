Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6C752E014
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 00:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245560AbiESWqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 18:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245443AbiESWqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 18:46:04 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C70C21E08
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 15:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653000363; x=1684536363;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=92GIukhX0cqtAzVc1D4hiNIn1xsez3bUyYRE62o+rAM=;
  b=PDPmVQmwtmzHqgPf/PekYVHkNfkectE1bdAztzAXaQUKBK1U3rxXOpbH
   Po3tshuCh1DWeBNQciyQ78yM5JBPGPmoc19MhdYOirLKlve/pbckhsD72
   eZd2js9rfgCTc4a1yaP5CVc1VnkCDqKdVc4Pr08DrLyROqHXalIjQCI+G
   x7c8jrCamBbPp9t+wnU0mOuJP+FU1fph8nyGYV3dnEyy4N8TCFGO41lgi
   KqvyJ15UwxgCahtx/9+dHo8GKWZE7alocN5RGU7g5c4csybeNoApN6ECB
   jYMQ8c2XQ91k8IYUnpuCrHk6lCXqtqOAkPzU5aONZHiHOAbLn9J0V1EKx
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="297714842"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="297714842"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 15:46:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="661953751"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 19 May 2022 15:45:57 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrou4-00041B-95;
        Thu, 19 May 2022 22:45:56 +0000
Date:   Fri, 20 May 2022 06:45:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Westphal <fw@strlen.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [netfilter-nf-next:testing 9/12] m68k-linux-ld:
 net/netfilter/core.c:183: undefined reference to `nf_hook_bpf_create'
Message-ID: <202205200631.Ie49FTz6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git testing
head:   4456ac35299c131e2ac26b4dc025b257d810277b
commit: 11b2910d788799e8c68df305994260fd79a61e10 [9/12] netfilter: add bpf base hook program generator
config: m68k-randconfig-p001-20220519 (https://download.01.org/0day-ci/archive/20220520/202205200631.Ie49FTz6-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git/commit/?id=11b2910d788799e8c68df305994260fd79a61e10
        git remote add netfilter-nf-next git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git
        git fetch --no-tags netfilter-nf-next testing
        git checkout 11b2910d788799e8c68df305994260fd79a61e10
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   m68k-linux-ld: arch/m68k/kernel/time.o: in function `rtc_ioctl':
   arch/m68k/kernel/time.c:105: undefined reference to `mach_get_rtc_pll'
   m68k-linux-ld: arch/m68k/kernel/time.c:110: undefined reference to `mach_set_rtc_pll'
   m68k-linux-ld: arch/m68k/kernel/uboot.o: in function `process_uboot_commandline':
   arch/m68k/kernel/uboot.c:70: undefined reference to `_init_sp'
   m68k-linux-ld: net/netfilter/core.o: in function `nf_hook_entries_grow':
   net/netfilter/core.c:183: undefined reference to `nf_hook_bpf_create'
>> m68k-linux-ld: net/netfilter/core.c:183: undefined reference to `nf_hook_bpf_create'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
