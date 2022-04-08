Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2ED4F97A2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbiDHOJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 10:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiDHOJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:09:01 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA541B9FD7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 07:06:58 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id p10so15215901lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 07:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+OPCNdj76CLB8yCZDySaFYBOtiA1oqmhgvF6bYV33T4=;
        b=eGgzR9tgn20HubUZlwVH67m6Sh8oBEaYCT2E92s9GLs0a+qnh9IHnfAxaU87LABPSF
         913vKcPPeV3k70GpkCZzgduVa5avEFOZr9vag66FiCjJlQkneGN/MYUu4Os62wq28euA
         yGEdSOyi02YLpGDQqfeD4kFM0vJK7kjyrK7vJfwJLc62wQsKwA0RcEgsoe1zBRV7mdv0
         7ORH+PZibwY178UGEV5kVVTzE8RLDfNJ0s6WnKxVRFUbBl9tohTvrdo++Tu54KeAbwYX
         Msum6/t54O9KC1RniyZrqdgNtTlbUWmz1+MOs/1nC2I4F/5dOJfpPsopg53DxvtKJc+x
         ISDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+OPCNdj76CLB8yCZDySaFYBOtiA1oqmhgvF6bYV33T4=;
        b=ZNTAMRDku3KuwA6uSx715MiCR6R3Hoi1wnlvTlaVCx13DLpHlbmITWoSUAmPdrtjgh
         1f5Ht5+7gAaOZZMmmK1jC0YSZk5yE7ILu6RBHcvHe3Vgf8iyYZXTFRLzPvAAVEomeLWc
         bqPs2JkbSLtye0DN315nBxrWrFsXDrCIfD8b5uXc5XlXGqFloVR9GqJsMlhSvHh1BWDe
         b8ee95t27pkjsElvdAnJRsTXY5d4xe7+cvoJe1iSFTQ1iQJzsUqDnOVX7C20/A08+4sL
         wC2D7ZbWTDsnZhW1/KrMTgO1CXrFH8oTz6TjsVQFE20PGOKNxMtdxBZfpwDUFNPWV2do
         mMWg==
X-Gm-Message-State: AOAM533xZMsZTBcs2Kq+mQeKUVjz7P3T7OypHJsx/Dr0GYhQKS88kddw
        Rf2/NvOalGZMnHZhrQfHb+zFaA==
X-Google-Smtp-Source: ABdhPJxxjdm8Unb7Z85232DOvXznn4/LVOW3mRPCJIyG+WlAoPxNTEek0ab2h6HrYgkiKGYlEBKZMw==
X-Received: by 2002:a05:6512:322f:b0:44a:57a0:6950 with SMTP id f15-20020a056512322f00b0044a57a06950mr12603033lfe.74.1649426816249;
        Fri, 08 Apr 2022 07:06:56 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-154.NA.cust.bahnhof.se. [98.128.181.154])
        by smtp.gmail.com with ESMTPSA id f5-20020a05651201c500b0046b890cb0a4sm144781lfp.98.2022.04.08.07.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 07:06:55 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.18-rc2
Date:   Fri,  8 Apr 2022 16:06:54 +0200
Message-Id: <20220408140654.119255-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.18-rc2. Details about the
highlights are as usual found in the signed tag.

Note that, this time I have also folded in a patch that isn't a fix. The reason
is that it's cross-subsystem change and I wanted to avoid us from sharing an
immutable branch.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.18-rc1

for you to fetch changes up to b71597edfaade119157ded98991bac7160be80c2:

  mmc: core: improve API to make clear mmc_hw_reset is for cards (2022-04-08 11:00:08 +0200)

----------------------------------------------------------------
MMC core:
 - Improve API to make it clear that mmc_hw_reset() is for cards
 - Fixup support for writeback-cache for eMMC and SD
 - Check for errors after writes on SPI

MMC host:
 - renesas_sdhi: A couple of fixes of TAP settings for eMMC HS400 mode
 - mmci_stm32: Fixup check of all elements in sg list
 - sdhci-xenon: Revert unnecessary fix for annoying 1.8V regulator warning

----------------------------------------------------------------
Christian Löhle (1):
      mmc: block: Check for errors after write on SPI

Michael Wu (1):
      mmc: core: Fixup support for writeback-cache for eMMC and SD

Pali Rohár (1):
      Revert "mmc: sdhci-xenon: fix annoying 1.8V regulator warning"

Wolfram Sang (3):
      mmc: renesas_sdhi: special 4tap settings only apply to HS400
      mmc: renesas_sdhi: don't overwrite TAP settings when HS400 tuning is complete
      mmc: core: improve API to make clear mmc_hw_reset is for cards

Yann Gautier (1):
      mmc: mmci: stm32: correctly check all elements of sg list

 drivers/mmc/core/block.c                           | 48 +++++++++++++++++++---
 drivers/mmc/core/core.c                            |  5 ++-
 drivers/mmc/core/mmc_test.c                        |  3 +-
 drivers/mmc/host/mmci_stm32_sdmmc.c                |  6 +--
 drivers/mmc/host/renesas_sdhi_core.c               |  8 ++--
 drivers/mmc/host/sdhci-xenon.c                     | 10 -----
 drivers/net/wireless/ath/ath10k/sdio.c             |  2 +-
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    |  2 +-
 drivers/net/wireless/marvell/mwifiex/sdio.c        |  2 +-
 drivers/net/wireless/ti/wlcore/sdio.c              |  2 +-
 include/linux/mmc/core.h                           |  2 +-
 11 files changed, 59 insertions(+), 31 deletions(-)
