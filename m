Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E687257F8F4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 07:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiGYFRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 01:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGYFRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 01:17:21 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97D9F5A4;
        Sun, 24 Jul 2022 22:17:19 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 686DF5C0097;
        Mon, 25 Jul 2022 01:17:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 25 Jul 2022 01:17:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1658726237; x=1658812637; bh=0fgmiotfvvA25BECvdY/7miKV
        B9hRcyaay/R6+d4lYA=; b=UTFtUC5dSKiyDoScNweUNf1i2QR4PIddEUzLmnzUy
        7fWzyyF4adFU1TPhBphdvZpAf/+Fxp8uGS3dSygeq/VKRO5OrWCPDDespbc+xiWT
        d+FsoRUQiIYboZTaVCwF8NgKOpJUAgUU2cuRrhYFU3cgQcb6SOj06RwsWTHq+UZ0
        S+d0cmmBMmGWehDT9rb6xg4eRm7LG9pwMS4KltRgukIkqx0KURk8mVTYMjUyTzDj
        k17fEMYYMQTseWjRP2RzxwSqzvlZwGI97jh8mFv49kMoXXVEVH5lRHX5728FG5MO
        k+S/MAkNfi+yci5J6iXV5pEnP8TM+K2J0xkbZZnCJj+kQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1658726237; x=1658812637; bh=0fgmiotfvvA25BECvdY/7miKVB9hRcyaay/
        R6+d4lYA=; b=AvtysUnUVFlYehOZtPhSJ4kKsWz3KAunMsKJen63KtzfiXN0u4G
        ArD2wEMkR1OkZ53QkQZziQDD3TKqntMAUwqI/uUiIGZFCyV3Ho3Ht2ZYHtnlqsOo
        CJSynXZdUryDA76MJHzr8J0BR9/N0YoTGS3Bp8Rm7VC5UQl5pmrv/Hr3n2PvR1um
        3nd5rB42ELmd8auwlevlUack/8r9i9bdLKGOHJ9xuGV3gUxWnGZIfBTn0S1QuSPp
        BrwOGkq67eaqFIY5TLh/lM7EkCfK7gkvSWI2EZ7JRP+TtcL1tTXx6Fw96WMzr2n5
        lHUW2WgEeTlZkw2/62BlFvTcOamvymtDGPA==
X-ME-Sender: <xms:XCfeYqkYh7LHuO5beX-2MXKfgv8CmZUtdqHtSbH0pCmVPhg7YV93nA>
    <xme:XCfeYh1yb_VqVtazAtDgnSxZVrEtlUqA1D0jRayNChLCIGHbN7aRKtQktdTFLk3t9
    JrMut6eIwUTWQ88WA>
X-ME-Received: <xmr:XCfeYor8FfG-PGFALTTYk1uqnZ-yEX-j8PfnjpKAe-aof6RHx3UfRL7yD_3TaksrO8lTWl_7r1WKlPhbxsL3sy-x8wnNTldLTUYikoroTmTIxk0EUbSmQZT55f1zTz8nYwaM9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddtjedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
    hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:XCfeYunuWydAvghR5gtsAdc2MqhXHuRjE_pvrGtIDfAiKARHSZR9zA>
    <xmx:XCfeYo3T2eP6JAPnJ_q_KvJj2DO4U_zT8qE2KRtBztdCh03n_ldjvA>
    <xmx:XCfeYltdsoQ9fVXLMMpybraA1ZWT8dBDK9QxDppM6WktseEgrWz5HA>
    <xmx:XSfeYhtjQNq4QbQHIfoqEeAeXGyo5QuzVMP9URdymhrLGvWw7t04bw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Jul 2022 01:17:16 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH] dt-bindings: timer: allwinner,sun4i-a10-timer: Add D1 compatible
Date:   Mon, 25 Jul 2022 00:17:14 -0500
Message-Id: <20220725051715.56427-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
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

Allwinner D1 contains the usual sun4i MMIO timer device. It contains two
timers like other recent SoCs, so it is compatible with the A23 variant.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 .../devicetree/bindings/timer/allwinner,sun4i-a10-timer.yaml     | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/allwinner,sun4i-a10-timer.yaml b/Documentation/devicetree/bindings/timer/allwinner,sun4i-a10-timer.yaml
index 53fd24bdc34e..3711872b6b99 100644
--- a/Documentation/devicetree/bindings/timer/allwinner,sun4i-a10-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/allwinner,sun4i-a10-timer.yaml
@@ -20,6 +20,7 @@ properties:
           - allwinner,suniv-f1c100s-timer
       - items:
           - enum:
+              - allwinner,sun20i-d1-timer
               - allwinner,sun50i-a64-timer
               - allwinner,sun50i-h6-timer
               - allwinner,sun50i-h616-timer
-- 
2.35.1

