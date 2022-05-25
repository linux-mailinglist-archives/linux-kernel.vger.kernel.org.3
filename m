Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4504C534567
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 22:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344063AbiEYU5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 16:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiEYU53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 16:57:29 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3488B8BE8;
        Wed, 25 May 2022 13:57:28 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id t144so23208110oie.7;
        Wed, 25 May 2022 13:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PvdkFEtwnY8PQ1QhT5M3rI8a4A3NL4oFFj4uvWw4Njw=;
        b=qAAYh8z9W9sthSvaFx8Cqas0uLq+3kwhqX5FF3EF62w2/1fPGqD/406S5MSu814iU8
         haJGxYkPw2zBRzKOcTUFlr2pyXRqKyClHNoys69tIVjUDip+oehB9jUYvI0PMmmE9l7b
         DSkuioULJbYIzl1VZalpHQe9RShrxbs/J4A5VdJ8uo0nLw2W+NKnyRBO10X03Kx+joMv
         y4qNx3wrCPIiH6kEFedXSpcvB7OjOqUUk770Hjr+zV+xBI8ulQQyY2Ee0yTYgLRBHkaS
         NavKvvRf4hSl/XOcAbXN2cd2IoUerjdU6E/6XAdTgP5jwBrhcb+XWWNgCEhlphf1AZzw
         cn7w==
X-Gm-Message-State: AOAM5310KgUdqPZlQNnaoYHP5cfu28MYnVK3sV5d8tzLuswPAvO/eeVL
        qNfCirGPjkePFjfzshk2/w==
X-Google-Smtp-Source: ABdhPJyRuiJ/assfY1zLs5zrpGcTguyfUw5N+iA1GV/DKuVDEOa45pd2/EegjcXHekwesofSJm644A==
X-Received: by 2002:a05:6808:f09:b0:328:b61f:1b52 with SMTP id m9-20020a0568080f0900b00328b61f1b52mr6053707oiw.150.1653512238956;
        Wed, 25 May 2022 13:57:18 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id r125-20020acada83000000b003289f51c2d7sm6896210oig.34.2022.05.25.13.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 13:57:18 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: display: ingenic,jz4780-hdmi: Drop undocumented 'ddc-i2c-bus'
Date:   Wed, 25 May 2022 15:56:26 -0500
Message-Id: <20220525205626.2482584-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While 'ddc-i2c-bus' is a common property, it should be in a connector
node rather than the HDMI bridge node as the I2C bus goes to a
connector and not the HDMI block. Drop it from the example.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml  | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml b/Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml
index b8219eab4475..89490fdffeb0 100644
--- a/Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml
@@ -55,7 +55,6 @@ examples:
         compatible = "ingenic,jz4780-dw-hdmi";
         reg = <0x10180000 0x8000>;
         reg-io-width = <4>;
-        ddc-i2c-bus = <&i2c4>;
         interrupt-parent = <&intc>;
         interrupts = <3>;
         clocks = <&cgu JZ4780_CLK_AHB0>, <&cgu JZ4780_CLK_HDMI>;
-- 
2.34.1

