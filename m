Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D8D580DF8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237602AbiGZHit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238298AbiGZHih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:38:37 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5851FCD8;
        Tue, 26 Jul 2022 00:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658821070; x=1690357070;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gAeq6Dc5lAvbBJi2sCscaeirSp2Hw0EMuXg5th4DIu0=;
  b=J8EpYQbFOps1XQxEG2e/31Tl5lF/v1bk3ziss6UEsfLNSRYCnWHNbV54
   dQg4OP3xOIVlz+AwYljMjRdXsCD1/VVbMKRcqvAWLFwpywyKnKecVQPW+
   f5LcG01nysLYjG3GqLCRiXsvLig10qNulLaQ7huvrk/pIh5PJWzeQaYRZ
   lmFy9p/TUOrIXLM95K7fwWN7SDFLCDbJrZ5vVSF+VKdZPCzxY5CDtxBx7
   /tHcQmkIu0V4SnmeWTajbZyacPxtZCQ1i89yVVwEP2l1y9XgfsJmipXw3
   B0ywA9ubYzoznv4lFn7wrh6rQlqXTcnUHUmQ1wKbkRvRILct410bBw3e6
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="351878800"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="351878800"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 00:37:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="627788511"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 26 Jul 2022 00:37:49 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGF8W-0006Bk-1j;
        Tue, 26 Jul 2022 07:37:48 +0000
Date:   Tue, 26 Jul 2022 15:37:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     SeongJae Park <sjpark@amazon.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [sj:damon/next 23/25] htmldocs:
 Documentation/admin-guide/mm/damon/guide.rst:5: WARNING: Duplicate explicit
 target name: "page".
Message-ID: <202207261536.B9ECWh72-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
head:   7b095128a1a8d7cd001d16012bd33216b7c89b6c
commit: e3d45147e4fb374314d08e0028560463a7da232e [23/25] Docs/DAMON: Add more docs -next doc
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/admin-guide/mm/damon/guide.rst:5: WARNING: Duplicate explicit target name: "page".
>> Documentation/mm/damon/eval.rst:81: WARNING: Footnote is not referenced.

vim +/page +5 Documentation/admin-guide/mm/damon/guide.rst

     2	
     3	==================
     4	Optimization Guide
   > 5	==================
     6	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
