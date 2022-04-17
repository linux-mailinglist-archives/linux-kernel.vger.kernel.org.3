Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BEE50460F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 04:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbiDQCTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 22:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbiDQCTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 22:19:15 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928873669D;
        Sat, 16 Apr 2022 19:16:41 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 0318A5C014B;
        Sat, 16 Apr 2022 22:16:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 16 Apr 2022 22:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1650161800; x=1650248200; bh=sw
        3vwnFAjqEPs+Y+Agbrwdr11Ajfm0FpDuzkylhvBe0=; b=FSFonIAEHL45Uxi01S
        UwRpCzE1/MA89qxKqi382jOqGn3eVEveuLm3pDMz/EPvWIZKW6EBbqcKpv4RfgwS
        ETaTZsRqeC2H8PTACH5dwvM+9AXdL1Zmve1etKFcIv42pCwx5MyDDCmL4/QsAnHL
        5/FDpQOJ3StHdYB8uBxjQFfoNbibM6bbH5gDwYvKShLl+wlrcGTL69gwsX+69PEI
        E3SfqvII3q/BFIfPMqPtL0+8dfzXny55Zw1EvY+TRvlQRyiApiVtQ+g+Pa4rjnOs
        1FQ0yEEyxroJUDnLfSwAziaNjuKUr8gSCqqK81PBGRZWtbKDRxahInPcjKnetLib
        uLvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1650161800; x=1650248200; bh=sw3vwnFAjqEPs+Y+Agbrwdr11Ajfm0FpDuz
        kylhvBe0=; b=wAR1dzEW8+5KTff30V4ycp6v+RTV3AYL/pKs0LH1TPYj89dPYDv
        uL0bnwqFRkVY3qhx9nsWJxcCXHOQJeUT6MI0iKtowxiQBnTv3lEfG8aGkR+R36Yn
        6TDH9HeSVDP/rFoEQnrwMdZvQAkHdnfKV+gVMQUDtCkJkyyOvwna6/VshtFEdoHM
        LyEEdN7QXsaxYv/dW0eMR3Hz2iPxPyBU74d4VTYPUB4YYCcxXwdQzV1uyYLy0iMj
        Eq3j/5qJnh0Tuon02QdKKpaYmkS3FApotHL5Vj5f202rSyK9eYxy6sCMXCsptp55
        cndE9El5sEwUuhh3SsUmGaBa1FqQ/nCzcfw==
X-ME-Sender: <xms:iHhbYuC1WUL8na1wtGUeqUmYRvodtcRgywuvT_P9afETJCbl_e9QRA>
    <xme:iHhbYojMDwzOxX2wgQ9VSfLlkM72fOyUv9l5smndNBhJK2qBXXcbRyFe2No_vBnsO
    Qs4B_0uZTQMTg8bUw>
X-ME-Received: <xmr:iHhbYhmePMmjlhiVuF5mg6QoTjr3HOvRQkjeTBVPilKKlR4_ldY_617s2s0ANtvxTPDUVHOOPGkmbEd3IuCowWfzXamf3LtZPNrfPqK0VDDNgtjbSpsjgeMdEk6s369B8odA4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudelkedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:iHhbYswyydbick2i_2vJwbO74bGoXhjEMf9UynPpoTHlgeCPVJzXog>
    <xmx:iHhbYjStoS_kqNdqoOOd6NuJSpboHjm-h6dny6YvBEif5S66pjiKnw>
    <xmx:iHhbYnYTSs7aHeIIj-yVSZxX6uKEZo1XyBtBtJZxjaiXg7Lr38QE9Q>
    <xmx:iHhbYiFTIKGVa8qPcCJwC5cyEMZrPifrenUtphRclvtN8jnraRa50A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 16 Apr 2022 22:16:40 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Ondrej Jirman <x@xff.cz>,
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 4/4] [DO NOT MERGE] arm64: dts: allwinner: pinephone: Add keyboard
Date:   Sat, 16 Apr 2022 21:16:32 -0500
Message-Id: <20220417021633.56127-5-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220417021633.56127-1-samuel@sholland.org>
References: <20220417021633.56127-1-samuel@sholland.org>
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

(no changes since v1)

 .../dts/allwinner/sun50i-a64-pinephone.dtsi    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
index 87847116ab6d..2fa1bdf8aa63 100644
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
+		i2c-bus {
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

