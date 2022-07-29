Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4564585636
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 22:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239275AbiG2Uh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 16:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiG2Uh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 16:37:26 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2123D6553;
        Fri, 29 Jul 2022 13:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659127046; x=1690663046;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BwLHPzr/dhNUDvI8Eh1ojBnr9YBQM1nsFP8p168BfKc=;
  b=chAZuk+0e8zo4pz77M7esMsJaHAoFpUIQsaaIhgHOrmMMH9sdo2jlM6t
   1rvPshmWSGn3ZdlHvoFS2svKuaQ17+tJoyXISvVp1ZzLogmz+h99A+bci
   s6scs7Xl2lzqEATOn6jZIZox+01TWq9I8g2P4GZipe1h1IVR61loivMru
   QQsH3zO01Bave3PkuZ/35k3oRSE1kYSylqGFHgqwWjjsmEB2dfReIZE+m
   qk6Uc4bPT+oNhSLXpLrBBkDYnUDWIJNK2WX5C2STUjg9pwSt7cZyqd1aS
   WYi7M13ANlq3joIAiH+CJEIWSeTuKvcunnzRfQgNAM6ctQ4PwxBYe7GR/
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="288857804"
X-IronPort-AV: E=Sophos;i="5.93,202,1654585200"; 
   d="scan'208";a="288857804"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 13:37:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,202,1654585200"; 
   d="scan'208";a="577078192"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 29 Jul 2022 13:37:21 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHWjZ-000C4n-0t;
        Fri, 29 Jul 2022 20:37:21 +0000
Date:   Sat, 30 Jul 2022 04:37:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vikas Gupta <vikas.gupta@broadcom.com>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Andy Gospodarek <gospo@broadcom.com>,
        Jiri Pirko <jiri@nvidia.com>, linux-doc@vger.kernel.org
Subject: [ammarfaizi2-block:netdev/net-next/main 16/29] htmldocs:
 Documentation/networking/devlink/devlink-selftests.rst: WARNING: document
 isn't included in any toctree
Message-ID: <202207300406.CUBuyN5i-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block netdev/net-next/main
head:   6957730e20389a63eb333afb6fcf38b45f549ea8
commit: 08f588fa301bef264576fc915da6bf31b585a824 [16/29] devlink: introduce framework for selftests
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/networking/devlink/devlink-selftests.rst: WARNING: document isn't included in any toctree

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
