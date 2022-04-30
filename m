Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943E7515F03
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 18:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243138AbiD3QY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 12:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237163AbiD3QYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 12:24:24 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E479737BDA
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 09:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651335661; x=1682871661;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rX2bI62ad3aLZ3scDHwLF6e59TPJNcoGTHYAURtpSe4=;
  b=ZDo7wmhMDMYVYkx1dFrxYNWJcCDCVIptNMIruQDFbQnCP2RfOygaBllN
   9OYLBe/e6zlAKUKlJMjZJgZUEAFZCR408yH8+tEG6wPccOzb/15swMHDJ
   j38h/Oqx3JiTcd66/VKxEyaD3cC7BqkHo7OljV1V8yFPnmDH+pJXQ1Ows
   YD8ViHzYAqAJBwrnLrzewdMECqK/OLiRkFsKyaMLwT8LNV6p+r/jlpazG
   H8/6pro+LDDAC1rx5BU7ak8l+TjToogjM3yMGUfIg4X6ABNQpGcoym3xW
   w9sUxKv///R/K5p96ArtSfI5Xco3B87fLl+Mp9vATW0bCzfZiens6a9w/
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10333"; a="265747555"
X-IronPort-AV: E=Sophos;i="5.91,188,1647327600"; 
   d="scan'208";a="265747555"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 09:21:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,188,1647327600"; 
   d="scan'208";a="706996887"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 30 Apr 2022 09:21:00 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkpq7-0007Ot-RO;
        Sat, 30 Apr 2022 16:20:59 +0000
Date:   Sun, 1 May 2022 00:20:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: {standard input}:26: Error: unrecognized opcode: `iccci'
Message-ID: <202205010034.zgGUNYAE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8013d1d3d2e33236dee13a133fba49ad55045e79
commit: de39b19452e784de5f90ae899851ab29a29bb42c powerpc: Rewrite 4xx flush_cache_instruction() in C
date:   1 year, 8 months ago
config: powerpc-randconfig-r011-20220429 (https://download.01.org/0day-ci/archive/20220501/202205010034.zgGUNYAE-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=de39b19452e784de5f90ae899851ab29a29bb42c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout de39b19452e784de5f90ae899851ab29a29bb42c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   {standard input}: Assembler messages:
>> {standard input}:26: Error: unrecognized opcode: `iccci'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
