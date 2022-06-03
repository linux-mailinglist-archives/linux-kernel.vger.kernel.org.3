Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317D953C97F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 13:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244072AbiFCLjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 07:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235135AbiFCLjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 07:39:17 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84BB1B79A;
        Fri,  3 Jun 2022 04:39:15 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id fd25so9783901edb.3;
        Fri, 03 Jun 2022 04:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xRRo842VgI+QiIiUk18sUkKyKXVeEuSKEQQnN+mgccU=;
        b=UqwnkdWsj/uQrNKdsUOEL/RAI/mfwQ1p7bz5+PVAE/sMZI2VS/k1PPsYzA2Xtknk2R
         1cNeuYgzGSkMrbRliGTcMMOWsjeZXJaFAtZXs1CEkR/Uv/TpMlCCUuGA/1eFwDgdpEPw
         CZh3sDqRPzzUvNaLqt+7MJ8jQafWdVZcAY7CGQ7q9jQq0+RUF4RbYlywex/f2D6wKE3d
         zq+1Xqu3GKT+OreXO90bzYk0dXckoWTtatLfZDRoui8Oy4rTe39ZB4Ih4ud5ZpQ537dj
         A5CwOOR77hoJ/zAf0ONqgySpS94gASRc724WMPgmtLER+8+QQsUPbLUCjPug1LYIcg8g
         pddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xRRo842VgI+QiIiUk18sUkKyKXVeEuSKEQQnN+mgccU=;
        b=D6hKMVLZB4s16QqrreBmro7AeU3W0fb0vmO90ivPsBnIGg30jDHCoi8LlGlLn6eEC9
         IHBy+p5Jc8pjtEVTBupeoh+jtdjo9KM8tZfV222zmSUyL6reIeMuATQuqP9ZJDH9cKtq
         hv9ACveoWK9GA2Ox1KPpaGM2nP0aTLb20l2sgMq++gUZbCIyum/YVS6BRpIYr3/F6hb5
         wax/QmCz5A12v3BID4nWhwzfnVtxG66aY4TFYiZ71H44fAHmDNdbZioAR0/E5qU/mFqh
         C/HmktNEGVFMwciYU4uGKZ7ZMxFEYG4vmeiv/JbyK6Q1Sh0WQkzbf79T742U6iIuVjxb
         wy5Q==
X-Gm-Message-State: AOAM532xsPJhiHKPKyXgly6iDBhw5LVFY3RrM1HgC5SwcH/RsE2xnzaa
        51zj0NL5cgk0Ep2OUcnMr4o=
X-Google-Smtp-Source: ABdhPJydXL16vIRY0VomB2fgeezOelqpxRvzG0qyCI679Hb40IKz59LPVhOCSsl7F8ENU6rVfmnGNg==
X-Received: by 2002:a05:6402:1e8b:b0:41c:59f6:2c26 with SMTP id f11-20020a0564021e8b00b0041c59f62c26mr10261446edf.156.1654256354076;
        Fri, 03 Jun 2022 04:39:14 -0700 (PDT)
