Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B25571095
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 05:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiGLDFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 23:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiGLDFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 23:05:21 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86D620F7C;
        Mon, 11 Jul 2022 20:05:18 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id v7so4303557pfb.0;
        Mon, 11 Jul 2022 20:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=QNJONW1dJfYdy41mOtesiq7l94Sojq7h/3wxZaevjsc=;
        b=WbFqP4wE0zxJ4qCyKCovtaWp/jNzql7iwZWepAe4KxuNzKfpX+/hT/raFvJg1nbY7y
         yTV/LaX8IBbXbPZLudGvCU+zNdDEvyKv9cDqYXWsPJYf1uRD7qfcpuiRQkvrQosTYhXV
         atgUlBvp4rFF6i4EBFrZdcn5qHmVFOpSvUxqLozRj+tFbMKCvsEBX0C2GuKIODRxZCyb
         HUC6m/i2Z3gH7JClRZ658wwBwqAYWTcAuCCEnM6VGn0BkO3Bc5+aaM3yzZjUHa+rpFLH
         M6CIktF2fBerBFvDizkA/79oOu8GxAs0hiQhgKaGTijCgPkLjSuPgsfwob2Kp5N2OFMe
         VDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QNJONW1dJfYdy41mOtesiq7l94Sojq7h/3wxZaevjsc=;
        b=Cr9rmru8ZwZNYrkDamRATP5ztatxs5XztLJW3fRgfNZESSftWO2KK1G1nzup9zanzz
         HW1awdR6LUVk4RrIpmrhXLb8VeY5BNoLGnSeM3vOzy9F//k7nFRNIv11o/VpHPKYwxIX
         iIaSGByapKUoX3sR1FVAA68R3wSDFNQGyjZ6BrfvUJZuIF6enRrqcsK5l3mg1NWF9bW8
         aYfWKaoWQh9dxdHLHKzhlTzAds1yhk7518QTCtG6Kg8akAzZmhtlImsksh5VQu8kqUkd
         xwkokTfIUT80yjcsBaIWXKI/Y59juplMbWSvYUM+YhpCb6LWiOVbgiwBMpv4Sp5gbWZm
         o4Bw==
X-Gm-Message-State: AJIora+c650bg01eTHdnBpkscAxUMG5O2KUi9WH/BFMoqK2qasDGsyhI
        9mJ+aeKs0KOpQr2dRUKxDoM=
X-Google-Smtp-Source: AGRyM1sKMOL5HnqzgXK1DWMH89QptCFMewUC+deopOQ46YN9JPnsHeQq8abdRfvl4rlljTTZqmCHiQ==
X-Received: by 2002:a05:6a00:24c1:b0:51c:784:cb59 with SMTP id d1-20020a056a0024c100b0051c0784cb59mr21614681pfv.57.1657595118049;
        Mon, 11 Jul 2022 20:05:18 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id i68-20020a626d47000000b005255263a864sm5467642pfc.169.2022.07.11.20.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 20:05:17 -0700 (PDT)
From:   Mia Lin <mimi05633@gmail.com>
To:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        ctcchien@nuvoton.com, medadyoung@gmail.com, mimi05633@gmail.com,
        KWLIU@nuvoton.com, YSCHU@nuvoton.com, KFTING@nuvoton.com,
        JJLIU0@nuvoton.com, mylin1@nuvoton.com
Cc:     openbmc@lists.ozlabs.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] RTC: nuvoton: Add nuvoton real time clock driver
Date:   Tue, 12 Jul 2022 11:05:06 +0800
Message-Id: <20220712030509.23904-1-mimi05633@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support Nuvoton NCT3018Y real time clock.

Changes since version 5:
 - Add battery voltage level check by NCT3018Y_REG_ST.
 - Remove disable clock output.
 - Fix errors in rtc-nct3018y.c.

Changes since version 4:
 - Fix warnings in rtc-nct3018y.c.
 - Reduce the number of error messages.
 - Add time vaild check.
 - Add functionality check.
 - Add maintainer.

Changes since version 3:
 - Add part number in Kconfig.
 - Refactor rtc-nct3018y.c.

Changes since version 2:
 - Fix errors in rtc-nct3018y.c.
 - Fix warnings in rtc-nct3018y.c.

Changes since version 1:
 - Add nuvoton,nct3018y property in NPCM devicetree.
 - Add new property in rtc binding document.
 - Add new driver for nuvoton real time clock driver.

Mia Lin (3):
  dt-bindings: rtc: nuvoton: add NCT3018Y Real Time Clock
  ARM: dts: nuvoton: Add nuvoton RTC3018Y node
  RTC: nuvoton: Add NCT3018Y real time clock driver

 .../bindings/rtc/nuvoton,nct3018y.yaml        |  45 ++
 MAINTAINERS                                   |   2 +
 arch/arm/boot/dts/nuvoton-npcm750-evb.dts     |   4 +
 drivers/rtc/Kconfig                           |  10 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-nct3018y.c                    | 553 ++++++++++++++++++
 6 files changed, 615 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
 create mode 100644 drivers/rtc/rtc-nct3018y.c

-- 
2.17.1

