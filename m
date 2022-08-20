Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA3E59AC14
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 09:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344011AbiHTHR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 03:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344017AbiHTHRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 03:17:48 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672D8C6CC4;
        Sat, 20 Aug 2022 00:17:46 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id jl18so5833593plb.1;
        Sat, 20 Aug 2022 00:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=4us/F8eJ4tlg85vnYkTyoESksVXkiPBpQ7bpWGLRwos=;
        b=XwO4jsclhEdDs+e+EKz62wjpyGp7J8Trg1Psjtc16e37N0551qfVeCLHzvkHl+H96k
         54ux0H3rbeURovPf399q/9jvcjONV09gnI0moMEiu40eYvAyYoowdGxt61PD6M8Qpdev
         bEXr06awDkfNJ3ANL/zcTAzUrscDwoWhu3NlQ2QLAsY4Wns3IQoMCeLlpJ6FRfZWBSWu
         fCL+WtTw3royLbz6/tH/ThP4rWPlyaRASk9DehAPnHxCtC0tcpduQYbz2puh5VrC6dSv
         QM8iHvtNC0Qx/8NsZ+0TSlIYReDGv0aqPyrQDsg2fRZKw1/IaJWhXuYcl4w52u5uZyWB
         FlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=4us/F8eJ4tlg85vnYkTyoESksVXkiPBpQ7bpWGLRwos=;
        b=ZYxKsgazrGKgXK2Ve9qQeOk5sIlFJsyNs8+dTXmQRRmBPmlkpTPoR4vRDS99L4w+CK
         LGjwPkDDg7Y5QtgYhj3kUDuYZPC/QzllRMDf6Wdo0mU+z9x/Wv/1/EXRAPMgKWvW5eu0
         /l/H6SQxHOhWXcRNBjcMqiw0pIO5pHpMI9o93fp6clVy0uuc2gD/w65qtoCwy4tcdoG/
         WiZK9OwXF8GxocilDu1XYTr9fLVTJ/JY2Cz1+ZwUsn/RCpbvKs4ciS11Ahe8jrHYb6rk
         LQw1EkNnHEc7YN92KSU2nzzEC93vPSWgrU7w3W3sOzVxLj1XMpgp7aoKUCg9y1LFD6sK
         IHTw==
X-Gm-Message-State: ACgBeo1RKwrbDBGkaSHHYmEgzjFWgTaAZ9pIoEKHBRANegcgihmPGfSj
        +WH0WaJ/rQdw6G81o2UDVWnlh3OwM18d83YhI5c=
X-Google-Smtp-Source: AA6agR5z4on5mvqISCpPOt29CWgrhGAriBua88sqdLBj9ZYLLKzrHoZRVNygEdAzEUmOj4SH3UMQ1g==
X-Received: by 2002:a17:90a:982:b0:1ef:f525:9801 with SMTP id 2-20020a17090a098200b001eff5259801mr12533685pjo.191.1660979864696;
        Sat, 20 Aug 2022 00:17:44 -0700 (PDT)
Received: from mithil.localdomain ([103.19.226.223])
        by smtp.gmail.com with ESMTPSA id j15-20020a17090a694f00b001faf273e4afsm1459019pjm.35.2022.08.20.00.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 00:17:44 -0700 (PDT)
From:   Mithil Bavishi <bavishimithil@gmail.com>
To:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org, sre@kernel.org,
        tony@atomide.com, linux@armlinux.org.uk, bavishimithil@gmail.com,
        contact@paulk.fr
Subject: [PATCH 05/10] dt-bindings: power: reset: Add bindings for twl6030-power
Date:   Sat, 20 Aug 2022 12:46:55 +0530
Message-Id: <20220820071659.1215-6-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220820071659.1215-1-bavishimithil@gmail.com>
References: <20220820071659.1215-1-bavishimithil@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds documentation for the twl6030 power driver.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
---
 .../bindings/power/reset/twl6030-power.txt    | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/twl6030-power.txt

diff --git a/Documentation/devicetree/bindings/power/reset/twl6030-power.txt b/Documentation/devicetree/bindings/power/reset/twl6030-power.txt
new file mode 100644
index 000000000..946bb3d9f
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/twl6030-power.txt
@@ -0,0 +1,31 @@
+Texas Instruments TWL family (twl6030) reset and power management module
+
+For now, the binding only supports the complete shutdown of the system after
+poweroff.
+
+Required properties:
+- compatible : must be
+       "ti,twl6030-power"
+
+Optional properties:
+
+- ti,system-power-controller: This indicates that TWL6030 is the
+  power supply master of the system. With this flag, the chip will
+  initiate an ACTIVE-to-OFF or SLEEP-to-OFF transition when the
+  system poweroffs.
+
+Example:
+&i2c1 {
+       clock-frequency = <2600000>;
+
+       twl: twl@48 {
+               reg = <0x48>;
+               interrupts = <7>; /* SYS_NIRQ cascaded to intc */
+               interrupt-parent = <&intc>;
+
+               twl_power: power {
+                       compatible = "ti,twl6030-power";
+                       ti,system-power-controller;
+               };
+       };
+};
-- 
2.25.1

