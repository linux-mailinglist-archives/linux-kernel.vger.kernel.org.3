Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1236F4A7DD2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 03:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348997AbiBCCR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 21:17:58 -0500
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:59207 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348961AbiBCCRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 21:17:55 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.west.internal (Postfix) with ESMTP id AAF1F2B001B1;
        Wed,  2 Feb 2022 21:17:53 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 02 Feb 2022 21:17:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=bQzz0YJg4cl1SXyRkVE6RCatDPM1bV
        hWbX8cgs4xCtk=; b=gHew6L0ZosFtcXtsY0jYitfuVA2WaRrSDcR5yuix5avHbE
        /scXuMRoMVgcUmI2xl+ivS3OWZOh2qjGYwuc7gV1DBxNItm6olTdAHfwW4Q8Yobm
        62N+otLbmilTgvSzGxr7BcKId471q0l/9zrsVQ9GX9X1g3iqzzyq8QPWOZYOSbz2
        cainy6yV72W3hpbPiGhh6Sx/b30Cx8hngYYFyngcPmNDfle4qZzW9M6q2BwddcF7
        qMwmo7K2jTnAoKVK6QM99MAt16J8SJywdG1wNC3ajXoEJW2EW3P1mXNEBanjbwpx
        K6tVJ8V4ox+wewk3cKUXVrDSir+OaJMs/1DNP2jA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=bQzz0Y
        Jg4cl1SXyRkVE6RCatDPM1bVhWbX8cgs4xCtk=; b=TXWm+UCasrUBwjxoT4RkwB
        XuckYJSMt/jl7HbhMMUVkltejxCqrcTFBTh591zDKtRzzlyAEvhcdzGhmZwVnkt4
        LHbgoUss0o0XBP4VCv+30J6i9zQPwqJO5aIHzA5IBI+PoRZHsCMmNX3xVO2kF2c/
        TfQHdCyEw23Fhb8Gvqkzs398QfbpXoutu0zFsV83J7kHAocXs4Tp0gf1nrSs1jI6
        ZSTyyGvV2LL5lgC2OW8rQnm0XcGg+IfmzyUq0Kh4dNx1b1DFUIXd6T5MBPz1NMGH
        cV/vectphS7nSWgESO43kKe2X4kc59cxssnhPNwTGshP6cKOIaC68D44UhuVay8Q
        ==
X-ME-Sender: <xms:UTv7YZkntX7KzYrQxk9XdlpCxp8w2JejyXYik0VvSl_ijk0wMmUSYA>
    <xme:UTv7YU1utyugHVImGeOjERUICO_ebt-eUehv4j40GvGR0NBdGq9NEATshDAPM8ZKP
    iFzD08D6TotUhPnQA>
X-ME-Received: <xmr:UTv7Yfp8j9ZQG9h3vNt9Jqq1oCDXf6y0h9vJ_sVkJzdzDmvAAGqH8BfPw9KblRM5z1q-tCppmBx9FwJO9D3kar0lSCE4Wxxsx6bJPrdxaqYojQycR-0dmgsjGRyfdg4MC5b1SA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeeigdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:UTv7YZk-vIwvbxIToYMla7xxOmty55nB5aMSY1SaV9WTrCictdmILA>
    <xmx:UTv7YX3hs6tJzsQUitD4cOho4qKoCmSXoyVRyBp4XLg3GPF2p8Y5Ew>
    <xmx:UTv7YYvsT37Ib49vVRC9s5QJ1ocsowAsSQcwTBVWFTJXrvSEaHFJnw>
    <xmx:UTv7Ye1KHg6gwgcLF7zmnDkbkzvry9cwQbx1cog0TbnloT7yg7neEM5nX-A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Feb 2022 21:17:52 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Michael Turquette <mturquette@baylibre.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 4/6] clk: sunxi-ng: mux: Allow muxes to have keys
Date:   Wed,  2 Feb 2022 20:17:34 -0600
Message-Id: <20220203021736.13434-5-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220203021736.13434-1-samuel@sholland.org>
References: <20220203021736.13434-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The muxes in the RTC can only be updated when setting a key field to a
specific value. Add a feature flag to denote muxes with this property.

Since so far the key value is always the same, it does not need to be
provided separately for each mux.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v3:
 - Drop the SUNXI_CCU_MUX_HW_WITH_KEY macro, since it is no longer used.

 drivers/clk/sunxi-ng/ccu_common.h | 1 +
 drivers/clk/sunxi-ng/ccu_mux.c    | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu_common.h b/drivers/clk/sunxi-ng/ccu_common.h
index 98a1834b58bb..fbf16c6b896d 100644
--- a/drivers/clk/sunxi-ng/ccu_common.h
+++ b/drivers/clk/sunxi-ng/ccu_common.h
@@ -17,6 +17,7 @@
 #define CCU_FEATURE_LOCK_REG		BIT(5)
 #define CCU_FEATURE_MMC_TIMING_SWITCH	BIT(6)
 #define CCU_FEATURE_SIGMA_DELTA_MOD	BIT(7)
+#define CCU_FEATURE_KEY_FIELD		BIT(8)
 
 /* MMC timing mode switch bit */
 #define CCU_MMC_NEW_TIMING_MODE		BIT(30)
diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mux.c
index 2306a1cd83e4..1d557e323169 100644
--- a/drivers/clk/sunxi-ng/ccu_mux.c
+++ b/drivers/clk/sunxi-ng/ccu_mux.c
@@ -12,6 +12,8 @@
 #include "ccu_gate.h"
 #include "ccu_mux.h"
 
+#define CCU_MUX_KEY_VALUE		0x16aa0000
+
 static u16 ccu_mux_get_prediv(struct ccu_common *common,
 			      struct ccu_mux_internal *cm,
 			      int parent_index)
@@ -191,6 +193,11 @@ int ccu_mux_helper_set_parent(struct ccu_common *common,
 	spin_lock_irqsave(common->lock, flags);
 
 	reg = readl(common->base + common->reg);
+
+	/* The key field always reads as zero. */
+	if (common->features & CCU_FEATURE_KEY_FIELD)
+		reg |= CCU_MUX_KEY_VALUE;
+
 	reg &= ~GENMASK(cm->width + cm->shift - 1, cm->shift);
 	writel(reg | (index << cm->shift), common->base + common->reg);
 
-- 
2.33.1

