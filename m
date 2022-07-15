Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BFD576687
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 20:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiGOSDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 14:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiGOSDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 14:03:23 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D625542AD0;
        Fri, 15 Jul 2022 11:03:22 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id s21so6279256pjq.4;
        Fri, 15 Jul 2022 11:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=82CEaTbPG5hRrKufgDuMl8R+gnz9vTnIDmFc+J3kvLs=;
        b=mS6SGZnqBxs6zBiQDMMbYqq1t1OADDFPaNO8IC2b1/cmmQF4XjF8YZYPKhTRECATiv
         LLG8iEG2GZDAqIloJ/l+7k1dezrL+UyuU6ScAVfOBgxZkgbnFJNvTYLtYdRIUlxgvtQS
         MGf35eiT1yZDjjYJp7IrVVs09i5buYYi1wPr9RiGKYH0wLJ61T266xZ+JaMRPp0OSR1L
         jdUAd58fQSGD1b0WBfBIkMQVT0L/4BqRGJbQsASXnRZ6lObtPCFUoOInvqU8YFYaqbJH
         AYztprdigI6blCGWs65eK4U7aCYX0cZJ5ZkAzktbNWAB7Mtx60vbecICHEwHP79pp9ec
         xfAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=82CEaTbPG5hRrKufgDuMl8R+gnz9vTnIDmFc+J3kvLs=;
        b=mUQgILbXevU5fglEbfd1Wm7xVk7yAFvImx8Q0wHJ/LsQEfzDygKHwNLFHdVKVcqZ4e
         hLWu13v2Vs9qV0c1uLtHJ3qGI2Kvrh+NHdy8Z8hbaudqt8OV9qlniLTP5530l8MXV6/E
         Oa5rYZCobfRSGNBD9dVh7n+pRbGvtfz33VyYh7zlwR4q275qGP3YjLSthsEOOq1X4qG3
         lCgkg+MhtxQLDmXVd57VCbZJYTHnvwWm7rmBqg/Jyq00GU90DddlPLDdw/6Vll6npEID
         yYff5DNcOrPggLH7Kj2KM6aL3F2H2uH2KOt//s2xh8rdK7bqkpL0CVZMfJIjfdIKDK81
         nY9g==
X-Gm-Message-State: AJIora+3qkvuvnllkMFHgA6b5uQaWbYABHkqFA0hDZyEpqu/ppoMTunJ
        nDFNz40YxpHaGPrYhIU83S1yR+qR0vc=
X-Google-Smtp-Source: AGRyM1vERXA6u2bO16oEvEDdFxRpgtr5+ZU6yasU0gnfdlN9ZH5WlAbBu+BHoT5EVFKk6OtHITRArQ==
X-Received: by 2002:a17:90b:1b48:b0:1ef:a90d:eae1 with SMTP id nv8-20020a17090b1b4800b001efa90deae1mr22951161pjb.68.1657908202280;
        Fri, 15 Jul 2022 11:03:22 -0700 (PDT)
Received: from [172.30.1.47] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902a38100b0015ee60ef65bsm3870042pla.260.2022.07.15.11.03.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 11:03:21 -0700 (PDT)
Message-ID: <06ba1e63-16a5-5659-e062-3c7e12f7e5cd@gmail.com>
Date:   Sat, 16 Jul 2022 03:03:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "open list:DEVICE FREQUENCY (DEVFREQ)" <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanwoo Choi <chanwoo@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Subject: [GIT PULL] devfreq next for 5.20
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Rafael,

This is devfreq-next pull request for v5.20-rc1. I add detailed description of
this pull request on the following tag. Please pull devfreq with
following updates.

Best Regards,
Chanwoo Choi


The following changes since commit 32346491ddf24599decca06190ebca03ff9de7f8:

  Linux 5.19-rc6 (2022-07-10 14:40:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-5.20

for you to fetch changes up to 53f853d55e312a639eaa910154248ce06eb754ac:

  PM / devfreq: tegra30: Add error message for devm_devfreq_add_device() (2022-07-15 11:40:08 +0900)
----------------------------------------------------------------

Update devfreq next for v5.20

Detailed description for this pull request:
1. Add new Mediatek CCI (Cache Coherent Interconnect) devfreq driver
- Add new MediaTek Cache Coherent Interconnect (CCI) devfreq drviver
  which supports the dynamic voltage and clock scaling.
  This driver uses the passive devfreq governor to get target frequencies
  and adjust voltages because it depends on MediaTek cpu frequency
  driver. In MT8183 and MT8186, the MediaTek CCI is supplied
  by the same regulators with the little core CPUs.

2. Update the devfreq drivers
- Convert the Samsung Exynos SoC Bus bindings to DT schema of exynos-bus.c

- Remove kernel-doc warnings by adding the description for unused
  fucntio parameters on devfreq core.

- Use NULL to pass a null pointer rather than zero according to function
  propotype on imx-bus.c

- Print error message instead of error interger value on tegra30-devfreq.c

----------------------------------------------------------------
Colin Ian King (1):
      PM / devfreq: imx-bus: use NULL to pass a null pointer rather than zero

Dmitry Osipenko (1):
      PM / devfreq: tegra30: Add error message for devm_devfreq_add_device()

Johnson Wang (2):
      dt-bindings: interconnect: Add MediaTek CCI dt-bindings
      PM / devfreq: mediatek: Introduce MediaTek CCI devfreq driver

Krzysztof Kozlowski (1):
      dt-bindings: interconnect: samsung,exynos-bus: convert to dtschema

Mauro Carvalho Chehab (1):
      PM / devfreq: shut up kernel-doc warnings

 .../devicetree/bindings/devfreq/exynos-bus.txt     | 488 ---------------------
 .../bindings/interconnect/mediatek,cci.yaml        | 141 ++++++
 .../bindings/interconnect/samsung,exynos-bus.yaml  | 290 ++++++++++++
 MAINTAINERS                                        |   3 +-
 drivers/devfreq/Kconfig                            |  10 +
 drivers/devfreq/Makefile                           |   1 +
 drivers/devfreq/devfreq.c                          |   4 +
 drivers/devfreq/imx-bus.c                          |   2 +-
 drivers/devfreq/mtk-cci-devfreq.c                  | 440 +++++++++++++++++++
 drivers/devfreq/tegra30-devfreq.c                  |   4 +-
 10 files changed, 892 insertions(+), 491 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/devfreq/exynos-bus.txt
 create mode 100644 Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/samsung,exynos-bus.yaml
 create mode 100644 drivers/devfreq/mtk-cci-devfreq.c
