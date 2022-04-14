Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7F55002FE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 02:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239175AbiDNA0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 20:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238784AbiDNA0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 20:26:19 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37BB1EEC7;
        Wed, 13 Apr 2022 17:23:56 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 417705C02EE;
        Wed, 13 Apr 2022 20:23:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 13 Apr 2022 20:23:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1649895836; x=1649982236; bh=sm
        LbHwGYtdmSDiKEj6LIJXKXjSMVo9Cyx4CzsqmRG0s=; b=kVU7oOEndcoeC/wDNm
        WIG/OFvtDRkrJgXrlDD5gXDjHyQrsgmbMR/lpl5pvOwp+5pDnVf+xMIeAkvNesWC
        Lo/gUVyS1SHoWT4EbbENN3anlwolpci1F5EzpCnTQJFYuk3u0rUrr/73qdHCChOk
        JM6oKIP4JZ9Ez2PLe76sJ78Wg6I3iJPujTfv/dbAzcuvjMX3Jy7b7rvaeouZ+u0c
        iyfDjfXTxOpFITa86oUWKwXkDJzvaY31nCDIWNDmbFZGpd8gJokDvltKy+O9AIWO
        c1bDLLcVXBZWbntMwGBNocCCsf2V53n955SwaC0YxJSVW73uS6F0wR6x0HHbdIr6
        whzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1649895836; x=1649982236; bh=smLbHwGYtdmSDiKEj6LIJXKXjSMVo9Cyx4C
        zsqmRG0s=; b=rmD1yK6cd4LWEVBuWox9ngsZHkdSQWVFAXL2oaHNOYu0i8DE+0l
        +Cu51dE8lNsPimZ5w7reuORkr8m3nWrwke86WuAgb0qlbOZVQ1iNvMXH9FH/NHdh
        EOtjdHSkbiYTj1RJoooC1z494h6+M/6XlTjOktW6AK1ph9XlZhQLDXs0LkEPBGwG
        bNCprVgUgyxZTYRWx66l5Lwl+RFAmITGdAFwyZdKU8lQxixhq8pBEWOSp+4Za1oB
        xMyuX8aKw0r/LvjUR3hAsiXXTxn7m6aDIC8S637/sEwzlGYeFTNCf8GwCxgMFNFh
        YA6Xlj5824Be1pI44rSqR3TF9bkZdQieA5w==
X-ME-Sender: <xms:nGlXYlNoYk8ekHvip2zcMCil9vz4QpEkCYSIyd0EMb_xBh_t8BYmNA>
    <xme:nGlXYn8ZG6UlyeaIDETDaqSuV-cvkUuiRkn8o5nR3Z3hTj5MwQXgwRuhp27H0rT3j
    YY9TGBUL7XIMoi4jw>
X-ME-Received: <xmr:nGlXYkRN5j_73x3cNeO2qfRTgFqOwEnmgSet7webjBX9APVPQAR4AvvE4eXor-jhtCE_WU6F6a35B0OSheOu4GLCS6w1YAI8_O_1no6SoaEiSZhcRSrvF8xMF1QIEB1KJSU-vw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudelvddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:nGlXYhtqDZblmr2p7G6eMrCubgAp6wZH6Nhgvk8UsgLXfl7GFk7Ggw>
    <xmx:nGlXYtczMmjFFvqQecxrp-y3UDsHIaWL4uFhlmvmmMzYkYGtjcoFOg>
    <xmx:nGlXYt3YDTWCut6bLWoMJ4TGmhGkBWd0sUI32_OlacRxmPuZvcvhRA>
    <xmx:nGlXYg8Z8-svXgySNVU_kIBs_pK9pJz7ZeIGKDGFALFKnTvSpDrMnQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Apr 2022 20:23:55 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH v2 3/3] Input: sun4i-lradc-keys: Add support for R329 and D1
Date:   Wed, 13 Apr 2022 19:23:48 -0500
Message-Id: <20220414002349.24332-3-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414002349.24332-1-samuel@sholland.org>
References: <20220414002349.24332-1-samuel@sholland.org>
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

This LRADC variant uses the same 3/4*AVCC reference voltage as the A83T
variant. The R329 and D1 LRADCs appear to be identical, so D1 support is
accomplished through having the R329 LRADC as a fallback compatible.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v2:
 - Set the new flag for the R329 variant.

 drivers/input/keyboard/sun4i-lradc-keys.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/keyboard/sun4i-lradc-keys.c b/drivers/input/keyboard/sun4i-lradc-keys.c
index 5630334a6c09..8f9bfb05244d 100644
--- a/drivers/input/keyboard/sun4i-lradc-keys.c
+++ b/drivers/input/keyboard/sun4i-lradc-keys.c
@@ -78,6 +78,12 @@ static const struct lradc_variant r_lradc_variant_a83t = {
 	.divisor_denominator = 4
 };
 
+static const struct lradc_variant lradc_variant_r329 = {
+	.divisor_numerator = 3,
+	.divisor_denominator = 4,
+	.has_clock_reset = true,
+};
+
 struct sun4i_lradc_keymap {
 	u32 voltage;
 	u32 keycode;
@@ -323,6 +329,8 @@ static const struct of_device_id sun4i_lradc_of_match[] = {
 		.data = &lradc_variant_a10 },
 	{ .compatible = "allwinner,sun8i-a83t-r-lradc",
 		.data = &r_lradc_variant_a83t },
+	{ .compatible = "allwinner,sun50i-r329-lradc",
+		.data = &lradc_variant_r329 },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sun4i_lradc_of_match);
-- 
2.35.1

