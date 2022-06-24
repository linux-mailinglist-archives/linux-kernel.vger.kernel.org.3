Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBF0559536
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 10:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbiFXISa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 04:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiFXIS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 04:18:29 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA5763612
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 01:18:25 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id c65so2371123edf.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 01:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qVB8bxx/r3S0fdgYdnv0n6Orbk3zdo+20SameD8/IKc=;
        b=h1oK/vu/uSxYa5LkNyd81gudxYa95rDOqzAavEXzV+f0GyVRNjKdN8pPA3mXK418xG
         rBYWIs83RfC3BkFrlQerH89Pa89ZxxiG0P5A4obM1r5X5PPKSRwYQ3rg1z1tlmD+fCpr
         +EKpEXbvvRhD0teOgVgPpJ/IuznJx+bk/+3uYfJ1RerThkowl9zTOkZCsf//lJK3jlka
         Epuyw14kA0b1v5zd8+9ktnmlHr6iQdpsjirkhX2+SJBQOSDM+70gO4f8jBVuVmGlHJNV
         LT43hlt2pTxvI0fe8XEaUn3ppYYkzku/ENo+LFEHoV173tfnSHFWNyUOUG7k3Bvk8pm+
         1baQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qVB8bxx/r3S0fdgYdnv0n6Orbk3zdo+20SameD8/IKc=;
        b=wK1u5CB3kGv1EpWqgihfIg1Y0c7fkOQP58dHNjK+16E50G7lZEBwHfXXJlbzdq/7Kh
         xrABVf0rgbZCAFMWtWvI2noMURcpIt92I9Si0Ru3VHpq0Xa0xnaANKbZPMxOnRVacTYx
         2HZwov9Jy8djTPso7wIHlkIYAaZ8o38yEqytx7X54qDrFf6dSbUyV+jW7USlZif4SBNx
         vhOW+jpX4P7OzwC9hpUxu1OG2LZIL0eaG0QShqI9VaM1vdaEa46ilPkOInNDguvdzR5w
         VWbUnRG+Jl+Ej2cEYSo4PRUcngkXSRAwkvscVwfOH3Kgaw+ujhg2bmUQZQjbVm4xWR3v
         iB4A==
X-Gm-Message-State: AJIora/+e2vIj1xkTDxZJNPYKGQH8ReT1854ge4WVzxJ0zOlh9i1gKAs
        xlC7IxuhFQAmg38cgTC8sOAjmg==
X-Google-Smtp-Source: AGRyM1vHr4xowKwQ5Nwu/LWw9TGrDN7QBcEOmV5mZLUL+m+jloOePEt0fBnbVZQzfQD0OBvHj1ZtAg==
X-Received: by 2002:aa7:d6c9:0:b0:435:6698:589a with SMTP id x9-20020aa7d6c9000000b004356698589amr16029481edr.59.1656058703927;
        Fri, 24 Jun 2022 01:18:23 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id r22-20020a170906705600b00703e09dd2easm701619ejj.147.2022.06.24.01.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 01:18:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL fixes] memory: fixes: for v5.19
Date:   Fri, 24 Jun 2022 10:18:19 +0200
Message-Id: <20220624081819.33617-1-krzysztof.kozlowski@linaro.org>
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

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-fixes-5.19

for you to fetch changes up to 1332661e09304b7b8e84e5edc11811ba08d12abe:

  memory: samsung: exynos5422-dmc: Fix refcount leak in of_get_dram_timings (2022-06-06 11:18:20 +0200)

----------------------------------------------------------------
Memory controller drivers - fixes for v5.19

Broken in current cycle:
1. OMAP GPMC: fix Kconfig dependency for OMAP_GPMC, so it will not be visible
   for everyone (driver is specific to OMAP).

Broken before:
1. Mediatek SMI: fix missing put_device() in error paths.
2. Exynos DMC: fix OF node leaks in error paths.

----------------------------------------------------------------
Geert Uytterhoeven (1):
      memory: omap-gpmc: OMAP_GPMC should depend on ARCH_OMAP2PLUS || ARCH_KEYSTONE || ARCH_K3

Miaoqian Lin (2):
      memory: mtk-smi: add missing put_device() call in mtk_smi_device_link_common
      memory: samsung: exynos5422-dmc: Fix refcount leak in of_get_dram_timings

 drivers/memory/Kconfig                  |  1 +
 drivers/memory/mtk-smi.c                |  5 ++++-
 drivers/memory/samsung/exynos5422-dmc.c | 29 ++++++++++++++++++-----------
 3 files changed, 23 insertions(+), 12 deletions(-)
