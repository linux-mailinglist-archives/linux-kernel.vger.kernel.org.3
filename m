Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCFE53487C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 03:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345843AbiEZB6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 21:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbiEZB56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 21:57:58 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A284BA997
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 18:57:57 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id rs12so328522ejb.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 18:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=mrTdgG+42EN8X3dWh4qUOgxusHGt7dRqQxIX8mfLL8s=;
        b=Xo34MICH/bcfvd+mHVNmnqv4v+nqJQL1FQEfUM1lVE+n2KGu0I2Rk7EQATD/D4faUt
         DDaj058Rf9FMbIy0swsYgCDLg0VzWenxBxXfhWX9oetuPtl/IYRsm4WFomaKiMMlpW6K
         2sm/uWrppJE7PwHwSDppX0uw6Ts0UihuiEyRa79nffKyrvEcGTBZ5i2o77VdctOLPy2b
         ZaEscPIk4FwZcMoBe71YdOhYOjoJ9gUjILbsMW2TYa8PV+CPvDBtwsSba6sjzCX08Vco
         XaXcqHNZYDydw8j8nGiWlvBb3nMfHadC4Pk54H0yiltAby6sRIDSPV2y4/4jWCiyQTYt
         xwuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=mrTdgG+42EN8X3dWh4qUOgxusHGt7dRqQxIX8mfLL8s=;
        b=wpXM5EM2kgu6MK2UQYruk4/iH21HZp6/irgNcK9weZgZ75IWYrjMmSTCwiI35Sdbg0
         lBk1RQjo+kGc2JNFJIl2YzsXZRPOpHfT12QDyufCtgqPcAxCR9IxqibW28p+MRA9BJPH
         zFlXaB18I0tEcDTtzLWL+7BnEoIN/EfxGwQo5ehBa3w+y9wTpEuKyZT+BVbrLghvZN6z
         JCrMHY4pdDbI3ohayYofzTz/4FUvyRdbADi0jfzgXmvcJW5/LMvY3M7RW8PItU4jcn5+
         9I0yBNivWQ35/OospzP+l0zrc9KLCUMCzTkmMRxfK4E+PhbHHznKsoO0/VOdgjEPxzO5
         M2yQ==
X-Gm-Message-State: AOAM532RtNxgqRUxn4RY1ppezZaGKMXBIgiv82EtsEe3bIOUdoadet+t
        bAnstMoJlEHXLmXXJFcJgenkYMJsktZvQjeZGzM=
X-Google-Smtp-Source: ABdhPJzS2x1ITuBaDNvuE8mv7nzZWD36y7Aku0I5R/v0ar8cJcE1wcX7K36sBMtxJRZS6LLFqdYd9/lUgFTwTtt1hjU=
X-Received: by 2002:a17:907:8a1c:b0:6fe:e53b:22ca with SMTP id
 sc28-20020a1709078a1c00b006fee53b22camr16431551ejc.407.1653530275971; Wed, 25
 May 2022 18:57:55 -0700 (PDT)
MIME-Version: 1.0
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 25 May 2022 20:57:44 -0500
Message-ID: <CABb+yY24U_2uwebN_a1M+ABVp0eqBai1c4H7oM7e0mDaGmFi0Q@mail.gmail.com>
Subject: [GIT PULL] Mailbox changes for v5.19
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

The following changes since commit 42226c989789d8da4af1de0c31070c96726d990c=
:

  Linux 5.18-rc7 (2022-05-15 18:08:58 -0700)

are available in the Git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
tags/mailbox-v5.19

for you to fetch changes up to 79f9fbe303520d2c32b70f04f2bb02cc2baaa4c3:

  mailbox: qcom-ipcc: Fix -Wunused-function with CONFIG_PM_SLEEP=3Dn
(2022-05-24 08:08:24 -0500)

----------------------------------------------------------------
- api: hrtimer fix
- qcom: log pending irq during resume
minor cosmetic changes
- omap: use pm_runtime_resume_and_get
- imx: use pm_runtime_resume_and_get
remove redundant initializer
- mtk: added GCE header for MT8186
enable support for MT8186
- tegra: remove redundant NULL check
added hsp_sm_ops for send/recv api
support shared mailboxes
- stm: remove unsupported "wakeup" irq
- pcc: sanitize mbox allocated memory before use
- misc: documentation fixes for arm_mhu and qcom-ipcc
----------------------------------------------------------------
Bj=C3=B6rn Ard=C3=B6 (1):
      mailbox: forward the hrtimer if not queued and under a lock

Fabien Dessenne (1):
      dt-bindings: mailbox: remove the IPCC "wakeup" IRQ

Kartik (3):
      mailbox: tegra-hsp: Add tegra_hsp_sm_ops
      dt-bindings: tegra186-hsp: add type for shared mailboxes
      mailbox: tegra-hsp: Add 128-bit shared mailbox support

Krzysztof Kozlowski (2):
      dt-bindings: mailbox: qcom-ipcc: simplify the example
      mailbox: correct kerneldoc

Mario Limonciello (1):
      mailbox: pcc: Fix an invalid-load caught by the address sanitizer

Nathan Chancellor (1):
      mailbox: qcom-ipcc: Fix -Wunused-function with CONFIG_PM_SLEEP=3Dn

Prasad Sodagudi (1):
      mailbox: qcom-ipcc: Log the pending interrupt during resume

Tinghan Shen (2):
      dt-bindings: mailbox: mtk,adsp-mbox: add mt8186 compatible name
      mailbox: mediatek: support mt8186 adsp mailbox

Tom Rix (1):
      mailbox: imx: remove redundant initializer

Xiaomeng Tong (1):
      mailbox: remove an unneeded NULL check on list iterator

Yongqiang Niu (1):
      dt-bindings: gce: add the GCE header file for MT8186

ran jianping (2):
      mailbox:imx: using pm_runtime_resume_and_get
      mailbox: omap: using pm_runtime_resume_and_get to simplify the code

 .../devicetree/bindings/mailbox/mtk,adsp-mbox.yaml |   7 +-
 .../bindings/mailbox/nvidia,tegra186-hsp.yaml      |   9 +
 .../devicetree/bindings/mailbox/qcom-ipcc.yaml     |  29 +-
 .../devicetree/bindings/mailbox/st,stm32-ipcc.yaml |  11 +-
 drivers/mailbox/arm_mhu_db.c                       |   2 +-
 drivers/mailbox/arm_mhuv2.c                        |   3 +-
 drivers/mailbox/imx-mailbox.c                      |   7 +-
 drivers/mailbox/mailbox.c                          |  19 +-
 drivers/mailbox/mtk-adsp-mailbox.c                 |   8 +
 drivers/mailbox/omap-mailbox.c                     |   6 +-
 drivers/mailbox/pcc.c                              |   2 +-
 drivers/mailbox/qcom-ipcc.c                        |  26 +-
 drivers/mailbox/tegra-hsp.c                        | 151 ++++++--
 include/dt-bindings/gce/mt8186-gce.h               | 421 +++++++++++++++++=
++++
 include/dt-bindings/mailbox/tegra186-hsp.h         |   5 +
 include/linux/mailbox_controller.h                 |   1 +
 16 files changed, 628 insertions(+), 79 deletions(-)
 create mode 100644 include/dt-bindings/gce/mt8186-gce.h
