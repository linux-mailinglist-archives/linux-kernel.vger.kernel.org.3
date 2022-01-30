Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED7D4A3454
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 06:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349337AbiA3FiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 00:38:16 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:38555 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232760AbiA3FiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 00:38:10 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id E6F11580300;
        Sun, 30 Jan 2022 00:38:09 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 30 Jan 2022 00:38:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=VpTV5RkDfW1t8UkFiogIwxmcp2RPyw
        DB0L6j+1GUGP4=; b=mYfbObyd0FcNaH2wMi3AxreS2qu95YMJ4S8dL+Mz1oid+2
        DAxb5VPDe0TqAHuo+4s7xjJ+s2z3i6j/TX/AJiok2SQ8hRMBL5ADvb15wWNID/M2
        Y+NOW2C5W1Z7y6qLzac9d+PXz3zqkFShbkcLqLVxTDcKcfvTH1pgy0R4xlPoI7Wo
        7eOHXoKFVeU2jO9gU+jYfVJHfLreloU15nkZgbc5UHTJthxfa3V44hRD7tNG55ad
        6EF7Vn/3N3RxGGTfQMnWiuQ+sCzd1xoXW7FLlrEKlkkB8OTSVeDMggxcj1Hqjxf8
        8dndsiid1ZNdzHCXPJDGIVqkU4zMPA21pTx+iEgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=VpTV5R
        kDfW1t8UkFiogIwxmcp2RPywDB0L6j+1GUGP4=; b=QlDy/33a0hBOuD+49NoCaa
        DFpz/OYXgXgJ0rgM+doDgAWJBgWKcCDQRmCqPxxJljL5T/S364mNgLBNk9OVh1DS
        AvYEg5ig5z3dj8WhsbGTHfcmt9VDd1TJUXNfCn73/akvSuzD9tkPHY1Yz8bPIKgp
        gf1XWuvwOcICrfuhYmXPP6oT+7ZtPQa5tcUkYgNExwHGLlI/baUPG8IBjIBzT6Wh
        EW7yMhCAo6Z/pKni0WZSyGXNIqvmBLLcgMWPNvGzNm56wNO+xiaKlyKMKZeot4JE
        ielZYYgNFscfaNiusXBRBGtyIMeLsCxshw65nOaGtZXCaledL//UfasnFzjh9oTw
        ==
X-ME-Sender: <xms:QST2YcXgUYE_SI7NCS92xqmgVcNtMVd1N0Rl9pRqScnyHSwAWe9u7A>
    <xme:QST2YQnOX_PhEYo-Nji0O2BKvj-NK58BKT3-NOo6w2faSSvkkx_OXQcmLAyx40X3i
    Sn-7TIH8Y6pCqK_HQ>
X-ME-Received: <xmr:QST2YQYok2h4MoyPS5L0ITM6BGwPYA5IUg3LPlu3Y5n8CSw6-Jb7FlcyIX_PQXMJo9PkZ2SxU3qNQHrN0r1_6Ez_Joge5Iox1FzZOO9c9Pq6zbGf7Qt15d7qiIsYyn0QURo1dQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrfeekgdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:QST2YbXaCBsklsNUQV9bSgJSfAOrrp39iB9nZDRL9vOBa4pNZTeG5w>
    <xmx:QST2YWmBY0i3sKQHhGdwNP7HmhQJg1oc2DUyCZYfV2wuga1FQ1jXbw>
    <xmx:QST2YQcMVRQRbClzQ6rWo7bVskT-kE1Oa6F8u67z6I0x66o8BSZnhw>
    <xmx:QST2Yck7Vz6SpA3c0t_C4Vh0kcRS_rpyrPCdkIt4_LMLrbQkXy1xAA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Jan 2022 00:38:08 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Samuel Holland <samuel@sholland.org>,
        Alex Bee <knaerzche@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Levin Du <djw@t-chip.com.cn>, Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tianling Shen <cnsztl@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Subject: [PATCH 2/3] arm64: dts: rockchip: rk356x: Add pdm node
Date:   Sat, 29 Jan 2022 23:38:02 -0600
Message-Id: <20220130053803.43660-2-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220130053803.43660-1-samuel@sholland.org>
References: <20220130053803.43660-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rk356x contains a PDM microphone controller which is compatible with the
existing rockchip,pdm binding. Add its node.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index a68033a23975..f2f3cdeab0aa 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -651,6 +651,27 @@ &i2s1m0_sdo0   &i2s1m0_sdo1
 		status = "disabled";
 	};
 
+	pdm: pdm@fe440000 {
+		compatible = "rockchip,rk3568-pdm";
+		reg = <0x0 0xfe440000 0x0 0x1000>;
+		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru MCLK_PDM>, <&cru HCLK_PDM>;
+		clock-names = "pdm_clk", "pdm_hclk";
+		dmas = <&dmac1 9>;
+		dma-names = "rx";
+		resets = <&cru SRST_M_PDM>;
+		reset-names = "pdm-m";
+		pinctrl-0 = <&pdmm0_clk
+			     &pdmm0_clk1
+			     &pdmm0_sdi0
+			     &pdmm0_sdi1
+			     &pdmm0_sdi2
+			     &pdmm0_sdi3>;
+		pinctrl-names = "default";
+		#sound-dai-cells = <0>;
+		status = "disabled";
+	};
+
 	dmac0: dmac@fe530000 {
 		compatible = "arm,pl330", "arm,primecell";
 		reg = <0x0 0xfe530000 0x0 0x4000>;
-- 
2.33.1

