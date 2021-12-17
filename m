Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883B4479112
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238922AbhLQQOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235959AbhLQQOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:14:35 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C379C061574;
        Fri, 17 Dec 2021 08:14:35 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o29so1974369wms.2;
        Fri, 17 Dec 2021 08:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9PrIKDIDs5G43xHziGUw5xjWzhxUWAXkgHn7b6XgCRg=;
        b=Hb1kRPY1nKW9YV5BDJ24z1aQxe8ouBR/JIGR5EyD7fr3bFji4yk6B8QP1W6tac5gd1
         /4YLednLOdFW8IUd7HtzA0EI1cD6DbmIL79LQnA19NwTP/Cm8+JkKvrc3WQau8PidGSF
         9sdbEafRfcQ1i9FwBj50umoGXFSePHO4MK3s7kxFFw5RvIwdyGoO4qaWmxSuQ3OV6R9I
         obF0C6HZCqlkmnxqreFnTtYSim1QLQyliZzfsR+6E/XYRlL8YLkiDdBJpxbUmc3QxYto
         sUAlbJMbOvQVP3Ygr9db+oEoEiKJWD6d01P6MehYT1s0iN747OY6Zd0t1St2B+aXbYCR
         qvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9PrIKDIDs5G43xHziGUw5xjWzhxUWAXkgHn7b6XgCRg=;
        b=bTS7UsXcLvSAVu42bREtYbifSMKezLj8GPJ7q2D9crj7Yqgz+QZJfAzG5Mm2lJ4YAE
         GcT58SrpyYOxWvkg61ZK/O8TxgkrRv5xCkIAGOPo9uOMFCDXzibQhkK1AMW3BqwDNRLP
         UCBBLISpweYhMF7UZ5lo8qZlGfnSpIyHFSiPssrs7+UTzYYUOdmIUSvAKiuYHYH7EfaV
         tNs1i0dRLRkIqDh7w1mmhXB2mYJNgj960fXfMjXn77RCvlAcoV0QtM0W+Hb6/PDQ4sd4
         50bd2eIUYmA5gtmsVLwfCtNph/fNnEuDfCW+O/OKtd5mCDwmOFxYoI/S+S4aqrBskJpT
         W9tA==
X-Gm-Message-State: AOAM532BS5yWj1scfzt9THj/LNmg6IgwdZh9dU4u3hVoz9tNMEwJpIfS
        v/+0yQ6FVwe4cgiSVcyQJJdEPYrSWsM80A==
X-Google-Smtp-Source: ABdhPJzcrnukyGJtVPRgJ+/YGbCE1v003rEfdzpBi5YbuLBsqBBWAW+Xrcj0X+FY12GRtvH+rdgAxQ==
X-Received: by 2002:a05:600c:3797:: with SMTP id o23mr2879199wmr.178.1639757673970;
        Fri, 17 Dec 2021 08:14:33 -0800 (PST)
Received: from localhost ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id h27sm12002300wmc.43.2021.12.17.08.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 08:14:33 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [GIT PULL] memory: tegra: Changes for v5.17-rc1
Date:   Fri, 17 Dec 2021 17:14:31 +0100
Message-Id: <20211217161431.1524285-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/for-5.17-memory

for you to fetch changes up to 9ecccfabc29df15e1fd03a440f3f6e611ebff062:

  memory: tegra: Add Tegra234 support (2021-12-16 16:48:21 +0100)

Thanks,
Thierry

----------------------------------------------------------------
memory: tegra: Changes for v5.17-rc1

This contains the stable tag that shares the device tree includes
between the memory and Tegra trees. I've also applied the Tegra234
support patch on top for your convenience.

----------------------------------------------------------------
Mikko Perttunen (1):
      dt-bindings: Update headers for Tegra234

Thierry Reding (4):
      dt-bindings: memory: tegra: Update for Tegra194
      dt-bindings: memory: tegra: Add Tegra234 support
      Merge tag 'tegra-for-5.17-dt-bindings-memory' into for-5.17/memory
      memory: tegra: Add Tegra234 support

 .../memory-controllers/nvidia,tegra186-mc.yaml     | 98 +++++++++++++++++++---
 drivers/memory/tegra/Makefile                      |  1 +
 drivers/memory/tegra/mc.c                          |  3 +
 drivers/memory/tegra/mc.h                          |  7 +-
 drivers/memory/tegra/tegra186-emc.c                |  3 +
 drivers/memory/tegra/tegra234.c                    | 81 ++++++++++++++++++
 include/dt-bindings/clock/tegra234-clock.h         | 26 +++++-
 include/dt-bindings/memory/tegra234-mc.h           | 32 +++++++
 include/dt-bindings/reset/tegra234-reset.h         | 12 ++-
 9 files changed, 246 insertions(+), 17 deletions(-)
 create mode 100644 drivers/memory/tegra/tegra234.c
 create mode 100644 include/dt-bindings/memory/tegra234-mc.h