Received: from localhost (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id d9-20020a50fe89000000b0042dd27ba7bfsm3786935edt.21.2022.06.03.04.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 04:39:12 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dipen Patel <dipenp@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hte: New subsystem for v5.19-rc1
Date:   Fri,  3 Jun 2022 13:39:08 +0200
Message-Id: <20220603113908.78777-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/hte/for-5.19-rc1

for you to fetch changes up to 5dad4eccd2b4316a84209603a28d34c6346392bb:

  dt-bindings: timestamp: Correct id path (2022-06-02 15:56:59 +0200)

This is a new subsystem that introduces support for associating
hardware timestamps with certain events (such as GPIOs and IRQs). Dipen
has worked on this for a couple of months and it's been in linux-next
for a couple of weeks. We think it's now ready for inclusion in v5.19.

Dipen's the official maintainer, but I volunteered to help out with the
logistics while he gets set up with the necessary key signatures and a
kernel.org account. Hopefully this will all be done by the next merge
window, enabling Dipen to take over.

Apologies for this being a little late, but there were a few last-minute
tweaks in the device tree bindings that I wanted to give an extra day in
linux-next just to make sure. The impact of this should be minimal since
it is all new code.

Thanks,
Thierry

----------------------------------------------------------------
hte: New subsystem for v5.19-rc1

This contains the new HTE subsystem that has been in the works for a
couple of months now. The infrastructure provided allows for drivers to
register as hardware timestamp providers, while consumers will be able
to request events that they are interested in (such as GPIOs and IRQs)
to be timestamped by the hardware providers.

Note that this currently supports only one provider, but there seems to
be enough interest in this functionality and we expect to see more
drivers added once this is merged.

----------------------------------------------------------------
Dan Carpenter (2):
      hte: Fix off by one in hte_push_ts_ns()
      hte: Uninitialized variable in hte_ts_get()

Dipen Patel (12):
      Documentation: Add HTE subsystem guide
      drivers: Add hardware timestamp engine (HTE) subsystem
      hte: Add Tegra194 HTE kernel provider
      dt-bindings: Add HTE bindings
      gpiolib: Add HTE support
      gpio: tegra186: Add HTE support
      gpiolib: cdev: Add hardware timestamp clock type
      tools: gpio: Add new hardware clock type
      hte: Add Tegra HTE test driver
      MAINTAINERS: Add HTE Subsystem
      dt-bindings: Renamed hte directory to timestamp
      dt-bindings: timestamp: Correct id path

Jiapeng Chong (1):
      hte: Remove unused including <linux/version.h>

Yang Yingliang (1):
      hte: Fix possible use-after-free in tegra_hte_test_remove()

 .../timestamp/hardware-timestamps-common.yaml      |  29 +
 .../bindings/timestamp/hte-consumer.yaml           |  39 +
 .../bindings/timestamp/nvidia,tegra194-hte.yaml    |  88 ++
 Documentation/hte/hte.rst                          |  79 ++
 Documentation/hte/index.rst                        |  22 +
 Documentation/hte/tegra194-hte.rst                 |  49 ++
 Documentation/index.rst                            |   1 +
 MAINTAINERS                                        |   8 +
 drivers/Kconfig                                    |   2 +
 drivers/Makefile                                   |   1 +
 drivers/gpio/gpio-tegra186.c                       |  81 +-
 drivers/gpio/gpiolib-cdev.c                        | 252 +++++-
 drivers/gpio/gpiolib.c                             |  58 ++
 drivers/gpio/gpiolib.h                             |   1 +
 drivers/hte/Kconfig                                |  33 +
 drivers/hte/Makefile                               |   3 +
 drivers/hte/hte-tegra194-test.c                    | 238 ++++++
 drivers/hte/hte-tegra194.c                         | 730 ++++++++++++++++
 drivers/hte/hte.c                                  | 947 +++++++++++++++++++++
 include/linux/gpio/consumer.h                      |  16 +-
 include/linux/gpio/driver.h                        |  10 +
 include/linux/hte.h                                | 271 ++++++
 include/uapi/linux/gpio.h                          |   3 +
 tools/gpio/gpio-event-mon.c                        |   6 +-
 24 files changed, 2930 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.yaml
 create mode 100644 Documentation/devicetree/bindings/timestamp/hte-consumer.yaml
 create mode 100644 Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
 create mode 100644 Documentation/hte/hte.rst
 create mode 100644 Documentation/hte/index.rst
 create mode 100644 Documentation/hte/tegra194-hte.rst
 create mode 100644 drivers/hte/Kconfig
 create mode 100644 drivers/hte/Makefile
 create mode 100644 drivers/hte/hte-tegra194-test.c
 create mode 100644 drivers/hte/hte-tegra194.c
 create mode 100644 drivers/hte/hte.c
 create mode 100644 include/linux/hte.h
