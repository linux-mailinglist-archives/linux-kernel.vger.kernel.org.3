Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843A547F4FC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 04:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhLZDPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 22:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhLZDPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 22:15:46 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B4DC061757
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 19:15:46 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id j11so25369036lfg.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 19:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=ykUfjX5LT2jLYM0XsemzshtieJCaQu4S3FzJvDLxa5c=;
        b=vOIjXgzHrljYC2cS6fgSQffzfI/3R0zL7ZsId5DYoQaZSQxn3eg5Po0tVVh9mG2700
         wQF1AAH5hsA46YsU1uWHAwqJD8LftcXXI+dDwbEUjZf4l0Gn1VguHSe521767UlnwoEP
         iCWq0MGlNOhRwRtQwNx1cRMLy16vUOlSApaVggijn25FQ5tc1FgkcMqRGVRWpF+jPvUu
         +oIDYBKESvyvz8I0XqUeeUx2nEM5kvlj+bqGgUWkC3BqTLmy97/rOR8SGDcEh1wNo9t+
         8Adwb1zRPd1/xS87mJTo98w0YHXu0p2uxqGlHlUuB5W5gL6xbMkZrB0W3cu9Llz9BdBS
         8c5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=ykUfjX5LT2jLYM0XsemzshtieJCaQu4S3FzJvDLxa5c=;
        b=LKn+NV9OdNRnwVE8v58rDas3U+Y0DjjsGiYabFQ8QGtki5iQENQ/it3I1KysHWzvdz
         LhFu5Cjpvk/k/FoNwt019nS36jvSZqqBntc5Ht0CXkUyXQNS658OINb3KlerMql0Ult/
         huq9VrvGqmBbIEq5tKQHu1n/gtizDT81VhoAQWIxJIbFAq/sj5bVdxHtQc52ty7u9Ndx
         i0mjIZyFfxMx324e0MSgCqRQ+N2tlCqsXtMnlm/ijKpBJGf/tcs+mUu1EA93HwL83+S3
         iBkvdW6QH6d4dwdi+WoBtUX8YdcIZDBc3zamPDS5pR4ZgNuhFWhkZ47xKDzDU38qv9mF
         u5Og==
X-Gm-Message-State: AOAM531vjmecc32demwadtv181fFcoR1n5rek6Xfiw5n97PTm49VPK46
        +oRRrPS3tjm1V7gyjOKp4egttqyncmbvmuM+fXbbHg==
X-Google-Smtp-Source: ABdhPJyn8FczVXK27tRYjNZyW5SfT51h0WmIGcbi1ql8NbPyBuFQE5vu9H7hCJDg/xxB4N8XVMal9zdxCqrlIQrgm+g=
X-Received: by 2002:ac2:5445:: with SMTP id d5mr10759396lfn.349.1640488544426;
 Sat, 25 Dec 2021 19:15:44 -0800 (PST)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 26 Dec 2021 04:15:32 +0100
Message-ID: <CACRpkdaJMVS5vmw5KweS8c1ptz+OoEguifdqRFP4mzU_chH8-w@mail.gmail.com>
Subject: [GIT PULL] pin control fixes for v5.16
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here are some hopefully final pin control fixes for the
v5.16 kernel series.

Please pull it in!

God Jul och Gott Nytt =C3=85r
Linus Walleij

The following changes since commit 136057256686de39cc3a07c2e39ef6bc43003ff6=
:

  Linux 5.16-rc2 (2021-11-21 13:47:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v5.16-3

for you to fetch changes up to b67210cc217f9ca1c576909454d846970c13dfd4:

  pinctrl: stm32: consider the GPIO offset to expose all the GPIO
lines (2021-12-16 04:14:56 +0100)

----------------------------------------------------------------
Some hopefully final pin control fixes for the v5.16 kernel:

- Fix an out-of-bounds bug in the Mediatek driver
- Fix an init order bug in the Broadcom BCM2835 driver
- Fix a GPIO offset bug in the STM32 driver

----------------------------------------------------------------
Fabien Dessenne (1):
      pinctrl: stm32: consider the GPIO offset to expose all the GPIO lines

Guodong Liu (1):
      pinctrl: mediatek: fix global-out-of-bounds issue

Phil Elwell (1):
      pinctrl: bcm2835: Change init order for gpio hogs

 drivers/pinctrl/bcm/pinctrl-bcm2835.c            | 29 +++++++++++++-------=
----
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c |  8 +++++--
 drivers/pinctrl/stm32/pinctrl-stm32.c            |  8 +++----
 3 files changed, 26 insertions(+), 19 deletions(-)
