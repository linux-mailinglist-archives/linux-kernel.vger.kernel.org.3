Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74AC4A490E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 15:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379259AbiAaOMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 09:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240507AbiAaOMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 09:12:13 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B12C061714;
        Mon, 31 Jan 2022 06:12:13 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id qe6-20020a17090b4f8600b001b7aaad65b9so7806107pjb.2;
        Mon, 31 Jan 2022 06:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=LfxBbcc8sOMG6OCY4dbokwU0H9EPLp8J38lLXb92tpo=;
        b=dK9veWso8b2VKdA1LHJ6APHUuIAzhaTR+aV4A9gGVAuR3SMU5az+cpfyoI0TgYfE2h
         tI6TMLtjzA4ZhykohQUak11uIT00wPgywULQs2KEXLnX3uK8CsDc0N37xOrGz4QMTdkl
         mywmECiJoQPIfCLJ0Llczb7aQSJ3zCxVrWPElUJ6UVMVWQFLBPC/HnlTp6mKYuxHh1JS
         qBImqyWTUZOmUyUctKsXjwcTou0F8jOFS+t25C4FnhQ0dPQ0oU6a88h/8+w6sMtt2gJ2
         sks8XWDL5VWNrahLfAJXbhcPKdAL4c23DPK9qCbIYHLjzMg0lo0myS1DBp9XdA5I4Pi8
         fokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LfxBbcc8sOMG6OCY4dbokwU0H9EPLp8J38lLXb92tpo=;
        b=Jt+VWLBSG38oK9G4UQXLWoYTZBcjC+5muNrJtHX+CFT5kaFR2QUM+B3NzrTl9mgsUf
         INUQsjJ9ECaLdygUqeIl4ZRkeH1VNsDylfrwGE6O7Lb6nT+FZp8A5wk6offx97dxk2FM
         FGZ5QsSRCx2qBsdg+iZ4D9qfLuS3oY8RBbjKp+ifn7poTl1M9ga9MYh6rIVrv3+Gh2gH
         CVSDWfNoampKCfgvP/+6RTlVnbnBu1DsvdUuQvV3tzP0OkcOAaH+yUTXT2BKSs/T8z5c
         QmTaLdiqnFqVCiBq8MH1ZQ+GQqquzyXknj4R1aI6djn/cGW1RQktSofNDEbN0K5v3m/R
         +ing==
X-Gm-Message-State: AOAM531q3n2S1+XHBMHqhInZnaTqIgFVfW6hZZtyudyQBGqw7EWYzyk5
        UKC/hQqg8gFuQApoBg4/oVY=
X-Google-Smtp-Source: ABdhPJz/cXOr81TfHzE3W9vpHPG0tMpDlSLPWWS9NZh1dXfmexQ9sTp7Qbp8+MWi2C3lNNOLnN9bGw==
X-Received: by 2002:a17:902:e2d4:: with SMTP id l20mr1827484plc.36.1643638333053;
        Mon, 31 Jan 2022 06:12:13 -0800 (PST)
Received: from localhost.localdomain ([124.253.246.115])
        by smtp.googlemail.com with ESMTPSA id g12sm18101682pfm.119.2022.01.31.06.12.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Jan 2022 06:12:12 -0800 (PST)
From:   Puranjay Mohan <puranjay12@gmail.com>
X-Google-Original-From: Puranjay Mohan <p-mohan@ti.com>
To:     kishon@ti.com, vigneshr@ti.com, s-anna@ti.com,
        bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Puranjay Mohan <p-mohan@ti.com>
Subject: [PATCH 0/2] remoteproc sysfs fixes/improvements
Date:   Mon, 31 Jan 2022 19:41:50 +0530
Message-Id: <1643638312-3912-1-git-send-email-p-mohan@ti.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a refresh of the patches from an old series [1].
Patch 1 of that series is not required now as [2] serves its purpose.
Patch 2 has been improved and is being posted here.
Patch 3 is unchanged, it has been rebased and posted.

The features being introduced here will be needed by the recently posted PRU
remoteproc driver [3] in addition to the existing Wkup M3 remoteproc driver.
Both of these drivers follow a client-driven boot methodology, with the latter
strictly booted by another driver in kernel. The PRU remoteproc driver will be
supporting both in-kernel clients as well as control from userspace orthogonally.
The logic though is applicable and useful to any remoteproc driver not using
'auto-boot' and using an external driver/application to boot the remoteproc.

[1] https://patchwork.kernel.org/project/linux-remoteproc/cover/20201121030156.22857-1-s-anna@ti.com/
[2] https://patchwork.kernel.org/project/linux-remoteproc/patch/20201126210642.897302-4-mathieu.poirier@linaro.org/
[3] https://patchwork.kernel.org/project/linux-remoteproc/cover/20201119140850.12268-1-grzegorz.jaszczyk@linaro.org/

Puranjay Mohan (1):
  remoteproc: Introduce deny_sysfs_ops flag

Suman Anna (1):
  remoteproc: wkup_m3: Set deny_sysfs_ops flag

 drivers/remoteproc/remoteproc_sysfs.c | 18 +++++++++++++++++-
 drivers/remoteproc/wkup_m3_rproc.c    |  1 +
 include/linux/remoteproc.h            |  2 ++
 3 files changed, 20 insertions(+), 1 deletion(-)

-- 
2.24.3

