Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE243518C25
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 20:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241276AbiECSY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 14:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241234AbiECSY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 14:24:56 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD6E1B7B9
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 11:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651602083; x=1683138083;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wjJKgzIfGuKA16AOtGpYY81I8GcbNSajMQOiGEreDbA=;
  b=gkHOqefSCfxjm8ufEvDWuvGkEFRlYLNsGdUlqzvn3zdCFru6zqtXx/H0
   2ZBC8jFrhP2PU7uTXDvLAJX4H9QcLjLKvNK0Yhz05PgCMS7atI34aGZ3O
   8CfvvN+X0VCLwB9dCFvRweeonsELWozn1kr4QMPVZdgynUCRPyT9mu1ft
   Gci283ifqe+VCnhziHTBPh2YzSkT959hwVtnfvUsBWYYxTPxlBd0wV8sv
   MloPHPL3SyYShV0iKoiSf/H7VKvUaWg5c5vp8jp8obebSrQ0t/u+DDfl4
   jnRQdklFPJdTdXwR0KQhCj49rY5B7Wh9ABr0zT3zd84z1BOhh+y+JknDq
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="255015504"
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="255015504"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 11:21:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="599178807"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 03 May 2022 11:21:21 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlx9E-000AhL-H4;
        Tue, 03 May 2022 18:21:20 +0000
Date:   Wed, 4 May 2022 02:21:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     kbuild-all@lists.01.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH pdx86-platform-drivers-x86] platform/x86: thinkpad_acpi:
 quirk_s2idle_bug can be static
Message-ID: <YnFyjKyfnPnfpHgW@74ccfaeec2ea>
References: <202205040241.QemV1sMH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202205040241.QemV1sMH-lkp@intel.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/platform/x86/thinkpad_acpi.c:322:20: warning: symbol 'quirk_s2idle_bug' was not declared. Should it be static?

Fixes: a50dfa903391 ("platform/x86: thinkpad_acpi: Add a s2idle resume quirk for a number of laptops")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 drivers/platform/x86/thinkpad_acpi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index f385450af8647..d5431d3d4246f 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -319,7 +319,7 @@ struct quirk_entry quirk_btusb_bug = {
 	.btusb_bug = true,
 };
 
-struct quirk_entry quirk_s2idle_bug = {
+static struct quirk_entry quirk_s2idle_bug = {
 	.s2idle_bug_mmio = 0xfed80380,
 };
 
