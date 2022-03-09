Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D179E4D2861
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 06:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiCIF35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 00:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiCIF3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 00:29:54 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6BD3FBD2
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 21:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646803736; x=1678339736;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/NxnOKiOS7ncX+ehMkS3Xdu2QCm32Nku4ZRKzFQqlbI=;
  b=nrz0bxpOzNfJI+9rQSmPPesW6TFM9BBmOpFSv/ATkgt8LMsC++JTFvsg
   vVeXU1FTiPHmZhCoqpUV0GRFCv6HSvr8XfkrMIvdXWBXTYOAXHyFw2Rxh
   3QQ2z3KAV2FQViFofl52DMKGNm92Oozz3349k1pspqLGoeebZvIVFtf+9
   Pa5WezMDMDmCB+iAXyLNI6KHcTTynPXwmpDqm5Y6ejZkztA7CGXEf0cmS
   eIfbXQoVA5z3Jicx4GeFonExnZyChK8LjL9wQdiiwzpdXbq+bhXElJ4tc
   EClsNDl+/Wep0eQ3IxrM6646+x3WVH2tbEKBe9J9Y9aGMuFLWJ/eK/Gby
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="242336305"
X-IronPort-AV: E=Sophos;i="5.90,166,1643702400"; 
   d="scan'208";a="242336305"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 21:28:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,166,1643702400"; 
   d="scan'208";a="642026895"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 08 Mar 2022 21:28:52 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRosW-0002eT-3L; Wed, 09 Mar 2022 05:28:52 +0000
Date:   Wed, 9 Mar 2022 13:28:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: dtbs_check: ERROR: dtschema minimum version is v2021.2.1
Message-ID: <202203091300.8HScLbcF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   330f4c53d3c2d8b11d86ec03a964b86dc81452f5
commit: e2b0d9987920f3dc727e08a1bf42296be9b5d6da dt-bindings: Bump dtschema version required to v2021.2.1
date:   12 months ago
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220309/202203091300.8HScLbcF-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce: make ARCH=arm dtbs_check

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   sort: -:2: disorder: 0
>> ERROR: dtschema minimum version is v2021.2.1

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
