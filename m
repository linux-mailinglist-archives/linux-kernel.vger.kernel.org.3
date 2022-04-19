Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D5F506C40
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352230AbiDSMYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352224AbiDSMYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:24:39 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DDF2CC90
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650370913; x=1681906913;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0otuNljz4+j3nvPWDBPORm6PDdN6rU5c7+S0wKF+DT8=;
  b=DO4goivvgZ7LBlmlJoygqJrsiHxyrs6PB0pAi5lmgoW0E00JOqtrbJw1
   1rXk6/uC9vm5XQYrZ7blsix6uF9R6Oy3RoRiUcDi4Egvfq6bMXsQh+PKZ
   LGsop6KelD/Gg3LsSKfj3Yf/dhgLzL+5hr4jz3jJgnnGII0ce8el/Tdv8
   1wCPqNwzUAjg8cxxDDGcljF6NkW6Nd/AG5s6J5NiegF2xjTNwUfzKsBjY
   Snn3erethR2tL8zWjn1GQO9Gd27wQKHUP+erPFEuVVRZw9p+l0MGXqrv2
   plWdGUy9USaER7qYVDCPrssCZ9s3MaVK+UA0zNBn/IaB9Ud6FD/+B+zaI
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="262610395"
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="262610395"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 05:21:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="530186601"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 19 Apr 2022 05:21:51 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngmrf-0005kq-2v;
        Tue, 19 Apr 2022 12:21:51 +0000
Date:   Tue, 19 Apr 2022 20:21:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chris Redpath <chris.redpath@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [RFC PATCH jsarha] ANDROID: sched/fair: __pcpu_scope_eenv_cache can
 be static
Message-ID: <Yl6pWPuKQxlB99D7@22daf826a52b>
References: <202204192047.g1X4yydR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202204192047.g1X4yydR-lkp@intel.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel/sched/fair.c:6738:1: warning: symbol '__pcpu_scope_eenv_cache' was not declared. Should it be static?

Fixes: 0d2a194c5434 ("ANDROID: sched/fair: re-factor energy_diff to use a single (extensible) energy_env")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 kernel/sched/fair.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index dd2b286ea4905..f7a382a602c86 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6735,7 +6735,7 @@ static bool cpu_overutilized(int cpu)
 	return (capacity_of(cpu) * 1024) < (cpu_util(cpu) * capacity_margin);
 }
 
-DEFINE_PER_CPU(struct energy_env, eenv_cache);
+static DEFINE_PER_CPU(struct energy_env, eenv_cache);
 
 /* kernels often have NR_CPUS defined to be much
  * larger than exist in practise on booted systems.
