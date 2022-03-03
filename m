Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195174CB814
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 08:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiCCHs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 02:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiCCHs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 02:48:26 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8017E10;
        Wed,  2 Mar 2022 23:47:40 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d3so6425947wrf.1;
        Wed, 02 Mar 2022 23:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=41/Zcs1+rOZW1dlgnZYTE4qTncwsL/D5m4xA8Yd4cWs=;
        b=fsM0WhwWB2VqHU2a0pOFBMHiAXveIYJ6iZ/ao0k9/9pOJWv8KeOuew9QBrGl2hlmg+
         MeG6uQbF3WsdKSVuSOr974GMdG6PVOmJfW8J7olt9Vhi76OYazwRQotA353cmSauJf8c
         1gqUh6dcpbNvE3Qo2/trb4jSsq5CoVgh4otpaEo3QqFZA1mI2Uxl7Fen2iVv+A1JDQtc
         xAbS2fxgkKiKJx1iQaVI/3vx8BYL3i52XDiGTQyYmDUUZq34CKwpptnceRK3KTuTm1Iy
         p0+yb8vtm4bigV7oBXCKpM9/b+T3DaYN4nAe7BBjmFJbf1W8aRoAQ7FYA4vSk/K9xaRq
         scIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=41/Zcs1+rOZW1dlgnZYTE4qTncwsL/D5m4xA8Yd4cWs=;
        b=2YeUUB6Qtw3JsAPrVbWreKAQAUT2nPZ1jUpdJVUv0du35vyJtg5ch+0xDWWXs2g5Vr
         bsxmRFkUoiMfxqUQr7JEEEufebiIuwrqvrplcDhNzXVy6rm3cXknc3RX1eZYXv54rpPA
         wJEnUs7lSQfVnsCciuJBvBQWf8eY4Y3HN8hM7V5r435oXa76uETEjCFGXrndTz0poEKy
         D5RJh3QgECN3JlPgQJHuPPo7teeN11FQaPMMGP7fz1q1N+l61j1b22P4dH/pDeaNKBJb
         Haouk1hMxN6GCjKgFmToYL2y/8FtQcH8df+eTTSgYxqK2RaO7Xh3O+ml0D2FVfrTXhjb
         RI1Q==
X-Gm-Message-State: AOAM532xk7xg2pYRDefU6fDXeg4fgvvCa43I1/yO8COAcDvc1HlHZeLk
        3Pm8maVR47YBkUap92nQc1B+dICj7Dc/tQ==
X-Google-Smtp-Source: ABdhPJz9owWDykpylw+0FTIyZNb3VL+0OsQaJG2j2e0ZHYOjNIaWcCIPIsGh9NHuRRdFqcWjXB9Lvg==
X-Received: by 2002:adf:db43:0:b0:1ef:7195:43cd with SMTP id f3-20020adfdb43000000b001ef719543cdmr21447794wrj.495.1646293659195;
        Wed, 02 Mar 2022 23:47:39 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id d3-20020a05600c34c300b003884e826642sm841169wmq.12.2022.03.02.23.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 23:47:38 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH for-5.18/uclogic 0/4] DIGImend patches, part III
Date:   Thu,  3 Mar 2022 08:47:30 +0100
Message-Id: <20220303074734.7235-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This series is a follow up to [1] and [2], kindly reviewed and applied
by Jiří in hid.git#for-5.18/uclogic.

It adds support for touch rings in order handle the Huion HS610 tablet.

Thank you very much to Nikolai for the patches a to the maintaners for
the quick reviews,
José Expósito

[1] https://lore.kernel.org/linux-input/nycvar.YFH.7.76.2202161642180.11721@cbobk.fhfr.pm/T/
[2] https://lore.kernel.org/linux-input/56454560-5f62-05b9-1a24-3f51a305140e@gmail.com/T/

Nikolai Kondrashov (4):
  HID: uclogic: Add support for touch ring reports
  HID: uclogic: Support custom device suffix for frames
  HID: uclogic: Allow three frame parameter sets
  HID: uclogic: Add support for Huion touch ring reports

 drivers/hid/hid-uclogic-core.c   | 83 +++++++++++++++++++++--------
 drivers/hid/hid-uclogic-params.c | 40 +++++++++++---
 drivers/hid/hid-uclogic-params.h | 90 +++++++++++++++++++++++++++++---
 drivers/hid/hid-uclogic-rdesc.c  | 65 ++++++++++++++++++++---
 drivers/hid/hid-uclogic-rdesc.h  | 20 +++++--
 5 files changed, 250 insertions(+), 48 deletions(-)

-- 
2.25.1

