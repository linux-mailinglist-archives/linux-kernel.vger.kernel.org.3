Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C915A6DB7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 21:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbiH3TqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 15:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiH3TqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 15:46:06 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462D3DED5;
        Tue, 30 Aug 2022 12:46:03 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id b26so5567731ljk.12;
        Tue, 30 Aug 2022 12:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=BwaHnJXXKqVytA1xrbgIzEHld+egNRhsKszAve8kFp4=;
        b=c+HPoubViNuEViD7RQqJolXuAhs9JdQ7Fz6AGt0VRq9NCotzcqj5B2lA+dfrQF+bOm
         CLOR7qhKA3BVPvjt/16F5/OveJLnrq2aKthzwKlWs+aCLtm7hz3uEZP0IIjybPUeg/ry
         kJcsUQCFGUsIq9Ql1RVpqD0hH/myBsnXKWw250WCo9TUqLsq/f4PYLzoTj1rZJw+avIH
         SemhCygI2CTajJwo4uqMPB1BJYHDqzbOOwYv0TVwO3w6svWAFvWZPHdwS039zYYZjFzF
         Q6AZmAFKZOpCQfheCrpeY4Vu1piTcjgZDPP4E+HnOoWvbAqpuDXcMb1T1Lj1Xioy9RYd
         fWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=BwaHnJXXKqVytA1xrbgIzEHld+egNRhsKszAve8kFp4=;
        b=q9VzQy5gVYNxquJUvCVRWR7EO5P/gpc3cOP9gSJhkEOoIMiCFMDGvsL9vFfGleYMHN
         SqLg6xR71G3oS9L5P/pBAHvL1SedLAfRh+zSf3sopPyucGXWAMBeQ/jEaitpKNXoKfGH
         9RtzW2MmJYMYOxrvIgpsKaGuHSDXmvF/v3yWIN3Xx6cgzRbjmt498pKItYDyr4UARlTG
         VKV5boO1PWRL0sXVcEiuQNRgulJ3NnEhBNW/MfZXeV3DXchl/4S12othgC8HpuwMl46B
         rRXJmiu9MvU+gzOUdGEAlWXH6LU2SdiU5EL5LPwzGDRpo2lVDg+hB0iATGoM6WFwfYhm
         aa/w==
X-Gm-Message-State: ACgBeo04d36U4RVz7ZX7xmzpu+Y2qGg23c+t8JPqjjXmZhgrloL6by2q
        kKLlc8PzceitKWBy6iAtCy2RT/hvJac=
X-Google-Smtp-Source: AA6agR4uBUMP5duJkR3o6KSBQRfwS7MYuVjef1YHkGazbzPXiMrPsGncvHPdxSLWlESaPaU1z9wvAA==
X-Received: by 2002:a05:651c:160b:b0:261:d3c7:4d92 with SMTP id f11-20020a05651c160b00b00261d3c74d92mr6940400ljq.23.1661888761364;
        Tue, 30 Aug 2022 12:46:01 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id g20-20020a05651222d400b004948b61f780sm1036lfu.144.2022.08.30.12.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 12:46:00 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     benjamin.tissoires@redhat.com, jikos@kernel.org,
        marcus.folkesson@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] VRC-2 Car Controller
Date:   Tue, 30 Aug 2022 21:50:54 +0200
Message-Id: <20220830195055.1812192-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The device creates two USB endpoints where on of those represent the X/Y
axis as 16 buttons which is not.. quite right.
So get rid of that endpoint.

Also fix the report descriptor for the other endpoint.

Output from hid-recorder:
#  X:     32 | Y:   1001 | # 
E: 000105.808008 7 20 00 e9 03 00 00 00

Link to previous discussion:
https://lore.kernel.org/all/CAO-hwJL-3vAzywjeUsopsRSJX6j-maC5R75ekxZg-W_oKDqYYw@mail.gmail.com/

Marcus Folkesson (1):
  HID: Add driver for VRC-2 Car Controller

 MAINTAINERS            |   6 +++
 drivers/hid/Kconfig    |   9 ++++
 drivers/hid/Makefile   |   1 +
 drivers/hid/hid-vrc2.c | 100 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 116 insertions(+)
 create mode 100644 drivers/hid/hid-vrc2.c

-- 
2.37.1

