Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC19358CBCD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 18:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243833AbiHHQDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 12:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236927AbiHHQDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:03:19 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B4B641E
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 09:03:18 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-10bd4812c29so10988575fac.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 09:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=rWZTIOBwzmM4sIioDCBDw6f1XYSRknsCYKXwTZDWqBA=;
        b=qWOp8PSTbG5Js6+SGWJEuKJZabFzITzdEL4iOhNXgzNDmXxHt51mZGYEcHD+pUHkHu
         zyJjkuEErmGlzNOgo0pEcfFxazTWoNuvd/KUErN4L+cE1MknxXMcEU5o8JZcp0SDgwJa
         79xB1NwBfHh3yj08fM6zc2a/WaK8NkXbBvDlCFF1zPLffZ/8PNzTxvoXjHLHR5MG+3t1
         HQnU6DDW+VBRr6DyDvIhFv0AVqI/i9frKg5jLLdJtGUmgT2tyx0RK7ZujCFrESTGshqD
         HoK282+bpVeiLYt0TcgZGPJIqJeIJMoUj4zMndpZOEHgFSNntCeztx4E+8Nqwn6t8SKD
         yDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=rWZTIOBwzmM4sIioDCBDw6f1XYSRknsCYKXwTZDWqBA=;
        b=RTn4Q9jpeg/5USWsoiJ11BWeaG3QSolAEdLDUhYIEWpCsiKRxqC1P1DidgTGhuCzVL
         UHLcL/7oGdaabHzcjBHHmZEhosK+EQt1r6CU9tTRyrYeAZPouQq9yZgdPf4Ac1vbbiHc
         t+NtOhSkxvNfFXZn22/5L1oLg6egKecMKr+oZ1BkP60dlpPgYO4jKynxhjjVl0VjLMEI
         7VnQq9Xz0uIvE7xIZxCR5DMvgKIc7epXWKpUL5/wUOjtzRjQiwCP3tv6kRsy57ABRPUo
         W/zBhQksa8HYOYcnWOpnsr2tDyDIllZaCEHhyi3LG1aO0RFBAakWfAooWYMZ1KSW8ieL
         uwog==
X-Gm-Message-State: ACgBeo2fabOfxaaUncQGq5F8+tZv/Gdk/dX/S2BTEsssWItHb7EdhANu
        5ffkmjZk3Gs3K/3KsWX2FC6jQQ==
X-Google-Smtp-Source: AA6agR5ksML+MM9uj7Xhr/5FSjtB2SGAkWiAGCgCsk3XNowYdVGQwB+HVYrT/mphSuJLJ1bBxMzmAg==
X-Received: by 2002:a05:6870:b613:b0:10b:db5f:6026 with SMTP id cm19-20020a056870b61300b0010bdb5f6026mr8768566oab.159.1659974597713;
        Mon, 08 Aug 2022 09:03:17 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id n16-20020a4ac710000000b0043540f7701esm2229054ooq.31.2022.08.08.09.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 09:03:17 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Minghao Chi <chi.minghao@zte.com.cn>
Subject: [GIT PULL] hwspinlock updates for v5.20
Date:   Mon,  8 Aug 2022 11:03:16 -0500
Message-Id: <20220808160316.2096259-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.37.1
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

The following changes since commit ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e:

  Linux 5.18-rc2 (2022-04-10 14:21:36 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/hwlock-v5.20

for you to fetch changes up to cdab30b44518513003607ecfc8a22de3dbbb78ed:

  hwspinlock: qcom: Add support for mmio usage to sfpb-mutex (2022-07-16 21:47:44 -0500)

----------------------------------------------------------------
hwspinlock updates for v5.20

This removes the need for representing the Qualcomm SFPB mutex using an
intermediate syscon node and it clean up the pm_runtime_get_sync() usage
in the OMAP hwspinlock driver.

----------------------------------------------------------------
Christian Marangi (1):
      hwspinlock: qcom: Add support for mmio usage to sfpb-mutex

Minghao Chi (1):
      hwspinlock: using pm_runtime_resume_and_get instead of pm_runtime_get_sync

 drivers/hwspinlock/omap_hwspinlock.c |  6 ++----
 drivers/hwspinlock/qcom_hwspinlock.c | 28 +++++++++++++++++++++++-----
 2 files changed, 25 insertions(+), 9 deletions(-)
