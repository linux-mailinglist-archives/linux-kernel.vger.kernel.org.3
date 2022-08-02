Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191A4587ABE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 12:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236105AbiHBKbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 06:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236464AbiHBKbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 06:31:06 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9729C10E7
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 03:31:05 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b16so9548252edd.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 03:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q+PCHhH5RY3YpATXYSctNUUiV4iFFV7Fmg95HJ0DFe0=;
        b=io3HzhFIfyn/dkiAahjBcd22WsDIXtuEdAhJGEifDqwHsa/C4rSvDZGltXe0xhn3Z6
         zdecvxTUv2BXT6i0zjd20+9wihS680plrHDDBpgrVj7UNX/iAT92N+cRfhh3jcBrfJXt
         uK8qMDUBZDr70gMr3t01mPY66vECw29acCkNH471Guccofl131ekIgX7E+Ax2tW+AXbU
         Hvqt5le99fvJzXxKCwmRHRiXCBy0KKLa7kXpED+H+WyooE1MSh4qCad5dBcqT05WfGXX
         AOVYOLCQgf+7SrbE2KhMy+VJpNw2KYmj89TpGYSKENv0TmUhUDQkahiFLDWOXr2K9WCQ
         xpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q+PCHhH5RY3YpATXYSctNUUiV4iFFV7Fmg95HJ0DFe0=;
        b=q6PI2LccpOet2UWl2a1rZaq8BCOp4u/fjo2PhlzERzb0tXEWAHIRiDpwX+M9q80BIy
         l5Nx+HI0wQFiMGBw+mGH+dYOBob1WNwlZZfJKEz+SrZ5Ocn9ZQXcaRa/WuuI+zxRuL5y
         l0jqxLiAPEws+4JEdc9bb4e0WQXXP5MO6Ge8/vpsHFNpkI9WIXv6WY21zkaJ4P1vNxzk
         Bprmliar59PIfOC/sc3ROnG4N/7W2/KBW3R3T+8KXBLrAfQsMLdXuADGPkcrB7uTjkgB
         jQq74dS4pxMGPk0VbTlgsO/OV7VvjD685ai6fjOGxF28guJkUFMCidebdG1IImdaoTMc
         Lzag==
X-Gm-Message-State: AJIora8Un+icXFQ3QUF44TFni2Z8qionb2pv5FADJ+jwTf6nusbu/FgO
        Hu2sRuhIfOV/gD0QojZYbXkQ6Q==
X-Google-Smtp-Source: AGRyM1s/Knjx88HG6B+GNu/lY+h+uZegZ9mmb8afXy7xIniy9hVOBoT8GVTyeAQi3BYzrrvdRpX2LA==
X-Received: by 2002:aa7:d8d1:0:b0:43c:ce93:ff67 with SMTP id k17-20020aa7d8d1000000b0043cce93ff67mr19896923eds.295.1659436264183;
        Tue, 02 Aug 2022 03:31:04 -0700 (PDT)
Received: from localhost.localdomain (ptr-4xh0y3uhn87zojrdbwi.18120a2.ip6.access.telenet.be. [2a02:1810:a44c:8f00:733c:5cdf:8a1a:e482])
        by smtp.gmail.com with ESMTPSA id k10-20020aa7d8ca000000b0043cb1a83c9fsm8057794eds.71.2022.08.02.03.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 03:31:03 -0700 (PDT)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Crt Mori <cmo@melexis.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: iio: mlx90632 Add supply regulator documentation
Date:   Tue,  2 Aug 2022 12:30:54 +0200
Message-Id: <20220802103054.423372-1-cmo@melexis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the newly added vdd supply option.

Signed-off-by: Crt Mori <cmo@melexis.com>
---
 .../devicetree/bindings/iio/temperature/melexis,mlx90632.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90632.yaml b/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90632.yaml
index b547ddcd544a..4a55e7f25ae7 100644
--- a/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90632.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90632.yaml
@@ -35,6 +35,9 @@ properties:
     maxItems: 1
     description: Default is 0x3a, but can be reprogrammed.
 
+  vdd-supply:
+    description: provide VDD power to the sensor.
+
 required:
   - compatible
   - reg
@@ -50,6 +53,7 @@ examples:
         temp-sensor@3a {
             compatible = "melexis,mlx90632";
             reg = <0x3a>;
+            vdd-supply = <&ldo4_reg>;
         };
     };
 ...
-- 
2.34.1

