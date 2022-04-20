Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F36508213
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 09:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359734AbiDTHaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240513AbiDTHaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:30:02 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF801107
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 00:27:16 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id g13so1687553ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 00:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V012myQFecH4RwOiutDxuAhe7kD3PdUfMSj2lgEMrMA=;
        b=BIguwQ0St1I5BdcJmLLQHXVyqVZkbjRiVuHtC++WSEf8y+nf7rBypBvTYezUVPc44N
         8eq3Dy2HVeCZK4QJsvIJEDWOhttBPSXBBcpIW45Urd19YQeDMi8CRrLGVKsvTOeTTnFw
         0QBlF8U5gPhnHdgdjAqC+MmMc4zFZS+5cknRt2N+76EunwOBmlvYPrjaOxxqI3bwOBVS
         Tz+hBWm2hz9xpi2yDqSVskw8h+2beVoLWrMiFOW1ql4c0EYlTaYhPNAcJfJ4WbofJAIA
         DPSm7gZNoCCb1kqSn0aj1pYGpBKa3SSgclM3Nw8pyhazOGFbn7HSPyS/RJv4u+yFbRGp
         fW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V012myQFecH4RwOiutDxuAhe7kD3PdUfMSj2lgEMrMA=;
        b=BzzIrVsOswdIggExgFRMKtT0VNxgpt1Qz178eEIRfaJhxr723o9cGIW3ymHBLSfa0G
         gP5WAVbmycoiRHe01Xuo2+lI4s7HzxWl3Qo6pN3R/0kWeaeYLWH9LT7t/UF1csyPiiH3
         SEf4GW56Sjqm4x/ZT33FhPTXc+cdE55oOVPVPgyhItBR0XMYYkV3a+ChvhzrsI9Pd+5G
         TFQrA5UnSfHhQRarpz7NbldoJYcBR14mI5eqLz0Go4RAPnuZnxn/twCQMS03MWSBVRoZ
         zWHW/hQw0zDdqRSCVcOITkVFzb6rwzVDQhvYa9EUv6kK3Vk1pcw0Qaliti6RmcR3bigo
         Y8Ow==
X-Gm-Message-State: AOAM531Ld5lZod0OCybLmOghZRHpTZZwKH09TEycN/xfFnEJwM8f6omy
        5vvfwL5gnQIDZTA08/aMIzbJqQ==
X-Google-Smtp-Source: ABdhPJwt7yUdpklzrHQQHRPhDbadLHRqaTEz8y0KS4pjn8IitxP+QbvgQWdrAiB1aPUVmcgx0aor3w==
X-Received: by 2002:a17:907:7f19:b0:6ef:fe0b:71aa with SMTP id qf25-20020a1709077f1900b006effe0b71aamr1784184ejc.493.1650439634807;
        Wed, 20 Apr 2022 00:27:14 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id lg4-20020a170906f88400b006e869103240sm6366147ejb.131.2022.04.20.00.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 00:27:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] memory: drivers for v5.19
Date:   Wed, 20 Apr 2022 09:27:12 +0200
Message-Id: <20220420072712.12648-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
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

Early pull with few commits.

Best regards,
Krzysztof


The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-5.19

for you to fetch changes up to d37b07897e5024088b2170b8e6e1c68d567b9be6:

  memory: fsl-corenet-cf: Use helper function devm_platform_ioremap_resource() (2022-04-19 16:59:03 +0200)

----------------------------------------------------------------
Memory controller drivers for v5.19

1. Exynos: Reduce memory usage/allocation in Exynos5422 DMC driver.
2. Renesas:
   - Add bindings for R-Car H3/M3/E3.
   - Simplify single/double data register access.
3. Minor cleanups: TI/EMIF and FSL/Corenet.

----------------------------------------------------------------
Christophe JAILLET (1):
      memory: samsung: exynos5422-dmc: Avoid some over memory allocation

Geert Uytterhoeven (2):
      dt-bindings: memory: renesas,rpc-if: Document R-Car H3/M3/E3 support
      memory: renesas-rpc-if: Simplify single/double data register access

Krzysztof Kozlowski (1):
      memory: emif: remove unneeded ENOMEM error messages

Lv Ruyi (1):
      memory: fsl-corenet-cf: Use helper function devm_platform_ioremap_resource()

 .../memory-controllers/renesas,rpc-if.yaml         |  5 ++++
 drivers/memory/emif.c                              | 11 +--------
 drivers/memory/fsl-corenet-cf.c                    |  9 +------
 drivers/memory/renesas-rpc-if.c                    | 28 +++++++---------------
 drivers/memory/samsung/exynos5422-dmc.c            |  5 ++--
 5 files changed, 17 insertions(+), 41 deletions(-)
