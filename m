Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066CD55063B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 19:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237081AbiFRRF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 13:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235146AbiFRRFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 13:05:52 -0400
X-Greylist: delayed 474 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 18 Jun 2022 10:05:50 PDT
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9F313CC9;
        Sat, 18 Jun 2022 10:05:50 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.west.internal (Postfix) with ESMTP id 2A0382B04FE1;
        Sat, 18 Jun 2022 12:58:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 18 Jun 2022 12:58:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1655571487; x=1655578687; bh=9L
        3nOLIP2wnDF3yh647i8HoUyhJh7T1SGaF8cyhW3i8=; b=kMqhbG5O1YT1vNLiKN
        CpFINUOZyyk7c9rud9wThSXauKdGW6DZELCKi4Sy2ed3/ZHamjfc8PU3OWQCNMAJ
        rvlBSathSYJUFqGzNOI2zK7ulWHNWbQD6DmVS/VO+ztYddSXlYyen4hKd+GH3r9S
        qlEWqbkGi8fy518cWlZKwdOwrgXBnSs0nlJz3fkXDBcM/t7fz0z0dHhExoowZ58/
        kYMaBcvgUY61zI0GleKSIyeOeL/TbahGMhtSLxjpoGvFqiPUS1GSKnOyHo+JcRcs
        Y4A8uypIY8fl7Aod2XyALVTolW89V67/6HjvGM53N/Tvpu6V4pdhwuKHPx9BXDt6
        bmnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1655571487; x=1655578687; bh=9L3nOLIP2wnDF
        3yh647i8HoUyhJh7T1SGaF8cyhW3i8=; b=WvYschwOCfWwxaRI9poMPaD+j9R06
        MhASiBhUshkqdhiV2vnRaIjymIpYlHV81STpE7szNEiqjRLMCab4fxWATkS0RBsH
        9jnR9S6wllMRcqEl1yI00rRm+FFcCXFDSn7js4qN73ul9kg9nVXP0fZoGVXtkQXE
        ELInEw5AMQ9xc/PZ5TPo5IUIPIRv/s7MFYpkKd3TGvZPitB2lw9JSOMzr+TwVoZA
        uaH85opmiGoCfvNEX9opvENDq2EH9kH+jqS+UmuzOkI/Wt1t73gAj1xFS/2zvBwo
        O78/tqkA7wEaFQAJdEtAcw7WGGSem9+VdqUch6FFD+gIG4VhJZ+RwSNvg==
X-ME-Sender: <xms:HwSuYigJzljSkhvMzExB-cNiscsC3CXUcMoHRHrc9wpFiPsIIbqltg>
    <xme:HwSuYjDyyVQC247nlS7O0HwyxwguDQl4Lztu4WTMGluLUmHImOwqyNUNE7W6bFw4Y
    Xa9MMPYtPLrGE6VHg>
X-ME-Received: <xmr:HwSuYqGWM2WM1Y4wlfT9OxhHavBHA96rn-9C4lfDtom2aaVDPisw-8NaSFpF9nUkgcACfTE_9B7s_eW6m2r9U7bbI0WC0kqtjLrM8pxl6Eq8vRpKdS3DfAgStd0e4TmUZeO8Nw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddvjedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeeh
    gfdufeeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:HwSuYrQ0my8Ri9IhWZMPIpBH_M0cC5kfKnMb02jyu61OpAVQjf4frw>
    <xmx:HwSuYvzsoqC7LrnxLfDPLqBGcDttWcAzgbvhhT5MWp8UC02Kw0dWxg>
    <xmx:HwSuYp7rf0cyXz1yLlfoDYtK7CkJttWV-bC1W6CM8SD11k3byoXGGA>
    <xmx:HwSuYgER_ARs0fjcJ_Zrya0-b_3IBtzlZo5RdA3bJ7qYWx63aBHtk-Je9wc>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Jun 2022 12:58:06 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Ondrej Jirman <x@xff.cz>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Colin Ian King <colin.king@intel.com>,
        David Gow <davidgow@google.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        "fengping.yu" <fengping.yu@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH v4 4/4] [DO NOT MERGE] arm64: dts: allwinner: pinephone: Add keyboard
Date:   Sat, 18 Jun 2022 11:57:47 -0500
Message-Id: <20220618165747.55709-5-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220618165747.55709-1-samuel@sholland.org>
References: <20220618165747.55709-1-samuel@sholland.org>
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

The official PinePhone keyboard accessory connects to the phone's POGO
pins for I2C and interrupts. It has an Injoinic IP5209 power bank IC
connected to the keyboard's internal I2C bus.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v3)

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

