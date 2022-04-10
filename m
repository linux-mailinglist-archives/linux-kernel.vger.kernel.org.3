Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FD24FAB9C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 05:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiDJDRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 23:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiDJDRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 23:17:42 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DFD36E24
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 20:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649560534; x=1681096534;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qXhMaVsyIvR141PzUbe0LwnrENc0jQTKyJqstx1pNf4=;
  b=UByqvthjuKLyViXiFnSZQfYgHw/bi6p1NWlFXkxinn69V5iKFdjatbDM
   VVw2wYndW2AqDq7e/ntsed4IYOWbwWDUIYHR+mPEosA8XiW/b6FYpZhRx
   dSxAiAHUdKqxHC4YAhaK8i8i+aHDtBhlHqeZgMk86pWvh2PdyRX1//J8U
   LSRoDHcGhhon/1Ro/B4mpJm9grrlIxbAqOnMU4ikD/2TxbiFKvzAgsrrc
   lTHhznfNJCcLkzqDf9PgymaiR7VwmqoAxPchc4dCePwQlD4HRngkGUNi6
   IoADyjYs8tC0A+oLMgzUi6cDV6nm9HV0IvN8F6yUxoejotUfqm4qwpwd6
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10312"; a="241875179"
X-IronPort-AV: E=Sophos;i="5.90,248,1643702400"; 
   d="scan'208";a="241875179"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2022 20:15:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,248,1643702400"; 
   d="scan'208";a="589373567"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 09 Apr 2022 20:15:32 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndO31-0000dg-Mp;
        Sun, 10 Apr 2022 03:15:31 +0000
Date:   Sun, 10 Apr 2022 11:15:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [toke:xdp-queueing-04 3/12] m68k-linux-ld:
 kernel/bpf/syscall.o:undefined reference to `pifo_generic_map_ops'
Message-ID: <202204101141.oHsayKFH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git xdp-queueing-04
head:   d67202baf237752a91366c8ba9bd801942e5fdaf
commit: fe606924ca53da2ffef87d4234ef54a5f1b66fbb [3/12] bpf: Add a PIFO map type for queueing packets
config: m68k-randconfig-c024-20220410 (https://download.01.org/0day-ci/archive/20220410/202204101141.oHsayKFH-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git/commit/?id=fe606924ca53da2ffef87d4234ef54a5f1b66fbb
        git remote add toke https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git
        git fetch --no-tags toke xdp-queueing-04
        git checkout fe606924ca53da2ffef87d4234ef54a5f1b66fbb
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> m68k-linux-ld: kernel/bpf/syscall.o:(.rodata+0x522): undefined reference to `pifo_generic_map_ops'
>> m68k-linux-ld: kernel/bpf/btf.o:(.rodata+0x1a0): undefined reference to `pifo_generic_map_ops'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
