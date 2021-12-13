Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C79B47267F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 10:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238413AbhLMJw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 04:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234972AbhLMJop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:44:45 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6A5C08EB19
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 01:40:52 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id i12so14426672pfd.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 01:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uZDeQb0Ps3ShCtM92tys7SAGXkYQwfQLQeqO425ONg4=;
        b=WsDhAlcwPpF6QMfxvJ2P67WsPkBZ2RwqiGsys5KG4ocv1l6Vw+/xOscJIzSU7zt4Uh
         6TSc+/nrXr896LrOqoB9dVKioMfNxqgQOf2Tfn74zA7f6bK3GbW5XDHYsZNSe3YyWXfg
         5HzPAycOG4R/UDENjRSZmYQU/AEROJ7Jd19qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uZDeQb0Ps3ShCtM92tys7SAGXkYQwfQLQeqO425ONg4=;
        b=0FEXmC/Oq/6UhD139gGKh5KTb4H8TxrWDX2c548UfX5doorwuBuI96guKpV0CI8VYB
         3R3bWcyNO7HkS1rdwkzE9ZvfvnNK3bggp5phuyQKqL8RJTpqjF5O2BRzKjIizPtVhfb+
         8fVpu3yNKyX6FupVcwyarwHwuHbi2Rw/0YADRQvG8ltlB0eyWUdxQ6wHRAXb2WNFhAT+
         ry8tMUv1WCwjeVbkqY93ALVd2ilN9NLboxDgejjIXH3judK+RlzPIzO6WcLT++e0QYWF
         7Ik3UGicnOV2buObwCS2TKLHPh+uCNWLsV8QBgeYsK8/U6X5SBJ5CQu9SR76QFx6QIg6
         +XyA==
X-Gm-Message-State: AOAM531Lrnyu6tLZwnUji3flA3FYBOcglFiSSZ8g3TxMxzhECt3d2gZq
        JWTwwPOuw56dRzRmMb2dhhfxxA==
X-Google-Smtp-Source: ABdhPJzl9btVCCXeNVhmFmt7knCVA9TwgiOdvW4x8BLB7eiAe9MFR+j20F51njzr0AhPUe8MZDaPqg==
X-Received: by 2002:a65:6a0a:: with SMTP id m10mr51429721pgu.82.1639388452047;
        Mon, 13 Dec 2021 01:40:52 -0800 (PST)
Received: from shiro.work (p864106-ipngn200510sizuokaden.shizuoka.ocn.ne.jp. [180.9.58.106])
        by smtp.googlemail.com with ESMTPSA id d195sm10237609pga.41.2021.12.13.01.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 01:40:51 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, linux-gpio@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Palmer <daniel@0x0f.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/5] dt-bindings: gpio: msc313: Add compatible for ssd20xd
Date:   Mon, 13 Dec 2021 18:40:32 +0900
Message-Id: <20211213094036.1787950-2-daniel@0x0f.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211213094036.1787950-1-daniel@0x0f.com>
References: <20211213094036.1787950-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible string for "ssd20xd" for the SigmaStar SSD201
and SSD202D chips. These chips are the same die with different
memory bonded so they don't need their own strings.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml b/Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml
index fe1e1c63ffe3..18fe90387b87 100644
--- a/Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml
@@ -14,7 +14,9 @@ properties:
     pattern: "^gpio@[0-9a-f]+$"
 
   compatible:
-    const: mstar,msc313-gpio
+    enum:
+      - mstar,msc313-gpio
+      - sstar,ssd20xd-gpio
 
   reg:
     maxItems: 1
-- 
2.34.1

