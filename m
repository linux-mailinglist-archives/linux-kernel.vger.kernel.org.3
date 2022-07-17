Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24955778B4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 01:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbiGQXCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 19:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGQXCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 19:02:05 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21E212618
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 16:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658098924; x=1689634924;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OVMXY+7rmXWAHxIusWcVmUZpYNQJLbBUjzzXhmEH/Ek=;
  b=XCZMBc+7S0cY+VjQ0SDhGiQjF5q7TNNGt+znypDJVw9fIvmt4zs24EKh
   zCMJQ0+vydDXrRENvVyxcCo2ovMsrBqmda/oAvm3/h5kHpNq6eU8efRlL
   deLAkdJNJ1Opx0Us47uNRrnUPbk1vdZY9w63mTGm2XDfFTqbNpHcoEawo
   OvGdcg3CDrLjDaz3xQkrPl7NkaxppOfF2xyamRlZCSJJF8aGNaydTw5iK
   tSykhWFiTmuj5GecqA9DsoyWeIM7LQEArCRXzoGvs1F6vUoX9Ea41bSYV
   d3ruXmE5ZrAO2nvIc5zlEAKAIn3e04ii5+Ho/ylbdc4PTklAkyCNsqG1W
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="269121352"
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="269121352"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 16:02:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="629718306"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 17 Jul 2022 16:02:03 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDDH0-0003ln-O9;
        Sun, 17 Jul 2022 23:02:02 +0000
Date:   Mon, 18 Jul 2022 07:01:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [axboe-block:for-5.20/io_uring 39/171] io_uring/net.c:476:2-7:
 WARNING: NULL check before some freeing functions is not needed.
Message-ID: <202207180642.8rluUa8x-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-5.20/io_uring
head:   004523ebfe6de8dd664ddf6fc26c47801b3bdaf5
commit: fcc5280b51cc06ca127d118985c7a73fdff61c70 [39/171] io_uring: split network related opcodes into its own file
config: s390-randconfig-c043-20220717 (https://download.01.org/0day-ci/archive/20220718/202207180642.8rluUa8x-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> io_uring/net.c:476:2-7: WARNING: NULL check before some freeing functions is not needed.
   io_uring/net.c:222:2-7: WARNING: NULL check before some freeing functions is not needed.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
