Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78E949CEC7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 16:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243029AbiAZPmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 10:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243021AbiAZPmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 10:42:14 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBA3C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 07:42:14 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id u129so320023oib.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 07:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fGpm6iptk90FIZD5qF+08CcBff5Hkmqqpo48Hq4y8X4=;
        b=zltP+9jvYqlosCwgBWqA7NLNKI00rwz256jDiYYOaqB8WGXmgOXWHVYLxM+WMf923T
         NgDlbzOW1tPTb4/bJ4ce55h2FMFaV5u1V2m8W9/VZ9VDfuC0ePa1WfWHi/fgoVPnCBh7
         tDpUSxCKHHZ8rhFFI2PSm2xKAFAi/Yo3bnS2Nu0Go6esNMW51H42nvpDS3162uFkKA6F
         UuU5E8uUuZAVTnhgxdbUkeEERXcj4K/Ctg+cQ0H6RV4ZPGaWiVJea1PcLQ+7wpvACl1e
         nDCRxG8ToUqtpsGR8CFCbKQo/C5vc3pBjKMRtMbRIpx+CfGbDw4F9GX4iTd+rCyjiVRk
         cOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fGpm6iptk90FIZD5qF+08CcBff5Hkmqqpo48Hq4y8X4=;
        b=RPZuwtOaMYYQv4FnXSuhEbQ+faxySIl0KilHNjHoKI66kpclxdCouM4fJ92KthHPJg
         cZkv0MmUCPbaq4PKvgKEtdkygJdLm6hii/n4MK5FUloeM/vt0LEw5hCpdZJw9GhRldBf
         EML2v/6FXgA3nS2DIQ+YQGlHyilERu8ug9FZIZTpF2R8LSBh+YVxVlFAcZFg2AJdALrQ
         2lShJDSTp/tpHcq7cGqsj8T4G4kaaBqtqHbqfExrpgI3SRnjegwF5Ofjc8rGJOT17zFP
         o31kofSWrWWc57TnIDDiEQKv7FQ7wTu1Y8kbua2MfjLJIAYJ/FCNJoSW0XZDa78YXRGI
         bsuA==
X-Gm-Message-State: AOAM530LBHvJLD0uY7H4aRXOHzccfJghxOHg1Vfhp460XG4HUM7sOe5I
        +TkiosCTtJKZUYXg6zBQ5zqHQw==
X-Google-Smtp-Source: ABdhPJwvnfSkw5mvNapOwgiLSzk/TmgJhegQRu6QXJY2/0XW2I6ebUaHmCi5gnzCvnr162SLelwOcA==
X-Received: by 2002:aca:e103:: with SMTP id y3mr4091730oig.146.1643211734073;
        Wed, 26 Jan 2022 07:42:14 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id p82sm425795oib.25.2022.01.26.07.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 07:42:13 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: [GIT PULL] remoteproc fixes for v5.17-rc1
Date:   Wed, 26 Jan 2022 09:42:12 -0600
Message-Id: <20220126154212.2452904-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit cfcabbb24d5f4e52ce2e7797cbcfacd8fe932fb6:

  remoteproc: stm32: Improve crash recovery time (2022-01-03 11:40:45 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rproc-v5.17-fixes

for you to fetch changes up to eee412e968f7b950564880bc6a7a9f00f49034da:

  remoteproc: qcom: q6v5: fix service routines build errors (2022-01-17 16:44:26 -0600)

----------------------------------------------------------------
remoteproc fixes for v5.17-rc1

The interaction between the various Qualcomm remoteproc drivers and the
Qualcomm "QMP" driver (used to communicate with the power-management
hardware) was reworked in v5.17-rc1, but failed to account for the new
Kconfig dependency.

----------------------------------------------------------------
Randy Dunlap (1):
      remoteproc: qcom: q6v5: fix service routines build errors

 drivers/remoteproc/Kconfig     | 4 ++++
 drivers/remoteproc/qcom_q6v5.c | 1 +
 2 files changed, 5 insertions(+)
