Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3140D48031D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 19:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbhL0SAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 13:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhL0SAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 13:00:42 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3AAC06173E;
        Mon, 27 Dec 2021 10:00:41 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d9so33769105wrb.0;
        Mon, 27 Dec 2021 10:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aavwzcZWj4+sjoB+pDrepWQ/BeCGF4ESyuF/2vgNuHQ=;
        b=XIy2t1vDQbwF8aH7sDa/Nfr34EonTBRdPgq56QvT39ehRdEhLCgLjPdJ5GyhNCGbTb
         7Jwi80gtFEKYSyvLHaYqiPQn1nIODW7VmWQ/HzuEktNL5OtMuT4++g3XcEBs3tcw8370
         3619XynsXB4mwdHv7Yoa20aWm/C5lWhwUCEMaG8bKIZy0BKkek2CbZMRyNx7g8/WCmtx
         NXkNR9tOayalgiJmSRx0AyU5X55mDYQ9PQZHRvQ7Cm95mi21mPpB3XnXFJvFJfmmbxTK
         a82ucJpJpHJoOeU5xKoWpt35MQBXtvbm4Qdr+PBy5AYYAT/Cbin8FOrcNeiVV6pQo93u
         v61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aavwzcZWj4+sjoB+pDrepWQ/BeCGF4ESyuF/2vgNuHQ=;
        b=o5TN7wTnxucOeOStuEmZ60r0szr8pXozeXfqiAiUhA2pMJftyCMrk8q/q5ZezRWXsj
         Y6d2kG2i3SiX21hOwIflKTqXaPhyzkp1XvRb1YBid6EKWYD+aovT86iriwpkxlCWwxk5
         c9dkeMnTM5GKV7lC+/Bi+JIFz8gFtZdOkc0YUx8YjpwApDyVZct6gvO/svUbRpuPY4WR
         UjIz0PGwr6utaIyCSBQVgEo75WjeoYRWUltMrbeM0QQxLs9i91YsviqT5Nm84YTAKLcj
         XbNea7g2+MbIUwV/3vgqOCuwxWKQc5YrRBg9tzcvMFF5g80qds/2fUPIkFCQp8mju7Ud
         dGPQ==
X-Gm-Message-State: AOAM5309H5jGV1P1XC4zpk7cqBTDy5iztjS3diz80utuiTyy3s8IYzsv
        NvKcBmRAkxc6in3kwaGQAbYivzfzQZg=
X-Google-Smtp-Source: ABdhPJyqv+WAs0c3T64zNqLQYnP29+hAfW9DYvGP+jcqOM0y7V9VWCWzZf8wl9DojymgW0VPvDXE4A==
X-Received: by 2002:a05:6000:1088:: with SMTP id y8mr13847516wrw.53.1640628040361;
        Mon, 27 Dec 2021 10:00:40 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c23-c4b2-f800-f22f-74ff-fe21-0725.c23.pool.telefonica.de. [2a01:c23:c4b2:f800:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id o11sm18572946wmq.15.2021.12.27.10.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 10:00:40 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/3] ARM: dts: meson: fix UART device-tree schema validation
Date:   Mon, 27 Dec 2021 19:00:23 +0100
Message-Id: <20211227180026.4068352-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

here are three UART device-tree schema related fixes for the 32-bit
ARM SoCs.
These patches don't fix any functionality which is why linux-stable
is not Cc'ed on them.


Martin Blumenstingl (3):
  ARM: dts: meson: Fix the UART compatible strings
  ARM: dts: meson8: Fix the UART device-tree schema validation
  ARM: dts: meson8b: Fix the UART device-tree schema validation

 arch/arm/boot/dts/meson.dtsi   |  8 ++++----
 arch/arm/boot/dts/meson8.dtsi  | 24 ++++++++++++------------
 arch/arm/boot/dts/meson8b.dtsi | 24 ++++++++++++------------
 3 files changed, 28 insertions(+), 28 deletions(-)

-- 
2.34.1

