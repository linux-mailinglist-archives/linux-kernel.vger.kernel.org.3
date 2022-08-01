Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823E8586B36
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbiHAMr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbiHAMrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:47:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F9ABF47
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 05:38:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76A1761128
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 12:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8404FC433D6;
        Mon,  1 Aug 2022 12:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659357496;
        bh=YbiPaRADfaZdOZqXAevhYBvKljj3zyXSlE1baUc/s0Y=;
        h=From:To:Cc:Subject:Date:From;
        b=tet6769k0e/Q6sRLmiByELahRfoTrDi4EtkD8RqCLuGivE40Ve231b15VPzA4q8cf
         Ut7x+PBD1XPhTRKFR2XNiF3L0gLZ/woCpf2zqD92xOqwhQgittod0rgBCNnVnxDqFx
         XPQyiGUI3G6mEfvbHgNdOnstcMa9YdCfv2Vr6WjHx852y1qNx4bjh9RXqlNRHtT6aT
         zI6p75N06HlSIHdL7vkUi6Jq3GbuBwhIHnmhbbw4HJMZGNBTPTFqIC5iMqzsFpTn0q
         LEDuE5LZYrthBf9k4SCovWY4JsvqPxooYvMJLmjU/kQAnDy3mXeIE/QHqxpmKvDwfO
         fYX0dJC6GUGcw==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator updates for v5.20
Date:   Mon, 01 Aug 2022 13:38:03 +0100
Message-Id: <20220801123816.8404FC433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 122e951eb8045338089b086c8bd9b0b9afb04a92:

  regulator: qcom_smd: correct MP5496 ranges (2022-06-07 20:38:09 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.20

for you to fetch changes up to efc93392960cb9c3534e7aed15481ca7bcfdf15c:

  regulator: Consumer load management improvements (2022-07-28 00:01:30 +0100)

----------------------------------------------------------------
regulator: Updates for v5.20

This has been a fairly quiet release for the regulator API, a few new
drivers and a small API update:

 - Support for specifying an initial load as part of requesting
   regulators through the bulk API.
 - Support for Maxim MAX597x, Qualcomm PM8074, PM8909 and Realtek RT5120
   devices.

----------------------------------------------------------------
Axel Lin (1):
      regulator: max597x: Don't return uninitialized variable in .probe

ChiYuan Huang (5):
      regulator: rt5190a: check if init_data is NULL, bypass rt5190a_of_parse_cb
      regulator: rt5120: Add PMIC regulator support
      regulator: mt6370: Add mt6370 DisplayBias and VibLDO support
      regulator: mt6370: Use 'fwnode_gpiod_get_index' to fix gpio parsing
      regulator: mt6370: Use the correct header for platform_device_id

Christian Kohlschütter (1):
      regulator: core: Fix off-on-delay-us for always-on/boot-on regulators

Douglas Anderson (2):
      regulator: core: Allow specifying an initial load w/ the bulk API
      regulator: core: Allow drivers to define their init data as const

Jean Delvare (1):
      regulator: mt6380: Fix unused array warning

Jiapeng Chong (1):
      regulator: max597x: Remove unused including <linux/version.h>

Lee Jones (1):
      regulator: pwm: Update Lee Jones' email address

Liang He (2):
      regulator: scmi: Add missing of_node_get()
      regulator: of: Fix refcount leak bug in of_get_regulation_constraints()

Mark Brown (3):
      regulator: qcom_smd: Add PM8909 and fix pm8916_pldo range
      regulator: Fix MFD_MAX597X dependency
      regulator: Consumer load management improvements

Mauro Carvalho Chehab (1):
      regulator: fix a kernel-doc warning

Patrick Rudolph (1):
      regulator: max597x: Add support for max597x regulator

Rob Herring (2):
      regulator: dt-bindings: Convert pwm-regulator to DT schema
      regulator: Add missing type for 'regulator-microvolt-offset'

Robert Marko (11):
      regulator: dt-bindings: mps,mp5416: add MP5496 compatible
      regulator: mp5416: alphabetically sort header includes
      regulator: mp5416: use OF match data
      regulator: mp5416: add support for MP5496
      regulator: mp5416: remove kernel.h include
      regulator: qcom_smd: add get_voltage to MP5496
      regulator: qcom_spmi: add support for HT_P150
      regulator: qcom_spmi: add support for HT_P600
      regulator: qcom_spmi: add support for PMP8074 regulators
      regulator: qcom,spmi-regulator: Convert to dtschema
      regulator: qcom,spmi-regulator: add PMP8074 PMIC

Stephan Gerhold (3):
      regulator: qcom_smd: Fix pm8916_pldo range
      regulator: dt-bindings: qcom,smd-rpm: Add PM8909
      regulator: qcom_smd: Add PM8909 RPM regulators

Stephen Kitt (1):
      regulator: rpi-panel-attiny: Use backlight helper

Zhang Jiaming (1):
      regulator: Fix parameter declaration and spelling mistake.

 .../devicetree/bindings/regulator/mps,mp5416.yaml  |   1 +
 .../bindings/regulator/pwm-regulator.txt           |  92 ----
 .../bindings/regulator/pwm-regulator.yaml          | 126 ++++++
 .../bindings/regulator/qcom,smd-rpm-regulator.yaml |   4 +
 .../bindings/regulator/qcom,spmi-regulator.txt     | 347 --------------
 .../bindings/regulator/qcom,spmi-regulator.yaml    | 323 +++++++++++++
 .../devicetree/bindings/regulator/regulator.yaml   |   1 +
 drivers/regulator/Kconfig                          |  28 ++
 drivers/regulator/Makefile                         |   3 +
 drivers/regulator/core.c                           |  25 +-
 drivers/regulator/devres.c                         |  28 ++
 drivers/regulator/max597x-regulator.c              | 502 +++++++++++++++++++++
 drivers/regulator/mp5416.c                         |  30 +-
 drivers/regulator/mt6370-regulator.c               | 390 ++++++++++++++++
 drivers/regulator/mt6380-regulator.c               |   2 +-
 drivers/regulator/of_regulator.c                   |   6 +-
 drivers/regulator/qcom_smd-regulator.c             |  29 +-
 drivers/regulator/qcom_spmi-regulator.c            |  37 ++
 drivers/regulator/rpi-panel-attiny-regulator.c     |   6 +-
 drivers/regulator/rt5120-regulator.c               | 420 +++++++++++++++++
 drivers/regulator/rt5190a-regulator.c              |   3 +
 drivers/regulator/scmi-regulator.c                 |   1 +
 drivers/regulator/ti-abb-regulator.c               |   4 +-
 include/linux/regulator/consumer.h                 |  16 +-
 include/linux/regulator/driver.h                   |   1 +
 25 files changed, 1955 insertions(+), 470 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/pwm-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/pwm-regulator.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
 create mode 100644 drivers/regulator/max597x-regulator.c
 create mode 100644 drivers/regulator/mt6370-regulator.c
 create mode 100644 drivers/regulator/rt5120-regulator.c
