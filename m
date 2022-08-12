Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D9C590D21
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 10:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237825AbiHLIBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 04:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237807AbiHLIAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 04:00:54 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271F7DE98;
        Fri, 12 Aug 2022 01:00:52 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 8939E5C0064;
        Fri, 12 Aug 2022 04:00:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 12 Aug 2022 04:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1660291251; x=1660377651; bh=8ACGRm0dwGVoAVmIuINlfIamT
        QCxuccBvGOj1vSpQxs=; b=wLvbqfvt6dUV1CYy9j1IYKCSz0dq6jwCyFzLdIvvY
        CZZSGcTw3w9K8aHYY8uA2alIUDMXsSeFUr6k3fVFmQy/S0F8KeLe/fBunR9UcOpC
        N2LCzzv4zs0VWPju8mR4Y1Ooi3R5LgJkcNYVv/Wkt5Z+6sTmZ2RgT00ZuXECWtGF
        ZI7MZGTd8YAkqbvizAwPuPhXYZ1aGf0KN69jdYum73rxXKQW+JJLcEx5fh3w/LF+
        l21oVObjq9gi+9cfEYw9L/gwoHbNwsSdwZDT/B1WN8gPZsA0h2Cv3FIEsLwxyK7G
        DjUwCpdwaaEWk2AcrffWXF7O2MCJTAkDPQHPiTwAz9GkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1660291251; x=1660377651; bh=8ACGRm0dwGVoAVmIuINlfIamTQCxuccBvGO
        j1vSpQxs=; b=wxoSlat8ZO4yKvbQu7hCvPD+NdsMKmkvq4Tz8CBjMBdBfX8tNjr
        Mxukx/yl07nfR/Tg0Sty6j8qevkLu4XtBEYnNAG62pUxyTNPgwG6YJwWdk8d/kpx
        cxElSLAi1fFTJszkeGsLKh/wdwdkQk2IbyHDrXs+2d9R+KBVbSzySNwOAXWpb7CK
        7jDXdBu46SQte/iuT0c84yjd+4p1lK1c0Sz6vhc3twuAQeUtNCThA2BbMvbEY2Rv
        1mpMhK2l94sPmqA62IXgFo9FXN788yBXvRqkkVWZm0/Hg7xD8DVxWA4PbJ38CYwi
        67ECugefkieeSvMhiHN1K8HNtNSfFW+isYQ==
X-ME-Sender: <xms:swj2Yhz3RNKkmDIaHa5EA13S3R-VWB12euh8WEv_pI5t6EfNZFg6eg>
    <xme:swj2YhR7JttJ0dIdlc1NSbdvIKXoOZs3EjSpGK5ReQmEgVMSkjSqXGFu3HEJhw6QH
    zJ-kRGj-DnMrLOfIg>
X-ME-Received: <xmr:swj2YrW3xqeGu-yIkfnP8x1lS7yQ6hngTYBjpSrj0CjEP6j1acdyRVvKvylRKCvC31Qe25BFEjK2jI_JuHsWNPS6eQAVlUZSQ0yW96rgrbP5WLnCAZc9SII_12x_NuuubrSR1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeghedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeekveelhfejueelleetvdejvdeffeetgeelheeujeffhefgffefkeeh
    hffhkeekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:swj2YjhCaI6QScNxW-3I5v6-Cfh5HqQErFRrJ1WYAo0Hnl0iBJzwFQ>
    <xmx:swj2YjBGxiX12Id0ux0xBNUF20fhE9VLW3NcCRJBvevXStfNfIdl7g>
    <xmx:swj2YsKeoQ0F13qarPOhAKAL5n1qOmdPtzTsCAYki9pQ_6degQKY_Q>
    <xmx:swj2YlDyNCnESDzoN5hJXTjdw4hwtolizpLCMF6UMGcZkT1LuOMkJQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Aug 2022 04:00:50 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH] clk: sunxi-ng: d1: Limit PLL rates to stable ranges
Date:   Fri, 12 Aug 2022 03:00:49 -0500
Message-Id: <20220812080050.59850-1-samuel@sholland.org>
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

Set the min/max rates for audio and video PLLs to keep them from going
outside their documented stable ranges. Use the most restrictive of the
"stable" and "actual" frequencies listed in the manual.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/clk/sunxi-ng/ccu-sun20i-d1.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun20i-d1.c b/drivers/clk/sunxi-ng/ccu-sun20i-d1.c
index 51058ba4db4d..8ef3cdeb7962 100644
--- a/drivers/clk/sunxi-ng/ccu-sun20i-d1.c
+++ b/drivers/clk/sunxi-ng/ccu-sun20i-d1.c
@@ -104,6 +104,8 @@ static struct ccu_nm pll_video0_4x_clk = {
 	.lock		= BIT(28),
 	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
 	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.min_rate	= 252000000U,
+	.max_rate	= 2400000000U,
 	.common		= {
 		.reg		= 0x040,
 		.hw.init	= CLK_HW_INIT_PARENTS_DATA("pll-video0-4x", osc24M,
@@ -126,6 +128,8 @@ static struct ccu_nm pll_video1_4x_clk = {
 	.lock		= BIT(28),
 	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
 	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.min_rate	= 252000000U,
+	.max_rate	= 2400000000U,
 	.common		= {
 		.reg		= 0x048,
 		.hw.init	= CLK_HW_INIT_PARENTS_DATA("pll-video1-4x", osc24M,
@@ -175,6 +179,8 @@ static struct ccu_nm pll_audio0_4x_clk = {
 	.m		= _SUNXI_CCU_DIV(16, 6),
 	.sdm		= _SUNXI_CCU_SDM(pll_audio0_sdm_table, BIT(24),
 					 0x178, BIT(31)),
+	.min_rate	= 180000000U,
+	.max_rate	= 3000000000U,
 	.common		= {
 		.reg		= 0x078,
 		.features	= CCU_FEATURE_SIGMA_DELTA_MOD,
@@ -202,6 +208,8 @@ static struct ccu_nm pll_audio1_clk = {
 	.lock		= BIT(28),
 	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
 	.m		= _SUNXI_CCU_DIV(1, 1),
+	.min_rate	= 180000000U,
+	.max_rate	= 3000000000U,
 	.common		= {
 		.reg		= 0x080,
 		.hw.init	= CLK_HW_INIT_PARENTS_DATA("pll-audio1", osc24M,
-- 
2.35.1

