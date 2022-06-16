Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9B954DA50
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 08:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358994AbiFPGJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 02:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358981AbiFPGJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:09:22 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AAE252BF;
        Wed, 15 Jun 2022 23:09:21 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 86B2F32009BE;
        Thu, 16 Jun 2022 02:09:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 16 Jun 2022 02:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1655359760; x=1655446160; bh=Oa
        skLM2rsVB8WYN8miwGXG1amlwpVFT97kyPItB/L34=; b=B2s02t8eovzTmtzEqK
        e1CUB84rCa3V8SbFRXBvzXRzBF3rxVchBq1XlQKmy6aUKdiv04K/dLvZd0gSf6J1
        7T8G19GhCtCkIam++7ecyRmX/ztSBPnWJZd6PX+nIuI3sPr7DTgcoC9TTe6lMEfw
        s1YxpFH+4lGtvkE+8XS+BCCcFr2PDqRG2EbwsUKigIDW6KiFfQj0bqYhIr6nQ05I
        /M+dlKBIO090yHa0a2I3lQSw64T9cco2oES4C76ZCJlw89X8ACANPUiMlVgwWrVm
        S1pVW3IQyfJxLVr30NA9ENMgGmJ+Eqf4SCU7ISMYkIvdpUFGAR0eRmHT0vd08fXq
        Khcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1655359760; x=1655446160; bh=OaskLM2rsVB8W
        YN8miwGXG1amlwpVFT97kyPItB/L34=; b=UJMXvnWhqJU3aJ8/DxPUuGl/7V7nb
        njcG2ncKOTXDBSGACSexVndcrMBDtPZ45nRsfJkYwaNfG99GXqfOVZo3R7oo17i3
        FJQvv/5kFsutACkLIW+FwyKr97sl0duH6kJDcpdM/znera7AY9nxaYwpacDWq8wB
        CZhFes/2EJV3iEW1lmHTrv9GK+Eento/UiM9GgOlFGM3BuOcMjTNf4xRKRc6B5Xe
        O1uxW+8o8mMG9GorBuBy3hfikEmaaVOjDxMMepFj227NuZgsgg9jCUi22nA+Ak8a
        JGcm7ODL8FvUyLmzlM4jV40mOgmSBzoYlmQ+q+EyhBa51uopwE5jMgGmw==
X-ME-Sender: <xms:D8mqYqaPSdVch5UFsHb2gYryyHZW_2aPbXjTb4BCI0DzHqNnn90XVA>
    <xme:D8mqYtZpX5An3iMEGL8WQ7ae2NYpmamxxvxUX8XVSMGTqI5PyxSBllU5dqxmPFNmQ
    n0trFw2Q9YasFQrvA>
X-ME-Received: <xmr:D8mqYk-sXk7FXd4lqrcSOZ_m0iWoaH99nELu1fjZlutwL0NRNEOJxKAkCrE6G3zdiebtkuQDRr8zRBvW40GfjGFwIqL3zMIOLdA8Mz5mTJ6trFnVlHs2C0KLLpANFV8YqdwecQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddvvddguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeeh
    gfdufeeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:D8mqYsrD1QxEapIjJbe9e13q3AxN8HkdLDgYDaeLTOX06ktIWp5jIw>
    <xmx:D8mqYlqdZ2uWZA0KpraKqCK9FRKw7YYih0SUlzlxOVZ4uwGMVKvoQQ>
    <xmx:D8mqYqR3W279AN8sjbJWVOsOjoQhxsRWmB4NiVa3hntzGKTujfKg9A>
    <xmx:EMmqYpdG3Y7y6kXKv8qs4aF3Iqn3WF3Cv3KdOC5q4jsKqi9ITpjGEg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jun 2022 02:09:19 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: gpio: Add AXP221/AXP223/AXP809 compatibles
Date:   Thu, 16 Jun 2022 01:09:12 -0500
Message-Id: <20220616060915.48325-2-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220616060915.48325-1-samuel@sholland.org>
References: <20220616060915.48325-1-samuel@sholland.org>
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

 .../devicetree/bindings/gpio/x-powers,axp209-gpio.yaml     | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/x-powers,axp209-gpio.yaml b/Documentation/devicetree/bindings/gpio/x-powers,axp209-gpio.yaml
index 0f628b088cec..6faa3ef28960 100644
--- a/Documentation/devicetree/bindings/gpio/x-powers,axp209-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/x-powers,axp209-gpio.yaml
@@ -19,7 +19,14 @@ properties:
     oneOf:
       - enum:
           - x-powers,axp209-gpio
+          - x-powers,axp221-gpio
           - x-powers,axp813-gpio
+      - items:
+          - const: x-powers,axp223-gpio
+          - const: x-powers,axp221-gpio
+      - items:
+          - const: x-powers,axp809-gpio
+          - const: x-powers,axp221-gpio
       - items:
           - const: x-powers,axp803-gpio
           - const: x-powers,axp813-gpio
-- 
2.35.1

