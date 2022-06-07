Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C0453FA21
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239922AbiFGJry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239923AbiFGJru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:47:50 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAC0D02B8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 02:47:46 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 1so18561762ljp.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 02:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r+fd1kmExEMyURkP01m+1X8U5VoGZ0zrhlDfla9ENQI=;
        b=WFU4KgU0IaHuI1H2ExwN/3ZUE2b1P1cHhhD9C4f7oJgAw5H/nCvhwGNYtIennhcMNM
         46wzmHwWMe810s15B5HvrbGapDqCKNroPwYNtHh1Qn3MJ+WPCvf96MiFJzWG4H5OVLFL
         LgQbdGghStCqcMaBMajXx/ZOWkn0SWOq22S2CK712K0FK+1wJ639tL9avjzwftVzRjwz
         sQ9sKm+yqeAYUBD7KIZWK6Hhru0Td2ig7ZB/qXTQnBtUHYDTVKgxfib4Ej/fKQ9m8WBU
         ySDB9ub005QG9mcm/vyd9FhCCT4E7ntSfdNeuJMdKpojPJ42ieYVu2bc5sBmWffzEkrN
         3/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r+fd1kmExEMyURkP01m+1X8U5VoGZ0zrhlDfla9ENQI=;
        b=0uWYUxIebEUbLLZz6A+XAWBSpUHhmoqDiSiXQNaBx884PRgE7RJx4StelYLL4VzP8R
         oFmGOU42GlLer12LD39j1VfmEUcITcvwP5gX1Ko0vHWo7CRxE4fI5yjHwcQsLbTKZek9
         0vb1L+gfJn8Id6xdStnLcy3ZQkH5j+D/NuxTHeSLPsx2NYNAUogKST9LW9A8Wq9VrCN2
         CNUW3Cbxri+SrJdFrswcQtsQqWI6ed/QuJAMxz1XVtbXQ9UaCV4hCJLVlyrhb78s4wpv
         uPuDaN19Wpa09MkY1I1umJpt0ib9YQJm6gLqlOz4dWpmfMZ8us9bEbTDoPWjrAYr5wgi
         XUDg==
X-Gm-Message-State: AOAM532nKIQkHCf4wc877VpEDXp/NAOhIZNnXR2EZoPK4tyFcY6vezwX
        IWft+p/S12QakrBi/GJ89XL8dA==
X-Google-Smtp-Source: ABdhPJwhV6RSaO44Tio23XR609SD3x+ZxluOofJ+L5VyvWEJl2XUA1eVRv8r04171oiALcXMa3o/xw==
X-Received: by 2002:a05:651c:141:b0:255:93fd:f499 with SMTP id c1-20020a05651c014100b0025593fdf499mr6385940ljd.29.1654595265144;
        Tue, 07 Jun 2022 02:47:45 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-133-137.NA.cust.bahnhof.se. [155.4.133.137])
        by smtp.gmail.com with ESMTPSA id x6-20020ac24886000000b00477b11144e9sm3216359lfc.66.2022.06.07.02.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 02:47:44 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.19-rc2
Date:   Tue,  7 Jun 2022 11:47:43 +0200
Message-Id: <20220607094743.204021-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.19-rc2. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit b00ed48bb0a7c295facf9036135a573a5cdbe7de:

  Merge tag 'dmaengine-5.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine (2022-05-29 11:38:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.19-2

for you to fetch changes up to 479260419fa4cb30e3e5d935a857fbdf0ffdd854:

  dt-bindings: mmc: Fix unevaluatedProperties warnings in examples (2022-06-01 16:17:30 +0200)

----------------------------------------------------------------
MMC core:
 - Fix CQE recovery reset success for block I/O

MMC host:
 - sdhci-pci-gli: Fix support for runtime resume
 - Fix unevaluatedProperties warnings in DT examples

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: block: Fix CQE recovery reset success

Ben Chuang (1):
      mmc: sdhci-pci-gli: Fix GL9763E runtime PM when the system resumes from suspend

Rob Herring (1):
      dt-bindings: mmc: Fix unevaluatedProperties warnings in examples

 Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml  | 2 --
 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml | 3 +++
 drivers/mmc/core/block.c                                       | 3 +--
 drivers/mmc/host/sdhci-pci-gli.c                               | 3 +++
 4 files changed, 7 insertions(+), 4 deletions(-)
