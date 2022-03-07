Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EF54CFF6A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 14:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241939AbiCGNCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235527AbiCGNCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:02:51 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15178A32A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 05:01:56 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id j17so23230727wrc.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 05:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=e67SutZxG438sci1TBJeJ7WtZkdVAr0qTy9gsVN3XwY=;
        b=x+ujloCRfsfVUjD1tD5rOP9jCBUAWKTRgEdz3RtXOAjouh8yHGKYjEERy5ZVtCTQjA
         vAjYQFg6yZOvnG77Fvw6ztdwzm7jb+nZqf5tPFWRoYoK8C2JWiVj7Q/KIk/EmjLTo8tX
         c+nH5I9dKsAkJ66wInYvfdxMDzBXmY5cjYKon3s2l9zJf7OLJqMSIDX/kS/iwR0tpqF4
         rlGp0zDx4dBAEsTnYca9a02lmFEebeGEiq8SYwLu2O4aC5dkugJCwMHcU8ZzZCcyaZk8
         49bsJTgttC36MOr6YgubjbJlltWBapYUbu+w/PZ3cqdmwwNZqRk1sZWGelokMdB3RhUh
         5zXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=e67SutZxG438sci1TBJeJ7WtZkdVAr0qTy9gsVN3XwY=;
        b=q9yhU0serIddsOY2bM2Ic2LPeFIlyud8AcQMRA573zEucthIZqOTqfld1Mf2NfQgOw
         2KWwGcUIUpCpGt56ZxSlzaBiRzy6qgjc/1FJFdCXSaY+UBdm2/Us8JOdssPYIlzgktCD
         MUMDN/lEYEuypjXslAL3CiH6+UkaoCUy7Au0tx9wWg2GvUhDAVEJZdUI7k2C1gU+IK9l
         yx7cCqABE+BQiQVBp4vFRR0mzKiX4ioWag1tkrhrBtxampj9fHxEUQlbMKpE9tJrDFW0
         4e54J1x0UbUeJDtlZUlPqaRaBAxMU27xZN9hJmTzNh1Ppzf0GzM5Q8drOdcrUaRk354S
         A9eQ==
X-Gm-Message-State: AOAM532J8T76MKEMN0ZoxbhuJB1FnX/l8ZmOFOGEfUBS3ycKFgG439kB
        eNr37xOk4C1FrtnNJ9nZG+Jrrg==
X-Google-Smtp-Source: ABdhPJyHJ5P/m6mr2APBp60J06cUWzigQkU9p2bOxINnrtMKSgqEdCUvkQo+S0Ov7CLmNhewHBpPeQ==
X-Received: by 2002:a5d:4cc1:0:b0:1f0:98e7:6af0 with SMTP id c1-20020a5d4cc1000000b001f098e76af0mr7953333wrt.363.1646658115173;
        Mon, 07 Mar 2022 05:01:55 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c26cb00b0037ff53511f2sm18526778wmv.31.2022.03.07.05.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 05:01:54 -0800 (PST)
Date:   Mon, 7 Mar 2022 13:01:53 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Immutable branch between MFD, SPI and DT  due for the
 v5.18 merge window
Message-ID: <YiYCQdLSuyAY9JKk@google.com>
References: <20220215075344.31421-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220215075344.31421-1-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[correct subject line this time]

Enjoy!

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-spi-dt-v5.18

for you to fetch changes up to 172e611b54e813c49a35b6b74bccaa99f27bf566:

  dt-bindings: mfd: maxim,max77802: Convert to dtschema (2022-03-07 12:55:59 +0000)

----------------------------------------------------------------
Immutable branch between MFD, SPI and DT  due for the v5.18 merge window

----------------------------------------------------------------
Krzysztof Kozlowski (13):
      dt-bindings: extcon: maxim,max77843: Add MAX77843 bindings
      regulator: dt-bindings: maxim,max77843: Add MAX77843 bindings
      dt-bindings: mfd: maxim,max77843: Add MAX77843 bindings
      MAINTAINERS: mfd: Cover MAX77843 by Maxim PMIC/MUIC for Exynos boards entry
      spi: dt-bindings: samsung: Convert to dtschema
      mfd: dt-bindings: google,cros-ec: Reference Samsung SPI bindings
      mfd: dt-bindings: google,cros-ec: Fix indentation in example
      spi: s3c64xx: Allow controller-data to be optional
      dt-bindings: power: supply: maxim,max14577: Convert to dtschema
      regulator: dt-bindings: maxim,max14577: Convert to dtschema
      dt-bindings: mfd: maxim,max14577: Convert to dtschema
      regulator: dt-bindings: maxim,max77802: Convert to dtschema
      dt-bindings: mfd: maxim,max77802: Convert to dtschema

 .../devicetree/bindings/extcon/maxim,max77843.yaml |  40 +++++
 .../devicetree/bindings/mfd/google,cros-ec.yaml    |  31 ++--
 Documentation/devicetree/bindings/mfd/max14577.txt | 147 ----------------
 Documentation/devicetree/bindings/mfd/max77802.txt |  25 ---
 .../devicetree/bindings/mfd/maxim,max14577.yaml    | 195 +++++++++++++++++++++
 .../devicetree/bindings/mfd/maxim,max77802.yaml    | 194 ++++++++++++++++++++
 .../devicetree/bindings/mfd/maxim,max77843.yaml    | 144 +++++++++++++++
 .../bindings/power/supply/maxim,max14577.yaml      |  84 +++++++++
 .../devicetree/bindings/regulator/max77802.txt     | 111 ------------
 .../bindings/regulator/maxim,max14577.yaml         |  78 +++++++++
 .../bindings/regulator/maxim,max77802.yaml         |  85 +++++++++
 .../bindings/regulator/maxim,max77843.yaml         |  65 +++++++
 .../bindings/soc/samsung/exynos-usi.yaml           |   2 +-
 .../bindings/spi/samsung,spi-peripheral-props.yaml |  33 ++++
 .../devicetree/bindings/spi/samsung,spi.yaml       | 187 ++++++++++++++++++++
 .../bindings/spi/spi-peripheral-props.yaml         |   1 +
 .../devicetree/bindings/spi/spi-samsung.txt        | 122 -------------
 MAINTAINERS                                        |   9 +-
 drivers/spi/spi-s3c64xx.c                          |  14 +-
 19 files changed, 1136 insertions(+), 431 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/extcon/maxim,max77843.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/max14577.txt
 delete mode 100644 Documentation/devicetree/bindings/mfd/max77802.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max14577.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max77802.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max77843.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max14577.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/max77802.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max14577.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77802.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77843.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/samsung,spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-samsung.txt

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
