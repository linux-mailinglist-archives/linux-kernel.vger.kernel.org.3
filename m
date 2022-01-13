Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F6B48D06E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 03:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbiAMC3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 21:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbiAMC3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 21:29:07 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40788C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 18:29:06 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id n137so457383iod.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 18:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=VuJFJ1rkgmwkLED1mbUou+DAwQnhI8SNKN9Yz8Tg4dI=;
        b=SgdhpWV5CsUbR+KONcpbCpxM/ACm3aMPVCcPz7KY4z4bmWVeybkjsa3QtUiXsVwCwh
         frwyFaaiRmVlUR2kOUQ6s6cSx74q7L6LPX9YuyXKp3CvMYP2OkTrXfr5oKEYcFNORZTN
         wPrM4jsLom2RJjWBUYyl81wlzWW/ziMgvWBfE1n3FATGp/FCJNUNGJGUti2hTtCnT3w/
         hOejj2rpSkFn+oMUsldvA+ebEOUFKH9UX0sxMOjPnccuNiX7e4lkB8KUFqrmyEsD6gpW
         KnOE6nbBZAsbuMeH4eJuLP2l0F4k+hOMZneh6OcicLg4S2aBU2xEww75O3Mk9Ibg68DR
         ngVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=VuJFJ1rkgmwkLED1mbUou+DAwQnhI8SNKN9Yz8Tg4dI=;
        b=KofUjogypd+rS7QvxmUNZcMBzmu/mRvxeUErKhdB+8t9q9HpmXGw3VuEwSQRAyNsf0
         iifDZZhG216i1LY8Z7XuzO0gmTxmRuJzmHnVJI9uVhsQ4LktXjS8Fv9HciV+DAPDmIEC
         PIbt9o0mWFl+XiSaWy9/gNGpJfznYQ6mYSAFyis6ndywdcSoH9kNRV4e/IEOCCdvKppE
         00JgFS9Su6Wwrp4b+DNSnvUYPUqgtLQzG1Fcx8oTTkkGGI4qndASl11qimI6K8wbGDo0
         Gx03okpIGRLDaB5CJ/gQv4TqOrrvXBZBNR/GWHiAvWQd8gYOOwq338Eapde2rLpDZTTG
         pHTQ==
X-Gm-Message-State: AOAM531Tr32nBy7AQ2lxQ/w1GxIvua5CDz8p81XOaiUsFNsascukDgvv
        JmhFeYAMr3z/IfOHBgySn7ZxuM/41OmZqZmpnmgjyXvjzpg=
X-Google-Smtp-Source: ABdhPJyGNmxTUZfoWJg3j2dI63SoLOzF5fQiJEewJSouusSuRnwFlO78uCkLUVvfr+9tgrm4lg7upWDd+O+ewmUPpn8=
X-Received: by 2002:a02:9992:: with SMTP id a18mr1047560jal.189.1642040945674;
 Wed, 12 Jan 2022 18:29:05 -0800 (PST)
MIME-Version: 1.0
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 12 Jan 2022 20:28:54 -0600
Message-ID: <CABb+yY3o9pOY1EbedNRM_++MxM8TNFrB3EbrZ+07h_p3O4i1LA@mail.gmail.com>
Subject: [GIT PULL] Mailbox changes for v5.17
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit c9e6606c7fe92b50a02ce51dda82586ebdf99b48:

  Linux 5.16-rc8 (2022-01-02 14:23:25 -0800)

are available in the Git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
tags/mailbox-v5.17

for you to fetch changes up to 869b6ca39c08c5b10eeb29d4b3c4bc433bf8ba5e:

  dt-bindings: mailbox: Add more protocol and client ID (2022-01-11
23:47:33 -0600)

----------------------------------------------------------------
- qcom: misc updates to qcom-ipcc driver
- mpfs: change compatible string
- pcc: fix handling of subtypes
avoid uninit variable
- mtk: add missing of_node_put
enable control_by_sw
silent probe-defer prints
fix gce_num for mt8192
- zynq: add missing of_node_put
- imx: check for NULL instead of IS_ERR
- appple: switch to generic compatibles
- hi3660: convert comments to kernel-doc notation

----------------------------------------------------------------
Conor Dooley (1):
      mailbox: change mailbox-mpfs compatible string

Dan Carpenter (1):
      mailbox: imx: Fix an IS_ERR() vs NULL bug

Hector Martin (2):
      dt-bindings: mailbox: apple,mailbox: Add generic and t6000 compatibles
      mailbox: apple: Bind to generic compatibles

Hsin-Yi Wang (1):
      mailbox: mtk-cmdq: Silent EPROBE_DEFER errors for clks

Huang Yiwei (4):
      mailbox: qcom-ipcc: Dynamic alloc for channel arrangement
      mailbox: qcom-ipcc: Support more IPCC instance
      mailbox: qcom-ipcc: Support interrupt wake up from suspend
      dt-bindings: mailbox: Add more protocol and client ID

Randy Dunlap (1):
      mailbox: hi3660: convert struct comments to kernel-doc notation

Sudeep Holla (2):
      mailbox: pcc: Avoid using the uninitialized variable 'dev'
      mailbox: pcc: Handle all PCC subtypes correctly in pcc_mbox_irq

Wang Qing (2):
      mailbox: zynq: add missing of_node_put before return
      mailbox: mtk: add missing of_node_put before return

jason-jh.lin (2):
      mailbox: fix gce_num of mt8192 driver data
      mailbox: add control_by_sw for mt8195

 .../devicetree/bindings/mailbox/apple,mailbox.yaml | 12 ++-
 drivers/mailbox/apple-mailbox.c                    |  4 +-
 drivers/mailbox/hi3660-mailbox.c                   | 18 ++--
 drivers/mailbox/imx-mailbox.c                      |  4 +-
 drivers/mailbox/mailbox-mpfs.c                     |  2 +-
 drivers/mailbox/mtk-cmdq-mailbox.c                 | 15 ++--
 drivers/mailbox/pcc.c                              | 10 ++-
 drivers/mailbox/qcom-ipcc.c                        | 99 +++++++++++++++++-----
 drivers/mailbox/zynqmp-ipi-mailbox.c               |  1 +
 include/dt-bindings/mailbox/qcom-ipcc.h            |  2 +
 10 files changed, 116 insertions(+), 51 deletions(-)
