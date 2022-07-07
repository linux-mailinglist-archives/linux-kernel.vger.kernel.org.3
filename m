Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736EA569BA3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 09:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbiGGHbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 03:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbiGGHbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 03:31:01 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BEC31345;
        Thu,  7 Jul 2022 00:31:00 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id bh13so11031912pgb.4;
        Thu, 07 Jul 2022 00:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=WUZiVSxb70SjflMeea8bnCcurZwfvJpru9MyA60zyUM=;
        b=eHZ5ZGtmYAbxeYOI8Dddtf1jnwZ2ma1m1Q1cpBIPuq4m5M3rUPHe3/Cwh+mDxlAL1w
         7Vt3vRKT+ZM/v+uo4v6CZe4heAWUn1MLYWfCQemLg9p5Rj2F5yGBeZ5ZRsnrTlWa155m
         fIlk0n4c+uGqNoXiZqY22PMyVE2bzAttgcTjGJFAnq7x/qbMQcxQukdptTGMFohrRqQn
         HPf4PcZ+SZh/iX93ZfROH+HIYihirMmnyQ4++yGixmazbL7TWE278fo9BSwLzJLPVT4/
         ENcxZzVhMXgeq/W/oHVenjJB24JPpHUmaX5ohdZ+QdyocStI7NLT8iMTi9sHcB6bGgRS
         jHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WUZiVSxb70SjflMeea8bnCcurZwfvJpru9MyA60zyUM=;
        b=AxlEdVEKr/a9ok+IStaREsJzW85S317h311QZaQkcMJ3pa8OhTCOF0zyKIAKzIqfGs
         5S6aKSJSQahb0jxQzNAZhWAozY//HOEO1WS8qMdbZMBr0fH7jdqeKWc15wb4xynTOyN/
         HHBE5WcIfxPJohkpsskgW5/nhVSTEbcTYIwa3SBkVNPUNqrNnrAJpyB80b/eY9tDBVOk
         JE/BGU9m/eWYcspOBWgUuNnKY/W3saEpIG2muCeTxXlvF1dsak3DTQL4OMYD3VB9cD+Q
         gglMXAKmSwfJ8vMp95p5E6FlbYXM+hh8YWBil7yXAisPZNvAhuoO+b47EB0jpUj7Nxeo
         HzNg==
X-Gm-Message-State: AJIora/q5rFvthcL9eBRc56UooNcYaF6bjqko6pHdQKa2MU2vJYrlZ6H
        BDBj3+E12LLcP6NMR2Civ3s=
X-Google-Smtp-Source: AGRyM1ugdnP2DY9671/p97edEwqdmfn/PaoBgKhvlhavh+06/vPSORCL6EneK3zNIgCKOMx7O+iH7g==
X-Received: by 2002:a65:498b:0:b0:412:8e4:2842 with SMTP id r11-20020a65498b000000b0041208e42842mr23752388pgs.71.1657179060291;
        Thu, 07 Jul 2022 00:31:00 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id s1-20020aa78bc1000000b00528c70c34c2sm928481pfd.115.2022.07.07.00.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 00:30:59 -0700 (PDT)
From:   Mia Lin <mimi05633@gmail.com>
To:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        ctcchien@nuvoton.com, mimi05633@gmail.com, KWLIU@nuvoton.com,
        YSCHU@nuvoton.com, KFTING@nuvoton.com, JJLIU0@nuvoton.com,
        mylin1@nuvoton.com
Cc:     openbmc@lists.ozlabs.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] RTC: nuvoton: Add nuvoton real time clock driver
Date:   Thu,  7 Jul 2022 15:30:51 +0800
Message-Id: <20220707073054.3954-1-mimi05633@gmail.com>
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

