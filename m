Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645BD4E5685
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 17:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238903AbiCWQeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 12:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237353AbiCWQeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 12:34:05 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171227CB2D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 09:32:35 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b19so2881250wrh.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 09:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=trCEH0bE6PaumD9lKzsz88cLWqI4Gc48zVWYeF+JLGE=;
        b=715G9aBMEgb/RuG3lm8ue1+D8YN6vxqXPzx2SVIgyire1F2RO8mwWraOJZEnLgLLME
         u5gmeTjoQA7ruESrpCjhYAtljoKGFODubsFiQXk1ieJqt6EZgv/1ZsUus1KSxaiLz3F/
         dNynSwomfjeZyMeTd/GzU2Bl9Z+M16eSRphbjnkl+QJWB09oPh7h7/Li6ZPTOe3SKkej
         /cRtQ5/sxe9nbI0ZKkat2GWiSqtvNyE2BzDkG/h55YUBnd0sBy8sEDpzimoqRHoKlNWk
         5tpaGDWvWq3jYVhyvNhcSMgcQLJ6UG5IjQVENV56JS+vI5VAhLcCa34vl1fgEU0cKtlh
         2czQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=trCEH0bE6PaumD9lKzsz88cLWqI4Gc48zVWYeF+JLGE=;
        b=0hgChPuUf1+c3caLShQcX3bJoyg030TUJwKj6JbEANaoXGofnvL9+FYtO7aFRstC8K
         dGsnSXOpfgl2EP97N3kAr9KMJ9da7VGyM0Fer18f15GlTYHD2hRu8l7Is1hgm7low6eM
         Zo0747HCjm4usB+6HqMiZvqALsvnRdN7HPesCfvY0IaBcLX+sst0JhMP8i9qW4C7SWv3
         jWP/Y5yw/vEiBw9+8xguKeIZiXAZOwVnZeVfEIjxbC8CBys15PanYVQmBeEl+mhhOBVo
         BHUHscKdqpb5xFyi/KctQddefeeEeK2/fuRRrHVOnjjO51blMSQwMGWLYUs3Zu1HTCuL
         rEqA==
X-Gm-Message-State: AOAM532MPXIyNXv9woyBhJmAf7FFMoNt4G6RU4RJNwfiYA9XHioD0cUI
        4PAhPDL/Dtl+gJdgiTFTrwDh7A==
X-Google-Smtp-Source: ABdhPJyQBA7RWxogEUW+4vbMCMwX77BkU0ZFJ808H936v0jDTJt8PagQZ8ycbymm/Ptx/ELaxKS4UQ==
X-Received: by 2002:adf:f5c4:0:b0:205:2836:f1e5 with SMTP id k4-20020adff5c4000000b002052836f1e5mr579608wrp.519.1648053153629;
        Wed, 23 Mar 2022 09:32:33 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:334:ac00:7d50:ff5:f5c1:e225])
        by smtp.gmail.com with ESMTPSA id w7-20020a1cf607000000b00389a5390180sm274635wmc.25.2022.03.23.09.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 09:32:33 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [GIT PULL] gpio: updates for v5.18
Date:   Wed, 23 Mar 2022 17:32:30 +0100
Message-Id: <20220323163230.691802-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

There are relatively few updates for the next release cycle. We have a single
new driver and some minor changes in drivers, more work on limiting the usage
of of_node in drivers and DT updates.

Please pull,
Bartosz Golaszewski

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-updates-for-v5.18

for you to fetch changes up to 87ba5badc541a79bab2fa3243ee0008c0880c64a:

  gpio: ts4900: Use SPDX header (2022-03-10 10:05:39 +0100)

----------------------------------------------------------------
gpio updates for v5.18-rc1

- new driver: gpio-en7523
- dt-bindings: convertion of faraday,ftgpio010 to YAML, new compatible string
  in gpio-vf610 and a bugfix in an example
- gpiolib core: several improvements and some code shrink
- documentation: convert all public docs into kerneldoc format
- set IRQ bus token in gpio-crystalcove (addresses a debugfs issue)
- add a missing return value check for kstrdup() in gpio-merrifield
- allow gpio-tps68470 to be built as module
- more work on limiting usage of of_node in GPIO drivers
- several sysfs interface improvements
- use SDPX in gpio-ts4900

----------------------------------------------------------------
Andy Shevchenko (9):
      gpio: altera-a10sr: Switch to use fwnode instead of of_node
      gpio: tegra: Get rid of duplicate of_node assignment
      gpiolib: Introduce for_each_gpio_desc_with_flag() macro
      gpiolib: Use short form of ternary operator in gpiod_get_index()
      gpiolib: Simplify error path in gpiod_get_index() when requesting GPIO
      gpiolib: sysfs: Move sysfs_emit() calls outside of the mutex lock
      gpiolib: sysfs: Move kstrtox() calls outside of the mutex lock
      gpiolib: sysfs: Simplify edge handling in the code
      gpiolib: Use list_first_entry()/list_last_entry()

Bartosz Golaszewski (2):
      gpiolib: make struct comments into real kernel docs
      Merge tag 'intel-gpio-v5.18-1' of gitolite.kernel.org:pub/scm/linux/kernel/git/andy/linux-gpio-intel into gpio/for-next

Corentin Labbe (1):
      dt-bindings: gpio: convert faraday,ftgpio01 to yaml

Hans de Goede (2):
      gpio: crystalcove: Set IRQ domain bus token to DOMAIN_BUS_WIRED
      gpio: tps68470: Allow building as module

John Crispin (2):
      dt-bindings: arm: airoha: Add binding for Airoha GPIO controller
      gpio: Add support for Airoha EN7523 GPIO controller

Kris Bahnsen (1):
      gpio: ts4900: Use SPDX header

Marcel Ziswiler (1):
      dt-bindings: gpio: fix gpio-hog example

Peng Fan (1):
      dt-bindings: gpio: gpio-vf610: Add imx93 compatible string

Xiaoke Wang (1):
      gpio: merrifield: check the return value of devm_kstrdup()

 .../bindings/gpio/airoha,en7523-gpio.yaml          |  66 ++++++++++
 .../devicetree/bindings/gpio/faraday,ftgpio010.txt |  27 ----
 .../bindings/gpio/faraday,ftgpio010.yaml           |  65 ++++++++++
 .../devicetree/bindings/gpio/gpio-vf610.yaml       |   4 +-
 Documentation/devicetree/bindings/gpio/gpio.txt    |   2 +-
 drivers/gpio/Kconfig                               |  16 ++-
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-altera-a10sr.c                   |   3 +-
 drivers/gpio/gpio-crystalcove.c                    |   9 +-
 drivers/gpio/gpio-en7523.c                         | 137 +++++++++++++++++++++
 drivers/gpio/gpio-merrifield.c                     |   3 +
 drivers/gpio/gpio-tegra.c                          |   1 -
 drivers/gpio/gpio-tps68470.c                       |   5 +-
 drivers/gpio/gpio-ts4900.c                         |  10 +-
 drivers/gpio/gpiolib-of.c                          |  10 +-
 drivers/gpio/gpiolib-sysfs.c                       | 100 ++++++---------
 drivers/gpio/gpiolib.c                             |  41 +++---
 drivers/gpio/gpiolib.h                             |  41 ++++++
 include/linux/gpio/consumer.h                      |  35 +++---
 19 files changed, 422 insertions(+), 154 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/airoha,en7523-gpio.yaml
 delete mode 100644 Documentation/devicetree/bindings/gpio/faraday,ftgpio010.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/faraday,ftgpio010.yaml
 create mode 100644 drivers/gpio/gpio-en7523.c
