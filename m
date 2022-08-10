Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736EC58E49C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 03:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiHJBlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 21:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiHJBk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 21:40:28 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61A31AF09;
        Tue,  9 Aug 2022 18:40:26 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0C60D5C0279;
        Tue,  9 Aug 2022 21:40:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 09 Aug 2022 21:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1660095626; x=1660182026; bh=HbNBRJbRBFm3jhvzvtzDhklvn
        z1h/RDiPgNM6S1lCOs=; b=XMg4KnU6zR9ZtIGpxJ3kAKJ7k0dYTZ9pnYWdZW1v2
        rJWwyGYs5fT1Y9LXtbkskFqSJEp87cZdVdbsUlu6kskCXqC5AFrBWtDhPhKpAjJz
        e62zK2f8wZ3CXEFiVeshZZrt05u/8GjiKT9vfe+BhhZB3ZLb2CUpN+eAh1UmqQeG
        ZgbaaB1f1rtEM+2EzPyMRkudi1SuSU/ZyTL46jd9q6LDcllV89MYOeeUqXwiF8Yq
        S+r6y7Kk/crm7MqxVj6hWrvbVrdCBDp+3anKYJ9Wf/reQsPkflk2kfT184LmUOH0
        9Ke+t80OwpGvYXmk+Gd9s9FYKVnk9se2GajRoLS9DkIDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1660095626; x=1660182026; bh=HbNBRJbRBFm3jhvzvtzDhklvnz1h/RDiPgN
        M6S1lCOs=; b=yNGG+zBxLzBI/dOaH2dXM4jhniKVX5CXV/wlLHdvHXRDmdfcUmG
        ZuzsDUP6ZtgFG3dIo+fL7RParwG+z0JmdV2Y/i4oXh12YzV4mPtPjuYuoHV101hi
        49T/pM0RSGEvYH82rADFU8/nf60t0A3AfUvRSHIUsA8Atw2HzktRpCfnGmkyr2JD
        HLjzObOQZQvbSlrfF++Heeo7G+tPTivLpdYMu8PnVIWGbfT9vimP4+b92X1hL+VA
        g6FHtC7aoxs9bBJWy7G/aUTLQd0MV8aDROpNFPq0oHyn2YEgt3XdcsttKK0zJOvI
        TwJqceu1+l/HtNsXp/qDwOjwCngInanOkkA==
X-ME-Sender: <xms:iQzzYol0vKW0PCUOSREp05jEXC6L1ASP8jkd5VDZ0U_pqAyI_nBobw>
    <xme:iQzzYn3QMmYyloj5Wl91g3hqOhvRPjhB1GRxBBgNzwVxEG8Gk-DbX4gVl7A65_b5e
    isRK6Y4WPinWsFioA>
X-ME-Received: <xmr:iQzzYmprj7vcbcnD0heskfd8z9uMOyMAUV6Z5n1WzkvkHHmTjy1nGIdfgc9uvtHK7gOpJJo1JOpkuudb46YdnBOH_4fDXteUU_ZcagYOjZn9Lf4gSPHzDJmoGaJDY5qvrhwgKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeguddghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
    hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:iQzzYklkLe1wSQMadIOch1mQ2M83eAQN4nId6NO6ZESlg9KN1mKxEA>
    <xmx:iQzzYm0N_cEP3eR-lW1oTNkblI_fgOncwK_SobPOCzkjG0ooNhu2Bg>
    <xmx:iQzzYrtBMVqt4uGr-y6-tX7nGIpawh4YofINRXsnPhfNujwItRjKyA>
    <xmx:igzzYvlzlaO2x23gwnqomuDk-8mGGB9Bz8TpKSKlBgv8QoM86L2g4A>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Aug 2022 21:40:25 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH] clk: sunxi-ng: mp: Avoid computing the rate twice
Date:   Tue,  9 Aug 2022 20:40:24 -0500
Message-Id: <20220810014024.27568-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ccu_mp_find_best() already computes a best_rate at the same time as the
best m and p factors. Return it so the caller does not need to duplicate
the division.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/clk/sunxi-ng/ccu_mp.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_mp.c b/drivers/clk/sunxi-ng/ccu_mp.c
index 57cf2d615148..cc94a694cb67 100644
--- a/drivers/clk/sunxi-ng/ccu_mp.c
+++ b/drivers/clk/sunxi-ng/ccu_mp.c
@@ -10,9 +10,9 @@
 #include "ccu_gate.h"
 #include "ccu_mp.h"
 
-static void ccu_mp_find_best(unsigned long parent, unsigned long rate,
-			     unsigned int max_m, unsigned int max_p,
-			     unsigned int *m, unsigned int *p)
+static unsigned long ccu_mp_find_best(unsigned long parent, unsigned long rate,
+				      unsigned int max_m, unsigned int max_p,
+				      unsigned int *m, unsigned int *p)
 {
 	unsigned long best_rate = 0;
 	unsigned int best_m = 0, best_p = 0;
@@ -35,6 +35,8 @@ static void ccu_mp_find_best(unsigned long parent, unsigned long rate,
 
 	*m = best_m;
 	*p = best_p;
+
+	return best_rate;
 }
 
 static unsigned long ccu_mp_find_best_with_parent_adj(struct clk_hw *hw,
@@ -109,8 +111,7 @@ static unsigned long ccu_mp_round_rate(struct ccu_mux_internal *mux,
 	max_p = cmp->p.max ?: 1 << ((1 << cmp->p.width) - 1);
 
 	if (!clk_hw_can_set_rate_parent(&cmp->common.hw)) {
-		ccu_mp_find_best(*parent_rate, rate, max_m, max_p, &m, &p);
-		rate = *parent_rate / p / m;
+		rate = ccu_mp_find_best(*parent_rate, rate, max_m, max_p, &m, &p);
 	} else {
 		rate = ccu_mp_find_best_with_parent_adj(hw, parent_rate, rate,
 							max_m, max_p);
-- 
2.35.1

