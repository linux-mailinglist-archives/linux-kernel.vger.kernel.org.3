Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB565620BC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 19:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235961AbiF3RBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 13:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235236AbiF3RBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 13:01:48 -0400
X-Greylist: delayed 398 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Jun 2022 10:01:46 PDT
Received: from mail.thepaulodoom.com (www.thepaulodoom.com [45.77.108.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C935421822
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 10:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thepaulodoom.com;
        s=mail; t=1656608105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=XsVkb/AD52GAZHCvQYNJpcreeFW5ZkqKXR8WqydymBA=;
        b=GAcHJcBbku7uBN+7/GlX1bnbw8CNMPJwePabDOfezaeLWa5XOTseKo/YKdktH4DTKUggD1
        AqwogUfMk2HDon7tMFBNwH9xhQRbCBTmhED+WlP9zSeR4le2q0uzAwvtYh8bR5CmNXaxe0
        6V/xmYtE/OCrnbBsQUPISm+cOnWxhTt9NWNXyHG+1X26jcj+21nr8OczB/iWUFE35rifNq
        7Rn9dcO0SpuTvf2FPmeAD3j0uKEuhdcqcLHU+JCk+HXF/6deg5UG7qp66ZHrEx9a/7peTg
        yfmTBVTDW87YCl7ceMPaxiV1GTc9/UCO9jJVMOBlI41QllhIYvhb1aT1NMn3YkZ7Gpcv6S
        H9HearwePg7Nt6erhoxu6yBVr31skBqTX5JeoiiLNQlZW571HJD6bFdt025MaucRyyQLzV
        7XWPgO4nmYV+CZv5uKFRsCcq2TetLaSXAgbrED6lXZgDB1P0sanO4I5Si3grJFn0rZq2Wc
        E9uXj8we465dnwpBxLOK1Fmvhs92x3Ljl4JJTir9SCJsQXrUpViEtrpG3l3w/8wuu9P6FB
        6J24N9ztbOg9LSwk1ezeCXv2H5ifL4Pp2pRLJsFHhrT5DzWmbAWpmt54BaErsRK4pfdf2b
        KtWhPuE3NNJSfbXihW1beDe2SKbW/8fcewT+PFhCP3lIE1LNek2zs=
Received: from paul-debian-hp (c-98-240-189-147.hsd1.mn.comcast.net [98.240.189.147])
        by vultr.guest (OpenSMTPD) with ESMTPSA id 77301d97 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 30 Jun 2022 16:55:05 +0000 (UTC)
Date:   Thu, 30 Jun 2022 11:55:02 -0500
From:   Paul Lemmermann <thepaulodoom@thepaulodoom.com>
To:     perex@perex.cz
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        notify@kernel.org
Subject: [PATCH] sound: arm: aaci: fixed formatting
Message-ID: <20220630165502.l4bb7ov3c3fhuvey@paul-debian-hp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

added proper spacing before parenthesis and around 'or' operator.

Signed-off-by: Paul Lemmermann <thepaulodoom@thepaulodoom.com>
---
 sound/arm/aaci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index 0817ad21a..724a1d50b 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -239,7 +239,7 @@ static void aaci_fifo_irq(struct aaci *aaci, int channel, u32 mask)
 			aacirun->bytes -= len;
 
 			/* reading 16 bytes at a time */
-			for( ; len > 0; len -= 16) {
+			for ( ; len > 0; len -= 16) {
 				asm(
 					"ldmia	%1, {r0, r1, r2, r3}\n\t"
 					"stmia	%0!, {r0, r1, r2, r3}"
@@ -250,7 +250,7 @@ static void aaci_fifo_irq(struct aaci *aaci, int channel, u32 mask)
 				if (ptr >= aacirun->end)
 					ptr = aacirun->start;
 			}
-		} while(1);
+		} while (1);
 
 		aacirun->ptr = ptr;
 
@@ -662,7 +662,7 @@ static void aaci_pcm_capture_start(struct aaci_runtime *aacirun)
 	writel(aacirun->cr, aacirun->base + AACI_RXCR);
 
 	ie = readl(aacirun->base + AACI_IE);
-	ie |= IE_ORIE |IE_RXIE; // overrun and rx interrupt -- half full
+	ie |= IE_ORIE | IE_RXIE; // overrun and rx interrupt -- half full
 	writel(ie, aacirun->base + AACI_IE);
 }
 
-- 
2.36.1

