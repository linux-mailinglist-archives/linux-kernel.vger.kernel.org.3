Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1005452FB77
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 13:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiEULOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 07:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242393AbiEULMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 07:12:03 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B2A2980B;
        Sat, 21 May 2022 04:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=H7dbDY9GC8I8dbN3igjTykudW5NgEABTKg0/xJ4Xl9s=;
  b=l0Onq+Y5NfWvtJwbK5oqdSgnRFFBJ2IvhlRx4irs74wZWeUpqJCtDxpZ
   XphwleMqS3boCi2f/wo3CCWiKQDXDnzfqufiwJV4ORSBtWnG8JQskOrDd
   7GEigAm5lP/FzmeeRcvHEmmpWkMprxr27T5z80ILKJHtULo8pycEZ4EgR
   8=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14727911"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:11:54 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     kernel-janitors@vger.kernel.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: bcm: brcmstb: pm: pm-arm: fix typo in comment
Date:   Sat, 21 May 2022 13:10:26 +0200
Message-Id: <20220521111145.81697-16-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spelling mistake (triple letters) in comment.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/soc/bcm/brcmstb/pm/pm-arm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/bcm/brcmstb/pm/pm-arm.c b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
index 3cbb165d6e30..7a07e8f9ae6d 100644
--- a/drivers/soc/bcm/brcmstb/pm/pm-arm.c
+++ b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
@@ -721,7 +721,7 @@ static int brcmstb_pm_probe(struct platform_device *pdev)
 	ctrl.phy_a_standby_ctrl_offs = ddr_phy_data->phy_a_standby_ctrl_offs;
 	ctrl.phy_b_standby_ctrl_offs = ddr_phy_data->phy_b_standby_ctrl_offs;
 	/*
-	 * Slightly grosss to use the phy ver to get a memc,
+	 * Slightly gross to use the phy ver to get a memc,
 	 * offset but that is the only versioned things so far
 	 * we can test for.
 	 */

