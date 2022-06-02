Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DD253BD74
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 19:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237628AbiFBRmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 13:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235980AbiFBRmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 13:42:39 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81C324444F;
        Thu,  2 Jun 2022 10:42:38 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 9921432007D7;
        Thu,  2 Jun 2022 13:42:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 02 Jun 2022 13:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1654191757; x=
        1654278157; bh=sdCSDnTwZq4cKIMvJzFEUcWYJ3lEuGnemhaFysCn4Yw=; b=h
        m5aaRDeaBuxkLWm2i4Nl+cUCfkn1NntvvL0E5qNsGUiDuFUx8q1oKwV3OIB6YSaa
        tZ/ln6iH3Osjx1KLtWr7G+r/A3E1gupNMi9xRmMOmWAXotXWYjO/PAjhhUYKX2AD
        IvAzEXMByfBx2OEVLxFmFplqRPKNDaMGHP6ze4B5eBE6EGuDYxiWHazWvq2Nf1Ji
        m/yPT9zqLrg5ZjZ5NfjsmoASDBFoMNLy+W06HK/EMWTNIV957DvBXqHV2PcTcs84
        2PZWSRgc6DTNfZmgb70uOok2eBtD4ykkTZAY5NXcJ6Mbhx79KqMB6SztG8J4oFrQ
        9uhICn0oOVnbwaWM2mkgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1654191757; x=1654278157; bh=sdCSDnTwZq4cK
        IMvJzFEUcWYJ3lEuGnemhaFysCn4Yw=; b=qkhRJqAy0YW0NayKJJvWEw0OXxR32
        sOCEPBATJVW04XZ/8sZ6DNMJR671ZQNI7mpZk277LcknyW9STZwmVjlpM0gefjW+
        ysZFwN5GBR5somBKd2lkK/5Yj3aTNYP+H2Nsxl/11tzJeEP/gluY9pefF4xJUmPk
        X388jSjI4spjKNzBThWJUSfRhlqoEAmjT5YYqweu3fB+xeqhgi06rZmV6ynZZOzG
        QDFm77/urOPYPjuXtM0dq+O+fi3wMmxRzMBdeJkhQAeIUs0yLqq4cIKX2jV48ROo
        y6MgMw+/qKMpwsaVoIVv/TCuZi/XVRvdLyKGbditW+uP4Ull0bS4b0nbQ==
X-ME-Sender: <xms:jPaYYm-yY35ccxlHbv2evNYSGFeAqvrEZL_CwdliXUvpt0Oz7Uf6aA>
    <xme:jPaYYmvPDGtPZn-JiZmWn0nWQhhUuvbj2ggR3C7rk6HQ5A4kDzQcc8P3u1J__6gzy
    -tPM3yzY0O5kcBMhbk>
X-ME-Received: <xmr:jPaYYsDK0g7tKE3RRIhK1Gog6yvnALLATSpAfNENUq54c2wmIeRANfSZlvwhcIB1as8RTWSx1EhijulA5raI5X4F1vG7AMU5cDB9zjLDCDBKp9Yp5I-KlCyZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrleefgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnhepjeeiheehkeegvdejhfevkeejgfdutdefhfethedtieffleekieeuudefleekjeeg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:jPaYYuc_zF-ez0TwkLSbX5mrzQcRPUCcQ4DFc2yrpKOqyNN8fQNSTg>
    <xmx:jPaYYrODmMJGoEPohgztmauhSBrhVfM2uQywWmg8mwZqt4GS7EbNMw>
    <xmx:jPaYYomBLQU5njWG9QnJi9PE0pZxzlCA_pCuEeuc59g9r1Fq7UTUhw>
    <xmx:jfaYYmcKxVa0J_O5DEATjON7tyDE6JYNkntzpeIiheIvN-zqluIM6A>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jun 2022 13:42:35 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: apple: t8103: Add ANS2 NVMe nodes
Date:   Thu,  2 Jun 2022 19:42:13 +0200
Message-Id: <20220602174213.2737-2-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220602174213.2737-1-sven@svenpeter.dev>
References: <20220602174213.2737-1-sven@svenpeter.dev>
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

This allows to use the internal disks attatched via NVMe.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 arch/arm64/boot/dts/apple/t8103.dtsi | 34 ++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
index 9f8f4145db88..51a63b29d404 100644
--- a/arch/arm64/boot/dts/apple/t8103.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103.dtsi
@@ -378,6 +378,40 @@ pinctrl_aop: pinctrl@24a820000 {
 				     <AIC_IRQ 274 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		ans_mbox: mbox@277408000 {
+			compatible = "apple,t8103-asc-mailbox", "apple,asc-mailbox-v4";
+			reg = <0x2 0x77408000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 583 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 584 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 585 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 586 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "send-empty", "send-not-empty",
+				"recv-empty", "recv-not-empty";
+			#mbox-cells = <0>;
+			power-domains = <&ps_ans2>;
+		};
+
+		sart: iommu@27bc50000 {
+			compatible = "apple,t8103-sart";
+			reg = <0x2 0x7bc50000 0x0 0x10000>;
+			power-domains = <&ps_ans2>;
+		};
+
+		nvme@27bcc0000 {
+			compatible = "apple,t8103-nvme-ans2", "apple,nvme-ans2";
+			reg = <0x2 0x7bcc0000 0x0 0x40000>,
+				<0x2 0x77400000 0x0 0x4000>;
+			reg-names = "nvme", "ans";
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 590 IRQ_TYPE_LEVEL_HIGH>;
+			mboxes = <&ans_mbox>;
+			apple,sart = <&sart>;
+			power-domains = <&ps_ans2>, <&ps_apcie_st>;
+			power-domain-names = "ans", "apcie0";
+			resets = <&ps_ans2>;
+		};
+
 		pcie0_dart_0: dart@681008000 {
 			compatible = "apple,t8103-dart";
 			reg = <0x6 0x81008000 0x0 0x4000>;
-- 
2.25.1

