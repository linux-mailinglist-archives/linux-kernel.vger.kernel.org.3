Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D614A6D69
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 10:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237629AbiBBJCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 04:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbiBBJCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 04:02:50 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D91C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 01:02:50 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id g14so58812328ybs.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 01:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=nnsoRIvHiPW86fgxS/TUyo3uILbX1Bq5yPw+gC/F9ps=;
        b=jcYJckd8Ljg20UUBM8DwyMlBxEUJU28BoexIQ5gFXf8MFvRLjMOwgeby/nQAUMck+R
         zgeldWz3rlkcnHIGXEkgSKvRPy8SUHeUS3OrmhopQkVqhEAb2vNDUW2fuvWFp89tK3iV
         9pB0F0wRWI2n8otQ+w22/W+XEbEhKoHirdS2nzt5A94k2sUJjmpGoGOwTrJJxUF6GF+8
         vycFMQyzdnVq7soCNlNJ1H2g4Vh2o/buypgUT7NDXDrtB7mmB8AFaYV39p8BDzlkzhp2
         aTnWX/6l1y5ppo1UeaT56ne2iZtsOl+OJyMbbD2/SyJOdlqo/h8+2E92sypqrb0rK0f0
         wwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=nnsoRIvHiPW86fgxS/TUyo3uILbX1Bq5yPw+gC/F9ps=;
        b=jURLFpMlygrNod1QCpyT4ZV7gJeCh/L+enmxW93fylVxbmsT3ooSU3hOBA7iraq+Ws
         u9u0UINYlGJRXHNbhq74qpAioaX5yKDnVyvDHNrQLHCktC5tKLDnb5CWRbXwLvIiN6pA
         rjyQQOYJjPOEVykGeU4XioJ2mo8PkV7SOKVmzl0CdCUT9r2rD4BSLAZQBadBzTwOk8VG
         HLzqlMeZ/vLKjp9ut2dM4dLy/fuxe7LHB3dY05nlLTY4q4FJSF0lQVjLlyHKS2yDYute
         A07R9h52R19UBaL7/RS51dzxOn50ioasNKD5QKxkGcwQXvi8IJfI5lQbBzWs3aN4o08n
         ubBw==
X-Gm-Message-State: AOAM5310b1f89CZoIZur9sGOOSjroUZ2L9HT38l32FskkU5wGcJXaJvj
        3lss+R8At4XvAYVxb0Zww6eppX8SL1MkcJaAJ2NHNw==
X-Google-Smtp-Source: ABdhPJyvdt2XcB7jzRbFPAV1aT4cuO5tnJlamsO5G6CPh11//XRMrUWWSxF02QNQh572rdlKdwV2g/+q7FXHG2ral+o=
X-Received: by 2002:a25:b13:: with SMTP id 19mr37709652ybl.684.1643792568511;
 Wed, 02 Feb 2022 01:02:48 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 2 Feb 2022 14:32:37 +0530
Message-ID: <CA+G9fYvN0NyaVkRQmA1O6rX7H8PPaZrUAD7=RDy33QY9rUU-9g@mail.gmail.com>
Subject: [next] arm: panel-edp.c:(.text+0xb74): undefined reference to `drm_panel_dp_aux_backlight'
To:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, dri-devel@lists.freedesktop.org,
        regressions@lists.linux.dev
Cc:     Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Grace Mi <grace.mi@ecs.corp-partner.google.com>,
        Douglas Anderson <dianders@chromium.org>,
        Marek Vasut <marex@denx.de>, Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following builds failed on Linux next 20220202 arm architecture.
  - arm-gcc-10-omap2plus_defconfig
  - arm-clang-nightly-shmobile_defconfig
  - arm-gcc-8-lpc32xx_defconfig
  - arm-clang-13-shmobile_defconfig
  - arm-gcc-10-shmobile_defconfig
  - arm-clang-11-shmobile_defconfig
  - arm-clang-11-omap2plus_defconfig
  - arm-clang-13-omap2plus_defconfig
  - arm-clang-11-lpc32xx_defconfig
  - arm-gcc-8-omap2plus_defconfig
  - arm-gcc-9-vexpress_defconfig
  - arm-clang-nightly-lpc32xx_defconfig
  - arm-gcc-9-shmobile_defconfig
  - arm-clang-13-lpc32xx_defconfig
  - arm-gcc-10-sama5_defconfig
  - arm-clang-11-vexpress_defconfig
  - arm-clang-11-sama5_defconfig
  - arm-gcc-9-omap2plus_defconfig
  - arm-clang-nightly-sama5_defconfig
  - arm-clang-13-vexpress_defconfig
  - arm-clang-nightly-vexpress_defconfig
  - arm-gcc-9-lpc32xx_defconfig
  - arm-clang-12-vexpress_defconfig
  - arm-gcc-10-vexpress_defconfig
  - arm-clang-12-shmobile_defconfig
  - arm-gcc-11-omap2plus_defconfig
  - arm-gcc-9-sama5_defconfig
  - arm-gcc-8-shmobile_defconfig
  - arm-gcc-10-lpc32xx_defconfig
  - arm-clang-12-omap2plus_defconfig
  - arm-gcc-8-vexpress_defconfig
  - arm-clang-12-sama5_defconfig
  - arm-clang-nightly-omap2plus_defconfig
  - arm-gcc-11-lpc32xx_defconfig
  - arm-gcc-11-sama5_defconfig
  - arm-gcc-11-shmobile_defconfig
  - arm-gcc-11-vexpress_defconfig
  - arm-gcc-8-sama5_defconfig
  - arm-clang-13-sama5_defconfig
  - arm-clang-12-lpc32xx_defconfig


make --silent --keep-going --jobs=8  ARCH=arm
CROSS_COMPILE=arm-linux-gnueabihf- 'CC=sccache
arm-linux-gnueabihf-gcc' 'HOSTCC=sccache gcc' vexpress_defconfig
make --silent --keep-going --jobs=8  ARCH=arm
CROSS_COMPILE=arm-linux-gnueabihf- 'CC=sccache
arm-linux-gnueabihf-gcc' 'HOSTCC=sccache gcc'
arm-linux-gnueabihf-ld: drivers/gpu/drm/panel/panel-edp.o: in function
`panel_edp_probe':
panel-edp.c:(.text+0xb74): undefined reference to `drm_panel_dp_aux_backlight'
make[1]: *** [/builds/linux/Makefile:1222: vmlinux] Error 1


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

meta data:
-----------
    git describe: next-20220202
    git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
    target_arch: arm
    kconfig: vexpress_defconfig
    toolchain: gcc-11

Build log:
-------------
https://builds.tuxbuild.com/24XRim72vFXix6l6MdAJNENy6je/

Steps to reproduce:
--------------------
# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.
# Original tuxmake command with fragments listed below.

tuxmake --runtime podman --target-arch arm --toolchain gcc-11
--kconfig vexpress_defconfig

tuxmake --runtime podman --target-arch arm --toolchain gcc-11
--kconfig https://builds.tuxbuild.com/24XRim72vFXix6l6MdAJNENy6je/config


--
Linaro LKFT
https://lkft.linaro.org
