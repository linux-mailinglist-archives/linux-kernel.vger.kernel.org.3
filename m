Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4B351131F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 10:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359250AbiD0IDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 04:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359235AbiD0IDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 04:03:44 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4538D1A399
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 01:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651046434; x=1682582434;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rZGiVUWYUDLckcZhXJwM3hUSIq5egffkTRg8FihuCwE=;
  b=Yyj6HkKJMccelAO9Uhd2wkYt9MORNG3ZBfU/gds0JIXZj8qI6fdXpPCI
   6uRjABL0M0YjQwJMieS89SLLMjEWLX+rKYaiziSVAfxTH5OwG0NEXcD3o
   1FqGcTcUNgqXpP/bLui3ZQNSIN0HCeh4B2gSYHk9bwjrTcN3mK1bQBWxN
   nmE10GC/LQqD9D8JXGchYrNEhezVpxlx4qeesi+qoTjKm7JKB2tHZiPem
   lsnI3K2jtwASAWoZiWlxY/jtQ+CjlDuY3r1yzv6IjFSPX90ktCHoyMATH
   d1eFXgrbEGkwhXExZ/soiwLKi1zfKN+a2UZsNCbP7298+Yw1LDx5cwpHF
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="326343471"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="326343471"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 01:00:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="596164720"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 27 Apr 2022 01:00:32 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njcbA-0004US-1A;
        Wed, 27 Apr 2022 08:00:32 +0000
Date:   Wed, 27 Apr 2022 16:00:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: {standard input}:85: Error: unrecognized opcode: `tlbsx'
Message-ID: <202204271547.NKU4sXn4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   46cf2c613f4b10eb12f749207b0fd2c1bfae3088
commit: 1a76e520ee1831a81dabf8a9a58c6453f700026e powerpc/64e: Tie PPC_BOOK3E_64 to PPC_FSL_BOOK3E
date:   7 weeks ago
config: powerpc64-randconfig-r021-20220427 (https://download.01.org/0day-ci/archive/20220427/202204271547.NKU4sXn4-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1a76e520ee1831a81dabf8a9a58c6453f700026e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 1a76e520ee1831a81dabf8a9a58c6453f700026e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   {standard input}: Assembler messages:
   {standard input}:68: Error: unrecognized opcode: `lbarx'
   {standard input}:68: Error: unrecognized opcode: `stbcx.'
>> {standard input}:85: Error: unrecognized opcode: `tlbsx'
   {standard input}:151: Error: unrecognized opcode: `tlbwe'
>> {standard input}:208: Error: unrecognized opcode: `tlbsx.'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
