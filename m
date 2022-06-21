Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3E25529E7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 06:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345178AbiFUDmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 23:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344337AbiFUDmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 23:42:31 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B732631E;
        Mon, 20 Jun 2022 20:42:30 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 36AA1320098E;
        Mon, 20 Jun 2022 23:42:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 20 Jun 2022 23:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1655782948; x=1655869348; bh=AP
        zgP+RiSPGLCgXWajedsYV2f6Mhd3R/GY/RwZrbvPY=; b=KLDJJEyltNuCFohgqM
        ZmIUIEXmLlK0Uy/XDnRchpWdBtMJDNNoEc2s1pYWwwlnxnEsuywbU37TmKaaLL+6
        CLXQyTOA4aszzlKFQCgIr2QC+OSePzZBkxcsnkO2ZaMTxGCt6rkY2k89soLHJnPF
        8Iv9UQ4tPapfYu02PC1Krjeq/J8++JYizu+elfeTyOvVeR4+Bl5pJRLFb9pQ0YhV
        TRNk9UYNN8usflEkqu7QEyVb+y5u9bGa38wEenO8MCgZuVTDSTIiBbYhOB1B+ePk
        wCyT+W6vnlKkTs9yFTaRq/MDpPbpywHL9TXXA8f4iMIfeISW69HzzvGE60XWCjUK
        6Jqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1655782948; x=1655869348; bh=APzgP+RiSPGLC
        gXWajedsYV2f6Mhd3R/GY/RwZrbvPY=; b=F4y5ZNHIXq/aTUalLHtttvbBRZ12S
        LpwFWuNvmCQSarPfZtF7+Wboo2BgZg5IYWCyEpTfhzd4NawyKS9supBEtFnU35bi
        nw4TK0KElvKVaUsBls51GZ0PP/l7ouAqZ2FtwZK25w8LtEDK+D4DmTr+kjEccv4K
        CDlqdQcf8yUH2eTMEaqOxGC+hK6oMDyat8/NP5BtdF+x7okeYIreycscpK10m/Wt
        fSF5kdA0TwTIxhPUaBBf2m7JtE3r5XByele5P/xX0ipes0kdogDONhzsge8h6Fa7
        qXSvzk7PS/wCmILgaZ+9peO67Qhtk/0QmLD8VtMmLeITqjZBhV+p23xDA==
X-ME-Sender: <xms:JD6xYk7MvkhFwb9OktG48eZ96rsGvOO54CkFXEjDVn30FEQXUsQwCg>
    <xme:JD6xYl4tqagBHFPAsEf2IHsGoyMxQ8mfE8Pv_7MQtZhju4LwceHl3PSXLR7vQhxQ-
    L_OSgm07UMbJm4mPA>
X-ME-Received: <xmr:JD6xYjcd0xxHteu5OTH5mevbOlHfuZ3oD8p4sSrKAp3PKQyPmr7eJaEHYezcTf3ixCkyyYy2xEkYc9gg-7AvhsxR-6NdUEaEGy4Bz_nmmu5EYbCER-hNywgBjXNFxesKyh22xg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefvddgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:JD6xYpJGutcyqn4205rnTV0xTrPZXCAMXE7VysFYIZjLZrGoJQwdjw>
    <xmx:JD6xYoL8khwOtDx3udZ-nFgAvO-FkyM27KniBKPNL18HOpzL3VGmlg>
    <xmx:JD6xYqzrMD5sEpN2X6SGqpeNstFOGGps-jCV-fE2sSiMeCpTiQsePg>
    <xmx:JD6xYn_Bbwyi9bUxS-w4nX9xsRGfvKUu1fxRdBbFgEU9UYZyowSKAQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jun 2022 23:42:28 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] dt-bindings: gpio: Add AXP221/AXP223/AXP809 compatibles
Date:   Mon, 20 Jun 2022 22:42:21 -0500
Message-Id: <20220621034224.38995-2-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621034224.38995-1-samuel@sholland.org>
References: <20220621034224.38995-1-samuel@sholland.org>
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

These PMICs each have 2 GPIOs with the same register layout as AXP813,
but without an ADC function.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v2:
 - Combine multiple "const"s in the binding into an "enum"

 .../devicetree/bindings/gpio/x-powers,axp209-gpio.yaml      | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/x-powers,axp209-gpio.yaml b/Documentation/devicetree/bindings/gpio/x-powers,axp209-gpio.yaml
index 0f628b088cec..14486aee97b4 100644
--- a/Documentation/devicetree/bindings/gpio/x-powers,axp209-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/x-powers,axp209-gpio.yaml
@@ -19,7 +19,13 @@ properties:
     oneOf:
       - enum:
           - x-powers,axp209-gpio
+          - x-powers,axp221-gpio
           - x-powers,axp813-gpio
+      - items:
+          - enum:
+              - x-powers,axp223-gpio
+              - x-powers,axp809-gpio
+          - const: x-powers,axp221-gpio
       - items:
           - const: x-powers,axp803-gpio
           - const: x-powers,axp813-gpio
-- 
2.35.1

