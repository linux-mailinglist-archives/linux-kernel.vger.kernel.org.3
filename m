Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66121576781
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 21:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiGOTdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 15:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGOTdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 15:33:47 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4450D65EA
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 12:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657913625; x=1689449625;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=O2kWSamBhfVjrvxYJMhGoXq9W3Mje0Olzj+vBYslo+g=;
  b=cunR9/rf7eCGSLLBd79NFyz0Xuaer3CF3lJOfhGkphSLhN1XB4xATjDB
   Eay2bjbKe+up9PoxC43uo3cqo7RgKQSr9JDBvjHGzWdn1N9gW96l8Uc5d
   sFUBd0I5G+dx+G8kFhAVmbrj6b4CyfHOuKUa88Nxc4kEjoewYXH5G6IuP
   9W0Mf9OpaBlEecTCILK/LmSBCj9DutB/mnKjcV13LpTit514inFT6fhWJ
   yhier3HaO47/GfTU9zsEzkguwCtKrjAL+q2yXc3iw36cPm+zoiVus4jCs
   1282oElud2PNVRrOfubnQc33im0uU2943XdyEF5wZKOt5o++nnwY0SFGn
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="268906611"
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="268906611"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 12:33:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="623979656"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 15 Jul 2022 12:33:43 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCR4I-0000gu-Iv;
        Fri, 15 Jul 2022 19:33:42 +0000
Date:   Sat, 16 Jul 2022 03:33:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Simo Sorce <simo@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: ERROR: modpost: "pkcs7_supply_detached_data"
 [crypto/asymmetric_keys/x509_key_parser.ko] undefined!
Message-ID: <202207160319.uQP2LbQs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9b59ec8d50a1f28747ceff9a4f39af5deba9540e
commit: 3cde3174eb910513d32a9ec8a9b95ea59be833df certs: Add FIPS selftests
date:   3 weeks ago
config: mips-buildonly-randconfig-r006-20220715 (https://download.01.org/0day-ci/archive/20220716/202207160319.uQP2LbQs-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 2da550140aa98cf6a3e96417c87f1e89e3a26047)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3cde3174eb910513d32a9ec8a9b95ea59be833df
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 3cde3174eb910513d32a9ec8a9b95ea59be833df
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "pkcs7_supply_detached_data" [crypto/asymmetric_keys/x509_key_parser.ko] undefined!
ERROR: modpost: "clk_get_io" [drivers/watchdog/lantiq_wdt.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
