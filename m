Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4BD512878
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 03:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240282AbiD1BH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 21:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238114AbiD1BHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 21:07:35 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2681AD8B;
        Wed, 27 Apr 2022 18:04:22 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 59C645C0206;
        Wed, 27 Apr 2022 21:04:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 27 Apr 2022 21:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1651107862; x=1651194262; bh=pW
        /iSjCJy6f2Vv0EQ/XJtZJNRvKHgymrVop1mTD/+d4=; b=FrGZ3IwMEyxk0BjXNO
        Vn6EK3IZkTeZYX1nmAgh0L/6GXH09OQFz5khjVFhqRQxvkDQ8iDuC/qi1acgqZqw
        tv8WRkEfQ4AoTjTRlaN6NhaK0RhZo1oWrkSkFdGyas5kgvRGJfsHCpjhYq78DvPe
        609Tt9NTCeO4N4Zm+TxBjBv+YRMa+Ie+sePBHJka1zTa2CT01GJCMFlJV9lF4zqz
        uGaKapqLbcroSeG19fmO4qom2nOwvEZOPxDShOLWyntpjiqX6PH+QZXp1bbQNnyg
        Iq7zhzqcW8PI2A+NZF6EY8wccvQ+EHyzA+wRQBo0Slg0FHmm9LrX0FLyT4GujU64
        usKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1651107862; x=1651194262; bh=pW/iSjCJy6f2Vv0EQ/XJtZJNRvKHgymrVop
        1mTD/+d4=; b=mJfp/fEwio/wl6hdscLqZwCPe04Lu8yYNk6DvErXlKYQrQiGlil
        dtH8DNLmMB/e2xjTKRjqv/DxgQgFsbVkjeIDdg9TdA8MIEDnSZvRwArLL+/riO3P
        yIFXrAdNx0jorrx8hpPN+o7ZWq2ZWzPM0j+aAK/tSgXXKhLFnqNts6h4AUk98KUC
        HAQ0y7n607zCKnHuDK74hDqqBE0GpJdH37c6/Vdla+aKdBokMbzJSpDgqlML4Hu7
        oahEmPxd7qZ+tHqNg3PCInxvCAdVFsr4eCnN3hirg9/u2OhrWKUTJVgaH9uTSuCE
        4sLZmHvMPzTGGCwpF1xXzf1ZY5GbF66rsnA==
X-ME-Sender: <xms:FuhpYq0EZ0uZKl5xR_YXNiBCVJ6i6ZxKi8257WG1dtW1ASthe0MaqQ>
    <xme:FuhpYtGHgkZZreEXAGXhoRmHQcTbFMkwVes6T-yuSMZ2_3BjxDDlSKReDfPq4eGtQ
    4-xZWJ6KAAJAdDyiw>
X-ME-Received: <xmr:FuhpYi7ypbVtND9R0bjH6s6mnQHQS_hCH1Y0-_t1VKoCku5sAZdImsO-kcHTca-E0AI3OWmmA_Y02HcufFmu3VRhKTWsgb3GKDrdIkovgoMcXKrfEQCyZ7pvaSKvMQM6CBx7yg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeigdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:FuhpYr3diNoK6jg3AVunpqPYUeYJqwGsGLmMEvvL3BLsmCGahaGAZA>
    <xmx:FuhpYtH7_Y9s7kJNLTNaVP3OL7_PTyrChjaRu3h0Ue7-XqW4ZDMMvw>
    <xmx:FuhpYk-a9GL8Z6J72ariS91YzrmcOyFbbpVons82YM8BTnuYK7KdOQ>
    <xmx:FuhpYvGQDdk5fOER4xo_VaXjotqiTRriv4oCud3RLOqI_7M0QDhaAQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Apr 2022 21:04:21 -0400 (EDT)
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
Subject: [PATCH 4/5] iommu/sun50i: Add support for the D1 variant
Date:   Wed, 27 Apr 2022 20:03:59 -0500
Message-Id: <20220428010401.11323-5-samuel@sholland.org>
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

D1 contains an IOMMU similar to the one in the H6 SoC, but the D1
variant has no external reset signal. It also has some register
definition changes, but none that affect the current driver.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/iommu/sun50i-iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index b9e644b93637..1fb707e37fb3 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -999,11 +999,15 @@ static int sun50i_iommu_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static const struct sun50i_iommu_variant sun20i_d1_iommu = {
+};
+
 static const struct sun50i_iommu_variant sun50i_h6_iommu = {
 	.has_reset = true,
 };
 
 static const struct of_device_id sun50i_iommu_dt[] = {
+	{ .compatible = "allwinner,sun20i-d1-iommu", .data = &sun20i_d1_iommu },
 	{ .compatible = "allwinner,sun50i-h6-iommu", .data = &sun50i_h6_iommu },
 	{ /* sentinel */ },
 };
-- 
2.35.1

