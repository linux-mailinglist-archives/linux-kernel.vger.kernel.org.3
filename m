Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006EA53CB7E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 16:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245078AbiFCO2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 10:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiFCO2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 10:28:18 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B2A22B38
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 07:28:17 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t6so10637514wra.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 07:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xEYT24Mw/3xwhggZ/dpbmQG99woOPJwgkQGW8eylJQs=;
        b=zvsMZh6sLDlicrdTGeylEAw0Q1YIMm9o7fadQF8XPiqdYFOu82UeM3gyvT0tNKQx0V
         QtfnOhpaMS6/olRJQJmIvNAF+XTbT5GKyjnYQmo49/MGEcLXAkdZ/IOPVjfItNW8YvyM
         oSfbsGy//J3DR4BaK449AbnXMGbVdzTaVeuSa7QCrwjt0RD3O3K1WOVnYtu2KNaVJloT
         dxLrm9R8JCzmhSm9XZFWrlTa0lmihGYrNPh6D/N/FZl2FcDcW8YlGafJmEs6WMJ1POVk
         BxqxOxLX16zCsZTbQjPT1K6ehsWp/z4wxwKIWq1X7iozSFWh0+rrQJAD8hIW0QLQRb4p
         XN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xEYT24Mw/3xwhggZ/dpbmQG99woOPJwgkQGW8eylJQs=;
        b=Dk6FqMOQhp/gj78DPB4mLZbbkgC0nUpE82owNot2VMBpws6NYhpQOJO97IofSdVKDP
         9+0PkpvoA4t9ufuztzX9XKZm1iGltwaxLriebLXt+OmYtJzfSm6Wy1YIkibHMO4FDBW4
         rdtQqEYYAKPDjO6hZqLovaBIWvd5Ne0gaShobuTNYXLSbLgP66o3XU041pWGdhXRKazE
         X3mk3xG7nSu4dp+RxDQYpQkLqnoK/lX1ewxgvF+I8XMeMnxxesWc2CscVfg74C2N5gHv
         8yiYcPoc/vnGNuPugZqWubfgH0KWm5fmytWzq1jVH1h5ketgAoriLWnBRqnfG+ralTyp
         mXfw==
X-Gm-Message-State: AOAM5333dJd94vBs+C5scFReVQEM12zVknt3up3zZnpbC8//WhEnDG0b
        IlaAyJ57shUEfzJpvszoREsfUlBSNot+YA==
X-Google-Smtp-Source: ABdhPJyovDLQyMgqK1CVt47Mttdzalhw7oxXByv7wtrOyjSW+woe/77ysnzSCDi+GJOQwyyhg3vJrg==
X-Received: by 2002:a05:6000:1568:b0:20f:d416:e5ac with SMTP id 8-20020a056000156800b0020fd416e5acmr8608338wrz.190.1654266495652;
        Fri, 03 Jun 2022 07:28:15 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:327a:d111:d547:a6d2])
        by smtp.gmail.com with ESMTPSA id a21-20020a05600c349500b003958af7d0c8sm8616581wmq.45.2022.06.03.07.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 07:28:15 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [GIT PULL] gpio: updates for v5.19-rc1
Date:   Fri,  3 Jun 2022 16:28:12 +0200
Message-Id: <20220603142812.66869-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the following set of fixes for the upcoming rc.

Best regards,
Bartosz Golaszewski

The following changes since commit 4b0986a3613c92f4ec1bdc7f60ec66fea135991f:

  Linux 5.18 (2022-05-22 09:52:31 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.19-rc1

for you to fetch changes up to 7bb8a0cf49d5fede1104afdcb43bd2f8a1df3253:

  gpio: adp5588: Remove support for platform setup and teardown callbacks (2022-06-02 09:17:38 +0200)

----------------------------------------------------------------
gpio updates for v5.19-rc1

- use the correct register for regcache sync in gpio-pca953x
- remove unused and potentially harmful code from gpio-adp5588
- MAINTAINERS update

----------------------------------------------------------------
Andy Shevchenko (2):
      MAINTAINERS: Update GPIO ACPI library to Supported
      MAINTAINERS: Update Intel GPIO (PMIC and PCH) to Supported

Haibo Chen (1):
      gpio: pca953x: use the correct register address to do regcache sync

Uwe Kleine-König (1):
      gpio: adp5588: Remove support for platform setup and teardown callbacks

 MAINTAINERS                 |  6 +++---
 drivers/gpio/gpio-adp5588.c | 19 -------------------
 drivers/gpio/gpio-pca953x.c | 19 +++++++++++--------
 3 files changed, 14 insertions(+), 30 deletions(-)
