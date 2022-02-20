Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774034BD111
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 20:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244663AbiBTTkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 14:40:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbiBTTkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 14:40:12 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7F725C5D
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 11:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645385990; x=1676921990;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XsbeTOOlLEfRYDPfCbEIZ8Da9mi8EWXphJOG64kuYTg=;
  b=BEv0HaaIgIm+8N9NQdxLg91YpVQ3XTWfAg5Lqf0JxVY3ueXFjO5pmndD
   gWtHkM2e+2QXm3kuOQU5ou//icNQy+U4AXXo36tK78DmoL/F8iPWCon8B
   mr/rCyQuhAxbZC9rVetujkTA7+OMH6JjQSxyA8TSUyyagSs4qh+SIsZPL
   ufyVGG7ACwKUs2WI+crrH8k7Y5T8eOtIUaEoXcBRQFZevOfihyww9z3yt
   6g5PFCFYebb+BBe3NHtfT/0i9RA63I5POyxDSfgd1t2Dk/1pvxJuQfLQW
   qhODdEsfEeubVOS8rMJ1QCWxw919DKshhLDAvcxKg4imNMSeV9ADc4wgY
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="231367528"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="231367528"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 11:39:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="504591297"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 20 Feb 2022 11:39:48 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLs3g-0000fA-3Y; Sun, 20 Feb 2022 19:39:48 +0000
Date:   Mon, 21 Feb 2022 03:38:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [intel-tdx:guest-upstream 2/32] ld.lld: error: undefined symbol:
 cc_init
Message-ID: <202202210333.fwcQuz3x-lkp@intel.com>
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

tree:   https://github.com/intel/tdx.git guest-upstream
head:   b87676dfde7b501c019b1e2c01f4c7ef5c83a12c
commit: 7f8e5b1391350249c5f6810ff425db9adbf6d38c [2/32] x86/coco: Add API to handle encryption mask
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220221/202202210333.fwcQuz3x-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/7f8e5b1391350249c5f6810ff425db9adbf6d38c
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-upstream
        git checkout 7f8e5b1391350249c5f6810ff425db9adbf6d38c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: cc_init
   >>> referenced by mshyperv.c:349 (arch/x86/kernel/cpu/mshyperv.c:349)
   >>>               kernel/cpu/mshyperv.o:(ms_hyperv_init_platform) in archive arch/x86/built-in.a

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
