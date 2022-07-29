Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4A258535E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 18:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237226AbiG2QVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 12:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiG2QU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 12:20:57 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F5187363;
        Fri, 29 Jul 2022 09:20:55 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id tk8so9383953ejc.7;
        Fri, 29 Jul 2022 09:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0fH5jllVFqMSEJxCgYVeoVoO2vhQofVpCBdQLjkkMaQ=;
        b=T2cdYKOUcrfbZenlYRnBZPOM85RT/qd65fs/xTRFTWGCSMBUXn0HZeZa6AyrqUWcbM
         ewEICxlW1vfLf9pHCTOkgypWmUe/bqNd8EzE2OWi4Vy2h22bIQn8+4DmcsOupE9iuM/C
         JdZnndHLopzIAzvMbUZgl4tSRFIGo22uV+1ULURpNuSU9Ql25SmK398AFLb5uJpKBasL
         /SnX/yWdHUSGrWnHiGtviEY32TLlj21Gd/wnrcROAnT8x/RH4U97JLlshe14wFfA3zUT
         ydY8Zie+mzvO3R+AphCkgB/6uE54re5cmxq18TvQYIas2qVJZuT01M5F0IjIzFACSYvX
         Frvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0fH5jllVFqMSEJxCgYVeoVoO2vhQofVpCBdQLjkkMaQ=;
        b=GdUubhyPctDC97eQ63lIGntviTescevP5UyMKoWbYaKjfP9tZGWcFRGho7PzQEiWOb
         JXAqnoIArk9mj73qdPqTvY43J34qfHc5CIqKGIzRvgoocmNvWhJN9QS4e3Je+V2lEBFp
         PTgt9UG9wirULhxXI7W9AdEjwP/2fTW1bEM8sEf36I77okiwrlzA0XEd9+84jkw48LDK
         RqMh8O9bhT4ikBhGDJ3duDs7prAf1xnNieU9TQfC1060/3lh+rDXmU0fTCw7ZCaUOZcA
         UpMlqZUGePKb4q56YkiQdtRs/MFIOIR7DlfB6N0EfzJJPrRpLYh5Wgi9uZO3BahZy5oD
         tUEg==
X-Gm-Message-State: AJIora8j44z9AgxQElmdrrB7GuDHOlgV76Rmson2g7iG25Zd10SjgEdy
        9InY2Fs+BTHuEUN7ILk8xFM=
X-Google-Smtp-Source: AGRyM1sYQvmyI4/jn52FywFyZpQOXmxUe3ueHWulpxVI8dgZ8FNAwrilrHN9PqH04wM11rgovhRmxg==
X-Received: by 2002:a17:907:9491:b0:72f:2827:37c3 with SMTP id dm17-20020a170907949100b0072f282737c3mr3530866ejc.306.1659111654181;
        Fri, 29 Jul 2022 09:20:54 -0700 (PDT)
Received: from localhost (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090626ca00b007262b7afa05sm1849422ejc.213.2022.07.29.09.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 09:20:53 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for v5.20-rc1
Date:   Fri, 29 Jul 2022 18:20:50 +0200
Message-Id: <20220729162050.2866901-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.20-rc1

for you to fetch changes up to 8933d30c5f468d6cc1e4bf9bb535149da35f202e:

  pwm: lpc18xx: Fix period handling (2022-07-29 13:41:18 +0200)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v5.20-rc1

After v5.19 had all drivers converted to the new atomic API and nobody
has reported any breakage, this set of changes starts by dropping the
legacy support.

Some existing drivers get improvements and broader chip support and a
new driver is added that emulates a PWM controller using a clock output.

Other than that there's the usual bits of cleanups and minor fixes.

----------------------------------------------------------------
Fabien Parent (3):
      dt-bindings: pwm: Add MT8365 SoC binding
      pwm: mediatek: Add MT8365 support
      dt-bindings: pwm: mediatek: Add compatible string for MT8195

Julia Lawall (1):
      pwm: atmel-tcb: Fix typo in comment

Lee Jones (1):
      MAINTAINERS: Remove myself as PWM maintainer

Lukas Bulwahn (1):
      MAINTAINERS: Add include/dt-bindings/pwm to PWM SUBSYSTEM

Nikita Travkin (2):
      dt-bindings: pwm: Document clk based PWM controller
      pwm: Add clock based PWM output driver

Uwe Kleine-König (13):
      pwm: Drop support for legacy drivers
      pwm: Reorder header file to get rid of struct pwm_capture forward declaration
      pwm: Drop unused forward declaration from pwm.h
      pwm: sifive: Simplify offset calculation for PWMCMP registers
      pwm: sifive: Fold pwm_sifive_enable() into its only caller
      pwm: sifive: Reduce time the controller lock is held
      pwm: sifive: Enable clk only after period check in .apply()
      pwm: sifive: Simplify clk handling
      pwm: sifive: Ensure the clk is enabled exactly once per running PWM
      pwm: sifive: Shut down hardware only after pwmchip_remove() completed
      pwm: twl-led: Document some limitations and link to the reference manual
      pwm: lpc18xx: Convert to use dev_err_probe()
      pwm: lpc18xx: Fix period handling

 Documentation/devicetree/bindings/pwm/clk-pwm.yaml |  46 +++++++
 .../devicetree/bindings/pwm/pwm-mediatek.txt       |   3 +
 MAINTAINERS                                        |   2 +-
 drivers/pwm/Kconfig                                |  10 ++
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/core.c                                 |  82 +-----------
 drivers/pwm/pwm-atmel-tcb.c                        |   2 +-
 drivers/pwm/pwm-clk.c                              | 148 +++++++++++++++++++++
 drivers/pwm/pwm-lpc18xx-sct.c                      |  67 ++++++----
 drivers/pwm/pwm-mediatek.c                         |   7 +
 drivers/pwm/pwm-sifive.c                           | 117 ++++++++--------
 drivers/pwm/pwm-twl-led.c                          |  16 +++
 include/linux/pwm.h                                |  35 ++---
 13 files changed, 349 insertions(+), 187 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/clk-pwm.yaml
 create mode 100644 drivers/pwm/pwm-clk.c
