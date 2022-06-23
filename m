Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C76055785F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 13:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiFWLFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 07:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiFWLFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 07:05:40 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE92B4B431
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 04:05:39 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id cf14so18228488edb.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 04:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D3Gu/8nTWxZTQK0cjVHFrSqiW7UgZie3lj03csp3tX0=;
        b=QK2dN86cO1YufMu6N9VLfiiK5vO63Ty9BkzEaKhgXuh/JplwGD9PlbLEFSJLxvvlUE
         eFxqNteHBKdW+Sw4G1HmD8BgoKREeLSyXl4Zv5VdknopjoXWaywO/mH6CPZB6sl6jPUT
         pl5n1THaaXNeDSdUm+6o49Zgx8vaMm+krPBbfI+oJahb03q7aYlwZ5sXYqbEvZLc/nXt
         vHM1wbyfUVF9fksojm1aqzt9SjF51449n1QRXU67pIOKbfRSc/ZzQGzRk1rEUBW9CrEl
         5M9rMz/VSD2V1fQchJU9oeQuzhHLjNU0AlF/aeUrk3vX4+AID1+csz7sTTtX6AhlVMET
         5I1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D3Gu/8nTWxZTQK0cjVHFrSqiW7UgZie3lj03csp3tX0=;
        b=YYH3wT2mrBNTV52K40qOAL02HUQ9TY+QZno0XipDE+nGEkcHgAgpOFD7NvK3uIlUNG
         ZUNaA9vY8yi4SVAog/LIq/7BHw2y3/bnT8vxzd7U78K03JEfdXIVW6lI1fPoBoUIy1Ve
         ithCYlOCxNscdfjH/33je96qbqXQm2Kf8teJkxFXg0r8QeL8m9qeIxOVvuu4GHDEOLJ4
         wB9vHHBOFu9jvDdx9BaU8SEgoH521RN1LUUtTMEGV7OoEgomketx43XVKOCtGXPAuRtE
         xCFVGimg0VOhXuJVEwRQq0J12zBDVbKz4LmHWgw3AAFUtOr1EJQnVFZIx0DBDlaT+Txa
         7lpg==
X-Gm-Message-State: AJIora/Iqr4HzhqnelkJMoKl6j0pQt1dKJfn52SrPK/7asE/jWUof8Xl
        x/sPBip7hYJXQOmFwdQYRw1HVg==
X-Google-Smtp-Source: AGRyM1v2E3x5h2VV6bQvwEbYXy3dDmfD+jRr/w7+3Ao5XMMBkw0RqXJKZf/WCi9eKAlulQk1nMzW2Q==
X-Received: by 2002:a05:6402:1f14:b0:435:97f3:640 with SMTP id b20-20020a0564021f1400b0043597f30640mr9990171edb.169.1655982338174;
        Thu, 23 Jun 2022 04:05:38 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l9-20020a056402254900b0042de3d661d2sm17778879edb.1.2022.06.23.04.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 04:05:37 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] ARM: qcom_defconfig: enable socinfo driver
Date:   Thu, 23 Jun 2022 13:05:34 +0200
Message-Id: <20220623110535.177326-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Enable the Qualcomm socinfo driver to provide some basic information
about the SoC being used.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 5cd935ee148a..563a396bfb23 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -253,6 +253,7 @@ CONFIG_QCOM_SMP2P=y
 CONFIG_QCOM_SMSM=y
 CONFIG_QCOM_RPMH=y
 CONFIG_QCOM_RPMHPD=y
+CONFIG_QCOM_SOCINFO=y
 CONFIG_QCOM_WCNSS_CTRL=y
 CONFIG_EXTCON_QCOM_SPMI_MISC=y
 CONFIG_IIO=y
-- 
2.34.1

