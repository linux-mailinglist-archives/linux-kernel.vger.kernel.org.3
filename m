Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2EF748DF14
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 21:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbiAMUh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 15:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiAMUh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 15:37:57 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0CFC06161C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 12:37:57 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id p27so12034263lfa.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 12:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VEcTviwAJjTA/PedVKsrB+d6L5irDjmQTiLW4y3/Af0=;
        b=BWfjSwRoeU2riXY1ZPs/XI/Cc41g7MMSZ2xpawgbbGgzFPgPOw2eueTj6hVygqycaV
         lJ0A1IhD9mYvyeDXOkma1D56qzPoGGFrLuiYegOTECpdoqU/yOs7lZ3i/4+wp0d3qMvG
         QJug3Z2HmY95KrlrKqteLfl9SytEMuYbAbDFRWrMLCGBePSANq49WJG68k9VG3m8qzus
         JARfZubi/QnSxI1Clp9O3fCW+0zkb3tJX3iSemRcepW5ZG7HCaci8Tfhv6HVrXU04NqB
         cmx3OV90nC5USr8gjbpiy5ODdw5CuPYmJwPZMneRWV7g4kZg7ykyHZhhuTBmJVSeftVM
         XIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VEcTviwAJjTA/PedVKsrB+d6L5irDjmQTiLW4y3/Af0=;
        b=KilBI7yUaw3q2kZpRuHZPWD7eEZ767AdO+VOJls1dHjL1GB+Dk3BadJOOmjaDzJOFE
         x+FfYXSPUn7qHdbP2l1bkjqclvIb+JrYEZWXkaq8R+or5XCMVgow10BQ8aBzILA3lBY/
         sCyaS6RAc13j0Ltyd8iusWzG1KWdDhoIavtxFtHiExuEh+f2wNP+zKdrzGJhjD89EOVZ
         DPWUwqf5SIoJ8oOoZ2lAi0m+flOqiMljt/+N9BaYHV1wvlvKjTsVH9Zv1DGGjzZNDIAH
         BRMarQfnsMIwhj9wN7Y1ZLgE+T0z58ZPEZKgHwquWXBeLufvIaSe3jVcWn2aZyNbffVn
         HCnw==
X-Gm-Message-State: AOAM5329eZLbb1/NvqgpZmSFWJcDrtWiAjRlmPtgeXT6b8YiuR3L+Q4B
        jlRTgNMbr/pFFzgQ9QyiQ6nWeQ==
X-Google-Smtp-Source: ABdhPJxP+YP/Eo4PH5vp+BdZtCJMRAcFlg33a6l/fZVWsMv6jFQDaXEv33wymB1vK3cCcpq1V6TvRQ==
X-Received: by 2002:a2e:a7d6:: with SMTP id x22mr4055309ljp.76.1642106275601;
        Thu, 13 Jan 2022 12:37:55 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id k21sm363298ljh.65.2022.01.13.12.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 12:37:55 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: samsung: Fix typo in CONFIG_EXYNOS_USI description
Date:   Thu, 13 Jan 2022 22:37:54 +0200
Message-Id: <20220113203754.23197-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The proper name is Exynos Auto V9, not V0. It was the typo slipped in
unnoticed, fix it.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/soc/samsung/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
index a9f8b224322e..02e319508cc6 100644
--- a/drivers/soc/samsung/Kconfig
+++ b/drivers/soc/samsung/Kconfig
@@ -31,7 +31,7 @@ config EXYNOS_USI
 	help
 	  Enable support for USI block. USI (Universal Serial Interface) is an
 	  IP-core found in modern Samsung Exynos SoCs, like Exynos850 and
-	  ExynosAutoV0. USI block can be configured to provide one of the
+	  ExynosAutoV9. USI block can be configured to provide one of the
 	  following serial protocols: UART, SPI or High Speed I2C.
 
 	  This driver allows one to configure USI for desired protocol, which
-- 
2.30.2

