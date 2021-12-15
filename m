Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3907476194
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 20:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344202AbhLOTVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 14:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbhLOTVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 14:21:41 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1AAC061574;
        Wed, 15 Dec 2021 11:21:41 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id g14so77562110edb.8;
        Wed, 15 Dec 2021 11:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8tM3tA7VofLMOjAxzFGeXbuG7wz0BjJnUf7afMSSks4=;
        b=eBqfM0NCsSA1tg5Jzmy8hOZxa0YA5ECF/3/29sj3nlY0xxsUq+fhe2TzPeqrzG1k9l
         1wHyJz3Rv+A1mpXgkwiC78379to+7OIfulALUjH7W3lO0S6tICZ/yEchv5DUYiSorF2B
         VdXmlUJUKbBh3WCTh99QJViY2PC5azby0Yo0PD125DrT1FzGgc/mCBjoqL0okIx7wLTn
         XQfivq3UeA7FJznKWkz1yuZg4gPypBX3seZx3wrIe/KfmvzW++zRADkqMhO/tsSTBehC
         hfa2OXK82KwnKri3PEN9yLs4J4yLNFdPY904c0wkWZYEGN/CndqFTbxBpGt6BrwR2VWG
         iPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8tM3tA7VofLMOjAxzFGeXbuG7wz0BjJnUf7afMSSks4=;
        b=pq6jaCaKdtqL6ZkoudPJlK891g9AEMcaH2YEfmMHfc/7TM//CGY37H9xojz1fMdpn1
         I1VR0M4i3IFR/2v16i9PWjIW8MsQf6mN0e8Kxnv4tKL9wHDaCR0oEKlJjd2jjirIfg00
         fyrPMvLBxYjpk5Tt9aJmjJYSfttpAVkU+WcZH7WGd2+wm3hcJREI5+8tj1e5ofrdJJPp
         SznGgpbIKgyeF7M0Q4idlBFRgeRsAgr+MAC/3X0f+A+wZKhd7GoVQR+wAL9r1dLbEkOG
         WprSbiscxYHzMuM6h3jOZ2TWmLQWN4kUx/mJoRmyHt9M+KH7ZWz1ANM6P10QcDJqS7tZ
         DHVw==
X-Gm-Message-State: AOAM530Fnu1Fo5lJ7EHO4J7iNQimCz8bHUzyIHtzKBENzmJHeoovcuRl
        SMuZTSLuGQSH8TiODCxzuss=
X-Google-Smtp-Source: ABdhPJxThLjFD0xPeQ2x0ipUIu9K6K8vg8Ud4zitzUMW/vWRUCNixJv3a5h8jTc6bk8EZAYod3pC0A==
X-Received: by 2002:a05:6402:5cb:: with SMTP id n11mr16749831edx.279.1639596099992;
        Wed, 15 Dec 2021 11:21:39 -0800 (PST)
Received: from zenorus.myxoz.lan (81-232-177-112-no2390.tbcn.telia.com. [81.232.177.112])
        by smtp.gmail.com with ESMTPSA id n10sm1461049edx.3.2021.12.15.11.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 11:21:39 -0800 (PST)
From:   Miko Larsson <mikoxyzzz@gmail.com>
To:     minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
        axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Miko Larsson <mikoxyzzz@gmail.com>
Subject: [PATCH 0/2] zram: zram_drv: Fix some formatting problems
Date:   Wed, 15 Dec 2021 20:21:26 +0100
Message-Id: <20211215192128.108967-1-mikoxyzzz@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This small patch set fixes some superficial formatting problems in
zram_drv that were reported by checkpatch, namely that it missed SPDX
license identifiers and that it used strlcopy instead of strscpy.

Miko Larsson (2):
  zram: zram_drv: add SPDX license identifiers
  zram: zram_drv: replace strlcpy with strscpy

 drivers/block/zram/zram_drv.c | 8 +++++---
 drivers/block/zram/zram_drv.h | 2 ++
 2 files changed, 7 insertions(+), 3 deletions(-)

-- 
2.34.1

