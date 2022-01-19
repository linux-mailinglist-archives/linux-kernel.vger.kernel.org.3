Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CB3493298
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 02:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350800AbiASByp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 20:54:45 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:33473 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350779AbiASByn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 20:54:43 -0500
Received: by mail-ot1-f44.google.com with SMTP id y11-20020a0568302a0b00b0059a54d66106so1103811otu.0;
        Tue, 18 Jan 2022 17:54:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qwNF7gDQbaVP4ndpQ6YMR5OTB3DEGyDODGB0cvvqRfI=;
        b=Uv2i19NbpnnyyV2GJmevQVO2Sq8KR+/9DN9Td27rdvyhK0AJwiPDv8mdmZbyOfC/Bt
         JLmuwZR03YB1bTXyYIyUnU6a8G41XrXL2/dkYooz2sPXfHJdEZI19LwSaa0nfNuN8unJ
         0qN6LmcNPFK+p/aaWz3GAumICtL9F5zzSS/TIJOwNOYd5lFy+kksTO1GdGpTokAbC6tL
         OEzS80qJMJ++BcMV9D1uBk4JLZuZjcWOu6kPJ+eVG+AEmwuvmBX0keJk0u2HMOXMxHQX
         1V4tPegfRUqVqgccgwX8HvcrVN/AP6NnDrbfaEYUE8nS+YS3yOGVxcD9J3CFXGwFJha7
         hRIg==
X-Gm-Message-State: AOAM5310ful6QlKImfmatHT6c6C3fOZ6w7bLV5hhtE/TFmEhoO4cROcA
        W+47O6sZfYiFgdr9NRRRhQ==
X-Google-Smtp-Source: ABdhPJzVUKXAC2YcMFSv4hVv2ACgxjnkM4ifG2UCVa32kabvoUCd5Cz5lVIyctz4yYEGV/7yATw++g==
X-Received: by 2002:a9d:4b13:: with SMTP id q19mr22246546otf.300.1642557282257;
        Tue, 18 Jan 2022 17:54:42 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id x26sm8030086ote.78.2022.01.18.17.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 17:54:41 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        - <patches@opensource.cirrus.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: [PATCH] dt-bindings: Drop unnecessary pinctrl properties
Date:   Tue, 18 Jan 2022 19:53:25 -0600
Message-Id: <20220119015325.2438277-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For a single pinctrl mode, it is not necessary to define pinctrl
properties as the tools always allow pinctrl properties.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../display/rockchip/rockchip,rk3066-hdmi.yaml         |  8 --------
 Documentation/devicetree/bindings/input/gpio-keys.yaml |  6 ------
 .../devicetree/bindings/pinctrl/cirrus,lochnagar.yaml  |  9 ---------
 .../devicetree/bindings/pinctrl/cirrus,madera.yaml     | 10 ----------
 .../devicetree/bindings/sound/samsung-i2s.yaml         |  6 ------
 5 files changed, 39 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3066-hdmi.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3066-hdmi.yaml
index 008c144257cb..1a68a940d165 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3066-hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3066-hdmi.yaml
@@ -26,14 +26,6 @@ properties:
   clock-names:
     const: hclk
 
-  pinctrl-0:
-    maxItems: 2
-
-  pinctrl-names:
-    const: default
-    description:
-      Switch the iomux for the HPD/I2C pins to HDMI function.
-
   power-domains:
     maxItems: 1
 
diff --git a/Documentation/devicetree/bindings/input/gpio-keys.yaml b/Documentation/devicetree/bindings/input/gpio-keys.yaml
index dbe7ecc19ccb..7fe1966ea28a 100644
--- a/Documentation/devicetree/bindings/input/gpio-keys.yaml
+++ b/Documentation/devicetree/bindings/input/gpio-keys.yaml
@@ -88,12 +88,6 @@ patternProperties:
             which can be disabled to suppress events from the button.
           type: boolean
 
-        pinctrl-0:
-          maxItems: 1
-
-        pinctrl-names:
-          maxItems: 1
-
       required:
         - linux,code
 
diff --git a/Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.yaml b/Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.yaml
index 80020539c3bb..5cd512b7d5ba 100644
--- a/Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.yaml
@@ -51,15 +51,6 @@ properties:
       appropriate of the LOCHNAGARx_PIN_NUM_GPIOS define, see [3].
     maxItems: 1
 
-  pinctrl-0:
-    description:
-      A phandle to the default pinctrl state.
-
-  pinctrl-names:
-    description:
-      A pinctrl state named "default" must be defined.
-    const: default
-
   pin-settings:
     type: object
     patternProperties:
diff --git a/Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml b/Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml
index e50d7ad5c229..c85f759ae5a3 100644
--- a/Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml
@@ -30,16 +30,6 @@ description: |
     Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
 
 properties:
-  pinctrl-0:
-    description:
-      A phandle to the node containing the subnodes containing default
-      configurations.
-
-  pinctrl-names:
-    description:
-      A pinctrl state named "default" must be defined.
-    const: default
-
   pin-settings:
     description:
       One subnode is required to contain the default settings. It
diff --git a/Documentation/devicetree/bindings/sound/samsung-i2s.yaml b/Documentation/devicetree/bindings/sound/samsung-i2s.yaml
index 2e3628ef48df..84c4d6cba521 100644
--- a/Documentation/devicetree/bindings/sound/samsung-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/samsung-i2s.yaml
@@ -110,12 +110,6 @@ properties:
       Internal DMA register base address of the audio
       subsystem (used in secondary sound source).
 
-  pinctrl-0:
-    description: Should specify pin control groups used for this controller.
-
-  pinctrl-names:
-    const: default
-
   power-domains:
     maxItems: 1
 
-- 
2.32.0

