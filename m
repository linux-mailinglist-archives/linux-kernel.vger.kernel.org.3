Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3851E4FEDF7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 05:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbiDMD6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 23:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiDMD6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 23:58:40 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB85B13D0F;
        Tue, 12 Apr 2022 20:56:19 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 10F8C5C0221;
        Tue, 12 Apr 2022 23:56:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 12 Apr 2022 23:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1649822178; x=1649908578; bh=DR
        oSY913xLuSIgS0hpRt0oFFyqY1ftnUzoS1QKfxFI8=; b=D//iJPycP/eXFSA4Ic
        0Eheb7Q7lYql9Svq2vMsZ07sfLMIZZhp5tbyQZtezi5qofATByQb2KhOi0q1Ue8q
        2rWAWRviPnUIHZMOMglCeAYc8EFgmOpynXoQAZPLW+ccLp+rJRJLko4BMtinGtmc
        HFBHfmAhjHcStdJ5tt3dqenEL5IwM3F9/dRgFBtdILfxR6thYBzlPWkW4bshP2vw
        cBy9ykTExAyco8HaJdoUzzXBhO/Kkg4bYgN9WMQxkb0bOalnNXBUa8mvrQgCy8ek
        U8j0QUewzTi4QOq3+aPGQnshqN2iXIz/qclKPKtiP4gv50k/laKh7DpptL1ATB72
        vIDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1649822178; x=1649908578; bh=DRoSY913xLuSIgS0hpRt0oFFyqY1ftnUzoS
        1QKfxFI8=; b=dt4eKKO7JGpWiK9+mDPeKT+ENEXgk6WafsrbpgTxtIbT6MvSYxQ
        EkTFZDkwUYgYMGrwV+ey/j6Ji1zhniDd5PArroJ+IkKJ45GFXp/KPSS+Rm5kLMpN
        w94XfplV1gc9k8vTWiSetOdCierzpLdnfqM3tghN0zyK4sODLsuVgDacJDhnY+xD
        ft2Vypjwy83PL9LOVx6Xlt7gdzX+fbwtCW4eeKOwa2lY+RDL1phXqZK4WivqGiGk
        eGc9seilZl2VSCi/WlNIMKgymUrD4nZl4tFK9cnR/O2a1YsIDOwbIl895MMdmtau
        y8mrHDVUpjgmk04H6dHznOx3znChHnDNMtg==
X-ME-Sender: <xms:4UlWYkQKpVZ3uYjVePjVhoegpQQJaTzVwLfvFnuxBXIAsG6AWVe7Cw>
    <xme:4UlWYhyTJOL2gfNsCcOznmwDiLVCEBpxazWbmv_bjlYHHPl48q-U2LMFgmPgCsgG7
    qTab0_ZOS_Z62UOEA>
X-ME-Received: <xmr:4UlWYh0j7gLYzis1jUv754QTpSNYoN35JzOLWOjfTOLfJ18kHMavjnPasrAEEK4r2CeJ9Xwg1ZTthDERb8m1A-bH_9HtEqCyAEVTR3293Kusqpr1pJHEsNB9KUK_upxHFxy0cA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekledgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:4UlWYoBtkPyYzLh1O8JzOcTL56jGYyyYP9eXHcsjKk8RCqHVf13alA>
    <xmx:4UlWYthjI3q7kN3XTaI0_mXQZIlqjVJF4j5TcGQCtUB1hTz7ZaU7vw>
    <xmx:4UlWYkovzKjetQbjbo-uc9aB895FZkAxnO4Py6weZjtOAihUzihuwQ>
    <xmx:4klWYoWIORw8diZ-3SilCXxqPdeOifNr32OMs5lMaKj5oP7jKWIE_A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Apr 2022 23:56:17 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: rockchip: pinenote: Add accelerometer
Date:   Tue, 12 Apr 2022 22:56:13 -0500
Message-Id: <20220413035614.31045-2-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220413035614.31045-1-samuel@sholland.org>
References: <20220413035614.31045-1-samuel@sholland.org>
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

PineNote has an SC7A20 accelerometer connected via I2C. Enable it.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 .../boot/dts/rockchip/rk3566-pinenote.dtsi    | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
index fea748adfa90..adc0e7d39fb3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
@@ -468,6 +468,22 @@ led@1 {
 	};
 };
 
+&i2c5 {
+	status = "okay";
+
+	accelerometer@18 {
+		compatible = "silan,sc7a20";
+		reg = <0x18>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <RK_PB2 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-0 = <&accelerometer_int_l>;
+		pinctrl-names = "default";
+		st,drdy-int-pin = <1>;
+		vdd-supply = <&vcc_3v3>;
+		vddio-supply = <&vcc_3v3>;
+	};
+};
+
 &i2s1_8ch {
 	pinctrl-0 = <&i2s1m0_lrcktx>, <&i2s1m0_sclktx>, <&i2s1m0_sdi0>, <&i2s1m0_sdo0>;
 	rockchip,trcm-sync-tx-only;
@@ -482,6 +498,12 @@ &pdm {
 };
 
 &pinctrl {
+	accelerometer {
+		accelerometer_int_l: accelerometer-int-l {
+			rockchip,pins = <3 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	audio-amplifier {
 		spk_amp_enable_h: spk-amp-enable-h {
 			rockchip,pins = <3 RK_PC4 RK_FUNC_GPIO &pcfg_pull_none>;
-- 
2.35.1

