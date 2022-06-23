Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F98155794D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 13:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiFWL5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 07:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbiFWL50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 07:57:26 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8528E4D604
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 04:57:23 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id i18so19292291lfu.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 04:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1mE9QbUsQhDNQHJahcefYpWUk+nyUKek2n9Yhh27xak=;
        b=dWlPd7JPxh6JEyB0r2JZilAbSpO/KUUN+LG/IgOaf5JkFX0cvBgOpordEp0sozk4BI
         vTLI1MtBSGPjkvhcSsWgNqGCJ/yKFN0ACPi3jRKo7aqL8qHygsUqb5T69j9tK0u0Jhif
         VfkXBrYILVJPRsKFZlFEwJNM50Fo5po7nYjBtC+3ybbqyMWzvCVDAtroh01tqPu5iBit
         OVVkhwXxmKOxK0bchYTWIZrb5DrAwCgT+BCdAWavn48OqQmqmUGlIJs1ZnNchkpoxP6/
         CUY0UkargJtvvmbwYibbQPbwjljzJJapq7CvOoQHozP5AVCVCvNu8I2wmTqPXslDyqeK
         nNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1mE9QbUsQhDNQHJahcefYpWUk+nyUKek2n9Yhh27xak=;
        b=fxVOkqWpiqKxu+szx6297ETCqCyFfyxLzFHIHEXWkhBNUguV63BZPGaR2gh4xT1YF4
         sRWafgPIvIDeyrMHnYva2O3u5sT5AbWkECu0hj+vqgJ2uHeweg9B11xw/CV3+4JCTq0U
         OndiTQuJAbm5+y5NBArUPtzBneGLbWHaihWblJAp6n+kA+y3CsC4SPXKQ8e7I2+63Gbt
         LBD3+eZtEltD0RdFy7l3nZgkuNeFtkP0exJ2e3kL2pAOHx4BSn9sAxk4R73xG9tKvaKc
         oL/ORHXeV3vB85PhuZ7HegTkXGy+aPSOJy8cJtazxCMwFVCQW9Nz3pYkXi7Kw5+c914b
         /AtA==
X-Gm-Message-State: AJIora9wMq+iRmdpXgfSoUSsemfww0VFzAHEL9MZS9sUcACZXlQuiKlL
        HHxzwb5TzULjUmqFncoWgf/Hvg==
X-Google-Smtp-Source: AGRyM1uy/9tHqBpEUUL+Tg9fSxETwwD30NJQsIrdVfOJ5rW5RAhslEgRXltg5MJmtzQriN7tBV5bpA==
X-Received: by 2002:a05:6512:3b22:b0:47f:6756:143 with SMTP id f34-20020a0565123b2200b0047f67560143mr5185880lfv.419.1655985441701;
        Thu, 23 Jun 2022 04:57:21 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-133-137.NA.cust.bahnhof.se. [155.4.133.137])
        by smtp.gmail.com with ESMTPSA id o14-20020a05651205ce00b00477b6328a4fsm975077lfo.158.2022.06.23.04.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 04:57:20 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.19-rc4
Date:   Thu, 23 Jun 2022 13:57:20 +0200
Message-Id: <20220623115720.44690-1-ulf.hansson@linaro.org>
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

Here's a PR with a couple of MMC fixes intended for v5.19-rc4. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3:

  Linux 5.19-rc2 (2022-06-12 16:11:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.19-rc2

for you to fetch changes up to 89bcd9a64b849380ef57e3032b307574e48db524:

  mmc: mediatek: wait dma stop bit reset to 0 (2022-06-15 10:05:56 -0700)

----------------------------------------------------------------
MMC host:
 - mtk-sd: Fix dma hang issues
 - sdhci-pci-o2micro: Fix card detect by dealing with debouncing

----------------------------------------------------------------
Chevron Li (1):
      mmc: sdhci-pci-o2micro: Fix card detect by dealing with debouncing

Mengqi Zhang (1):
      mmc: mediatek: wait dma stop bit reset to 0

 drivers/mmc/host/mtk-sd.c            | 20 ++++++++++++--------
 drivers/mmc/host/sdhci-pci-o2micro.c |  2 ++
 2 files changed, 14 insertions(+), 8 deletions(-)
