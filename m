Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A5459FE22
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 17:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239257AbiHXPVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 11:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238837AbiHXPVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 11:21:08 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CC074DE2;
        Wed, 24 Aug 2022 08:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661354466; x=1692890466;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0blbZmCGeUs6sn2zmHlBPUj2jjJyqCVMCrHAfZOhsJ4=;
  b=k6wdD35i7rP31k/iKJ7VD35BKyNMwj30URIINKUeY9C/GMs35gUogXs9
   VNdJVwHL7zwQgxeVUUVkJecsV5R8Njc/lBCkNm99AQK34adZNyMCTRAfO
   KnmCtByVE42cd9ngf37lTtctv4kq8VoM2jgCOGbfLOTLkl6n+89VTRNPl
   X4DHVZsPxFqZl5z7bYsdttnvfsEnVHL9ImwMG6dKPOalEGau+BrcahxQ/
   +IQ3uTcvbmrH9giwmK/J+8Hb+uoTJo+3nRzaG0l8TtH6ingfeijKdETuj
   Y8LjbFTYc1pRr309an7g20gbfR+/SnDWg+7+la2vJ03bBb2YAmWdqk+V/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="295275958"
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="295275958"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 08:21:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="670545402"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 24 Aug 2022 08:21:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 87A90174; Wed, 24 Aug 2022 18:21:17 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] platform/x86: intel_cht_int33fe: Fix comment according to the code flow
Date:   Wed, 24 Aug 2022 18:21:15 +0300
Message-Id: <20220824152115.88012-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't use software_node_register_nodes() in the code, fix the comment.

Fixes: 140355e5db8b ("platform/x86: intel_cht_int33fe: Convert software node array to group")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel/chtwc_int33fe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/chtwc_int33fe.c b/drivers/platform/x86/intel/chtwc_int33fe.c
index c52ac23e2331..9448e2e67c3f 100644
--- a/drivers/platform/x86/intel/chtwc_int33fe.c
+++ b/drivers/platform/x86/intel/chtwc_int33fe.c
@@ -219,7 +219,7 @@ static int cht_int33fe_add_nodes(struct cht_int33fe_data *data)
 
 	/*
 	 * Update node used in "usb-role-switch" property. Note that we
-	 * rely on software_node_register_nodes() to use the original
+	 * rely on software_node_register_node_group() to use the original
 	 * instance of properties instead of copying them.
 	 */
 	fusb302_mux_refs[0].node = mux_ref_node;
-- 
2.35.1

