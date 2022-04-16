Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE135045C7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 01:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbiDPXuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 19:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiDPXt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 19:49:56 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536AF369C6
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 16:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650152843; x=1681688843;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6nvsl2XooqY0xGFl2PBOjBZxq/6fq6BxfZAstAogJMs=;
  b=GDeBOPOpclDUhlvFj9EuqQCzEoxT+Stugi73lPPKAhZgSGLh0fW1VhdK
   2SZbHzFtI7oHct5/dgNDAdq2ZN/ezqtspc/bJ9g3ZJjKnyy+7XfDYAsZZ
   pydSqVwj4Be1ntrrwoSmsTK+/Ddmx/4hivR8vdQjQZmSYGDBFBBVxEw0z
   13EtLME+gzVuAPLLrRMfCazLGJKY21TJmlXVTBxzxtfJ1YDSA2eCPiTe3
   SzrIp6Y7sf/8n3wK66xbZIielFX2rcirQVyXr5tyIJfkhgER8v7npfnM4
   FUJ2FlM5BofwthBdhCLpQ5IazB2GEOSdtIfmEybLUqskD7cId6/btOStb
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="262203551"
X-IronPort-AV: E=Sophos;i="5.90,266,1643702400"; 
   d="scan'208";a="262203551"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2022 16:47:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,266,1643702400"; 
   d="scan'208";a="592008210"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 16 Apr 2022 16:47:21 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfs8P-0003ZN-5O;
        Sat, 16 Apr 2022 23:47:21 +0000
Date:   Sun, 17 Apr 2022 07:46:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Min Li <min.li.xe@renesas.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: powerpc-linux-ld: warning: orphan section `.ftrace.tramp' from
 `drivers/mfd/rsmu_core.o' being placed in section `.ftrace.tramp'
Message-ID: <202204170705.2B4HbAAz-lkp@intel.com>
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

Hi Min,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   90ea17a9e27b5778ec517efb1ce0b81d36905654
commit: a1867f85e06edacd82956d3422caa2b9074f4321 mfd: Add Renesas Synchronization Management Unit (SMU) support
date:   9 months ago
config: powerpc-randconfig-r023-20220417 (https://download.01.org/0day-ci/archive/20220417/202204170705.2B4HbAAz-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a1867f85e06edacd82956d3422caa2b9074f4321
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a1867f85e06edacd82956d3422caa2b9074f4321
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   powerpc-linux-ld: warning: orphan section `.init.plt' from `drivers/mfd/rsmu_core.o' being placed in section `.init.plt'
>> powerpc-linux-ld: warning: orphan section `.ftrace.tramp' from `drivers/mfd/rsmu_core.o' being placed in section `.ftrace.tramp'
   powerpc-linux-ld: warning: orphan section `.init.plt' from `drivers/mfd/rsmu_core.o' being placed in section `.init.plt'
>> powerpc-linux-ld: warning: orphan section `.ftrace.tramp' from `drivers/mfd/rsmu_core.o' being placed in section `.ftrace.tramp'
   powerpc-linux-ld: warning: orphan section `.init.plt' from `drivers/mfd/rsmu_core.o' being placed in section `.init.plt'
>> powerpc-linux-ld: warning: orphan section `.ftrace.tramp' from `drivers/mfd/rsmu_core.o' being placed in section `.ftrace.tramp'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
