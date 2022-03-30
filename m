Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39EC4EB866
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 04:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242057AbiC3Ck4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 22:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242029AbiC3Ckw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 22:40:52 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C670A94C4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 19:39:07 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id i8-20020a4a6f48000000b00324ada4b9d9so3396874oof.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 19:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yfd2pacZwfLZJPHvVrPsqPPBhsNU2+TGNgnyGrMa2qo=;
        b=qs/2HS8rzDJc9kYzeKXAw0X0Cf/K0wWeI1+3L0OxJbikDgHTekjwVN45eGQkreib/t
         /pD9KgEdIxz5cMq9jNvHzB2qdObXpYEkKxDpnDwaK1z+eIbeTvU1/q1Zdr13P/EBbCBl
         8+yaGOCv9U37o484+T1g8Zx1eu/7MigrgDJYFfjDfizKgqiFPjK82NKUoAaHyZOsJuUU
         ZGPtAEOBvsWUi9rRQ9yiWmJmfmnUDt7PP+MQ6R9JMkUd8m1gEkiQuUFsVQtsZVRsILHw
         ILo39FJDuhpVwqnMwAguDnmf0U7GuOPgQXcXkxBnRCHsFOkglyBd/oh2ZIfFXAeClnk1
         l3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yfd2pacZwfLZJPHvVrPsqPPBhsNU2+TGNgnyGrMa2qo=;
        b=sC/CAJmEeNP50VW1/HDGq2YkavHgJi9rrLherBLNBYjXvqu3W1G7A2ldt2WmQuMVt8
         1v0TlZ3CCElPjZ48YYNRssnQ1W5izo7k/GBuCP5ZRgw82KmG082qIqrTEw7tlx8Dh7ET
         Ey3GENFO8n0vOmpaBX0F8NZOkR0OkVYGtTNhP7qP2/w7eSn5YzGLysejZXp4w+2d1s3a
         LfMJlAem5eMkpqdwb4QvuUXw+8GOjB+Q4vkaNAXR1ydQFud3TotR9E2Xh+qZHgaCA9uv
         3qcZXFyCeD6nrD3fy7zlrskfX+/4t7OZrmi4GSRm1Ph18syWeGjVDPi8WJHrDIU79AT6
         I86g==
X-Gm-Message-State: AOAM531HlrfkWxwi7IsFA2wzgKjboAHFCvN2ldHfmBdMPYXUFL4bBvDY
        EqLFNv2VZmnfal0XwQG6po7BRQ==
X-Google-Smtp-Source: ABdhPJytZoTwr8j5QP8KWU7bCZ4Ws4NV9u5JLB2etb4WhJUZxgrEyby3ldu2+CSL/jzyN5DOLdEeuw==
X-Received: by 2002:a4a:8e17:0:b0:321:3fe1:77f0 with SMTP id q23-20020a4a8e17000000b003213fe177f0mr2137259ook.15.1648607947176;
        Tue, 29 Mar 2022 19:39:07 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id s10-20020a4a3b0a000000b0032486bc11d0sm9712281oos.39.2022.03.29.19.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 19:39:06 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Sinthu Raja <sinthu.raja@ti.com>
Subject: [GIT PULL] hwspinlock updates for v5.18
Date:   Tue, 29 Mar 2022 21:39:05 -0500
Message-Id: <20220330023905.188282-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.32.0
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

The following changes since commit 26291c54e111ff6ba87a164d85d4a4e134b7315c:

  Linux 5.17-rc2 (2022-01-30 15:37:07 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/hwlock-v5.18

for you to fetch changes up to 9a41358972eb35e6e45327035a67adfa4a223ed2:

  hwspinlock: sprd: Use struct_size() helper in devm_kzalloc() (2022-03-11 14:56:57 -0600)

----------------------------------------------------------------
hwspinlock updates for v5.18

This updates sprd and srm32 drivers to use struct_size() instead of
their open-coded equivalents. It also cleans up the omap dt-bindings
example.

----------------------------------------------------------------
Gustavo A. R. Silva (2):
      hwspinlock: stm32: Use struct_size() helper in devm_kzalloc()
      hwspinlock: sprd: Use struct_size() helper in devm_kzalloc()

Sinthu Raja (1):
      dt-bindings: hwlock: omap: Remove redundant binding example

 .../bindings/hwlock/ti,omap-hwspinlock.yaml        | 33 +---------------------
 drivers/hwspinlock/sprd_hwspinlock.c               |  3 +-
 drivers/hwspinlock/stm32_hwspinlock.c              |  4 +--
 3 files changed, 3 insertions(+), 37 deletions(-)
