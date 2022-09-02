Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963535AABD3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbiIBJv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235136AbiIBJvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:51:23 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6DC90812
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 02:51:16 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id k18so1659180lji.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 02:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=TBFJI0EeUotcw714y9rA+fHR54otguK4p1tiMHOZkpo=;
        b=kUx6RK8atndn6CFMOl9Bwa4GcwmD68k4WWC+NEszwHvAwzSuy/AEE09aygAIlpQp1a
         n3oLt0pYcGhOPtbxax9DRf9uXAr0DFdxsOOZiObV9y5dlXJUsqSB+uwqtqlr9NCMIGfs
         XnyKjzqms3bM07mE+1ztBqbwwAjwLH8KSK4B7x1oGNjZqNqXWNWQ/Yq6tQ/mFi6XzeyL
         UHsLu8q/O+ev+eIL+Hzcn1tK9DBEKhGmQotVHH5o3hq6xYBPbkT/kSgcsywlZkJ/iILl
         4bQyKr//oPQLUY4FGDk2gf3g4OPjsHR5qEdZDE0O6AU28UUkQyMb48SkEu/M3Nl3x5YJ
         qlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=TBFJI0EeUotcw714y9rA+fHR54otguK4p1tiMHOZkpo=;
        b=CcTAVY0nWAGwCik/3OR8lee3ugShdF8NR92X51BVGTd8mTmHUYCW8riS7jTKmLehGc
         DnIK0w2pMdUlYxme5trrRf9mE3FXRIQmota+R7EwvemNjlzKdf+2vhnwFEM9Y+ZTAj9Q
         8dgjFSOlKgeThoHxG80iNqoH4q0gAz6jIB5myscJHA6yzU+Poymqy4L8DpBtXqElDI1p
         vwVTP5ifE4DorZ6m4bBLpF3kf1BYeKcGjPtDaVK9OLms5CKR3F+HVMPje+ckBKgaZ07h
         fb6FnCERzqlsKMPDrxk7OZ0q+jWpbPqJIKgQHKvN2xNoHPlFdrzKrATUcLN7Pw46iizF
         MmSQ==
X-Gm-Message-State: ACgBeo2WXhH71ITKOUuLEiEo7TdNjaKKiv1/rNnRv8pLWPdKYiQ0vj5y
        VfuGDEqpfQIE6dBprBFhx9oc+w==
X-Google-Smtp-Source: AA6agR4tVeJ1pwC/WJclJV1QdLlZjMk/1HpxHpa7P1PJJ5MM07Z4jY3uDcK9CeWGQQkE/Q+sW4nY2Q==
X-Received: by 2002:a2e:bc21:0:b0:25e:c921:f7d7 with SMTP id b33-20020a2ebc21000000b0025ec921f7d7mr10448983ljf.91.1662112274513;
        Fri, 02 Sep 2022 02:51:14 -0700 (PDT)
Received: from uffe-XPS13.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id a12-20020ac25e6c000000b004947fbc5d28sm186283lfr.303.2022.09.02.02.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 02:51:13 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.0-rc4
Date:   Fri,  2 Sep 2022 11:51:13 +0200
Message-Id: <20220902095113.499331-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Here's a PR with a couple of MMC fixes intended for v6.0-rc4. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 1c23f9e627a7b412978b4e852793c5e3c3efc555:

  Linux 6.0-rc2 (2022-08-21 17:32:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.0-rc2

for you to fetch changes up to 63f1560930e4e1c4f6279b8ae715c9841fe1a6d3:

  mmc: core: Fix inconsistent sd3_bus_mode at UHS-I SD voltage switch failure (2022-08-22 12:58:28 +0200)

----------------------------------------------------------------
MMC core:
 - Fix workaround for SD UHS-I voltage switch

----------------------------------------------------------------
Adrian Hunter (2):
      mmc: core: Fix UHS-I SD 1.8V workaround branch
      mmc: core: Fix inconsistent sd3_bus_mode at UHS-I SD voltage switch failure

 drivers/mmc/core/sd.c | 46 ++++++++++++++++++----------------------------
 1 file changed, 18 insertions(+), 28 deletions(-)
