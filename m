Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143ED4C1317
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 13:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240574AbiBWMsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 07:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234236AbiBWMsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 07:48:00 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADB84A3EF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 04:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645620452; x=1677156452;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=J3WZheIBZnnrM8r4+hrCD31X6y5oMK65dUnWm8uHPpA=;
  b=mmlsFk5rgrJa21JMznh8YTT4xOknWpc6F08Mec1hvD8Z4yWPahtijnG6
   zqEbLkRCiSEXPYVRJQL+cRiDTnLnCEWCoAu/GlPQ7ksZtyIQ7mfUjvDOY
   qgSqRYbxw/jZe579CpctCOmmAxW3I0pqhCHnIHDpQgKArhmUxEUkemj/y
   pCHx5Dq6cgcB6dT9PVLhwVScsM6lF5RhF80Ymb+TfLSggq+LYMRt4bXzw
   s7UPrFlN1nR5BO9CbaB7h8rgCVuo1+jsjhEXyfqKDrgzXrASo71aALIPj
   OA9HrNjWxSu2XlqySooATMJnE3P8kdeGbm1ornKVFavAglZFWvuSrm2Zb
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="312669943"
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="312669943"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 04:47:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="505900413"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 23 Feb 2022 04:47:30 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMr3J-0001On-WF; Wed, 23 Feb 2022 12:47:30 +0000
Date:   Wed, 23 Feb 2022 20:47:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: include/linux/eventpoll.h:81:13: sparse: sparse: restricted __poll_t
 degrades to integer
Message-ID: <202202231910.H30peLyl-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5c1ee569660d4a205dced9cb4d0306b907fb7599
commit: 249dbe74d3c4b568a623fb55c56cddf19fdf0b89 ARM: 9108/1: oabi-compat: rework epoll_wait/epoll_pwait emulation
date:   6 months ago
config: riscv-randconfig-s031-20220221 (https://download.01.org/0day-ci/archive/20220223/202202231910.H30peLyl-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=249dbe74d3c4b568a623fb55c56cddf19fdf0b89
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 249dbe74d3c4b568a623fb55c56cddf19fdf0b89
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   fs/eventpoll.c: note: in included file:
>> include/linux/eventpoll.h:81:13: sparse: sparse: restricted __poll_t degrades to integer
>> include/linux/eventpoll.h:81:13: sparse: sparse: restricted __poll_t degrades to integer
   include/linux/eventpoll.h:81:13: sparse: sparse: cast from restricted __poll_t

vim +81 include/linux/eventpoll.h

    70	
    71	#if defined(CONFIG_ARM) && defined(CONFIG_OABI_COMPAT)
    72	/* ARM OABI has an incompatible struct layout and needs a special handler */
    73	extern struct epoll_event __user *
    74	epoll_put_uevent(__poll_t revents, __u64 data,
    75			 struct epoll_event __user *uevent);
    76	#else
    77	static inline struct epoll_event __user *
    78	epoll_put_uevent(__poll_t revents, __u64 data,
    79			 struct epoll_event __user *uevent)
    80	{
  > 81		if (__put_user(revents, &uevent->events) ||
    82		    __put_user(data, &uevent->data))
    83			return NULL;
    84	
    85		return uevent+1;
    86	}
    87	#endif
    88	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
