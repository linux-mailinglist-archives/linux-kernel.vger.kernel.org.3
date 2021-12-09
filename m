Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0461346F25A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbhLIRqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbhLIRqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:46:21 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36048C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 09:42:47 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id u1so10945127wru.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 09:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2QbjfUJdTfiLlwXUcq5wjfx6LHl5Fvuz1d4NowJhN9s=;
        b=gcsM6ywG8GZDWV5R75Xvfl745yqjyH5h9RA217PHH0pz9FI/1q4Z5G5mNLG+0vuCjT
         uldIXA4WvnYseIKQw44wkD6d7Zleo8TMFI9b13R0M5TKynYVXZVgBJue5cSQK2dyTycx
         L1o2VmD/D12wUE2V7VMEIV8m4827m8B7y+o8uB05EphXV6KSwm6MNSOQeG32fW/umRPi
         29XvZDwcThOZJbFD7Vp1FZKt2GiMM4vH4jN7beXE73NDaGlechKAM6T6HVYZEbj60qVH
         UFeIlbUFR6cmy5cJl2QBYVZMPJdWS1IzAO4gW4vw/UzkIYcItCaAycULUdAJePYmgdMM
         C2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2QbjfUJdTfiLlwXUcq5wjfx6LHl5Fvuz1d4NowJhN9s=;
        b=aoZ7YSVGTb3JTxQio07Svew6Qr4RkMvtKjiLz3WoboM6rlVq5cmj05sO5MFmTmObae
         ds0JhA8X+Qm49+eLEUbr6fZWBQEz/zRK/SKpgIBWDDMvSSL/40d3GSoEp8ZzJgHeTgaU
         mVRKxPsRbMAonalOHmQ6JpOUTrCVkWHis/31ToXhE+jt56cRszJXJVVGerQHHngnrr6V
         XuxqB6dQ0Stwn6JUzNrRRg/ayt2CNmk8dQXRMtSDCW6fsU6Fr0Pm8TIkt98+/URVdyu3
         a6yRfo6q5da1ulatJy2LBcj+yEdP/Is4FB1bmUcs0/hiGE21PIBKNSB7lX7NsG/Nkntj
         obhA==
X-Gm-Message-State: AOAM530L3uf0Oj5Yctj//DjZGW2VoKbz9zVhjQyIl5AlI6iDy0fox0x1
        uZu41eka/4YwclPpGBX5HLw/+Q==
X-Google-Smtp-Source: ABdhPJxklcKijrWDIUBHtoRjeyZBmyhH83YeotI+u0wyryM5YqPp5fWFEEsty+5M50kGlL/ftltMZg==
X-Received: by 2002:a5d:67ca:: with SMTP id n10mr7967212wrw.246.1639071765788;
        Thu, 09 Dec 2021 09:42:45 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id w4sm308666wrs.88.2021.12.09.09.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 09:42:45 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/4] nvmem: patches (set 1) for 5.17
Date:   Thu,  9 Dec 2021 17:42:31 +0000
Message-Id: <20211209174235.14049-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some nvmem patches for 5.17 mostly bindings updates and update in mtk-fuse
to support one byte access.

Can you please queue them up for 5.17.

thanks for you help,
srini

Chunfeng Yun (3):
  dt-bindings: nvmem: mediatek: add support bits property
  dt-bindings: nvmem: mediatek: add support for mt8195
  nvmem: mtk-efuse: support minimum one byte access stride and
    granularity

Rob Herring (1):
  dt-bindings: nvmem: Add missing 'reg' property

 .../devicetree/bindings/nvmem/brcm,nvram.yaml       |  3 +++
 .../devicetree/bindings/nvmem/mtk-efuse.txt         |  2 ++
 Documentation/devicetree/bindings/nvmem/rmem.yaml   |  3 +++
 .../devicetree/bindings/nvmem/st,stm32-romem.yaml   |  3 +++
 drivers/nvmem/mtk-efuse.c                           | 13 +++++++------
 5 files changed, 18 insertions(+), 6 deletions(-)

-- 
2.21.0

