Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC835150CC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379123AbiD2QbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379108AbiD2QbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:31:16 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB512D95D5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:27:57 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id n32-20020a05600c3ba000b00393ea7192faso5047696wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MW4/SCqXJVlOKCfNX0kh20TWsOYEb0YYvKibQ3Hqw4A=;
        b=sLcpEho4+NsJLgcRC8qZZScY/AbdEJ9oyDjgwMrPiPfyGi43JtgFgRmo/UdVd1Mvq7
         uLcvPwop3kBoBSOcwZkfrNNYLg3S+Giv1ydkHijy0OfEY9fFz1cMpuDXBz8vlmG1Rqgd
         pxpNHV1gEuaQoiRi4b7Rew8BPah7TJLqbh4I/81cjd4yhROk9T+90GnXYiSZW2JQTgtP
         YDu5pDbPjEAldogDGyGB5P8jhIVQKKcPqGeIsdzCm0CLULCeuIC8MeZ0iYuL3RHcDGvl
         iGdFJv1vv0dUGWXzOTkjgO5rthQ+KQ/1b/Jl/GoKdJ6ojo2wyP3/RiaI0p6EJ05ubA6S
         S5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MW4/SCqXJVlOKCfNX0kh20TWsOYEb0YYvKibQ3Hqw4A=;
        b=AEorP7yRKEfxmnQcKoVc+j/nZmXZY9dQKz+QyJ3LVWzmleshapSIjl9cG6wbjspPm6
         pnNoybAOVzpxATl42jPrr8RoMvX0mGFP3o7yXuDcAQgYbxh/63+BybVaLmtIj7HLD8FC
         y/PgRdSkIS6+DnBRoNlUAyieTJtR6MFVkk5aTjiv3ZZWDIOKfGldrW8G9HT05JL6Eu59
         oxzqz82sQXy26d5Z3s+rHTN2sr3tuH2UJ4lVgjw27W3XKMKOXOCVwt8iJ8pyKcSCAnZA
         CLOxNUMLE9s8/FBrYMbToi/WhIZj+1kJSK1fV6cYXCyA6K+CcPjdMm88wCiAwjHCGUxu
         qK5Q==
X-Gm-Message-State: AOAM531srGzrERdkLRrz337yBRIXbJKxBGMLNw9rqMEG1vs1d5nsy9xm
        SsZMZ8l6ErUU7/1sCSeyea/pLg==
X-Google-Smtp-Source: ABdhPJzuetYpkT6RQv2eNup8cZFEfLe03TK5FgNwDYL2xdl2WTx9LY4GgzjESxJ6RS482oVnU944bw==
X-Received: by 2002:a1c:3587:0:b0:381:50ff:cbd with SMTP id c129-20020a1c3587000000b0038150ff0cbdmr3954921wma.140.1651249675926;
        Fri, 29 Apr 2022 09:27:55 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id b5-20020adff905000000b0020a8781be70sm2781801wrr.12.2022.04.29.09.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 09:27:55 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Sven Peter <sven@svenpeter.dev>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 03/16] MAINTAINERS: Add apple efuses nvmem files to ARM/APPLE MACHINE
Date:   Fri, 29 Apr 2022 17:26:48 +0100
Message-Id: <20220429162701.2222-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220429162701.2222-1-srinivas.kandagatla@linaro.org>
References: <20220429162701.2222-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Peter <sven@svenpeter.dev>

Signed-off-by: Sven Peter <sven@svenpeter.dev>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fd768d43e048..1bf57fd937b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1837,6 +1837,7 @@ F:	Documentation/devicetree/bindings/clock/apple,nco.yaml
 F:	Documentation/devicetree/bindings/i2c/apple,i2c.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/apple,*
 F:	Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
+F:	Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
 F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
 F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
 F:	Documentation/devicetree/bindings/power/apple*
@@ -1847,6 +1848,7 @@ F:	drivers/i2c/busses/i2c-pasemi-core.c
 F:	drivers/i2c/busses/i2c-pasemi-platform.c
 F:	drivers/irqchip/irq-apple-aic.c
 F:	drivers/mailbox/apple-mailbox.c
+F:	drivers/nvmem/apple-efuses.c
 F:	drivers/pinctrl/pinctrl-apple-gpio.c
 F:	drivers/soc/apple/*
 F:	drivers/watchdog/apple_wdt.c
-- 
2.21.0

