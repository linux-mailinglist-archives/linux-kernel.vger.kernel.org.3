Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBA54CB6BF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 07:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiCCGNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 01:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiCCGNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 01:13:34 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106CA3466F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 22:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646287969; x=1677823969;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=su36CMckldqWhdXbhjjzt3AD3t+FfqRqmUyh69ml0Ok=;
  b=KtoAeugOXcwyULg2cBi/kB6fhqIlFCorWHKcLq0Q79iIt+Nwftn0d/GH
   wAoeJJlb5tmEdBRlo9Zlv8c34ZWXGjMcxs+aP96d1AZzC1maIxO69/jG0
   rruoP9TRqvC4ZddSXKzP2Q3BtMb5af2plgea4D8raOareGJ0buRcqUvEa
   HJArUOOB4a3FTqbROU3eWb6YA4D98iRGGfKl1YOqgzk5DARvJPSD3BKxI
   FODj20qbFLb0pzxUXA4vX/tHwEs89FunYELm55o+MgR0fVRQdvvOXQ9AE
   BCDoe59G94vTtKY/B6CUUHcbhEV+4F3YN+XLmdJDyINdHrw2O8TSL2JHm
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="234202225"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="234202225"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 22:12:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="511295925"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 02 Mar 2022 22:12:46 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPehh-0000DU-KR; Thu, 03 Mar 2022 06:12:45 +0000
Date:   Thu, 3 Mar 2022 14:12:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Amit Pundir <amit.pundir@linaro.org>
Subject: [RFC PATCH ammarfaizi2-block] ANDROID: net: paranoid: commoncap:
 __cap_capable() can be static
Message-ID: <20220303061236.GA70904@6305ff5a442d>
References: <202203031440.TcuCrT9t-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202203031440.TcuCrT9t-lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

security/commoncap.c:75:5: warning: symbol '__cap_capable' was not declared. Should it be static?

Fixes: 2b02b4ab89b9 ("ANDROID: net: paranoid: commoncap: Begin to warn users of implicit PARANOID_NETWORK capability grants")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 security/commoncap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 2ed79a834a965..f38709ba26317 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -72,7 +72,7 @@ static void warn_setuid_and_fcaps_mixed(const char *fname)
  * cap_has_capability() returns 0 when a task has a capability, but the
  * kernel's capable() and has_capability() returns 1 for this case.
  */
-int __cap_capable(const struct cred *cred, struct user_namespace *targ_ns,
+static int __cap_capable(const struct cred *cred, struct user_namespace *targ_ns,
 		int cap, int audit)
 {
 	struct user_namespace *ns = targ_ns;
