Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28034EE9F9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 10:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343905AbiDAIwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 04:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236874AbiDAIwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 04:52:30 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083C21F9759
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 01:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648803042; x=1680339042;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Xsjc6JVDeLKGlaloug0/oweGPwuW9yusfFSj8jCkWgQ=;
  b=gEd456gU0/Pt9FxCssH73+nP12qt/iAjDYnFAKVz3ZeWJ2oHrDbNqPBz
   35HaqA73d84mc2L0UrIXV/m6thYZK+acwkzR18metZydC63GObMhJpd3L
   L3rcYK82O/0iaBgE5x/eh+P3AE7C+Ca9NRTABWf2oGuzHtV4xzAiwxzfh
   8HNyjcRS8KaixxKFofye3fLRF3gCBrz46vmDwRYYx3vTAw4DpJMO08GYW
   6rVqsrCU6fbx5Nbr0q0PjG+SFQbuRvo/pPfHfNdEx2hUmTlvYa4FyG2zQ
   4TxUYTD44qa3Nlas1vnF1tF8sq2CY4GQmKC8hceMKo+ItQNdzd5+d90tr
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10303"; a="258914010"
X-IronPort-AV: E=Sophos;i="5.90,226,1643702400"; 
   d="scan'208";a="258914010"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 01:50:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,226,1643702400"; 
   d="scan'208";a="522699478"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 01 Apr 2022 01:50:40 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1naCzP-00016J-Kt;
        Fri, 01 Apr 2022 08:50:39 +0000
Date:   Fri, 1 Apr 2022 16:50:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: dtbs_check: ERROR: dtschema minimum version is v2022.3
Message-ID: <202204011633.0XlAbzBd-lkp@intel.com>
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

Hi Rob,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e8b767f5e04097aaedcd6e06e2270f9fe5282696
commit: 2783a7f56f9980f61ca809b826bcd14dc77eb7b9 dt-bindings: kbuild: Pass DT_SCHEMA_FILES to dt-validate
date:   3 weeks ago
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220401/202204011633.0XlAbzBd-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce: make ARCH=arm dtbs_check

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   sort: -:2: disorder: 2022.1
>> ERROR: dtschema minimum version is v2022.3

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
