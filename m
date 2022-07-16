Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C52576B7C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 05:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiGPDnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 23:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiGPDm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 23:42:59 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C081A1262C;
        Fri, 15 Jul 2022 20:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657942978; x=1689478978;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZhDaWO1LXpQhv4EjItP/P50Nc3AtU/RtqFlWKF3v0lg=;
  b=MkFcljd0xC0qIIbQPUrdA6j9d5cWP0+uiRU6D0maK0QcyuUc/2X7gXgO
   6a77O0kPfZI4D0m79VKeNjoXOMOwp1jTC72oimrObivZCjES42acTW5Rn
   xvVlEXK9FSgAmbZoZ7kq4kpNY0Lqu/v1Z3WiiG0qP6spe5LbvH+tLmMru
   BgM72ZQUw763vdlcc/lIHbjFecB1B2kFjwGcnZgngjKXT6X5ERIdcrXam
   fcSm+0ahG9j6qBOneN0T3qeddpb1HX6/oCtngn98xUaFZT3fzIf4O/qKp
   tqNtQaz4z5EARUw81LmWIy3FYyufyCDYIA4dgIYUG+w+Of+rci7aRO5to
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="286679560"
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="286679560"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 20:42:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="773198671"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 15 Jul 2022 20:42:56 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCYhk-00016i-8C;
        Sat, 16 Jul 2022 03:42:56 +0000
Date:   Sat, 16 Jul 2022 11:42:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Martin Liska <mliska@suse.cz>, linux-doc@vger.kernel.org
Subject: [jirislaby:lto 18/48] htmldocs:
 Documentation/kbuild/lto-build.rst:40: WARNING: Bullet list ends without a
 blank line; unexpected unindent.
Message-ID: <202207161100.lCdR6Unx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git lto
head:   79a278f10955da2801240f52efb828d158b2b36c
commit: 0350b4dd55922f586c4007f2612f91d2d2925749 [18/48] Kbuild, lto: Add Link Time Optimization support
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/kbuild/lto-build.rst:40: WARNING: Bullet list ends without a blank line; unexpected unindent.
>> Documentation/kbuild/lto-build.rst: WARNING: document isn't included in any toctree

vim +40 Documentation/kbuild/lto-build.rst

    36	
    37	Requirements:
    38	-------------
    39	- Enough memory: 4GB for a standard build, more for allyesconfig
  > 40	The peak memory usage happens single threaded (when lto-wpa merges types),
    41	so dialing back -j options will not help much.
    42	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
