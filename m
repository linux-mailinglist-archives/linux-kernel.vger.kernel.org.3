Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B79591555
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 20:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238539AbiHLSMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 14:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiHLSMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 14:12:06 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F81B2871;
        Fri, 12 Aug 2022 11:12:01 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id s10so866856ilq.5;
        Fri, 12 Aug 2022 11:12:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=vPDP46SbD5PMcyL1dEuWf5iKsofXHoY5Pt8XyHeL+Ho=;
        b=ymy1MjYeENA/iG6ie7GCZpkNIC20g1cmOZ8mH0E+eQH/yojmD+9RwU9Bg2POmIwiI7
         3GNBDyUWzi7MBU66wcarj5/1/NJbux5q3oNX1NHJIFL/6HRipAZE2ifMRYRO2lE8vnTI
         qhXRU54qlZ723tV04t4w5kFfdydyohUlinldwUWv5iIGjRDyd9CUSjjLEmDpBxEZKhEJ
         gGgldR6p0DAkXuXWPyF8OVCLj4lHPRD+AwegxmX7ziejf9hzkKz7n8HkviSiogUyF2Y3
         C3JDBVD90JAlqd0g3n3pqj6NA4r5gHRLX1ct6xHBzLDzOsP6c5X0JbEbGLD793pQYExs
         xn4Q==
X-Gm-Message-State: ACgBeo3T7UBQrEq1hf86DLqUQJ8wN+SVl8RI9LHsuxcI+KTdgsuw6hi8
        FFrTEWhSZw3Y7POYXqImsw==
X-Google-Smtp-Source: AA6agR7Iogo68hWdtZvlYHAq3kuETNChIpkR/cUVPhgEQ27Q565iwm/ZxwYiFtBuuoHtdJ3bi3Ik+g==
X-Received: by 2002:a05:6e02:1208:b0:2df:38d1:cb5b with SMTP id a8-20020a056e02120800b002df38d1cb5bmr2452528ilq.65.1660327920358;
        Fri, 12 Aug 2022 11:12:00 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id b24-20020a02a598000000b0034334c61c96sm150726jam.106.2022.08.12.11.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 11:11:59 -0700 (PDT)
Received: (nullmailer pid 465319 invoked by uid 1000);
        Fri, 12 Aug 2022 18:11:58 -0000
Date:   Fri, 12 Aug 2022 12:11:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree fixes for v6.0, take 1
Message-ID: <20220812181158.GA462401-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull a few DT fixes and one missed schema conversion.

Rob


The following changes since commit eb555cb5b794f4e12a9897f3d46d5a72104cd4a7:

  Merge tag '5.20-rc-ksmbd-server-fixes' of git://git.samba.org/ksmbd (2022-08-08 20:15:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.0-1

for you to fetch changes up to 8f426582e0e0c9bbd58e170e1b209334eb5df79e:

  dt-bindings: chrome: google,cros-ec-typec: restrict allowed properties (2022-08-12 11:13:32 -0600)

----------------------------------------------------------------
Devicetree fixes for v6.0, take 1:

- Fix schema warnings in qcom,ipq6018-pinctrl and sdhci-msm

- Convert Qualcomm SPMI PMIC to DT schema

- Make secure interrupt optional for arm,mhu

- Fix google,cros-ec-typec binding allowed properties

- Update a bunch of bouncing email addresses

----------------------------------------------------------------
Bhupesh Sharma (1):
      dt-bindings: mmc: sdhci-msm: Fix 'operating-points-v2 was unexpected' issue

David Heidelberg (1):
      dt-bindings: mfd: convert to yaml Qualcomm SPMI PMIC

Krzysztof Kozlowski (7):
      dt-bindings: display: simple-framebuffer: Drop Bartlomiej Zolnierkiewicz
      dt-bindings: iio: Drop Joachim Eastwood
      dt-bindings: iio: Drop Bogdan Pricop
      dt-bindings: Drop Beniamin Bia and Stefan Popa
      dt-bindings: Drop Robert Jones
      dt-bindings: Drop Dan Murphy and Ricardo Rivera-Matos
      dt-bindings: chrome: google,cros-ec-typec: restrict allowed properties

Rob Herring (3):
      dt-bindings: Drop DT_MK_SCHEMA_FLAGS conditional selecting schema files
      dt-bindings: pinctrl: qcom,ipq6018: Fix example 'gpio-ranges' size
      dt-bindings: mailbox: arm,mhu: Make secure interrupt optional

 Documentation/devicetree/bindings/Makefile         |   4 +-
 .../bindings/chrome/google,cros-ec-typec.yaml      |  15 +-
 .../bindings/display/simple-framebuffer.yaml       |   1 -
 .../devicetree/bindings/hwmon/adi,adm1177.yaml     |   1 -
 .../devicetree/bindings/iio/accel/fsl,mma7455.yaml |   1 -
 .../devicetree/bindings/iio/adc/adi,ad7091r5.yaml  |   2 +-
 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    |   3 +-
 .../bindings/iio/adc/nxp,lpc1850-adc.yaml          |   2 +-
 .../devicetree/bindings/iio/adc/ti,adc108s102.yaml |   2 +-
 .../devicetree/bindings/iio/adc/ti,ads124s08.yaml  |   2 +-
 .../bindings/iio/amplifiers/adi,hmc425a.yaml       |   1 -
 .../devicetree/bindings/iio/imu/nxp,fxos8700.yaml  |   2 +-
 .../bindings/leds/leds-class-multicolor.yaml       |   2 +-
 .../devicetree/bindings/leds/leds-lp50xx.yaml      |   2 +-
 .../devicetree/bindings/mailbox/arm,mhu.yaml       |   1 +
 .../devicetree/bindings/mfd/gateworks-gsc.yaml     |   1 -
 .../devicetree/bindings/mfd/qcom,spmi-pmic.txt     |  94 ----------
 .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    | 190 +++++++++++++++++++++
 .../devicetree/bindings/mmc/sdhci-msm.yaml         |   2 +
 .../devicetree/bindings/net/ti,dp83822.yaml        |   2 +-
 .../devicetree/bindings/net/ti,dp83867.yaml        |   2 +-
 .../devicetree/bindings/net/ti,dp83869.yaml        |   2 +-
 .../bindings/pinctrl/qcom,ipq6018-pinctrl.yaml     |   2 +-
 .../devicetree/bindings/power/supply/bq2515x.yaml  |   3 +-
 .../devicetree/bindings/power/supply/bq256xx.yaml  |   2 +-
 .../devicetree/bindings/power/supply/bq25980.yaml  |   3 +-
 .../devicetree/bindings/sound/tas2562.yaml         |   2 +-
 .../devicetree/bindings/sound/tlv320adcx140.yaml   |   2 +-
 28 files changed, 224 insertions(+), 124 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
