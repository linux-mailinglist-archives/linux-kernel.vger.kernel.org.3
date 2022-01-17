Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01AE249101A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 19:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242313AbiAQSMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 13:12:02 -0500
Received: from mail-qv1-f41.google.com ([209.85.219.41]:39727 "EHLO
        mail-qv1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbiAQSMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 13:12:01 -0500
Received: by mail-qv1-f41.google.com with SMTP id ee17so7946582qvb.6;
        Mon, 17 Jan 2022 10:12:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=nP8dCcD5x2Uj/NuOQ+k1uj+xSjjaAiCKfaCAXq4vDo0=;
        b=RyRUiVSinz5qFZ+j2KDfNyVjai7/rrW75Qeg6rTulIhuuL9DNvkTFR83abIlOMael9
         HLRAsM/QPJn2+x8WyqZY8W60JvT97cLlp1KVZ7LwuSLX+ubmUJabrCT2H0J6nhNo3uW4
         zX6hPLdR3AQAR/95fYOCQhBqau9FW/rYtppTZj6uGgIbNEL/Le2qY+rFQDwrAXtnmsmj
         lZ9m9Gyx9+vBFdiMGlotgSVQXRe4jos5QSJKDg9FbYuehbf8rWfAfvj8hVI3xLybq4Fk
         JEMJoTlZbBiWwu4JAzw2EeUkqODoZ+djczngFwfGIccMoEEAtfRvvGjVpSRGVnW1U42R
         xS3Q==
X-Gm-Message-State: AOAM5329uc49rfOKLQ7mS4xvlOVii5cX21Mv1NBDD9cdtp4mdTGrQ2Lv
        0NaPQ5Fj9TMVUphLKEE6vjZLZecdObuqvMRRYQuGE1IZQAQ=
X-Google-Smtp-Source: ABdhPJwcfp5YvzWX2Sm4i0CtelaNW/jH0WRwjfo3lpjuWY/2SL0p8ORFb+BGOv2taqTC1bfsYRmVNT9LkfDPMwm18jU=
X-Received: by 2002:a05:6214:29cc:: with SMTP id gh12mr7074084qvb.35.1642443120986;
 Mon, 17 Jan 2022 10:12:00 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 17 Jan 2022 19:11:50 +0100
Message-ID: <CAJZ5v0hwe1bdpymAMMv-W-mpxZGMZVdE5UM4JZbammhS0rdPMQ@mail.gmail.com>
Subject: [GIT PULL] More power management updates for v5.17-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.17-rc1-2

with top-most commit 5865918fe49ed3cb9d7b5d21f41aff8a68fbceb1

 iio: pressure: bmp280: Use new PM macros

on top of commit b35b6d4d71365fbfb6f2cc8edc331b3882ca817e

 Merge tag 'pm-5.17-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more power management updates for 5.17-rc1.

This is a continuation of the rework of device power management
macros used for declaring device power management callbacks (Paul
Cercueil).

Thanks!


---------------

Paul Cercueil (6):
      PM: core: Remove DEFINE_UNIVERSAL_DEV_PM_OPS() macro
      PM: core: Remove static qualifier in DEFINE_SIMPLE_DEV_PM_OPS macro
      PM: core: Add EXPORT[_GPL]_SIMPLE_DEV_PM_OPS macros
      PM: runtime: Add DEFINE_RUNTIME_DEV_PM_OPS() macro
      PM: runtime: Add EXPORT[_GPL]_RUNTIME_DEV_PM_OPS macros
      iio: pressure: bmp280: Use new PM macros

---------------

 drivers/iio/pressure/bmp280-core.c | 11 ++------
 drivers/iio/pressure/bmp280-i2c.c  |  2 +-
 drivers/iio/pressure/bmp280-spi.c  |  2 +-
 drivers/mmc/host/jz4740_mmc.c      |  4 +--
 drivers/mmc/host/mxcmmc.c          |  2 +-
 include/linux/pm.h                 | 55 +++++++++++++++++++++++++++-----------
 include/linux/pm_runtime.h         | 24 +++++++++++++++++
 7 files changed, 71 insertions(+), 29 deletions(-)
