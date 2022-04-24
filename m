Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9F150D318
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 18:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbiDXQI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 12:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbiDXQIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 12:08:09 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA56334;
        Sun, 24 Apr 2022 09:05:09 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id B38AA5C0107;
        Sun, 24 Apr 2022 12:05:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 24 Apr 2022 12:05:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1650816308; x=1650902708; bh=0J
        bi/ZnVf6vIyll9pNxOYAmjLJ95kCyVCsOJ7za8xEE=; b=AdLvEytCeqg5ayMLNV
        kbMdE91xa/+pBtqXh5joMG4LI680YGPa8iK06FW+fih5AuorL67pknUIvGXtm9kY
        ido5WuZmqKSPvJUrlOeP0xR7Thw7eGmGL2A66DQgoqFoVMliX3eWs8PnjPL2CVHc
        knrH0JCRJlYAzTTj925LCxKxGJiOXuK5a6Zy4KDVZssD4De1xIGpV4LvFwOAZ94X
        Xbqjtdb+IJ6GaHQPa2Lavs4c+FsfhoIBaqnKrrO2r0KkNUwdU7NeW/dSS5Q+uUae
        9cxcf7Af22dnz8/PzynV5N/Z6fqXHpJbpkPusIaRVVU89pTcF8g2KuCvgdvc4s1J
        qkNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1650816308; x=1650902708; bh=0Jbi/ZnVf6vIyll9pNxOYAmjLJ95kCyVCsO
        J7za8xEE=; b=qXJr1UL65/woDgSwYtU8ouPy++pCSy0SRAo3amrXrYN0VgYv/6q
        CK41f5AJO/C69/0dErWiRpN9co/nzVpJdRVfsBMy7QI+xAjjJTRTrSgZeaDjpo2C
        fRpBKeUxGxfShznq1IeJllgTHzYDXV0HvSYWrScP1HLvoVo7MSlLH30orx5CoJrL
        pfopt8uewRyMzxXlQ45YnF6W5miOUcQxZy3bRyK51mnQw5qbtZR4u7mlCbj3+/pG
        qwnZu0VQ+F9mNTNsRN9e9d2AoDOGjI82v4vI66IRk01px/Jzxqg+SxsNIXewosq5
        BAr9AihdbI4sj23Ss623JV8On+ZT79h509w==
X-ME-Sender: <xms:NHVlYhRNFQwvvPwJZZaQ-Owyb6KjE7Wp8afyrMpI1kVmsFQPZqt2cA>
    <xme:NHVlYqzlt_b6Uwv8fITWxyzVdbtLhRWUSpZARxJ_FlVuLQadO7Bqd2NicOFq2abDd
    Dz24mJV0ja3BWMTaw>
X-ME-Received: <xmr:NHVlYm2qlR5JxjiTKHrIuVR9048mCxn5C3XNIs7sMfLR6yb0rOmX_c1FmhiWhdKR5cmyQ7TeTmRyF4W1mi8moKDR3XXCeJWzBkjsCyvLIopmCZqwGJIpEnHyzT9yCHXcgbXGsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdelgdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:NHVlYpDqNmQIkTta8itxEmrB32HBRFG7avLYPix2OX4cJpGT4xeSRQ>
    <xmx:NHVlYqgDI1sM_778-sNzd6oFspyb8SklIRjZIO3MCX_uqjAe2MxBOw>
    <xmx:NHVlYtoa-NL325qoeaU44pFok7LrspcaiQYSs5uABVd909VMT8HstQ>
    <xmx:NHVlYlUfgFTuljxbN07loD5PPHg7T4h0-pgwiIUBR4_w2SrJgBjkzw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Apr 2022 12:05:08 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Ondrej Jirman <x@xff.cz>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 4/4] [DO NOT MERGE] arm64: dts: allwinner: pinephone: Add keyboard
Date:   Sun, 24 Apr 2022 11:04:57 -0500
Message-Id: <20220424160458.60370-5-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220424160458.60370-1-samuel@sholland.org>
References: <20220424160458.60370-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The official PinePhone keyboard accessory connects to the phone's POGO
pins for I2C and interrupts. It has an Injoinic IP5209 power bank IC
connected to the keyboard's internal I2C bus.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v3:
 - Rename i2c-bus to i2c

 .../dts/allwinner/sun50i-a64-pinephone.dtsi    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
index 87847116ab6d..1d757cce246a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
@@ -208,6 +208,24 @@ accelerometer@68 {
 /* Connected to pogo pins (external spring based pinheader for user addons) */
 &i2c2 {
 	status = "okay";
+
+	keyboard@15 {
+		compatible = "pine64,pinephone-keyboard";
+		reg = <0x15>;
+		interrupt-parent = <&r_pio>;
+		interrupts = <0 12 IRQ_TYPE_EDGE_FALLING>; /* PL12 */
+		wakeup-source;
+
+		i2c {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			charger@75 {
+				compatible = "injoinic,ip5209";
+				reg = <0x75>;
+			};
+		};
+	};
 };
 
 &lradc {
-- 
2.35.1

