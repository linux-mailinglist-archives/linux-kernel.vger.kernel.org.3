Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810004D5A24
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 05:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiCKE73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 23:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiCKE70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 23:59:26 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D54EBAF5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 20:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646974702; x=1678510702;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZSfgV4FTdC89Jr7bvCxlPiktDojQHbtsbzRZWF+3FDY=;
  b=LdkZ/6luh5rxFexo2EubGqYciwLadS+gV84FApOyvcGbtUa/IEPzEAd0
   unYrO2RX23qiuJWEdUM9ruzuLDW6b+Rk3TP9hwFU6ES6NF4xxbK5fXBEA
   WUZ1T5ZkxwOnQoGw3Tu1XsIqLh24GRGmTdTZaw6t5dLXRDNdDmD8aZ/K8
   jrZlZY5/aUo1cioEjmf9apl0IDXxjalT6q88A+v76L/92Cd8pgOwPghwC
   xA3mnfiqfZ2B48BFPw3UEZiDkh956GkTtUD5HgEtznKc5F8UjQE1ia4P1
   5Wqk8r7sTwMUCgy72KgUbalqc/gig2ylbnIVgAQfQWlTw9XtfZmebOfvm
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="318723607"
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="318723607"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 20:58:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="514376777"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 10 Mar 2022 20:58:20 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSXM3-0005rB-Ni; Fri, 11 Mar 2022 04:58:19 +0000
Date:   Fri, 11 Mar 2022 12:58:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: proc-v7-bugs.c:undefined reference to `spectre_v2_update_state'
Message-ID: <202203111231.E0EK6F0R-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dda64ead7e82caa47fafe0edc36067ee64df2203
commit: 9dd78194a3722fa6712192cdd4f7032d45112a9a ARM: report Spectre v2 status through sysfs
date:   6 days ago
config: arm-randconfig-r022-20220310 (https://download.01.org/0day-ci/archive/20220311/202203111231.E0EK6F0R-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9dd78194a3722fa6712192cdd4f7032d45112a9a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9dd78194a3722fa6712192cdd4f7032d45112a9a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: arch/arm/mm/proc-v7-bugs.o: in function `cpu_v7_bugs_init':
>> proc-v7-bugs.c:(.text+0x4e): undefined reference to `spectre_v2_update_state'

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
