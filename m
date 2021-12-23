Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51F747E400
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 14:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348606AbhLWNRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 08:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348587AbhLWNRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 08:17:30 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B40C061401
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 05:17:30 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id p7so8270242ljj.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 05:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T1vdIWuNNE8OnHa60L7/WMRUeBtjD7twHKWeQD7MBsw=;
        b=DJ5/MLtjnLGIXlUDwTkWr1KMw/+Cyo3QPBIeYqs5PjfB1pvPlwCQ6ixh281aVLn3yk
         pePSX24DhsTVqx/hc+v1kV4pQXaa+KdEZUjZ/PCGqFvMC+inILUin77mfCmWPZMw7hX2
         4Sne3rwgKfw+KXTGfS4KtXF1OhHQ9253wynGjuUCFCpMTM1rvDCs9SMWXGvR1DeRGPUM
         TZxgBqQA9cVKHCQ3bORqiJDh+RAMV3XNLdDDUdmfaVza/zjN0zOlTYQ4ptMLeR04ftCG
         aU/95Woyi5zHzyRFwiRVhDLfsMxabcRcbyff1pOQSD0P5qjz3f/Gz66/crcsDcBf02PS
         3CHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T1vdIWuNNE8OnHa60L7/WMRUeBtjD7twHKWeQD7MBsw=;
        b=BYr1xXje/y9BBZW0Zu51LZbiOv4pdJaW1GRxdS8Pwyu3IofCaRaiNHGtPHs3l7svxg
         8MCF63+e0dcjE4v3ptFu1zCBmCdjDe190fuCPBlaVjlykcP2b7tIggMYPmuCpg+1kJIc
         5f1TH/GGQsA5DUJrHBkZkEaw0d+ZuBCil8cV3tZA9aTmzUYWPK1+EI1YZFjM/xfQPVhN
         JmNnK+uehXy5h/AskWNn8raMOcxDs1Ju8q4/dYGcDljKVbCZgc6x4SkHuq9D1V4y6p4E
         i/M9E6gU5rqXuGV1XIJfRXWqrbkOTjgHdMeXIu82U/mTwaU4xDjXjZ/o/qyUmrP/b95Y
         srzg==
X-Gm-Message-State: AOAM531WNN/sqopZr6s5tRUTq+wVfBLRxJb/LstNO7UrJSQfywm6kp14
        R/qRC4vPZGrde//bFn2Scp2ZhUhJyEwn9m+R
X-Google-Smtp-Source: ABdhPJyJN5DZyWS7pU+4iPcAevDPJh6n4d5DwIh7cLH/9B7CUCXvGxrk2tm2ntIGEQy+upp7Ektr/w==
X-Received: by 2002:a05:651c:88e:: with SMTP id d14mr1727969ljq.42.1640265448249;
        Thu, 23 Dec 2021 05:17:28 -0800 (PST)
Received: from localhost.localdomain (h-155-4-129-21.NA.cust.bahnhof.se. [155.4.129.21])
        by smtp.gmail.com with ESMTPSA id bu36sm498755lfb.259.2021.12.23.05.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 05:17:27 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.16-rc7
Date:   Thu, 23 Dec 2021 14:17:26 +0100
Message-Id: <20211223131726.10956-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.16-rc7. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 2585cf9dfaaddf00b069673f27bb3f8530e2039c:

  Linux 5.16-rc5 (2021-12-12 14:53:01 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.16-rc5

for you to fetch changes up to ff31ee0a0f471776f67be5e5275c18d17736fc6b:

  mmc: mmci: stm32: clear DLYB_CR after sending tuning command (2021-12-21 13:03:51 +0100)

----------------------------------------------------------------
MMC core:
 - Disable card detect during shutdown

MMC host:
 - mmci: Fixup tuning support for stm32_sdmmc
 - meson-mx-sdhc: Fix support for multi-block SDIO commands
 - sdhci-tegra: Fix support for eMMC HS400ES mode

----------------------------------------------------------------
Martin Blumenstingl (1):
      mmc: meson-mx-sdhc: Set MANUAL_STOP for multi-block SDIO commands

Prathamesh Shete (1):
      mmc: sdhci-tegra: Fix switch to HS400ES mode

Ulf Hansson (1):
      mmc: core: Disable card detect during shutdown

Yann Gautier (1):
      mmc: mmci: stm32: clear DLYB_CR after sending tuning command

 drivers/mmc/core/core.c              |  7 +++++-
 drivers/mmc/core/core.h              |  1 +
 drivers/mmc/core/host.c              |  9 ++++++++
 drivers/mmc/host/meson-mx-sdhc-mmc.c | 16 ++++++++++++++
 drivers/mmc/host/mmci_stm32_sdmmc.c  |  2 ++
 drivers/mmc/host/sdhci-tegra.c       | 43 ++++++++++++++++++++++--------------
 6 files changed, 60 insertions(+), 18 deletions(-)
