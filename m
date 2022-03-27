Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA074E8984
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 21:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236429AbiC0TJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 15:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiC0TJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 15:09:23 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405E41275B
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 12:07:44 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id v12so3807812ljd.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 12:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=INTrBTrJY7RVmPLb8SbyXB8sqGb+uTMdgIk+2pXg01s=;
        b=gn35GwaLNeG5jMkGhmp8vlq8JyWjgJRPwiKs/ueFbDUXqk73yjS7lXrKvy2EEOsh7L
         SqFFGj5pZKW/z8AxSIH5MqgiMv28Fk8ePi/YKCnA0imgkx8gs322sZjNsM/2lQvhZ09H
         3KJUIPQ41vp7/hqeC49BBei3LxqhzDu/9jdPr8irQllLxPGSXRk9hL+SUXqtUFrD/omK
         mf61bW29GExKwOqAh1M+Whsj9MV5k69Rh2b5TloF5X/rx+8IcPk9F6hvLQ7E0jzb9CT4
         jY8y3OMF8Ux+W9+9NGIb3plkwCQdLnL6KbJPY0+fhLcPFe2nUfJ4H6hX8eGiKUKC5zEU
         /lww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=INTrBTrJY7RVmPLb8SbyXB8sqGb+uTMdgIk+2pXg01s=;
        b=Vmc8m4zTUbLsYiy6yApmukRsp1TwdaKNoq754blSEnugMswn5DE3NPWzXKbPQ3/r2A
         lS3yaCqNxwVeQEOW1X+Q9vEBA4pZYnoXfmoO7PlmDWiIIoHDki+Gq8e2WBxdOJJgA8OH
         RTlvYnCVGBokWu7HH+1WC80ZOi6qDzPPQYbCdrjVHlEZYGYYHDl/tUwfyNb7A9FQOdVw
         lWPhSPNFSlSpeNZY02ZsJKNuaGvv2o4uXthoD/UwmCq2I6V94MWysh6anh4LW/ZSV9Ru
         RM5wYic/EDKVQgfhQF4pUDJXDk3h5gvyd8rhiuQS04H6mH5PVOunHYEHSkjD+Ni4B2eJ
         ZWDQ==
X-Gm-Message-State: AOAM5304l1eXwPEpaZlwOXbR7Q5Qa6+kj1XjrVuosx2lXQ7JrEQK7PMK
        312kleBw+M5Prlz/ZvJx8w9wm9ktEI6Lcs/YnUVkK5CKaSA=
X-Google-Smtp-Source: ABdhPJzIfQho+S3dXGiXi5AT1WZXp+xqt2JJ/q0qZJ+JWEs4J85/KIkAATX5dU1NwNdgePifT/JcBWhRy17R7hkaRRI=
X-Received: by 2002:a2e:b6cf:0:b0:24a:c0e6:1aa1 with SMTP id
 m15-20020a2eb6cf000000b0024ac0e61aa1mr8853871ljo.422.1648408062512; Sun, 27
 Mar 2022 12:07:42 -0700 (PDT)
MIME-Version: 1.0
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Sun, 27 Mar 2022 14:07:31 -0500
Message-ID: <CABb+yY3JSArf0Tnp3RWN=D9J11KvBpkds6W4tWd8=zq3cj5+5w@mail.gmail.com>
Subject: [GIT PULL] Mailbox changes for v5.18
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
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
The following changes since commit ffb217a13a2eaf6d5bd974fc83036a53ca69f1e2:

  Linux 5.17-rc7 (2022-03-06 14:28:31 -0800)

are available in the Git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
tags/mailbox-v5.18

for you to fetch changes up to 1b0d0f7c12d57763fe27200d0569c863f11d2b8a:

  dt-bindings: mailbox: add definition for mt8186 (2022-03-12 19:33:39 -0600)

----------------------------------------------------------------
- qcom: add support for MSM8976
- mtk: enable mt8186
add ADSP controller driver
- ti: use poll mode during suspend
- tegra: fix tx channel flush
- imx: add i.MX8 SECO MU support
prepare for, and add iMX93 support

----------------------------------------------------------------
Adam Skladowski (2):
      dt-bindings: mailbox: Add compatible for the MSM8976
      mailbox: qcom-apcs-ipc: Add compatible for MSM8976 SoC

Allen-KH Cheng (2):
      dt-bindings: mailbox: mtk,adsp-mbox: add mtk adsp-mbox document
      mailbox: mediatek: add support for adsp mailbox controller

Dave Gerlach (2):
      mailbox: ti-msgmgr: Refactor message read during interrupt handler
      mailbox: ti-msgmgr: Operate mailbox in polled mode during system suspend

Franck LENORMAND (1):
      mailbox: imx: add i.MX8 SECO MU support

Pekka Pessi (1):
      mailbox: tegra-hsp: Flush whole channel

Peng Fan (7):
      dt-bindings: mailbox: imx-mu: add i.MX8 SECO MU support
      mailbox: imx: introduce rxdb callback
      dt-bindings: mailbox: imx-mu: add i.MX93 MU
      dt-bindings: mailbox: imx-mu: add i.MX93 S4 MU support
      mailbox: imx: extend irq to an array
      mailbox: imx: support dual interrupts
      mailbox: imx: support i.MX93 S401 MU

Ranjani Vaidyanathan (1):
      mailbox: imx: enlarge timeout while reading/writing messages to SCFW

Rex-BC Chen (1):
      dt-bindings: mailbox: add definition for mt8186

Robin Gong (2):
      mailbox: imx: fix wakeup failure from freeze mode
      mailbox: imx: fix crash in resume on i.mx8ulp

 .../devicetree/bindings/mailbox/fsl,mu.yaml        |  35 ++-
 .../devicetree/bindings/mailbox/mtk,adsp-mbox.yaml |  50 ++++
 .../devicetree/bindings/mailbox/mtk-gce.txt        |   8 +-
 .../bindings/mailbox/qcom,apcs-kpss-global.yaml    |   1 +
 drivers/mailbox/Kconfig                            |   9 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/imx-mailbox.c                      | 308 +++++++++++++++++++--
 drivers/mailbox/mtk-adsp-mailbox.c                 | 176 ++++++++++++
 drivers/mailbox/qcom-apcs-ipc-mailbox.c            |   1 +
 drivers/mailbox/tegra-hsp.c                        |   5 +
 drivers/mailbox/ti-msgmgr.c                        | 181 +++++++++---
 include/linux/soc/ti/ti-msgmgr.h                   |   8 +-
 12 files changed, 715 insertions(+), 69 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/mtk,adsp-mbox.yaml
 create mode 100644 drivers/mailbox/mtk-adsp-mailbox.c
