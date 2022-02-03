Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6C64A7D85
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 02:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348874AbiBCBvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 20:51:23 -0500
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:44063 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348861AbiBCBvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 20:51:19 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 861152B000B2;
        Wed,  2 Feb 2022 20:51:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 02 Feb 2022 20:51:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=oqPS/m8KdcwSEqSZDEqPQcylkLS5Bx
        Wh5VCZ7RIAJTQ=; b=OPfolPSeFqBN7+2WBft/PzG9Qf+vuXW7fGAtKcdwY7hBt9
        p//R5NQFO8Kd8XKpS0AzBpPbmh6/857b0+XMTCV0QTKddL/hph82cg8tYOROKOtD
        m60SGmJRDF1MAX1WvmZUIDJ/Q7keZNxKZmJD569fVCAVt85JLxWeQkqVnBqhpcko
        qobYSRLY2lz7muP3qb8/cYeZ+Rysek0IdjjVull/WeSeUQTfVWCTEPzlHi4eKCd9
        ujDvEsqndXQsLQ8Y0LQmT3MHtQBrIQeb15Mx+IlXQe28AcDzx5JNEE8TU14hBQ9X
        jGuFd+ova53J/nSVYSANOwAxDlj4N8EcjpKNWghg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=oqPS/m
        8KdcwSEqSZDEqPQcylkLS5BxWh5VCZ7RIAJTQ=; b=gtvImH1Up2Cm+sAJovBnj/
        u1UwtFmOzaQSgDyS4VgyIE/odakeT1coAhPNQUoP2EbzWRt7I3ZkE4zL71ev9nhn
        dUUJvB5W55Ze2HYat5SvQcaBJ36KSwWpkPAyvypxdAutC8LnOMc2VtQB3wPEqb0F
        +b6VzOKqStlEKY4a7W4KMtTFNtPi2zgKCsyn59EkdQOwJviotbdC+SuE2T7VZtL7
        5rTeMmaRLuHN45HPFJNyeyQmkb/OpBec1U6QcchXLHX/ErkNFu9JvPnDl2qaUVGc
        On1nyiSF4cd6YpMWnk2aKphBYw053OCCz9HwWKB+1A5XB2ij+awvly5kKtSh5dPw
        ==
X-ME-Sender: <xms:FTX7YTo_SHU8P_deJ_Av1PzwDC5Wq4pfe4E5XKDOBqoj1G10VOOPTw>
    <xme:FTX7Ydoj_7XrQx9ts1UfjuxHm_fjpO7i_MVV5reE3Oru-7FROk-MD6hF_TQkXU5TX
    EnprktQlZ6Sbu6e4A>
X-ME-Received: <xmr:FTX7YQN4MMgHIFHj_PlPiz2Z8VgKRunD3oLZspIcBW3NR3relvRUCEEf75ziYjPv2isJL_4ZagaxnHLeovetL2Z1tZpVzN_TKDZv5XFPlhTjQ_BNybX0o6nIbdQLS09Fp5WOfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeeigdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:FTX7YW43HUqixIHZQXzO4FLl7O4CAqVsfUIIfVBl7emb7B_Dx8jiLw>
    <xmx:FTX7YS4y6Ydi0gAEyVY61HSRB9Sqfzh8wfXQxflBP33xMV1ubrc5BQ>
    <xmx:FTX7YehNrgg-wlAIjsmlnj4lFLylDepyDvjqWdI1TBTbxvJ_tYx4ww>
    <xmx:FjX7YbEPx4Y5JR8sZbV4Jxva-xc7G7L5zCMNy3qcVVWcynLtN873KXzazJY>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Feb 2022 20:51:16 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 2/2] mmc: sunxi-mmc: Add D1 MMC variant
Date:   Wed,  2 Feb 2022 19:51:11 -0600
Message-Id: <20220203015112.12008-2-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220203015112.12008-1-samuel@sholland.org>
References: <20220203015112.12008-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

D1's MMC controllers are unique in that they have the DMA address shift
(like A100) with a 13-bit descriptor size field (like sun4i). Add the
compatible and parameters for this new variant.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/mmc/host/sunxi-mmc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 2702736a1c57..c62afd212692 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1167,6 +1167,14 @@ static const struct sunxi_mmc_cfg sun9i_a80_cfg = {
 	.can_calibrate = false,
 };
 
+static const struct sunxi_mmc_cfg sun20i_d1_cfg = {
+	.idma_des_size_bits = 13,
+	.idma_des_shift = 2,
+	.can_calibrate = true,
+	.mask_data0 = true,
+	.needs_new_timings = true,
+};
+
 static const struct sunxi_mmc_cfg sun50i_a64_cfg = {
 	.idma_des_size_bits = 16,
 	.clk_delays = NULL,
@@ -1205,6 +1213,7 @@ static const struct of_device_id sunxi_mmc_of_match[] = {
 	{ .compatible = "allwinner,sun7i-a20-mmc", .data = &sun7i_a20_cfg },
 	{ .compatible = "allwinner,sun8i-a83t-emmc", .data = &sun8i_a83t_emmc_cfg },
 	{ .compatible = "allwinner,sun9i-a80-mmc", .data = &sun9i_a80_cfg },
+	{ .compatible = "allwinner,sun20i-d1-mmc", .data = &sun20i_d1_cfg },
 	{ .compatible = "allwinner,sun50i-a64-mmc", .data = &sun50i_a64_cfg },
 	{ .compatible = "allwinner,sun50i-a64-emmc", .data = &sun50i_a64_emmc_cfg },
 	{ .compatible = "allwinner,sun50i-a100-mmc", .data = &sun50i_a100_cfg },
-- 
2.33.1

