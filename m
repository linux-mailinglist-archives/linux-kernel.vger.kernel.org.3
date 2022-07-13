Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A65573206
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235993AbiGMJHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbiGMJG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:06:57 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDCD286CD;
        Wed, 13 Jul 2022 02:06:56 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id y14-20020a17090a644e00b001ef775f7118so2624109pjm.2;
        Wed, 13 Jul 2022 02:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=y5g+g4Wo+o19kQAE0fo44H2kWR0Y0l61IsNjeKb+644=;
        b=jmETtGr3eP2DhxmH6rJIXCrUC6Z6+HlK4YR+wsVsOt+nj6BfyveFYJkZTzgW/08Uk0
         rM7UHb/aQy46gblqKXCpEHQinbpmF3PP0Mv9uGkja7L/yJjghs3rUeX0QOtWwZ3YPZ0B
         g6sxkVOEaEgVazFhsOaMQNtDVFIPfquZ7naLb9j+ZQWimFYVKAlGOQ3DItTAXbkTo3J+
         y6BJH8tuBHXvIyXigC1LuDb+SUDD0Tg9UCAeOfCgrFdAUCfxGsmESvVZcZ4WKp6AvWJJ
         H5PXJ2i9tQ55mYM29O+wgqteF07XEB35UNXoxKgsHimTz4KwZBK+xXx4UtohzV1DEGIU
         JhLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y5g+g4Wo+o19kQAE0fo44H2kWR0Y0l61IsNjeKb+644=;
        b=GRDO+xEwzkHTMc2ks7jB2zFCNCUheZLcyVgtDd0O6eJU++oiiiySMP/AJGwO5u/AuR
         LtE42QoB1YMebd3fsjl4e6LSyE1vdrIycqugZAqJnze1//yXDh/gVAhgxjZIxY61/tKR
         u9vFU68zPcxzYUKym/SYUTBM/r9zpZGTYc0gEq8z+/r0q784O3oRrmU+b4q/zyF3TDYt
         mVMEUgWL16tA6XGLbVjAnWCHvtGxSCfr8fkvMiHc5kJlB2shli8fDfT/P4AZr9AIxX1o
         a2hq66QSmB4cl5F1V9eeZbr2C9fA4CSHlz4ym9LqEbW5nhQp3HhLHFUtbShOYKfhrj73
         OhTA==
X-Gm-Message-State: AJIora/+6nlyZn0tC8bUbO2lGOb8WPbZcSKYzjMSyrAy78p+OwslOd2v
        pNI3sYLtj6DSm4mUsTmcG1Q=
X-Google-Smtp-Source: AGRyM1vWxb3GMUCfWNl9c5VytfK+GlcaW8s0PShjS5RQUJTTYzPKGP+F0OjAGD6fTfHLgAfNnSYeDw==
X-Received: by 2002:a17:90a:6008:b0:1ef:abc7:a740 with SMTP id y8-20020a17090a600800b001efabc7a740mr2671643pji.179.1657703215712;
        Wed, 13 Jul 2022 02:06:55 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id gg10-20020a17090b0a0a00b001ef917f1c30sm1051975pjb.6.2022.07.13.02.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 02:06:55 -0700 (PDT)
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
Subject: [PATCH v6 0/3] RTC: nuvoton: Add nuvoton real time clock driver
Date:   Wed, 13 Jul 2022 17:06:44 +0800
Message-Id: <20220713090647.8028-1-mimi05633@gmail.com>
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

Changes since version 6:
 - Add review tag.
 - Add blank line in dts.

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
 arch/arm/boot/dts/nuvoton-npcm750-evb.dts     |   5 +
 drivers/rtc/Kconfig                           |  10 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-nct3018y.c                    | 553 ++++++++++++++++++
 6 files changed, 616 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
 create mode 100644 drivers/rtc/rtc-nct3018y.c

-- 
2.17.1

