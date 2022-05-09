Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7085201F5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 18:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238864AbiEIQMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 12:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238850AbiEIQMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 12:12:06 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1411A270C8A
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 09:08:12 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ks9so21348947ejb.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 09:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NOVuzkGtUFMZkUhl8LlnbBPQ227MlE7VyG3byjiP1jw=;
        b=mQA5pnSW3NegCJ5ZG+24oCq56yDE2BdbIvXVs7LcZWiDb6bgBUUOl7togdgVnSjexP
         KMWuvadAizO7/gDqhi+GKPU2kFR3v9nn9HSEKYMk/MaNjneK4FNHwD+i9VMSKSgOC5UI
         7DWsWOXoUG8p8OXWZZrwETGmieiZmeQXwNf3Zo9zE0LmNbztUWIudzmeeAx6rNgoWVSo
         G3Q2hhkvooCb4Y/GCTNmx8kXFqLsxKxEL5X4dqNz/1IZ4QOT/dVczpTQWq9ajJ4Ia5uF
         8ceoR0usOt8k2LuMgsLMexR8DBuflKuC6IV9cus4Fv0EUCS/ViJwQQklF8OhoZRCcLDg
         uxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NOVuzkGtUFMZkUhl8LlnbBPQ227MlE7VyG3byjiP1jw=;
        b=BxTfSZKi5o+73fC2x21qsHQSFyceScrv5GpW8trcCxBGAqF8XqNDm+Tn5j6iDx9DOm
         Evjcf5wON2i8DZT33MxOUBicJlPqLfis/miAqKwSK0+GoqeX14l2pNZlUjzF7+WmPIU5
         YsQScTgodyadh4PD4IcGSTO5Ienai8hA6103mX1uyq1xHT5wL4QML3nJsuyLMYXKdHvj
         tPmn1KCUzUEs49agIEgNAGkfPE7r7rVzVh0eouWOeWTpCWkxPRNVob+6PefLCKMgiFHc
         BkX4K4pQ8JKaUFRqjXFRM5yBp2JzHzVWeJgXgDug2Lo6fzFoHbYUiupr98lGZtgq/jhB
         vE2Q==
X-Gm-Message-State: AOAM532Ogvu9BCw7W5Ys4USZWS9GZWiXOw+1iLq2GWkpzznG8zXd3xxb
        2TQMT9UX0n1WAEFi0b+fu9NWWg==
X-Google-Smtp-Source: ABdhPJzdnVrZKcw9d2SLcvlOMJOYlVlkkba+emfNm8k6JJCsHoFH9gvBn4ng6PIjjG5EhiOkU+tr5Q==
X-Received: by 2002:a17:907:7dab:b0:6f4:6650:395d with SMTP id oz43-20020a1709077dab00b006f46650395dmr14833140ejc.82.1652112490673;
        Mon, 09 May 2022 09:08:10 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id jl8-20020a17090775c800b006f3ef214e2dsm5157631ejc.147.2022.05.09.09.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 09:08:10 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Thierry Reding <treding@nvidia.com>
Subject: [GIT PULL] memory: drivers: tegra for v5.19
Date:   Mon,  9 May 2022 18:08:07 +0200
Message-Id: <20220509160807.154187-1-krzysztof.kozlowski@linaro.org>
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

Topic branch for Tegra specific memory controller drivers.

Best regards,
Krzysztof


The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-tegra-5.19

for you to fetch changes up to 54a85e09f44c5fa322a2d186f50862d09f517225:

  memory: tegra: Add MC error logging on Tegra186 onward (2022-05-09 10:46:14 +0200)

----------------------------------------------------------------
Memory controller drivers for v5.19 - Tegra SoC

Add support for Tegra234 memory controller and for logging memory
controller errors on Tegra186, Tegra194 and Tegra234.

----------------------------------------------------------------
Ashish Mhetre (2):
      memory: tegra: Add memory controller channels support
      memory: tegra: Add MC error logging on Tegra186 onward

Sameer Pujar (1):
      memory: tegra: Add APE memory clients for Tegra234

Thierry Reding (1):
      memory: tegra: Add Tegra234 support

 drivers/memory/tegra/Makefile       |   2 +
 drivers/memory/tegra/mc.c           | 137 +++++++++++++++++++++++++++++++-----
 drivers/memory/tegra/mc.h           |  50 ++++++++++++-
 drivers/memory/tegra/tegra186-emc.c |   3 +
 drivers/memory/tegra/tegra186.c     |  39 ++++++++++
 drivers/memory/tegra/tegra194.c     |   9 +++
 drivers/memory/tegra/tegra234.c     | 110 +++++++++++++++++++++++++++++
 include/soc/tegra/mc.h              |   8 ++-
 8 files changed, 339 insertions(+), 19 deletions(-)
 create mode 100644 drivers/memory/tegra/tegra234.c
