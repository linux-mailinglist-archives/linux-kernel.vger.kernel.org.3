Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFD854FF6E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 23:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235973AbiFQVhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 17:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbiFQVhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 17:37:33 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85801005
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 14:37:32 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id c21so7229761wrb.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 14:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wGbMUWjxs8BkGkLUVDpfhH3mQEW003HHHcJjYYfU7v4=;
        b=SLDzV2QIqEa40kiO6UHKNr4FOD7iSpRR4+KbKYh4OQ8FAYv+DyGH964zD+o8MLMqru
         LAx0TEzv3qw2FW4OB1uGntlpn7DYZAdFJ6aOgFveGQt7ptcSFY66IxN00Nxx3LM60vTz
         CKfj0YSixRUUYt3Y01puNxiX8KI4XHFGS4qM8ipQZU+P3o5rd9zf6fqoHr0wzw9xcMXq
         2Jz3hLTHdfE3rhgPMk/nmt+3cUg1gu68UwhgJV4rO+d1jLEPv2ZkcSjPfnt3fVG5Z00j
         3dEPcrutimdfF6gWpUEcuB8CmV2B0GmCUyBg6Tf3B/mOldFz+cPIyHKHDntg6vsRV8bf
         PZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wGbMUWjxs8BkGkLUVDpfhH3mQEW003HHHcJjYYfU7v4=;
        b=4q/7hsNHEFvgCs32rJ3pJnwCwJ/1/wPPtLSn+wbPjJ2wmGQSAV9aLgSCmkwNmDwBBz
         YIlB/JoTV2fFEaEQfayAVHav+FQMONhX4sATkrgNuRyAcRPQD5kfkmd55FehkcOCN68n
         WJVumM1EYfjikVzu9D7AIex1TmB3MjN4FktDCK7S6Ygqx6BUFL6PUchlK5RAcC3/B5tt
         Br7496085awVClyBhYyUEW1moC/HLHrD+svlHdvFSfyxUjn9qQiMpEX8ra5jb5KUKpXJ
         q/bI5s6oUYzK6uP32q/kgGui07bmwozwFNiHvZVlJhoOWh2B1akrfPO7UTnS+sZEwIQ8
         J0ng==
X-Gm-Message-State: AJIora/MZbursSjZ/TGyXVXz1+6+kpmiOfwIbyb9i64WTBZmw3PwYG5j
        ZqKXBXjWlHv4o/0kbTDUn5pLyAAOZmmIcWplhWI=
X-Google-Smtp-Source: AGRyM1tr5HuJpzlTGlamBFC16nJpme8r8TCAQYFHnLloq5rkURi5r/W+JiMekrV08CqRLjwlrpNLEA==
X-Received: by 2002:adf:f184:0:b0:21b:6c76:5b6e with SMTP id h4-20020adff184000000b0021b6c765b6emr4253788wro.126.1655501851181;
        Fri, 17 Jun 2022 14:37:31 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id z14-20020a5d654e000000b00210288c55d0sm5623988wrv.52.2022.06.17.14.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 14:37:30 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH] dt-bindings: display: delete ilitek,ili9341.txt
Date:   Fri, 17 Jun 2022 22:37:07 +0100
Message-Id: <20220617213706.376730-1-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

ilitek,ili9341.txt was replaced by ilitek,ili9341.yaml but the txt
binding was not deleted. Do so.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/display/ilitek,ili9341.txt       | 27 -------------------
 1 file changed, 27 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/ilitek,ili9341.txt

diff --git a/Documentation/devicetree/bindings/display/ilitek,ili9341.txt b/Documentation/devicetree/bindings/display/ilitek,ili9341.txt
deleted file mode 100644
index 169b32e4ee4e..000000000000
--- a/Documentation/devicetree/bindings/display/ilitek,ili9341.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-Ilitek ILI9341 display panels
-
-This binding is for display panels using an Ilitek ILI9341 controller in SPI
-mode.
-
-Required properties:
-- compatible:	"adafruit,yx240qv29", "ilitek,ili9341"
-- dc-gpios:	D/C pin
-- reset-gpios:	Reset pin
-
-The node for this driver must be a child node of a SPI controller, hence
-all mandatory properties described in ../spi/spi-bus.txt must be specified.
-
-Optional properties:
-- rotation:	panel rotation in degrees counter clockwise (0,90,180,270)
-- backlight:	phandle of the backlight device attached to the panel
-
-Example:
-	display@0{
-		compatible = "adafruit,yx240qv29", "ilitek,ili9341";
-		reg = <0>;
-		spi-max-frequency = <32000000>;
-		dc-gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
-		reset-gpios = <&gpio0 8 GPIO_ACTIVE_HIGH>;
-		rotation = <270>;
-		backlight = <&backlight>;
-	};
-- 
2.36.1

