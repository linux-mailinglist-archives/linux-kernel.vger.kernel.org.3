Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC6D569C67
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbiGGIET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiGGIES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:04:18 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D6825C5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 01:04:17 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bf9so6550333lfb.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 01:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t9dYgQ35cdd5QcwdHZmKr6Q8Vl0RugkCrkWrdr8ld24=;
        b=AeV56w8X6d0UUFxOQOh6iNGq9TyUYX8ofNmERk0UhTdG9g3q6Rd8ibW7E60fMU73N/
         E/HlUkN/PpEXf1DM786OvOL7jyPe4cDT63s//co2l2T3vtIxbVNy+Jzm49G2nCMu7wxC
         U5jOYRdmdvIy6sVDYyjEGqUb3P04X/1iK2UTTbyoBqZ+X1aJLgHCEekcW895rw0Dekhb
         CeiFBn9raIWf/7ACKj2h/05hz/TKzzaFob3nEcs0p2c8tC+tA/lnMUKrgMm/yYTOXaOe
         TWLrSJWQrLkFHIva/c9meAiKyZvUYQDLgiftcbMLwtiCP5vytl4iA4dg4HBhW3NrLauf
         VFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t9dYgQ35cdd5QcwdHZmKr6Q8Vl0RugkCrkWrdr8ld24=;
        b=rybtbM+MK+GMPXipkGNmW8c0K9xRMQyQd7zhO3cyT4699xgyQwYsNo262Q6g35u+w2
         IB5d/HveTy33r+n9VZCbeYNBCMDsocSHGPUlBnUl75PxHJTljzojZW4sRg83zFbZupmH
         JtOfJ3Wltj7JhUofnvLGalqc0dNJow5erKuvFgiP6/UleFsHwN3eanILrRLQkyChqHwZ
         cpxd7knBz5742wpSMNAKFFt1ytptspmcXjVMbajaS1YX5cQlU2beU4mRvPQo6L705DDZ
         ikFEvkrrZaAR2Fdq02fT42LVLncKQmIkAHpq7osiGHRnzQQrHRacIAVf/SAgwE2RLVSJ
         HlUQ==
X-Gm-Message-State: AJIora9w/4vYuGPzzH0Bk/3kKkIUaotPebguWi73xl6U/T6AqgRKsYyS
        51Hfo5egFasluab+5E3BADOhlnoOLXd5GCYi
X-Google-Smtp-Source: AGRyM1sFsafUoEd5OpC5bdbiu44MmM3ARKbnb0/kpVDSpu/pZHsf52Uy0hJBrMCVvqCZac/uRBLmBg==
X-Received: by 2002:a05:6512:3051:b0:47f:7945:83d0 with SMTP id b17-20020a056512305100b0047f794583d0mr26620431lfb.99.1657181055571;
        Thu, 07 Jul 2022 01:04:15 -0700 (PDT)
Received: from krzk-bin.home ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id u16-20020a05651220d000b00478ea0e4f66sm6702687lfr.169.2022.07.07.01.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 01:04:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 1/2] ARM: dts: samsung: 2nd round for v5.20
Date:   Thu,  7 Jul 2022 10:04:07 +0200
Message-Id: <20220707080408.69251-1-krzysztof.kozlowski@linaro.org>
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

Hi,

On top of previous pull request. This also includes DT bindings for
convenience, although nothing depends on the bindings itself.

Best regards,
Krzysztof


The following changes since commit 82cd16902a51773cfc0ee05bbd1ab470db5181ab:

  ARM: dts: exynos: add function and color to LED nodes in Odroid XU/XU3 (2022-06-22 13:58:01 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-5.20-2

for you to fetch changes up to 3e27bf719303b1b19edd37bd04e9e586c73f6511:

  dt-bindings: soc: samsung: exynos-pmu: add reboot-mode (2022-07-06 18:24:32 +0200)

----------------------------------------------------------------
Samsung DTS ARM changes for v5.20, part two

1. Cleanups: align SDHCI node names.
2. DT bindings: Document preferred compatible naming schema.
3. DT bindings: fixes and improvements to Exynos PMU bindings.

----------------------------------------------------------------
Krzysztof Kozlowski (8):
      ARM: dts: exynos: align SDHCI node name with dtschema
      ARM: dts: s3c24xx: align SDHCI node name with dtschema
      ARM: dts: s3c64xx: align SDHCI node name with dtschema
      ARM: dts: s5pv210: align SDHCI node name with dtschema
      dt-bindings: samsung: document preferred compatible naming
      dt-bindings: soc: samsung: exynos-pmu: cleanup assigned clocks
      dt-bindings: soc: samsung: exynos-pmu: use abolute ref paths
      dt-bindings: soc: samsung: exynos-pmu: add reboot-mode

 .../bindings/arm/samsung/samsung-soc.yaml          | 40 ++++++++++++++++++++++
 .../bindings/soc/samsung/exynos-pmu.yaml           | 13 ++++---
 arch/arm/boot/dts/exynos4.dtsi                     |  8 ++---
 arch/arm/boot/dts/s3c2416.dtsi                     |  4 +--
 arch/arm/boot/dts/s3c64xx.dtsi                     |  6 ++--
 arch/arm/boot/dts/s5pv210.dtsi                     |  8 ++---
 6 files changed, 61 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/samsung-soc.yaml
