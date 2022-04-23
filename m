Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF27F50C855
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 10:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbiDWI4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 04:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiDWI4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 04:56:53 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D11B203F67;
        Sat, 23 Apr 2022 01:53:57 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id bq30so18107848lfb.3;
        Sat, 23 Apr 2022 01:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p6GJf9BMIDR3r+WQtHJ0HYAGpVz6cOo41pGrBoVNvTk=;
        b=h3abwxPAQQ5leVx3P//ivcf0kvc+JnoRD28JZ4dd0+IsPw5BqQNxR3rT1Q45MdsY+8
         VjW46SGQ/6WAwFncePCK/pR9EqDvOKjc6TM6ohn2jgf1bW1nq5HbvbCMdzOvixssHTPd
         aAmaNfJ4fGj+UlfGzQ02ziHXeSuv0gNAQ11LxjLAXKWOWxjqzk/ywbIjGSKjH+S2TpMW
         lrRu0m/ShEKe8xFJJsmEQhemGbAZ+HplRhZtpHeRvw6gwuCKon5t5jiOOulPRIJZLwVS
         YJSJ/29MoY2LCP9tFJJDcsyZQU2RQhg+kSXZB0MxKKvIhoerLLAisJE9DFueVlNU+PKE
         lIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p6GJf9BMIDR3r+WQtHJ0HYAGpVz6cOo41pGrBoVNvTk=;
        b=f0RNI8nPn6HhNNxGpBJR22zdLRRQx1sHBof39KJDH/jMGQHKPkZqUFA/gYE1usTu9i
         b4qybDPgixyS1DrWHUbMPt1v9ldRwBFj41anD4DTv8Wgkbtn3YhIO1FXyX/YawxG8obR
         jPv8+y7uLydwOdhQnpiFNHg/oG6c/dNr0fkwO763WM/Gk9Nu6uUAX7trjGXxAzFTKf2B
         oi2oGJY35K+VYlipEpQYJ/mFA1T6jcUSizpsc1pt1HlFOG64jrA1D5Skbt7TOuEDNfRE
         WT5fUEFJRAKLNhjCYE3a+qxP9hQWy5WE08PKQto5Ix5ld1uIae7NgY6kQxyCUnNavDGm
         sGKw==
X-Gm-Message-State: AOAM532KWQVzyZzslYWKUWbE345te5r0THhKu2QloGUjzAQoiYRZnpUi
        OyIxSia3BGNM3vvHFpvIJxLBHLnpjhA=
X-Google-Smtp-Source: ABdhPJzIcXlKiaNe1PPx5Yj42/leZ1jOUpTURdYSOoBTr1ty8ykAQj2PhHXpVGKKVtAoWjTrUdVxzg==
X-Received: by 2002:a05:6512:31cc:b0:471:d125:162c with SMTP id j12-20020a05651231cc00b00471d125162cmr6039834lfe.96.1650704035156;
        Sat, 23 Apr 2022 01:53:55 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id p25-20020a2e9a99000000b0024dc3ccff47sm493677lji.32.2022.04.23.01.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 01:53:54 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v5 0/5] Add support for Silicon Mitus SM5703 MFD
Date:   Sat, 23 Apr 2022 11:53:13 +0300
Message-Id: <20220423085319.483524-1-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for Silicon Mitus SM5703 MFD and the
appropriate device-tree bindings. This only adds support for the
regulator module, leaving room for other modules implemented in
future (code for other modules is really not ready for submission
right now). Silicon Mitus SM5703 is used on various mobile phones,
mostly Samsung Galaxy (J5 (2015, 2016), On7, J7 (2015, 2016) ...).

Cc: Matti Vaittinen <mazziesaccount@gmail.com>

v2:
- mfd bindings: add "SM5703" to the title
- mfd bindings: indent the example
- regulators/Makefile: sort alphabetically
v3:
- mfd bindings: fix an error in example: there should be no
  newline between #size-cells and #address-cells and the node
v4:
mfd bindings:
- drop the -mfd in the compatible
- change reference path to the regulator yaml to an absolute one
- use -gpios for the reset GPIO
- make reset-gpios a required property
- correct the example node name
- correct the example compatible
regulator bindings:
- add unevaluatedProperties: false to all four types of regulators
v5:
mfd driver:
- depend on OF for the SM5703 MFD (Kconfig)
- correct the compatible in the MFD driver
- remove the compatible of -regulators in the struct mfd_cell*
mfd bindings:
- adjust the example for regulators {} node
- include GPIO header in the example
- indent the example properly
- adjust the example for the voltage regulators being fixed
regulator bindings:
- remove the compatible
- refer to regulators.yaml
regulator driver:
- add a separate ops for fixed voltage regulators (to avoid kernel WARN)
- set the config.dev to dev->parent to probe from parent OF node
- (Kconfig) SM5703_MFD -> MFD_SM5703 fix typo

- Add a patch to avoid driver name conflicts in SM5502 extcon driver

Markuss Broks (4):
  dt-bindings: regulator: Add bindings for Silicon Mitus SM5703
    regulators
  dt-bindings: mfd: Add bindings for Silicon Mitus SM5703 MFD
  mfd: sm5703: Add support for SM5703 MFD
  regulator: sm5703-regulator: Add regulators support for SM5703 MFD

 .../bindings/mfd/siliconmitus,sm5703.yaml     |  91 ++++++++++
 .../siliconmitus,sm5703-regulator.yaml        |  48 ++++++
 MAINTAINERS                                   |   8 +
 drivers/mfd/Kconfig                           |  12 ++
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/sm5703.c                          |  81 +++++++++
 drivers/regulator/Kconfig                     |   7 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/sm5703-regulator.c          | 162 ++++++++++++++++++
 include/linux/mfd/sm5703.h                    | 105 ++++++++++++
 10 files changed, 516 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml
 create mode 100644 drivers/mfd/sm5703.c
 create mode 100644 drivers/regulator/sm5703-regulator.c
 create mode 100644 include/linux/mfd/sm5703.h

-- 
2.35.1

