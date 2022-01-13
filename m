Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2B548D933
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 14:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbiAMNjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 08:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235343AbiAMNjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 08:39:24 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5078CC06173F;
        Thu, 13 Jan 2022 05:39:24 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id a18so23141961edj.7;
        Thu, 13 Jan 2022 05:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lo7RqmvVE3qGhY8Rz5lRe01h/4O84xF8iBhO2A51oDQ=;
        b=YW1us8THCvj2uGkbpxk7y+T8DrBp9tHBT0mTMVX+r4wknVkZ9ZGzEKt7fGywC0O8Yc
         Su73ePWkGv6q1DE6RqyVSLM7VauMd/P50E535xyFy1D+DweVl6FGrHAnXWKaDwVX90Bs
         rPEpLr7DrZin/g0YYeTisMdds3DSRWgJMn2oByxpyriVAB8xiBfI/kFmZ0/VZAqTyb8m
         4wbff0K2l3onrIW7qi4NFOmtMpdjcKjouibg01pNNTcHFGyiuJua06X5gLbu7hvzAXb/
         T6sW8kyhKzxUHsMzuZV8qsQK8i4DKHFTzFXESVaE9X3Qp4vmbLKEyyFl7gTqV7+PM4XV
         q0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lo7RqmvVE3qGhY8Rz5lRe01h/4O84xF8iBhO2A51oDQ=;
        b=AUJwlCvWTEfP5bWUtbXiV/FEhlv656TLaf76imnzwW4xVw2GF3+kzNrSlhmOQYJIvD
         lgmQccYVQdlwgbZ+pX7VOlSN64FLWoVHkDQm4i7W6uBubcMMwQ6WYQiFI03/gmb0v30y
         xZMvfS1DJKP/pzbHQF3vjMXJmdcVDWRGcTflClLAW21qt4tG0LL7s55RuKE8+nIutHZf
         wdWaWzQBMfdpHfrIehE+lcnexyfRu1VIf0m3W90aYn0/u8P9sbkW18742t++ifcAQRZv
         ssvtZtDR3JIxtUz2mfv2aCHu19eO3PQiT3K5hFysUhkDzKrAA6f6qiDHghnBMqUNmeeH
         6dxg==
X-Gm-Message-State: AOAM5327YMFpQiCeIAFmsQEpSw4hixxm2iDfRkat9NMhR8M/j31kjAWV
        t1iIY05yMoD/i9wqArHMkEEVA6nkz4o=
X-Google-Smtp-Source: ABdhPJzebkwtl8Z93/oPbjUpe1mWgmIKZCmjRa3IZRoZxloJQq23aQZqBlRv1RpAY0Is/frdqyzaCQ==
X-Received: by 2002:a17:906:158f:: with SMTP id k15mr3492493ejd.367.1642081162894;
        Thu, 13 Jan 2022 05:39:22 -0800 (PST)
Received: from standask-GA-A55M-S2HP ([188.123.115.255])
        by smtp.gmail.com with ESMTPSA id gb35sm894149ejc.36.2022.01.13.05.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 05:39:22 -0800 (PST)
Date:   Thu, 13 Jan 2022 14:39:20 +0100
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: trivial-devices: fix double spaces in
 comments
Message-ID: <13b3f66efd3b20f1d9bbb9eff1eca00757ac5367.1642080090.git.stano.jakubek@gmail.com>
References: <cover.1642080090.git.stano.jakubek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1642080090.git.stano.jakubek@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup double spaces in some of the comments.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 098811b7aa97..091792ba993e 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -31,7 +31,7 @@ properties:
       - enum:
             # SMBus/I2C Digital Temperature Sensor in 6-Pin SOT with SMBus Alert and Over Temperature Pin
           - ad,ad7414
-            # ADM9240:  Complete System Hardware Monitor for uProcessor-Based Systems
+            # ADM9240: Complete System Hardware Monitor for uProcessor-Based Systems
           - ad,adm9240
             # AD5110 - Nonvolatile Digital Potentiometer
           - adi,ad5110
@@ -43,7 +43,7 @@ properties:
           - adi,adp5589
             # AMS iAQ-Core VOC Sensor
           - ams,iaq-core
-            # i2c serial eeprom  (24cxx)
+            # i2c serial eeprom (24cxx)
           - at,24c08
             # i2c trusted platform module (TPM)
           - atmel,at97sc3204t
@@ -305,7 +305,7 @@ properties:
           - socionext,synquacer-tpm-mmio
             # SparkFun Qwiic Joystick (COM-15168) with i2c interface
           - sparkfun,qwiic-joystick
-            # i2c serial eeprom  (24cxx)
+            # i2c serial eeprom (24cxx)
           - st,24c256
             # Ambient Light Sensor with SMBUS/Two Wire Serial Interface
           - taos,tsl2550
-- 
2.25.1

