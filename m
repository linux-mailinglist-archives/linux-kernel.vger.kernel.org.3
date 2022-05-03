Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6362F518326
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 13:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbiECLWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 07:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbiECLWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 07:22:13 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E512927CCA
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 04:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651576721; x=1683112721;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PDA0yq6HAMATY3Cn6z4lnO9DG8Qb4cEApNV5/AAc0UI=;
  b=MMUjGpE1uQ/ifQq2PSdx3kudK1PBgzKb323mpQQ46BYifG9bMGIbLGE0
   RF3sjxvcXjru8hZ4UDIbo/QmHoDqdbWGOY/ezp+VT0BRZPvhRPGXIQPDF
   JOLltIToYmZwDO6OkSCeUy4Nwl9I9lZzgKVRtUvDXnmox3S0xQywIhi29
   Ip1wy57CkIbOaadm0XwCUk3alg/FPEKei21zl/CHw+cOYq3CoiyINLdsS
   bIWKXPIvaAgt1h1CUYHII0XSMhob9fAur395jXwVA2HzMlSa6Wr18v3Bp
   XoyKWuskNHVgSgvi3+6sY99p5XA69P7KBR/hCwRvvbn3l1WwZA0siXThp
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="267330266"
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="267330266"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 04:18:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="733875852"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 03 May 2022 04:18:40 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlqYB-000APT-D4;
        Tue, 03 May 2022 11:18:39 +0000
Date:   Tue, 3 May 2022 19:18:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     kbuild-all@lists.01.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH pdx86-platform-drivers-x86] platform/x86: thinkpad_acpi:
 quirk_btusb_bug can be static
Message-ID: <YnEPbSO2rBJq37Ez@74ccfaeec2ea>
References: <202205031944.EP1ElC1B-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202205031944.EP1ElC1B-lkp@intel.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/platform/x86/thinkpad_acpi.c:317:20: warning: symbol 'quirk_btusb_bug' was not declared. Should it be static?

Fixes: 25eecc2ff6cc ("platform/x86: thinkpad_acpi: Convert btusb DMI list to quirks")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 drivers/platform/x86/thinkpad_acpi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index aed17d32ed84b..eefa22e86ae10 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -314,7 +314,7 @@ struct quirk_entry {
 	bool btusb_bug;
 };
 
-struct quirk_entry quirk_btusb_bug = {
+static struct quirk_entry quirk_btusb_bug = {
 	.btusb_bug = true,
 };
 
