Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5BE512875
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 03:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240187AbiD1BHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 21:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbiD1BHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 21:07:34 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7F113DEF;
        Wed, 27 Apr 2022 18:04:18 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 3FE065C0216;
        Wed, 27 Apr 2022 21:04:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 Apr 2022 21:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1651107858; x=1651194258; bh=EW
        QuBrshtflaBYZQbOQftY716qHgPAQrgs5xYJD0PZQ=; b=B27RA3E11tPFjhXoZl
        BCXngJ4YKleJDrSbx28eZHU8/vEasIR/rNzdX+0YfcwNkYs22yPGBbBjNktJtMOe
        np3rp6oQ3OLLc5xXlLifCZV4CkCux2q0f0al1x1odNlZniJGqSzPV0YYSEf5Cz39
        a963ajqTtRnxiCeQh2vBRYypvbH0RCUaljLvXP9YoeHUDk3YG40CqnCyYGJikvuj
        AwQbtuMTLbrp7Nmq9PgSb50Dka2xAM6P1CLCurp5QzUpx7AGrq1mM/0LZXnDuW4d
        Y+KhLbeCOBWMMD8spVkuwdyfcAliYIpfwz68yOpsZyOCxuRFGecIyImrHLCoJoC2
        mo2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1651107858; x=1651194258; bh=EWQuBrshtflaBYZQbOQftY716qHgPAQrgs5
        xYJD0PZQ=; b=HN2J6N7ELnQR3Gy9fUmDvuEk9YlYKp9j7GPM2wWJGOlfvoLRYro
        qPxAJxQXaPAiCFUANedSSSTw6H7d23TRSskiqrtJ+sEsSBq3+a8XHJDBOcJoHFd7
        QUc0TV3p1g7bdK2v9lyV5qA9FcsV+xn8syFJQo8RdXd8iHf/C59/sp5DLVrRmomL
        RebZWUBp3uuLATt8lGTZRx4HRMUI5Fq9kxiLOcZ1BzlkB34tsPzHuND4M9OCPqEX
        gurem5f3Z/74dn2SHEMHIDVkSuqkdCTQJCTZYy8LRl3EV7SVB9z+2aXBkfyGcOtV
        Ve5zqxdiy/bGIjDnOBKmfMTMllDYbEaYB0A==
X-ME-Sender: <xms:EuhpYiffe1DAaWEuU_68hMUOBvbCoui-fcIL1RS2YG0nVIiGRlauZA>
    <xme:EuhpYsMpJWFJo0J0ehGz_Ii_rQr8oLWQsgQk9ozuccLjyIapi2z0cLOKXiFzGlszg
    eADy8XQY9N25tVVZg>
X-ME-Received: <xmr:EuhpYjhSfFHsGZ9OUA-7tBa6NWIdm7Icl5arTlUJOxHwV-VGhyRF1QzLUyiCCB8FIcTcUZrp5pCukFkB1F4bWpzEGG9_osOF49FghfEr2aP-_ZdGdojfqyBwn3eS2Uek5Q0Fag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeigdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:EuhpYv-9UAS85yEzxjAya6_MNmWfVVLGaDvoLZeI8-PENgg-cMupMg>
    <xmx:EuhpYuvDa-YXf4W-vmvlhT17qVRPnqantOu7Lb8H9GlVebkFWL3ilw>
    <xmx:EuhpYmEpctWVjsxcZdxljjMhExeISxNIc93WvPZSXSBMRyosXrkFWQ>
    <xmx:EuhpYqOvI53ClkFNLgbr8waNRaIs9DQ4WmvEDlRQaI5dyEhshxRHlQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Apr 2022 21:04:17 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH 2/5] iommu/sun50i: Support variants without an external reset
Date:   Wed, 27 Apr 2022 20:03:57 -0500
Message-Id: <20220428010401.11323-3-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428010401.11323-1-samuel@sholland.org>
References: <20220428010401.11323-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IOMMU in the Allwinner D1 SoC does not have an external reset line.

Only attempt to get the reset on hardware variants which should have one
according to the binding. And switch from the deprecated function to the
explicit "exclusive" variant.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/iommu/sun50i-iommu.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index c54ab477b8fd..ec07b60016d3 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -92,6 +92,10 @@
 #define NUM_PT_ENTRIES			256
 #define PT_SIZE				(NUM_PT_ENTRIES * PT_ENTRY_SIZE)
 
+struct sun50i_iommu_variant {
+	bool has_reset;
+};
+
 struct sun50i_iommu {
 	struct iommu_device iommu;
 
@@ -905,9 +909,14 @@ static irqreturn_t sun50i_iommu_irq(int irq, void *dev_id)
 
 static int sun50i_iommu_probe(struct platform_device *pdev)
 {
+	const struct sun50i_iommu_variant *variant;
 	struct sun50i_iommu *iommu;
 	int ret, irq;
 
+	variant = of_device_get_match_data(&pdev->dev);
+	if (!variant)
+		return -EINVAL;
+
 	iommu = devm_kzalloc(&pdev->dev, sizeof(*iommu), GFP_KERNEL);
 	if (!iommu)
 		return -ENOMEM;
@@ -947,7 +956,8 @@ static int sun50i_iommu_probe(struct platform_device *pdev)
 		goto err_free_group;
 	}
 
-	iommu->reset = devm_reset_control_get(&pdev->dev, NULL);
+	if (variant->has_reset)
+		iommu->reset = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 	if (IS_ERR(iommu->reset)) {
 		dev_err(&pdev->dev, "Couldn't get our reset line.\n");
 		ret = PTR_ERR(iommu->reset);
@@ -987,8 +997,12 @@ static int sun50i_iommu_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static const struct sun50i_iommu_variant sun50i_h6_iommu = {
+	.has_reset = true,
+};
+
 static const struct of_device_id sun50i_iommu_dt[] = {
-	{ .compatible = "allwinner,sun50i-h6-iommu", },
+	{ .compatible = "allwinner,sun50i-h6-iommu", .data = &sun50i_h6_iommu },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, sun50i_iommu_dt);
-- 
2.35.1

