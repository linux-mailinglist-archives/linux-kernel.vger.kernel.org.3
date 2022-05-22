Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD69530679
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 00:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345212AbiEVWVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 18:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiEVWVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 18:21:34 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847461C126
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 15:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653258093; x=1684794093;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PlOTnZ8DceWHQRrs52ps3Pqs1XjD9A7Vo/umIMX0t5s=;
  b=E/v10J5I8sSGg+714oRS4PtHplvL46f36pxLSaToMWmxjAFWKQcO4psY
   wGFw9sMQYYKiFnYjQdptGwM2J3olV6dUM1JBPanO22rZFD0Y6mT8tKRqU
   NOREqypcNorNKCJxnVyLv3rbDqP4YaMSs2D0BpXeSnBtbrzQclKpQECRG
   y6HeEp9KsPUygQzfI84P5OTlqannyuQ8UmS3ovXePHNqfPEwFfa39ULZa
   kzkTwadPGODP1ktsgy/QRiiINbUL2xa4KjLN5e8haGgmfB1EIGmYdF7QA
   DTkqy8ikg/sGaCGQP+wIdiAZe8xrbJF8CxHySwM8bG+2og9DVnjlYGaNY
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10355"; a="270622638"
X-IronPort-AV: E=Sophos;i="5.91,244,1647327600"; 
   d="scan'208";a="270622638"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2022 15:21:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,244,1647327600"; 
   d="scan'208";a="558361849"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 22 May 2022 15:21:32 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nstx5-0000f1-DY;
        Sun, 22 May 2022 22:21:31 +0000
Date:   Mon, 23 May 2022 06:20:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [madvenka786:orc_v2 7/20] arch/x86/kernel/setup.c:1243: undefined
 reference to `unwind_init'
Message-ID: <202205230628.BFRpX4yZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/madvenka786/linux orc_v2
head:   ed9a1d5c036130a53c639eb712485e3d13ab4372
commit: a4c6af5b74f86f69cebc1b18d8a31a3beff7cd8e [7/20] objtool: Reorganize ORC kernel code
config: i386-randconfig-a004-20220523 (https://download.01.org/0day-ci/archive/20220523/202205230628.BFRpX4yZ-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/madvenka786/linux/commit/a4c6af5b74f86f69cebc1b18d8a31a3beff7cd8e
        git remote add madvenka786 https://github.com/madvenka786/linux
        git fetch --no-tags madvenka786 orc_v2
        git checkout a4c6af5b74f86f69cebc1b18d8a31a3beff7cd8e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: arch/x86/kernel/setup.o: in function `setup_arch':
>> arch/x86/kernel/setup.c:1243: undefined reference to `unwind_init'


vim +1243 arch/x86/kernel/setup.c

ee9f8fce996408 arch/x86/kernel/setup.c  Josh Poimboeuf 2017-07-24  1242  
ee9f8fce996408 arch/x86/kernel/setup.c  Josh Poimboeuf 2017-07-24 @1243  	unwind_init();
^1da177e4c3f41 arch/i386/kernel/setup.c Linus Torvalds 2005-04-16  1244  }
5649b7c30316a5 arch/x86/kernel/setup.c  Ingo Molnar    2008-09-16  1245  

:::::: The code at line 1243 was first introduced by commit
:::::: ee9f8fce99640811b2b8e79d0d1dbe8bab69ba67 x86/unwind: Add the ORC unwinder

:::::: TO: Josh Poimboeuf <jpoimboe@redhat.com>
:::::: CC: Ingo Molnar <mingo@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
