Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9518591278
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 16:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237637AbiHLOsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 10:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbiHLOsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 10:48:12 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965F298D09
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 07:48:11 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 047E532007F0;
        Fri, 12 Aug 2022 10:48:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 12 Aug 2022 10:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1660315689; x=1660402089; bh=nFAyZba+rUSSpa4dMw5jpMYFE
        bkfzVnF4ksUNlmVM3A=; b=aBWH05Od0HQ74QiuPgre2ttFPk/yRPqxtG7J3wILw
        pN9tIc6SYBKLJjQ6KHnvN18/vLLxbNhfDuaEUw+4Vj29AxsLDMOf+s5LGZPmOvdY
        K0tEsG2JW/ITmwGyIRngtZiHkYjao0cug5P+tDPlUn4pTD/anny5mIdAh3gaEJOq
        sXcwIyY0/Nay1ajcFPpHMN3qGT48oXkEkoFkiSOCHvejBTBMKhjjSVeTy5wTEUke
        gReJsmeJPDisCQr4N7ObzUl/KEFJqBa3D9qD3AP/I2fd9tm7L0LfMcFuPWzs6rSe
        wDNOCG3f1SnqbmewhS1FzyV/p+BTSnuDN8TdNySipohBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1660315689; x=1660402089; bh=nFAyZba+rUSSpa4dMw5jpMYFEbkfzVnF4ks
        UNlmVM3A=; b=BihLiXC4PtN2SfU+VBV4DM4mEGnvTGkeAlF76WFLDpPtsdd6EyW
        e37t73EA8IFPtt3fToOOP+B/ifL4pxW9mDcVzHonzNgLr33xrvY6qMlH7lrYaK9i
        mSCg7OtX4wdzNtWiC2HJeSNv8b+LHwus+ZyQz1CG7ctYzz9Q4cA6Xkwsu9aIWBin
        5iyyveb1gQUWPlncAJZjadHrXvRqSwhDYqd1bG2zlwSL+7MNxD290cqWXcVKy9J8
        teZQDNLC/l+zbEZVPuSvrV0aTLbbnCp7NnTxJBQDuCzqbZ0gBm5a3JOCUDvqfV5f
        8NWdUYnmmIefT41RTs9uDzXZPb8H4V0aUjw==
X-ME-Sender: <xms:KGj2YhGpHq2WIrq7pE725XRiIoCZuPX54xRzi2tLqVvtG7iikGyE-w>
    <xme:KGj2YmVelSMbeOLBszGJHZvx_j8xIk1zEkiDmSirizDm8MEUHlGH6wf_EbxdNG9lx
    VyEg0KOd87nXpowuQ>
X-ME-Received: <xmr:KGj2YjJH5Ou5yStvqlggt-3S3VPopiDVqGkaU3UvtJont5VMnoETjhPeFiXp47p5MIIbl9pQsT94gh5XWiJTCHJjy3CJipVCHoNWDbR8-sdcgSiNd40Z_8tNxbSLtEehX88>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegiedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghj
    rdhiugdrrghuqeenucggtffrrghtthgvrhhnpefhfefghfdtteehvddufefgtdelfeehge
    ekvddthfehgedvkeevvddutdehgeefieenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:KGj2YnGoJMsaWvT6ybbpz7J_NwW1p2UPp55Jkc6ri5GLO5h8Dl1fqw>
    <xmx:KGj2YnUCYfC1CLewAtzjPcceTe6yPk9DYzGxXV4dBvh-zinJel4LlQ>
    <xmx:KGj2YiPGRbwDLiLwb-4PJMzLr7vyvceKoXb7jG0z5vn0yuS2f4SoDA>
    <xmx:KWj2Ytd-LzVJnPfa4mOq4QVSvWXfHt3jFAsYW6FPwB_XzLWRruUe_Q>
Feedback-ID: idfb84289:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Aug 2022 10:48:05 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     openipmi-developer@lists.sourceforge.net
Cc:     minyard@acm.org, joel@jms.id.au,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: [PATCH] ipmi: kcs: Poll OBF briefly to reduce OBE latency
Date:   Sat, 13 Aug 2022 00:17:41 +0930
Message-Id: <20220812144741.240315-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ASPEED KCS devices don't provide a BMC-side interrupt for the host
reading the output data register (ODR). The act of the host reading ODR
clears the output buffer full (OBF) flag in the status register (STR),
informing the BMC it can transmit a subsequent byte.

On the BMC side the KCS client must enable the OBE event *and* perform a
subsequent read of STR anyway to avoid races - the polling provides a
window for the host to read ODR if data was freshly written while
minimising BMC-side latency.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/char/ipmi/kcs_bmc_aspeed.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
index cdc88cde1e9a..417e5a3ccfae 100644
--- a/drivers/char/ipmi/kcs_bmc_aspeed.c
+++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
@@ -399,13 +399,31 @@ static void aspeed_kcs_check_obe(struct timer_list *timer)
 static void aspeed_kcs_irq_mask_update(struct kcs_bmc_device *kcs_bmc, u8 mask, u8 state)
 {
 	struct aspeed_kcs_bmc *priv = to_aspeed_kcs_bmc(kcs_bmc);
+	int rc;
+	u8 str;
 
 	/* We don't have an OBE IRQ, emulate it */
 	if (mask & KCS_BMC_EVENT_TYPE_OBE) {
-		if (KCS_BMC_EVENT_TYPE_OBE & state)
-			mod_timer(&priv->obe.timer, jiffies + OBE_POLL_PERIOD);
-		else
+		if (KCS_BMC_EVENT_TYPE_OBE & state) {
+			/*
+			 * Given we don't have an OBE IRQ, delay by polling briefly to see if we can
+			 * observe such an event before returning to the caller. This is not
+			 * incorrect because OBF may have already become clear before enabling the
+			 * IRQ if we had one, under which circumstance no event will be propagated
+			 * anyway.
+			 *
+			 * The onus is on the client to perform a race-free check that it hasn't
+			 * missed the event.
+			 */
+			rc = read_poll_timeout_atomic(aspeed_kcs_inb, str,
+						      !(str & KCS_BMC_STR_OBF), 1, 100, false,
+						      &priv->kcs_bmc, priv->kcs_bmc.ioreg.str);
+			/* Time for the slow path? */
+			if (rc == -ETIMEDOUT)
+				mod_timer(&priv->obe.timer, jiffies + OBE_POLL_PERIOD);
+		} else {
 			del_timer(&priv->obe.timer);
+		}
 	}
 
 	if (mask & KCS_BMC_EVENT_TYPE_IBF) {
-- 
2.34.1

