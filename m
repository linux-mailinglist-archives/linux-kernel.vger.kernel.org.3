Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459AC57015D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiGKL4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiGKL43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:56:29 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0328932B8E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 04:56:26 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id y4so5917249edc.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 04:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7PtfrXO1muPciH2j8bRjfuNDfP1Fsd4zwF2waXvYN50=;
        b=onJg3HN0oCrv0W9dCJRxiNKQyqV0TFr8Dfwdc6eY989ZSl6ci0/0AY2iXw2m4ibjeH
         0OjAJXtJYm1FPVegXDX5Gvdh4tEDG9PMMK1MDRnVw65gG+UOrFGa3r1PCKFWXz8IbDYe
         Xku+4mbYsI6U+HV+o47l+gFl9fNlAO6fHYzIDhVkLTrUDpTKWGOD2F39yTxbpEPZt1cX
         tdb791uUZvPSSo2YwpY0j6fB5gOzUhdEKV6AN0W/hgPp3G4883XWlecmnuyaatZdpHtm
         wQasHxidD1d0T9fW9LYURrF4UtYTzcXoBU0MbwlIJxf5D+0e8v9Qb1ZMzBG/rU74QlxC
         VFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7PtfrXO1muPciH2j8bRjfuNDfP1Fsd4zwF2waXvYN50=;
        b=4Vln3uqRaa7BbPro+sCRIi/MEqXPFJ2xMPV+roeHcjs+muRkYNckiO+mJW8Et45eQL
         UeSA8sKNzn3R4Vt3xw3xb/vjKpx5eUnJy1aOU70tXvLNvkW+Ustl7a08P7TKZ+jJedbL
         ZeV9WbEVbR81jbzFKQID+7uDIfJ+kGNv8oPCqLrRCmKMqRfNAd5tcPGIZSuPhZ9hNzCR
         M9iVCdDXeN7zYzmb4+ud87iHUjMZ1b3Qyj8LjqWiWb0fvZqNJC4CtxRUO2HAyid3VO//
         BRMDJITm2ySIRUAdHcMSvNNFdmJ3O1MgxkrBtKJ8Ai8FNYwovHZcE98+yXiKjE+BUAec
         v+8A==
X-Gm-Message-State: AJIora/nmXKbuKwFLgGJf907n+d6w4wBaTIcy36SiU/mSej9Yldo1kwY
        fbTP8QYNni3QQX2XDgqtKk4BpIxUgYwE6Q==
X-Google-Smtp-Source: AGRyM1vMfIA4XQ6ZtFet6Vbj8aoaBP0vzK/gnYP4nB46mV88UIvfjrpml3nHPraiPFFSJbxez3fkQw==
X-Received: by 2002:aa7:d389:0:b0:43a:56c0:c863 with SMTP id x9-20020aa7d389000000b0043a56c0c863mr24055139edq.373.1657540585360;
        Mon, 11 Jul 2022 04:56:25 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id z9-20020a170906270900b00722e50dab2csm2594932ejc.109.2022.07.11.04.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 04:56:24 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] clk: imx: Updates for v5.20
Date:   Mon, 11 Jul 2022 14:55:42 +0300
Message-Id: <20220711115542.1015136-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/ tags/clk-imx-5.20

for you to fetch changes up to c196175acdd3ab06114bde2955971bc7282f2b85:

  clk: imx: clk-fracn-gppll: Add more freq config for video pll (2022-06-16 17:28:59 +0300)

----------------------------------------------------------------
i.MX clock changes for 5.20

- Correct adc1, nic_media and edma1's parents for i.MX93
- Fix rdiv, mfd values, the return rate in recalc_rate and add more
  frequencies in the table for fracn-gppll

----------------------------------------------------------------
Haibo Chen (1):
      clk: imx93: use adc_root as the parent clock of adc1

Jacky Bai (1):
      clk: imx93: Correct the edma1's parent clock

Liu Ying (1):
      clk: imx: clk-fracn-gppll: Return rate in rate table properly in ->recalc_rate()

Peng Fan (4):
      clk: imx93: correct nic_media parent
      clk: imx: clk-fracn-gppll: fix mfd value
      clk: imx: clk-fracn-gppll: correct rdiv
      clk: imx: clk-fracn-gppll: Add more freq config for video pll

 drivers/clk/imx/clk-fracn-gppll.c | 36 +++++++++++++++++++++---------------
 drivers/clk/imx/clk-imx93.c       |  6 +++---
 2 files changed, 24 insertions(+), 18 deletions(-)
