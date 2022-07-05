Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DE9566377
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 08:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiGEG4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 02:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiGEG4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 02:56:34 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A479FD4;
        Mon,  4 Jul 2022 23:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657004193; x=1688540193;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yP0vnE8jr/5KW/AT54c96ivpWXdzRo0Q16ebXobF5KU=;
  b=XuwcNeZTwvG0ecfsuv4abNiGD3YX5/XUKqLopk0oR0gqqkLUfZyjl3ou
   OiJIz6+HqmLvqzd7T+fnHFyfaQ4xbCSEnhdV4+88WpC8dBby0ofr4qTwL
   eSpDwnu09B4ajnfNZRW/x1NFiOXuX4l+eBPf83FkTh8YLSxji+PMl49J8
   8CS6yH416AsWzCTJnGQbf7Tac61UOGlpqNTIvX58O7SLyblAs8DVHAvgT
   nTr2KrREtPSXkgeRW9GsM0v0AW5wwkCB6CrWradl5HsrBXBBHdcTRmb6R
   cAYv3qLK6BBZldaWcA8BM7ReumblsUCLgi8TjCiXFPOG0clWswnh2wEqG
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="347250478"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="347250478"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 23:56:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="542834686"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 04 Jul 2022 23:56:31 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8cU2-000Ip1-Sh;
        Tue, 05 Jul 2022 06:56:30 +0000
Date:   Tue, 5 Jul 2022 14:55:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, linux-doc@vger.kernel.org
Subject: [sbates130272-p2pmem:p2pdma_user_cmb_v8 4/21] htmldocs:
 Documentation/driver-api/infrastructure:50: kernel/dma/mapping.c:258:
 WARNING: Option list ends without a blank line; unexpected unindent.
Message-ID: <202207051424.iwUCGEfD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/sbates130272/linux-p2pmem.git p2pdma_user_cmb_v8
head:   019a11842e81acaa69f2395e767dc902e1a01c49
commit: 2151bb896c668fc027737cc7779223825ca6337f [4/21] dma-mapping: allow EREMOTEIO return code for P2PDMA transfers
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/driver-api/infrastructure:50: kernel/dma/mapping.c:258: WARNING: Option list ends without a blank line; unexpected unindent.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
