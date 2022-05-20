Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B43E52EC3B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243222AbiETMgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiETMge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:36:34 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F4B5E15B
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:36:32 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 27so4566497ljw.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xGncHVX9PqWBfDwc0H7X3Y0RBAzmQK7gEv/KlhgQIFU=;
        b=n7u9zgy8R2EEPG7xkvIIeSOnMhW/c3vq0cTBXYCQngSibUDoynkYDolKt3ma3ZZW8x
         DBoMso0maqFQsDwkhY6oUmCjbxcaeYfDa/FkgjoGvHNaMlV9b0dLqgj/bd8b3Oh4GBmW
         8uRYQW8qu1mmYask+PovLh10t6IDcw6pM2+44vmWYTqLP7yHSdEqhwlh0sIeXTMFLsXP
         PwTigRoxwgLjOaMftG+cYjUugbir4hc3lsRzDyvntFo3UaLAS35tX9kGrnbd1uxZ0KOK
         sqopp3GmIbbvrWE9EGCvRu4WQwg2Ffgj8CkwiNoq0sGDoq9WdJeZ6VcXJP/FyxLevuRT
         a6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xGncHVX9PqWBfDwc0H7X3Y0RBAzmQK7gEv/KlhgQIFU=;
        b=nqEkrqRTme7IwtrlxcYy7AYnxCUOdQ9MKY+rZQs3rmx5n7FltVKOHvf2Cg7q3Ew75E
         daknwlLW9QZOI06iOwBjdWz2rlJ5QD9Vw6kVOH6WDHFDfYk1mt9EaVrswUa1SPw7k30y
         pv9/L0ANkaeyWPcY35xb7T8JytA90CqyjqjW05HLG9MDx3O87CRF/fDC2Vs1OvSP8njq
         TYNWkII5Q3HPTJtmKJKuR0Z537Ebfhy/skZjGTUly/rJyD0gUcKbMC6r1fmp88aSp8uj
         GbXXy6UQnefUZzer24yRGrtu2T6HDHppQev+shd5DsjE8wdWJJMmz5nAHLDfVJZCRkcD
         W+Qg==
X-Gm-Message-State: AOAM531oBtoJTl6fQGOCzhKo74vSFHwUgPspN4l43kejMZz5ZTS0OyJn
        FHhTxNXVmWaUirzlTknjnVZtyA==
X-Google-Smtp-Source: ABdhPJwLBdNwh3xBWo2b/5yTtd2qZWhE9XiACStDUXrelLY1sD912zvcZvSoA4ihzMOV3Yq/he1Gog==
X-Received: by 2002:a2e:9410:0:b0:253:c996:59fd with SMTP id i16-20020a2e9410000000b00253c99659fdmr5444397ljh.41.1653050190685;
        Fri, 20 May 2022 05:36:30 -0700 (PDT)
Received: from localhost.localdomain (ua-84-216-129-17.bbcust.telenor.se. [84.216.129.17])
        by smtp.gmail.com with ESMTPSA id x3-20020a19f603000000b0047255d211ccsm642295lfe.251.2022.05.20.05.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 05:36:29 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.18-rc8
Date:   Fri, 20 May 2022 14:36:25 +0200
Message-Id: <20220520123625.46331-1-ulf.hansson@linaro.org>
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

Here's a PR with an MMC fix intended for v5.18-rc8. Details about the highlights
are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 3e5a8e8494a8122fe4eb3f167662f406cab753b9:

  mmc: sdhci-msm: Reset GCC_SDCC_BCR register for SDHC (2022-05-04 12:31:55 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.18-rc4-2

for you to fetch changes up to e949dee3625e1b0ef2e40d9aa09c2995281b12f6:

  mmc: core: Fix busy polling for MMC_SEND_OP_COND again (2022-05-19 15:46:46 +0200)

----------------------------------------------------------------
MMC core:
 - Fix busy polling for MMC_SEND_OP_COND again

----------------------------------------------------------------
Ulf Hansson (1):
      mmc: core: Fix busy polling for MMC_SEND_OP_COND again

 drivers/mmc/core/mmc_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
