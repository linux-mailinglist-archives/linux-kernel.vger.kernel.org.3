Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911B34E6A3C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 22:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354134AbiCXVbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 17:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236476AbiCXVbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 17:31:31 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE71F110
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 14:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648157398; x=1679693398;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qTVMVZR8BefAIPFSDR80KpTf57Z7L6mtN5K1nB5mpvQ=;
  b=lJvdDfWq4EbzaGI681XZDXYNuhjQEH32xz5kL7YksDR7krLxQj7TkCIt
   X7fEvzeGUpDI9b6zR3Ei0rLuznU47Izu5a/2wPgCzCkD/RdqVH6y9Zloj
   ++fwG0ix/6pPNNtuLg44ptedYAggStq1EGblJrfyx8aynkLM6rR4/qZ6d
   54mEsccj7yymfjeAyfZxujXeQO8aCaJQ7gIiC/x+vgXvfR3NkpD45qfAm
   mhN99zCG7PDJHyLlZ5eEI5NbrF4aGvvNI+aBYHffSKk6wgBK1dxdaX2sl
   +TpL1xMBBMZOVp7proq6x7vPy+B4MF+7+daZcaJpT9lL9+yH79N8X54pX
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="245969645"
X-IronPort-AV: E=Sophos;i="5.90,208,1643702400"; 
   d="scan'208";a="245969645"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 14:29:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,208,1643702400"; 
   d="scan'208";a="717982007"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 24 Mar 2022 14:29:57 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXV1o-000LSY-Hj; Thu, 24 Mar 2022 21:29:56 +0000
Date:   Fri, 25 Mar 2022 05:29:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yuri Nudelman <ynudelman@habana.ai>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Oded Gabbay <ogabbay@kernel.org>
Subject: [ogabbay:habanalabs-next 15/19]
 drivers/misc/habanalabs/common/memory.c:2137:28: sparse: sparse: symbol
 'hl_ts_behavior' was not declared. Should it be static?
Message-ID: <202203250539.2vJ8t5I0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git habanalabs-next
head:   8893b113963d24b89844a072c968b042ae76aa46
commit: 079c2434d6e86f38700d7d8b37f16bfb31315f8f [15/19] habanalabs: convert ts to use unified memory manager
config: i386-randconfig-s002 (https://download.01.org/0day-ci/archive/20220325/202203250539.2vJ8t5I0-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git/commit/?id=079c2434d6e86f38700d7d8b37f16bfb31315f8f
        git remote add ogabbay https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git
        git fetch --no-tags ogabbay habanalabs-next
        git checkout 079c2434d6e86f38700d7d8b37f16bfb31315f8f
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/misc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/misc/habanalabs/common/memory.c:2137:28: sparse: sparse: symbol 'hl_ts_behavior' was not declared. Should it be static?

Please review and possibly fold the followup patch.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
