Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71B4516783
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 21:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349142AbiEATh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 15:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349336AbiEAThV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 15:37:21 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02E24EDDA
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 12:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651433635; x=1682969635;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=s4TkhpsREgImcr2x4CJkqy8z8uTHR+GkvLDhwxJHU4M=;
  b=dL8Gks+m5fvaL2kbjff76knHKoIQ/clcVQP7Jn8JfB6pSjdyB1cOwsA7
   ykLQYOzxUFZabPN4s+ayrlqmwgYcSc8m2M7RgP7Kw1/B0/+cJGxu3rZed
   s6Myp0SZ0S5csfAevyR//Hzx7+h3vmnlJbsWxPnfWcWkGbmQX7K2vmuew
   UNvb+Ptpx61F9sSO9VnYpAXfydYsDpPG5iB5VgdwxbqNxZO2VbLAGTC1d
   2QAgf756dOyjUk0msgaD/qj9l22ug4XgoT7k2VYBRPARN+i3u6GX5jKGY
   Qz0sjrzgDK568BdeDBEkaT6IPNifUAML+hAci/jl5DSwd53GDLUPJGJbt
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="254489016"
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="254489016"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2022 12:33:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="561370579"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 01 May 2022 12:33:54 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlFKL-00091n-KS;
        Sun, 01 May 2022 19:33:53 +0000
Date:   Mon, 2 May 2022 03:33:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: xtensa-linux-ld: section .start VMA
 [00000000d1000000,00000000d1000007] overlaps section .image VMA
 [00000000d0003000,00000000d1011c1f]
Message-ID: <202205020317.d5fsluT5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b2da7df52e16110c8d8dda0602db81c15711e7ff
commit: 337015573718b161891a3473d25f59273f2e626b printk: Userspace format indexing support
date:   10 months ago
config: xtensa-buildonly-randconfig-r003-20220501 (https://download.01.org/0day-ci/archive/20220502/202205020317.d5fsluT5-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=337015573718b161891a3473d25f59273f2e626b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 337015573718b161891a3473d25f59273f2e626b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> xtensa-linux-ld: section .start VMA [00000000d1000000,00000000d1000007] overlaps section .image VMA [00000000d0003000,00000000d1011c1f]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
