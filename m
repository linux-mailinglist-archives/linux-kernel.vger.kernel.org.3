Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB66957FB22
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbiGYITc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiGYITL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:19:11 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F14613CD6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:19:09 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id b26so14859097wrc.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BiiV58nU4rcN8bdraPGg645D1WoAdToltdDT10Y4MlA=;
        b=yxSj25Jac0tBpewedcx75I0V8AXibC32IcqyFe5LWXT2XFcLbjj/VCWyt1YjR+Ambn
         4trkkyYubCldCHZgCtjTWcN2hj9fO7UMhw8fH8KAkBC4EXnr20asStmofrcxbG95hZi9
         qrO/nduVf/pBba+PHSS1PVku10Q76Uo+Kohv+5TLKZsUquUpAtxqbMrmGDrgj+EaNSYP
         yR7ajhLMqkZBaEOWHCrqI5IiwMyWymdNT6HPRgdBpQiGBa922y8hgDm7jBg77DKD5TKs
         A97TM4WFRhZA0PLJPPURZEK/s1GKD0xThMUIRIs1FfX0yvnF/i3tLcQEPtxuRQ/egi1G
         dysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BiiV58nU4rcN8bdraPGg645D1WoAdToltdDT10Y4MlA=;
        b=AcG/dkHwS6QAzq2Thum70ht10D3JFOyVCYvKq9PuhyTMLwyh1ULlmZ8ant8d2Mg5Aj
         ub188lsKAzyjU0I7uKuUTfJgttYfkgU03FUjJ1mnU/ygCp53CNrbrvdtBMIIH93Bueqk
         zFy6IgF6UGJDR6Pcyk3dyL+KYrpah76tEQb9TNXj14wArA6Yh+UBZgmd4lwBUVDgWRSQ
         VPqyN3hyL7yOlNV+Y4CSBro2NF3DfCGSlqByLMEUYH0E7nZlVtwPZWoCgxFDI+lreFIz
         /CoKIBiO8aXgYEkUBcMZ7EExwFvcIB8roGuPZPXmF526PNJ74kX3sqWqMFN4TgXShdtb
         xRdQ==
X-Gm-Message-State: AJIora93kZMvmPflBH2aVPDCzbCQqejacq8i9BC4W86KUQ5HLfJPR5AT
        anZjKeVxIFXGCIrmqqdIpLDmkw==
X-Google-Smtp-Source: AGRyM1s09Hj0Ovo8gO4XIgJh8/tiWDq5AfIXHuQX7HAQyK6OBlWljcZEzkfM801KP4JxiVQI7Qx9/A==
X-Received: by 2002:a05:6000:1acb:b0:21d:ad71:3585 with SMTP id i11-20020a0560001acb00b0021dad713585mr6633475wry.156.1658737147630;
        Mon, 25 Jul 2022 01:19:07 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4090:a243:806e:25e7:daa:8208:ceb])
        by smtp.gmail.com with ESMTPSA id x3-20020a05600c420300b003a3200bc788sm16695264wmh.33.2022.07.25.01.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 01:19:07 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2 0/4] soc: mediatek: MT8365 power support
Date:   Mon, 25 Jul 2022 10:18:49 +0200
Message-Id: <20220725081853.1636444-1-msp@baylibre.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this series contains patches related to the support of mt8365 power domains. I
took over the series from Fabien.

Best,
Markus

Changes in v2:
- Updated error handling path for scpsys_power_on()
- Minor updates described in each patch

Previous versions:
v1 - https://lore.kernel.org/linux-mediatek/20220530204214.913251-1-fparent@baylibre.com/

Alexandre Bailon (2):
  soc: mediatek: Add support of WAY_EN operations
  soc: mediatek: add support of MTK_SCPD_STRICT_BUSP cap

Fabien Parent (2):
  dt-bindings: power: Add MT8365 power domains
  soc: mediatek: pm-domains: Add support for MT8365

 .../power/mediatek,power-controller.yaml      |   2 +
 drivers/soc/mediatek/mt8365-pm-domains.h      | 147 ++++++++++++++++++
 drivers/soc/mediatek/mtk-pm-domains.c         |  98 +++++++++---
 drivers/soc/mediatek/mtk-pm-domains.h         |  29 ++--
 include/dt-bindings/power/mt8365-power.h      |  19 +++
 5 files changed, 267 insertions(+), 28 deletions(-)
 create mode 100644 drivers/soc/mediatek/mt8365-pm-domains.h
 create mode 100644 include/dt-bindings/power/mt8365-power.h

-- 
2.36.1

