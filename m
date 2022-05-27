Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41685535BD9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349918AbiE0IrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349898AbiE0Iq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:46:59 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C796D25C5A;
        Fri, 27 May 2022 01:46:57 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id a13so3586140plh.6;
        Fri, 27 May 2022 01:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=LT+QAOqNHX7ViHSsik7kvf3ypjWNwSuEN+rviPBBKVw=;
        b=EkXFhzB6I2uejZeDOfwTivxzmkAjlXWQzgl7qS1XAqWQSsrMu3JAjkaSjsfaL51svU
         uZBzGyfFzcwDbnNsjntpXEi6BKOUPzamrL5XX4vGVMPP4+9JI4cl2BQScVC5lNBlEoVm
         rVtSgcMKqsbGqBzEOr6qb5QvJ0DnzQxDYdxoj5Q+KrmLGGK/IBiaAG5CubqkZ6JAURhh
         fnHmldWC0iducAx6xhxoqiAVBoh/9AAR2nT6Io4ILBQT4AHvTXNf+j3PX7DjGPUMZ4lU
         QElFZQaiz8IcjrdWNtptAUIMZpbTh4w4mlws44DvIwY+ZKdT6luOpK2CHcQGD7zgshyQ
         6/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LT+QAOqNHX7ViHSsik7kvf3ypjWNwSuEN+rviPBBKVw=;
        b=vttJdLvBGu5KTrgIkrqvnqw3bjclu3k+f7cPAXjz442iUEreHVCV3U6wRyzr2OT+4F
         33liF1ZFIN+5F9kQ/9dFv6UY/IXzTwi858iu00BF5af2+NbaT2ElFEnbMpb3otoQFe/N
         ieB2nOU+mpLWOyixLasxBXM/fUeD3idLj81AHRHjwzbGCIsFHgEB4o5ocqZl35TicBmZ
         x33KtP9RfnQtfAiIYBTF4Do2WNYpleWI67CVPG7oCyuRvhULmW9GlOienq8uGn6h3Jux
         wCcsGdYbVzD6XLiEtP/lzZ/+HqlM/bOHIHQx1NXQFXBRWtL4VUBkGBK9ipekDFtnmQ9P
         TN7Q==
X-Gm-Message-State: AOAM532R/RI/hoP/ETO3z7WEXcHK9Wgsghm2wCi3HQnTKL6Nga20F904
        IbTJXY2zVsFFSdK6N7ON9Pjzjp2UUU/Ncw==
X-Google-Smtp-Source: ABdhPJwbMVfPy1IMJtptgkrIf6LW9VDXVLIQ/vswb1KPSPLQl8dZBhbh32Dh0jzQbem2FdkY30ZOMw==
X-Received: by 2002:a17:90a:5d03:b0:1e0:cc5b:4808 with SMTP id s3-20020a17090a5d0300b001e0cc5b4808mr7091366pji.180.1653641217105;
        Fri, 27 May 2022 01:46:57 -0700 (PDT)
Received: from localhost.localdomain ([116.89.143.231])
        by smtp.gmail.com with ESMTPSA id k12-20020a170902d58c00b0015e8d4eb1ebsm3003254plh.53.2022.05.27.01.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 01:46:56 -0700 (PDT)
From:   medadyoung@gmail.com
X-Google-Original-From: ctcchien@nuvoton.com
To:     benjaminfair@google.com, yuenn@google.com, venture@google.com,
        tali.perry1@gmail.com, tmaimon77@gmail.com, avifishman70@gmail.com,
        robh+dt@kernel.org, alexandre.belloni@bootlin.com,
        a.zummo@towertech.it, KWLIU@nuvoton.com, YSCHU@nuvoton.com,
        JJLIU0@nuvoton.com, KFTING@nuvoton.com, ctcchien@nuvoton.com
Cc:     openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: [PATCH v3 0/3] RTC: nuvoton: Add nuvoton real time clock driver
Date:   Fri, 27 May 2022 16:46:44 +0800
Message-Id: <20220527084647.30835-1-ctcchien@nuvoton.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Medad CChien <ctcchien@nuvoton.com>

Support Nuvoton NCT3018Y real time clock.

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

Medad CChien (3):
  dt-bindings: rtc: nuvoton: add NCT3018Y Real Time Clock
  ARM: dts: nuvoton: Add nuvoton RTC3018Y node
  RTC: nuvoton: Add NCT3018Y real time clock driver

 .../bindings/rtc/nuvoton,nct3018y.yaml        |  44 ++
 MAINTAINERS                                   |   2 +
 arch/arm/boot/dts/nuvoton-npcm750-evb.dts     |   6 +
 drivers/rtc/Kconfig                           |  10 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-nct3018y.c                    | 560 ++++++++++++++++++
 6 files changed, 623 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
 create mode 100644 drivers/rtc/rtc-nct3018y.c

-- 
2.17.1

