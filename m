Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D69569C66
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbiGGIEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbiGGIET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:04:19 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4642E31373
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 01:04:18 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id d12so6456392lfq.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 01:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z5ssFYeQl7V2JJ54NmhIzC4kevK2DFEIrlaz+FamJ4o=;
        b=nQyKLogTPnRG/buW57rEKh/p4nVI47DT4almuA9zdgse7ZnePqyIwZragdTmyL5Zkk
         Yp09663+gJTNo6qUACiFo0ItN4bQo+s4TS0rCPM2pDXCJPJX25HqaZZJNmvGB/j31Aq1
         aS3fWZ/H1HJmLrZV6uu9kUzNZlxk3eDVOBZXpwg0A10QMvW12iLmccF1dNE1rlP9sVtl
         Vq+JSBAzqzBEd5oPAnKpx18289Y2MSIz3mUyK+RGsBHrAhfB3FRo+SQj5UXSSaTGKfPM
         04k1TMBLdFVVsLPv9IxxFCW4Wh1/EQOusbiWmRBRv29+eVjtV9XMLbhofx+RqjB9ebGE
         QFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z5ssFYeQl7V2JJ54NmhIzC4kevK2DFEIrlaz+FamJ4o=;
        b=wPbxrwcDg4RDhY9cS8nDs5Wz2RqHiNOzQuJhoGGbjU9olfiBOOC5FYGacKmYTI8SJR
         2opVxa6GACRPlRWPKa3WZNP63aPMia5EIeiMYWW6p5R6gHKE/C1LHhihIq1A+Dd/Uctf
         jAS5mSfc2r4iGEpm+JuOb0YNyelO1TsLpiRtKW5PjCPTIPxD1halscPpEXT99BHEDSSK
         tZgUwi42fDHbQtHRY2Rfa9ijlyHbulIfvnsJrb4qkuwKtJuGLlR2gWBlZnE2+a9ME91o
         618Jm5mWSONGd/mRBEs+NNe3grWPLJrR3OjBPVqvhwDx8oXrYZF4xyHO+k94Kc50pYlr
         S8bA==
X-Gm-Message-State: AJIora9Qq8ANHSXVico4mFHFs38w8nFZ2gWdEU5ezsnNTnOm4O52ld9l
        Xi3daV5V6V4+pHy+PYemdWDEMA==
X-Google-Smtp-Source: AGRyM1uBT3p2me4ed88jdqAaeNxgZQVJKSTxRZJFJljooGEjRoS8yamieK3o3TdtSIRerorKAVhrTw==
X-Received: by 2002:a05:6512:3c96:b0:488:c36d:b336 with SMTP id h22-20020a0565123c9600b00488c36db336mr623077lfv.410.1657181056637;
        Thu, 07 Jul 2022 01:04:16 -0700 (PDT)
Received: from krzk-bin.home ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id u16-20020a05651220d000b00478ea0e4f66sm6702687lfr.169.2022.07.07.01.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 01:04:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 2/2] arm64: dts: samsung: 2nd round for v5.20
Date:   Thu,  7 Jul 2022 10:04:08 +0200
Message-Id: <20220707080408.69251-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220707080408.69251-1-krzysztof.kozlowski@linaro.org>
References: <20220707080408.69251-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On top of previous pull request.

Best regards,
Krzysztof


The following changes since commit 1a4f20cab6411c6e73dd22d28b6595b728cc2829:

  Merge branch 'for-v5.20/exynos7885-emmc-clk' into next/dt64 (2022-06-24 09:12:47 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-5.20-2

for you to fetch changes up to 1ba1fd7d775dbccf43951671a7331c561408e72b:

  arm64: dts: exynosautov9: add usi device tree nodes (2022-07-05 12:34:36 +0200)

----------------------------------------------------------------
Samsung DTS ARM64 changes for v5.20, part two

1. Correct SPI11 pin names on ExynosAutov9.
2. Add more USI (I2C/SPI/UART) devices to ExynosAutov9.

----------------------------------------------------------------
Chanho Park (5):
      arm64: dts: exynosautov9: correct spi11 pin names
      dt-bindings: soc: samsung: usi: add exynosautov9-usi compatible
      arm64: dts: exynosautov9: add pdma0 device tree node
      arm64: dts: exynosautov9: prepare usi0 changes
      arm64: dts: exynosautov9: add usi device tree nodes

 .../bindings/soc/samsung/exynos-usi.yaml           |    8 +-
 .../boot/dts/exynos/exynosautov9-pinctrl.dtsi      |    6 +-
 arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts   |    2 +
 arch/arm64/boot/dts/exynos/exynosautov9.dtsi       | 1087 +++++++++++++++++++-
 4 files changed, 1093 insertions(+), 10 deletions(-)
