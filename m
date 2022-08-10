Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE70F58E48D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 03:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiHJBfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 21:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiHJBed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 21:34:33 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC216E8A6;
        Tue,  9 Aug 2022 18:34:32 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id F00E15C0225;
        Tue,  9 Aug 2022 21:34:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 09 Aug 2022 21:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1660095271; x=1660181671; bh=RmoM/4oIo6wEIqBAN+lEhaPi9
        bDevafPtd5uBxBK7UY=; b=M2j9G+Unc9fn3oNdPnclF/EUeZk3vYIqhAIIj7UVg
        mwIgKhePiDGreA3US6YNTmw2drytW+Yc9MVctH3mtytnbFt/uG4NbIXyXJEnLrXl
        faX0rP9zCpQfEKDWyv8SwiOJAylJCbzLlWOhS2dAR4VHiqGoT0wYK4xI1kTpcjro
        5P9LHXRRMq2C9QvsugVT2431m2YEDo7+jvEK7OCJGwVcU3EWJIeDqVXqOKGk1yev
        S8sLHswcAZhHaw5YsRClOHZIaV6RV2ayJYfzQ7zfjsYSZN9GrRvPRUJGqLoUq78j
        igocq0G9V2tPiiVzpr/gFM0jQ7l3weJI+322OJru3GZ7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1660095271; x=1660181671; bh=RmoM/4oIo6wEIqBAN+lEhaPi9bDevafPtd5
        uBxBK7UY=; b=V8Sj/IB1vn4QSG8cNuVuFf2s0Z7QvhkBvcs8KJQy6UA9QA0BBjj
        GNrvFiYZbQmp8x4E/RBtN5zLiCbQX0Z9G8NQNHoC91xwAu3Su44ky8l2PPe3PPy0
        sTbeX/OibKV0zMq4rUX3QRhCfuwdvSYR55oIOQYtNe/nPic5fIxSsxHdn/pU35XB
        YjWjBxlTO5zXH/MavQuhSKF8d7JNp4STLkPubk0dfV7TvtSA2eLKhHn390XU9Msf
        5QHV99PirnHxqNL2ss9W5VRilmi4hHaXYhcHTNdDu7WUwcI0BdvGLG1ILyRQrE//
        CMwrD5KM32267qsODkazOrhJjKPx+4pSWmA==
X-ME-Sender: <xms:JwvzYqNI8oaDIY5mGybKZu15N5D4EvjjjwMWX8HLkHREtoBoYo1zsA>
    <xme:JwvzYo97pbovDtHSk3T6RH7DYV_hV2boG-4p4P1hoRj7g_jT_Lx0XkuEH1jfbYTIX
    hwKb2WOQCalWQVAqg>
X-ME-Received: <xmr:JwvzYhRurAaEu5Skb3hIe2XHaCqXtCwEdfB3cTrC60SJHz5u43loWWWDRi3U_IXgkm5dyXcBIIz67UX1wL1F7QurMwA9mfDTmhDWARQ2IRgtNilObhZZW4yjn2whp2Ev_qyZqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeguddggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
    hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:JwvzYqtCpNlmzzHOP37l2TIgXxaM-v5PB0ddjeLERezsGDD-KdIl0g>
    <xmx:JwvzYifJvToFxzgNY1b5exkjOAIFKUtuHfAXwOqQny1pfEwAzu3WBg>
    <xmx:JwvzYu1LYkgkZm70mmmlgIXAzqHSj67ukI1ubtvv9X_ASPqmQsSRJA>
    <xmx:JwvzYvEjmxXhpgshZZ4feNAOcubgWNSMVxTw6tH_ArNQvQJKgIapXg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Aug 2022 21:34:31 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mfd: x-powers,axp152: Document the AXP228 variant
Date:   Tue,  9 Aug 2022 20:34:30 -0500
Message-Id: <20220810013430.27061-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
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

AXP228 is a PMIC used on boards such as the Clockwork ClockworkPi and
DevTerm. Its register map appears to be identical to the AXP221 variant.
The only known difference is in the default values for regulator on/off
states and voltages.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
index 3a53bae611bc..cfbf221789bb 100644
--- a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
+++ b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
@@ -92,6 +92,9 @@ properties:
           - x-powers,axp806
           - x-powers,axp809
           - x-powers,axp813
+      - items:
+          - const: x-powers,axp228
+          - const: x-powers,axp221
       - items:
           - const: x-powers,axp805
           - const: x-powers,axp806
-- 
2.35.1

