Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613435267DC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 19:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382730AbiEMRFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 13:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356197AbiEMRFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 13:05:17 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A555A174
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 10:05:16 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id l11so8035813pgt.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 10:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VxUbVIJfDPKovOH85qumbwINB246mdu93fA8EKGD0Q4=;
        b=r9DxuHYSlxU+T16xfaZ3O/UPZmGzM29cDZT+o/GKLRYX58IeBo5mKJFhPcJ+6+KWLp
         kvkNJkaYVRprSwjfb8+qiP02Wk3RKfR/H5hjqjvqW3JA+7y3GZS92EQwwN3P8gRXWBXS
         3Zq0QNUhjQsOag72nAT3p33sJCbeOhnM3BiHpu0FSomwUvLVeUHsqz6Mu0XbdNijm/ap
         cPyTZWNnlwB+lPMjq8kK2xk7tvK/FtX1MZtWh2AjOFY+CqIfct7ZJxqTsrflvVCvRHY3
         AuXsDly1u4YGbFr4mMBJ7m1mYdmp2G5zjA+2ilP2tX4daUN1AIht2wNMa/KvruK9krJq
         LCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VxUbVIJfDPKovOH85qumbwINB246mdu93fA8EKGD0Q4=;
        b=C0FnLoCG4ufYKjyM1HkBZOrH2ad1IkvITewL1tOYyeH4yacwUZPZY8gbSW1JkC6kx4
         FvkVrOhIg1CvHy9OzQfRTIZOb9wP0l1N5h39lyxZ1g0CioC4lLsLW5tO4nn7TU93dF8D
         Pg/iH3WJJMizjJ1qTFcjnlcLC/I/UFOXEoJ2keI9vYp6WWV9nt2BcrWia/RJPvy3/fXW
         l1ypcXZwcsQ6aaHncCyR3JZ2aEIjN4qB8b/TvRXrGaPm1BdFg2kKPof9UVKGUQx34tLc
         KFjgTPKBghk5BNAQKseTuh/ldBRYQnrVK7MdFzHz6ttosiZPrfcj5CPrExKyZRh5gucG
         jR0g==
X-Gm-Message-State: AOAM530fxWSeyIFOlTONAv/sNMLKJGzP5SrxeIGetAzBid3o8nohEzuf
        adcyg5pwtE+jIGAnBDG1W76o7Q==
X-Google-Smtp-Source: ABdhPJwdRXoorZL9b6hOiDqo5sleRd9CEftCksC+uwX4Yxr3B8G/og8vtC/wYi+5Gmu3sUpc0Wb98A==
X-Received: by 2002:a05:6a00:e8e:b0:4fa:a52f:59cf with SMTP id bo14-20020a056a000e8e00b004faa52f59cfmr5394126pfb.84.1652461515669;
        Fri, 13 May 2022 10:05:15 -0700 (PDT)
Received: from p14s.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id fr2-20020a17090ae2c200b001d94c194a67sm1821748pjb.18.2022.05.13.10.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 10:05:14 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Suzuki.Poulose@arm.com
Subject: [GIT PULL] Coresight changes for v5.19
Date:   Fri, 13 May 2022 11:05:13 -0600
Message-Id: <20220513170513.3276002-1-mathieu.poirier@linaro.org>
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

The following changes since commit ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e:

  Linux 5.18-rc2 (2022-04-10 14:21:36 -1000)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/coresight/linux.git tags/coresight-next-v5.19

for you to fetch changes up to 1adff542d67a2ed1120955cb219bfff8a9c53f59:

  coresight: cpu-debug: Replace mutex with mutex_trylock on panic notifier (2022-05-09 16:03:24 +0100)

----------------------------------------------------------------
Coresight changes for v5.19

Good day Greg,

Please consider those for the the upcoming v5.19 merge window when you have time.

This pull request includes:

- Work to uniformise access to the ETMv4 registers, making it easier to
look for and change register accesses.

- A correction to a probing failure when looking for links between devices.

- The replacement of a call to mutex_lock() with a mutex_trylock() in the panic
notifier of the cpu-debug infrastructure to avoid a possible deadlock.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

----------------------------------------------------------------
Guilherme G. Piccoli (1):
      coresight: cpu-debug: Replace mutex with mutex_trylock on panic notifier

James Clark (15):
      coresight: etm4x: Cleanup TRCIDR0 register accesses
      coresight: etm4x: Cleanup TRCIDR2 register accesses
      coresight: etm4x: Cleanup TRCIDR3 register accesses
      coresight: etm4x: Cleanup TRCIDR4 register accesses
      coresight: etm4x: Cleanup TRCIDR5 register accesses
      coresight: etm4x: Cleanup TRCCONFIGR register accesses
      coresight: etm4x: Cleanup TRCEVENTCTL1R register accesses
      coresight: etm4x: Cleanup TRCSTALLCTLR register accesses
      coresight: etm4x: Cleanup TRCVICTLR register accesses
      coresight: etm3x: Cleanup ETMTECR1 register accesses
      coresight: etm4x: Cleanup TRCACATRn register accesses
      coresight: etm4x: Cleanup TRCSSCCRn and TRCSSCSRn register accesses
      coresight: etm4x: Cleanup TRCSSPCICRn register accesses
      coresight: etm4x: Cleanup TRCBBCTLR register accesses
      coresight: etm4x: Cleanup TRCRSCTLRn register accesses

Mao Jinlong (1):
      coresight: core: Fix coresight device probe failure issue

 drivers/hwtracing/coresight/coresight-core.c       |  33 ++--
 drivers/hwtracing/coresight/coresight-cpu-debug.c  |   7 +-
 drivers/hwtracing/coresight/coresight-etm3x-core.c |   2 +-
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    |   2 +-
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 136 +++++-----------
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    | 180 +++++++++++----------
 drivers/hwtracing/coresight/coresight-etm4x.h      | 120 +++++++++++---
 7 files changed, 268 insertions(+), 212 deletions(-)
