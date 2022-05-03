Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0160517E0F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 09:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbiECHKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 03:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiECHK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 03:10:29 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EB22AC67
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 00:06:57 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g23so18837262edy.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 00:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kc27XkBGcgpvj03uAIYtN/02TiD3/pa2n1+ce6OYwxU=;
        b=oiujbke1mRaMlkrcvlJUsyRrSeYQQfI74Nfjm3EQNjNj1vJPnauGqf8I9d/0ottIAO
         9blvr38o8Rx9hytaNwfDaQsSyqkgbczUToEqrMYzmV0IHAsfmBj0QSXXAGsx7WFNyTxy
         435x0+jDlBxN0vM9vG3RcXG4spjyxafTf2YUHIRJ4zBYN6e/LnFpdxUNvo5QsYxpjQBO
         6qeXC1TJYSr8NUBIAfIcmDZwu0/6StMwPGQdzfcBGX4JrmN8AIsVffC8MCECL7PFGQeh
         gDwdI4BEFBo0albVdfwjVn+rJM9UpO/hdMWSnCxWr2jSaIYyOv5RBqGgz99p8Uh2m1xG
         nBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kc27XkBGcgpvj03uAIYtN/02TiD3/pa2n1+ce6OYwxU=;
        b=en4W/MQDafmQCtoZT+Tu0v3zwxJ3lB5exWbz4m71uAaw6ZLwLyBVx9KGRKMr1D53LN
         MgoDw5l2wmcFzjqWIzBV8ivP18eKuza6NJ34G+G5ScITBdFJd2wDatWqRxI5+RvcZxlk
         QaAlSAI3MxeOnvi4ejFeOJ4wAuAcaQipJE2On0hZHPYoKezDfwqIx1iBEbw8Cr40OcS0
         N6oZe63D2GVRVAe602nu8sbV9Z71tHM/l/uMqnqzCwA3osZkVQVyD1Vi4ugUvoSV5p/t
         5NBkqbAva3C4aETvkp2R/0BvejsuaSDZn0LwXibiGuqRIVB9aHH8zfjDtCmWZ+h3S1yC
         XhUQ==
X-Gm-Message-State: AOAM533kZK4dtyOBjouG8x3n4ZQapDPvcy9jb8kuk80C1CDq9S7rVGeQ
        7MgPTQj4+Vy5FSiHZoYR0FINCw==
X-Google-Smtp-Source: ABdhPJx6otopPtL/mDsEY9EYB6OU78ELkUNRo7Bc1zygiqHJ0krCRFZejUlcSAKWtlvTUFjS9GkqFA==
X-Received: by 2002:aa7:d407:0:b0:425:f57e:7ae5 with SMTP id z7-20020aa7d407000000b00425f57e7ae5mr16536588edq.393.1651561616510;
        Tue, 03 May 2022 00:06:56 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ze16-20020a170906ef9000b006f3ef214e37sm4300593ejb.157.2022.05.03.00.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 00:06:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] memory: drivers for v5.19, part two
Date:   Tue,  3 May 2022 09:06:52 +0200
Message-Id: <20220503070652.54091-1-krzysztof.kozlowski@linaro.org>
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

On top of previous pull (tags/memory-controller-drv-5.19).

Best regards,
Krzysztof


The following changes since commit d37b07897e5024088b2170b8e6e1c68d567b9be6:

  memory: fsl-corenet-cf: Use helper function devm_platform_ioremap_resource() (2022-04-19 16:59:03 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-5.19-2

for you to fetch changes up to 854fd9209b20837ab48c2e6714e5e44dd8ea33a2:

  memory: omap-gpmc: Allow building as a module (2022-04-29 08:57:36 +0200)

----------------------------------------------------------------
Memory controller drivers for v5.19, part two

1. Cleanup: simplify platform_get_resource() calls by using
   devm_platform_get_and_ioremap_resource() helper.
2. OMAP: allow building omap-gpmc as module and make it visible (it is
   not selected by platform anymore).

----------------------------------------------------------------
Krzysztof Kozlowski (7):
      memory: da8xx-ddrctl: simplify platform_get_resource()
      memory: emif: simplify platform_get_resource()
      memory: ti-emif: simplify platform_get_resource()
      memory: ti-emif-pm: simplify platform_get_resource()
      memory: tegra: mc: simplify platform_get_resource()
      memory: brcmstb_dpfe: simplify platform_get_resource_byname()
      memory: renesas-rpc-if: simplify platform_get_resource_byname()

Roger Quadros (2):
      memory: omap-gpmc: Make OMAP_GPMC config visible and selectable
      memory: omap-gpmc: Allow building as a module

 drivers/memory/Kconfig          |  2 +-
 drivers/memory/brcmstb_dpfe.c   | 10 +++-------
 drivers/memory/da8xx-ddrctl.c   |  3 +--
 drivers/memory/emif.c           |  4 +---
 drivers/memory/omap-gpmc.c      | 43 ++++++++++++++++++++++-------------------
 drivers/memory/renesas-rpc-if.c |  3 +--
 drivers/memory/tegra/mc.c       |  4 +---
 drivers/memory/ti-aemif.c       |  4 +---
 drivers/memory/ti-emif-pm.c     |  6 +++---
 9 files changed, 35 insertions(+), 44 deletions(-)
