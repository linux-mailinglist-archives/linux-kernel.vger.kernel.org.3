Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B654D6456
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 16:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348511AbiCKPKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 10:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbiCKPKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 10:10:52 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819FE1C232A
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 07:09:48 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id n19so15497926lfh.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 07:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qqY71AUzATHTLGKyAzwvSw6q4/NroX39pMmuicUc9QM=;
        b=lNYnqjfB2ONnlK2OT+blK4EuYRqEDUuqvPBFjmbTehTX9zN0zNGdAMbmGFjuz2ju3d
         pYM0kM2QuWs1T361dlk5ChZN+7gljju/RfsrwfymsUScdXysvOFcF5KIEJFOe6MjfSUS
         lwxonnSHL7D/TeeRoMSDmUnTPw4LtToaAgb7aRtkJ5j82jznc1nlFK1Q5mdEbRLJ+A9J
         paMeQNbenMSVJSYv/KQrBP67rWb/B2jpUpwo0hx/13ob9tveOqe7PMDzpcswEh0LIVOA
         WC7ou0vQqRGSupaTU76Zj4l+zhWHobs5QiDR0XEgkT3fq4G6pwOj07nu5K5wQB0mlTxq
         5hiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qqY71AUzATHTLGKyAzwvSw6q4/NroX39pMmuicUc9QM=;
        b=jAPiNtV2UPEgIQzc8aglwEh0OdazMOB7tnQXjigvofB2euhQBNtosGlT6g5L9/gJ6Z
         sRHbLRKMXnwWJrIF/n6cbbaHa65QoFcVj9HUpvTLopnagFANlzS4LkoHlstasVRfzhjZ
         m2ELuc6qt13/6ZQxhOwEuaUVF3Q9wkhlLqXTShpiNiWX2BgM5wXrQ5G8Y/0qjm4NKwLL
         6t5RWncAu5MrdyjoB9HBfvkP9ONPemzv3RVTNwq5nIJ4zlTuZLdgTe9qZfo9+0wGpFg1
         SMtMPD1cYXLjgj8DF0FDuc5V9Rsq5FVmhXXK3C+BzJWXipaidVglj27F6kyRxkGGn6pe
         BPVw==
X-Gm-Message-State: AOAM530ORiCG87l21mV9RoywDHLBb1Ik9pbSQ22cWWGeZbSWGixgqa5m
        mE0GL95C9P9agniZWbWRraiSxnooGLPV3Q==
X-Google-Smtp-Source: ABdhPJyP7Hm372/ApUE3c0lGEDB1sgUok3CVvp4PMBVGtAi8hCEmi+cS9QBaZtP14ItjK+kQCbA3gw==
X-Received: by 2002:ac2:4145:0:b0:448:273a:7697 with SMTP id c5-20020ac24145000000b00448273a7697mr6370536lfi.601.1647011386742;
        Fri, 11 Mar 2022 07:09:46 -0800 (PST)
Received: from localhost.localdomain (h-155-4-129-34.NA.cust.bahnhof.se. [155.4.129.34])
        by smtp.gmail.com with ESMTPSA id 16-20020ac25f10000000b00443890bd84asm1663988lfq.114.2022.03.11.07.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 07:09:45 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.17-rc8
Date:   Fri, 11 Mar 2022 16:09:45 +0100
Message-Id: <20220311150945.84262-1-ulf.hansson@linaro.org>
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

Here's a PR with a couple of MMC fixes intended for v5.17-rc8. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3:

  Linux 5.17-rc6 (2022-02-27 14:36:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.17-rc6

for you to fetch changes up to 1760fdb6fe9f796fbdb9b4106b3e0bbacc16b55c:

  mmc: core: Restore (almost) the busy polling for MMC_SEND_OP_COND (2022-03-07 11:47:39 +0100)

----------------------------------------------------------------
MMC core:
 - Restore (almost) the busy polling for MMC_SEND_OP_COND

MMC host:
 - meson-gx: Fix DMA usage of meson_mmc_post_req()

----------------------------------------------------------------
Rong Chen (1):
      mmc: meson: Fix usage of meson_mmc_post_req()

Ulf Hansson (1):
      mmc: core: Restore (almost) the busy polling for MMC_SEND_OP_COND

 drivers/mmc/core/block.c        |  2 +-
 drivers/mmc/core/mmc.c          |  2 +-
 drivers/mmc/core/mmc_ops.c      | 13 +++++++++----
 drivers/mmc/core/mmc_ops.h      |  3 ++-
 drivers/mmc/core/sd.c           |  2 +-
 drivers/mmc/host/meson-gx-mmc.c | 15 ++++++++-------
 6 files changed, 22 insertions(+), 15 deletions(-)
