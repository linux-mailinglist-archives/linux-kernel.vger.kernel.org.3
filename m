Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29724C0113
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbiBVSPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiBVSPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:15:40 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7151728A0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645553714; x=1677089714;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NWFl0CB77QKEA52n0Z7ndSDN12aGvq4CdcOnsvkuPzs=;
  b=fzfDz3byLgq0pQP1TbtJh1X+L8Mn/VreSO50xVbxSt7nxczEdvEA9G0V
   ZGOQvuvcVwBREXAHlhMTiys1oM2WTmoxcdRJvP7c5i6wl6l64p+4LTGpr
   nLZUSgSQ1vcg1SyTu3/DposmmO2V4MuGs0XUJroaBn1vLCsBx6Q8NQPBm
   1V8K5+Sp8mKox8SE0Gdbr20sDR4cht6IYJWXNjjQzLQEudUYd1eD6vtzK
   O/94rh6dWy8zmBikvrF6EJ+SLutpwf11iADKVw8UEGFFlL4TpTEWPthhX
   dsG4KrfNMRoxvqma//j57DMmtUePS7Xv1KqmKysxBF95fykAisWRL3VbX
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="276383733"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="276383733"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 10:14:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="508091363"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 22 Feb 2022 10:14:50 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMZgX-0000Ud-T6; Tue, 22 Feb 2022 18:14:49 +0000
Date:   Wed, 23 Feb 2022 02:14:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-5.4
 4032/9999] drivers/dma-buf/heaps/system_heap.c:312:5-8: Unneeded variable:
 "ret". Return "0" on line 321
Message-ID: <202202230232.gcmck8F2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-5.4
head:   0d36c5d6308623c56e2e94aff13e820cdd676bbf
commit: 44008f99d9ca0793e2562967e1da01fa74ee4a41 [4032/9999] ANDROID: dma-buf: system_heap: Add pagepool support to system heap
config: x86_64-randconfig-c022-20220221 (https://download.01.org/0day-ci/archive/20220223/202202230232.gcmck8F2-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> drivers/dma-buf/heaps/system_heap.c:312:5-8: Unneeded variable: "ret". Return "0" on line 321

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
