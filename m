Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9F44B3C6C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 18:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237268AbiBMRQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 12:16:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237258AbiBMRP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 12:15:58 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707C458E72
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 09:15:52 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id jg20so8033287ejc.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 09:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i1RYgt0bRyM5+K2M0i2x/hO7uPol3JRFphrZi4pLhJE=;
        b=eDDKPuA0ZIRuuv+Ui4l8NM4SLz3TFkdl8RpCqVxuo/9HKjvHpmpp1QEtLQb9GbOcQC
         saiSJL+1vTCvsRG+13ab9jRlePInIwGc7+564H+hRhWaFCr8eMJ+zkbWUcnNLv15vUX5
         9YabH8RGBRZGYfQmshJ+HjH2DvbkiIlYU4LEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i1RYgt0bRyM5+K2M0i2x/hO7uPol3JRFphrZi4pLhJE=;
        b=skAoEWOCkDm606Xb1u7TlxmIhEaT8E7XTlb+IvVgjxQra1EBFHR3zzTJGCbOa4swCb
         t5UHiQMQ1N9MSfrVS41DDQDPGjbOtUSQwUD/fguznF80Uj4OnMohLt21DHxduHSTGjdR
         oLZsVkiICFPZ8m3bXSG9PN8dz5ckiTuHS+8C0Xk/bKz2X3g+vjxubKyJ06tUUKqegqEE
         ATI9lS6d1aV7Qv0NCsNHHGUAYvYLlEmgbBTZzh5jzBs5iOcrgUk1RyibwpQCGZVDU8Dd
         fIajMj1QjvUFYDum72zavWYFXpjt8R8urjoant8CJ82hZucb4YmnBmRtOO1DeLJs/T0n
         VSjQ==
X-Gm-Message-State: AOAM5332NM2Xgk2HcX+M1rXalxyNT3tIGGY/k/oBOXavgd6pH4a1X363
        MACYif3J+Jk8qDne3AQovi2AUAr9t5P/Fw==
X-Google-Smtp-Source: ABdhPJzr35wW1sMK5FzxA73gYiBRCu4+lYqZ+2I90LD7agEyCPLVnMjtHEGObv/1ZgCTauKagGCplA==
X-Received: by 2002:a17:907:234b:: with SMTP id we11mr8334781ejb.5.1644772550831;
        Sun, 13 Feb 2022 09:15:50 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-52-8-210.retail.telecomitalia.it. [82.52.8.210])
        by smtp.gmail.com with ESMTPSA id o10sm6598878ejj.6.2022.02.13.09.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 09:15:50 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH 1/6] dt-bindings: input: touchscreen: edt-ft5x06: add report-rate
Date:   Sun, 13 Feb 2022 18:15:27 +0100
Message-Id: <20220213171532.346270-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220213171532.346270-1-dario.binacchi@amarulasolutions.com>
References: <20220213171532.346270-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It allows to change the M06/M12 default scan rate.

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 .../devicetree/bindings/input/touchscreen/edt-ft5x06.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
index 2e8da7470513..a4cd9bb156b2 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
@@ -85,6 +85,14 @@ properties:
     minimum: 0
     maximum: 80
 
+  report-rate:
+    description: Allows setting the scan rate.
+                 M06: range from 3 (30 Hz) to 14 (140 Hz).
+                 M12: range from 1 (1 Hz) to 255 (255 Hz).
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 255
+
   touchscreen-size-x: true
   touchscreen-size-y: true
   touchscreen-fuzz-x: true
-- 
2.32.0

