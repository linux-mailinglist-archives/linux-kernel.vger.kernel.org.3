Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C399558C228
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 05:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236337AbiHHDnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 23:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236042AbiHHDnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 23:43:35 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E04A10FC0
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 20:43:34 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z2so9810917edc.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 20:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=GfscjxHAQtv8gD9StqSm6VdXQAQi0z2X3OY2YGX9LqI=;
        b=NCwLziFNfJADYG+vMw2UXzJTxBGQiJ/w7g6cbKXTY2LRYybSETspUDxNm0e+G3fsaH
         qe8d6P0dIjVqh4AnkBEw0m2bP0HE4LmNdhrpApJQzjGhgq3SKTtEgcg9FMIDMKifCsj9
         huK6VjzcULwypY0jpYEf2tqxR3MRnKXNnBDtD663Ly2lxqVaEOhESIRbu9KADkiuixde
         +8OQEi18WqUYug9cY6u3vYcCc0l4PHgyWMyIiV+ues2S5E8ujaTZ1WQNM6DLiS7p7d3a
         Ya/Ck5npkB8Ggwk2ycXwLP5XL19ZXUHjeA+3XRwkz8WHuW3CTJKw45BXk/ZekAiEVaBb
         NK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=GfscjxHAQtv8gD9StqSm6VdXQAQi0z2X3OY2YGX9LqI=;
        b=dputbD2nfYrUzLmHVZQT2CLGFjhPTTPR7l4T9FRX9/7D8oxorH3zvvip/QaIuZzTtQ
         yGN+DGXbMmVHnEsmCLiG8usprvz/zi8Db6cKxJkl2iJlrEEDQTpFHkGDHYeC722XPH0y
         //3qgHRbCOKdsHpUfO6oJm1qMWMv0OA79BaDokU9WjWECLIXPoG+tkwLBd2YAPdfAkLJ
         2dnKm1IFojIqjJ2HHvkMlVjXyakkC7jRDJDecxYMT3Cx4uPEhRACrLRRbctYGSrIpNNL
         5JvqU99bxMte6jtCzuL+r6iaLTXMtQ76YbdpWL29m9+s1JSgG5QsaVHh+QdvZ3xqg0yu
         d4Hw==
X-Gm-Message-State: ACgBeo2vnuIxWsriSIWIw5Rknw8ujHPRRo38q0jcqMRrWxfuzfRbrm3g
        NeTVTIkzo6AoH1mOLVFnq6EF1jeutmUW0EecREQ=
X-Google-Smtp-Source: AA6agR6omwbuI1b65St5mP13m6/9cVxc1uhU69I7Srhcp9lSFie2aQ0AWyayCuk01HlJEBaqQFJI9T4H/prZb01WjKs=
X-Received: by 2002:aa7:d795:0:b0:43c:eb00:fc77 with SMTP id
 s21-20020aa7d795000000b0043ceb00fc77mr15989416edq.284.1659930213126; Sun, 07
 Aug 2022 20:43:33 -0700 (PDT)
MIME-Version: 1.0
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Sun, 7 Aug 2022 22:43:21 -0500
Message-ID: <CABb+yY2gc3bDOu8v0vCizsdrSr2BQxGW1tuvpBzjCrRr64e7MA@mail.gmail.com>
Subject: [GIT PULL] Mailbox changes for v5.20
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

The following changes since commit e0dccc3b76fb35bb257b4118367a883073d7390e:

  Linux 5.19-rc8 (2022-07-24 13:26:27 -0700)

are available in the Git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
tags/mailbox-v5.20

for you to fetch changes up to 8a8dc2b9596e6088522d30bc79306b834c681943:

  mailbox: imx: clear pending interrupts (2022-08-03 09:48:13 -0500)

----------------------------------------------------------------
- mtk: use rx_callback instead of cmdq_task_cb.
- qcom: add syscon const.
add SM6375 compatible.
- imx: enable RST channel.
clear pending irqs

----------------------------------------------------------------
Bryan O'Donoghue (1):
      dt-bindings: mailbox: qcom,apcs-kpss-global: Add syscon const
for relevant entries

Chun-Kuang Hu (1):
      mailbox: mtk-cmdq: Remove proprietary cmdq_task_cb

Konrad Dybcio (1):
      dt-bindings: mailbox: qcom-ipcc: Add SM6375 compatible

Peng Fan (3):
      dt-bindings: mailbox: imx-mu: add RST channel
      mailbox: imx: support RST channel
      mailbox: imx: clear pending interrupts

 .../devicetree/bindings/mailbox/fsl,mu.yaml        |  6 ++-
 .../bindings/mailbox/qcom,apcs-kpss-global.yaml    | 46 ++++++++++++----------
 .../devicetree/bindings/mailbox/qcom-ipcc.yaml     |  1 +
 drivers/mailbox/imx-mailbox.c                      | 40 ++++++++++++++++---
 drivers/mailbox/mtk-cmdq-mailbox.c                 | 11 ------
 include/linux/mailbox/mtk-cmdq-mailbox.h           | 10 -----
 6 files changed, 64 insertions(+), 50 deletions(-)
