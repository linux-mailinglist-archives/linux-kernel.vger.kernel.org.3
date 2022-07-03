Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF997564A10
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 23:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiGCVge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 17:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiGCVgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 17:36:31 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561172AE0;
        Sun,  3 Jul 2022 14:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656884190; x=1688420190;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=24QQ5NPrwFmpCkw+mx2t1WzaBx8QIpAmI3MSKELw5lE=;
  b=h/3Yy+C7US0kx/CvqAzBxZjHLkBZ517j35ojb0IopMkwggf4/D/pZoD4
   wFd2Y2FSNIjRvsEoLTKyydXGnUI0SQ1Yyb1PT3jKjZHBBUHkJzdXP+Ra9
   VmNTU5Q68Uk7MX91gNcHed6cyybIwNGysn2vI987Le4afKSoaIU7jCZdc
   OznKdKz4WH4oiSgyfEdf9q28mm1WszTbI8WWPrjmQ1lHP7VZbIztj6U3Z
   m81kWoaOG9dZ6PrQirj/RqRHVvw0MgtYM6pCvfVs4M2TuE3Vmtc/sZpmF
   0GjTnSEr9QSm/QvedwCCepiTlVePpGXjrtfo0M+lo6BMY1xj4q87arx/0
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="263396831"
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="263396831"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2022 14:36:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="695114319"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 03 Jul 2022 14:36:28 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o87GV-000H19-S3;
        Sun, 03 Jul 2022 21:36:27 +0000
Date:   Mon, 4 Jul 2022 05:36:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        David Gow <davidgow@google.com>, linux-doc@vger.kernel.org
Subject: htmldocs: Documentation/dev-tools/kunit/api/test:9:
 include/kunit/test.h:318: WARNING: Inline interpreted text or phrase
 reference start-string without end-string.
Message-ID: <202207040533.Ja5Z2Onx-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   20855e4cb361adeabce3665f5174b09b4a6ebfe6
commit: 9bf2eed995f9f8136f00110214c120f2d7912ad8 kunit: add support for kunit_suites that reference init code
date:   10 weeks ago
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/dev-tools/kunit/api/test:9: include/kunit/test.h:318: WARNING: Inline interpreted text or phrase reference start-string without end-string.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
