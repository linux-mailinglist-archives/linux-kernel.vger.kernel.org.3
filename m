Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7EE51D395
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 10:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347537AbiEFIqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 04:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242689AbiEFIqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 04:46:23 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3567C5C747
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 01:42:41 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id c15so8446918ljr.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 01:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nm5ep95Y15PZCTogsWvIGJT66Lt0anHsb8v0LiicQmI=;
        b=Q6d5fWVtFS+1gjx6xmOvyS/76KWjn23Gn+f/ET6tdXuzQ6cT2YABOtPuDsY+t4Md97
         NmRWY0J7DWe4RN+fbzFxnXTA4OIELjafAAxR6AVHUwakmwvnK2lc3PM30BcdO0ceUMkH
         4xOL4uIcio/He9NW7Hc+oMndYD8i7VwcLxJ3pfNymMLamzuY+y2UUnf8HQ682aNzcrxM
         W5UC/U01V2lrrnl1b+9bZUiawwGCPA83AV7qEkxAgawtYVRz7Tmun1iBkpqqV+IXNoaq
         U0nVu8pSrntmipMhkbJHf/6V+jU1yfjt4VQ08podXZAkrz9I3iF2RRk25IPloVH+AV0q
         LkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nm5ep95Y15PZCTogsWvIGJT66Lt0anHsb8v0LiicQmI=;
        b=obrlBd1RNtPI7spN4NLY8nKdqONpr/BmbICbZpaB18oJPSPUzjN5uDbp1rpCDy37oY
         Pdd+2qTtx/Xr5VPaTG0xYRj+t4oOIZJNH8Rvmp4WIylvNoW4XPRHMJo/0KKbzDe+0VaX
         3pX02IY6j8bLgxiLvGaRXdhrqO2agCAjbaQhoAz+VYjupkJKVS3x39y1hfA5hUopiTOe
         A5Z5W8cgCPBK1gk0/ZDH7naqa6I7DASTJ46O1SlskxvFFYDj5nSykPUWLrUP1Ec6oUrb
         HWvanLqgIR0KEZSuOAgl2HYIiw6pwcJc/giLqVYOO5rufMLml41RMrhPOlsw30+RH3NE
         PlPg==
X-Gm-Message-State: AOAM530vQmfOH3JvaA15/XUyt6lk6rIxA9t6hc3X/ImGIYfx+JLW1ER8
        1X9EWfEjMFrJeFQK7TuLXo2/l2Zky3rtfg==
X-Google-Smtp-Source: ABdhPJy+YBdaHRgY3ceb79lvQFaROGNNZWNB0GoBbqFOe4OI9Y7EBCIRLxXyFxDKWlHWpO6/n92cIA==
X-Received: by 2002:a2e:97c7:0:b0:24f:e5b:21a8 with SMTP id m7-20020a2e97c7000000b0024f0e5b21a8mr1390258ljj.143.1651826559516;
        Fri, 06 May 2022 01:42:39 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-154.NA.cust.bahnhof.se. [98.128.181.154])
        by smtp.gmail.com with ESMTPSA id h5-20020a056512338500b0047255d2111csm594749lfg.75.2022.05.06.01.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 01:42:38 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.18-rc6
Date:   Fri,  6 May 2022 10:42:38 +0200
Message-Id: <20220506084238.279365-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.18-rc6. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit af2d861d4cd2a4da5137f795ee3509e6f944a25b:

  Linux 5.18-rc4 (2022-04-24 14:51:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.18-rc4

for you to fetch changes up to 3e5a8e8494a8122fe4eb3f167662f406cab753b9:

  mmc: sdhci-msm: Reset GCC_SDCC_BCR register for SDHC (2022-05-04 12:31:55 +0200)

----------------------------------------------------------------
MMC core:
 - Fix initialization for eMMC's HS200/HS400 mode

MMC host:
 - sdhci-msm: Reset GCC_SDCC_BCR register to prevent timeout issues
 - sunxi-mmc: Fix DMA descriptors allocated above 32 bits

----------------------------------------------------------------
Brian Norris (1):
      mmc: core: Set HS clock speed before sending HS CMD13

Samuel Holland (1):
      mmc: sunxi-mmc: Fix DMA descriptors allocated above 32 bits

Shaik Sajida Bhanu (1):
      mmc: sdhci-msm: Reset GCC_SDCC_BCR register for SDHC

 drivers/mmc/core/mmc.c       | 23 +++++++++++++++++++----
 drivers/mmc/host/sdhci-msm.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sunxi-mmc.c |  5 +++--
 3 files changed, 64 insertions(+), 6 deletions(-)
