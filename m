Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F6953BCDD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 18:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237304AbiFBQxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 12:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbiFBQxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 12:53:03 -0400
X-Greylist: delayed 443 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Jun 2022 09:52:59 PDT
Received: from mail.shift-gmbh.com (mail.shift-gmbh.com [IPv6:2a01:4f8:a0:5496::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FDB27B9BD;
        Thu,  2 Jun 2022 09:52:59 -0700 (PDT)
From:   Alexander Martinz <amartinz@shiftphones.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shiftphones.com;
        s=2018; t=1654188336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=imGM7saNPOQ6vbKogvcqXOICfijWBW6J11L5perWAFg=;
        b=SPkvOhTj83B6oiJW3ZAr24eQ87yTw5YKMp8thSdc+8WpuYXGlWvxUk4x3VYgij5bb4pOhs
        dQbS4mOPX1RWY/Pu1wgAh41UG3hwC2EZcw7HcMoEg1c33blT+f7q5V4f9tTARR3kOdlYZP
        CaQTjPSJF7G4uIaPouDVMMwa6fYRIa1l9h+NRSaZF55+ua8vne/ugrWaUnXXmUk09tKKKm
        dnW8FXetCsw1XtkBuauUiw366+SuKbEOwAmKxtDq9Lostm16iyTS7ZfyVurzQf4wiS30LI
        ftKT364RV/wmI64x5etHJMHvwIOyC0MmW06r1LmlAzXMSc6SM1CKtYNnKPxrAg==
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     phone-devel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Caleb Connolly <caleb@connolly.tech>,
        Dylan Van Assche <me@dylanvanassche.be>,
        Alexander Martinz <amartinz@shiftphones.com>
Subject: [PATCH 2/2] ASoC: dt-bindings: nxp,tfa989x: Add tfa9890 support
Date:   Thu,  2 Jun 2022 18:45:04 +0200
Message-Id: <20220602164504.261361-2-amartinz@shiftphones.com>
In-Reply-To: <20220602164504.261361-1-amartinz@shiftphones.com>
References: <20220602164504.261361-1-amartinz@shiftphones.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=amartinz@shiftphones.com smtp.mailfrom=amartinz@shiftphones.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document TFA9890 binding for tfa989x.

Signed-off-by: Alexander Martinz <amartinz@shiftphones.com>
---
 Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml b/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
index b9b1dba40856..7f2e68ff6d34 100644
--- a/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
+++ b/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
@@ -15,6 +15,7 @@ allOf:
 properties:
   compatible:
     enum:
+      - nxp,tfa9890
       - nxp,tfa9895
       - nxp,tfa9897
 
-- 
2.36.1

