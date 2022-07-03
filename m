Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641AD56477C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 15:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbiGCNP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 09:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbiGCNPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 09:15:55 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC41A63E8;
        Sun,  3 Jul 2022 06:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656854154; x=1688390154;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/K/XbiGJKbxDxO0RGsaOp2tGMlUlUOZKBB0ivtAl+iU=;
  b=OKQ5uv/N/OocDIrKUHF0bgA0IkVzcuN5fB5fUyE4LjAGVjUs1vhLs1oY
   CfO8h7yzMpjwpwBJUGij+b53s2MdICfBBBw+blEbdLFqVZzOpscjSRER3
   s2/kug5op0Az2qVeKDbp4oa9JNCvNKgK4V9Bs1yfPXIz77DHA/M6LVa2x
   LLDitDotQk5hNMmM4shk4SDDhP3cSxbt1wS75cHt4Mr+PGDPWmBLgcSUa
   gAxbFmBoLG+kcp7pq74GlLeYTTNucIxQboun+FBxYmO7z09ZWGiC/BbRq
   zLvjt7bbQfIafoXA16MnP/Z4z/Aww3QgD0lAjKOO1Zu10BUD/bcVgSInN
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10396"; a="271717601"
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="271717601"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2022 06:15:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="919021209"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 03 Jul 2022 06:15:53 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o7zS4-000GYi-J5;
        Sun, 03 Jul 2022 13:15:52 +0000
Date:   Sun, 3 Jul 2022 21:15:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     SeongJae Park <sjpark@amazon.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [sj:damon/next 17/20] htmldocs:
 Documentation/admin-guide/mm/damon/guide.rst:173: WARNING: unknown document:
 /vm/damon/api
Message-ID: <202207032102.FQn5Ryi7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
head:   54aa71ecf6cac755c491a1992d83437cd2240311
commit: e381a2734cd4250c0e3ab5f46cecc86ec67edb57 [17/20] Docs/DAMON: Add more docs -next doc
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/admin-guide/mm/damon/guide.rst:173: WARNING: unknown document: /vm/damon/api

vim +173 Documentation/admin-guide/mm/damon/guide.rst

   172	
 > 173	If you are a kernel space programmer, writing kernel space DAMON applications
   174	using the API (refer to the :doc:`/vm/damon/api` for more detail) would be an
   175	option.
   176	
   177	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
