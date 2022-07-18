Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0155788D3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 19:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbiGRRvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 13:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiGRRvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 13:51:53 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4AE2D1D0;
        Mon, 18 Jul 2022 10:51:52 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y8so16383630eda.3;
        Mon, 18 Jul 2022 10:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OzNDaj+DZhSHMIrNJY7lm71T3WkSPnzySsNM702N+zE=;
        b=IWbRPmZUG1AiFeiQO3HR1B31sET+hYeHvzIh0Q39+w7eyfEjso7f94PSh6QwpZNeM4
         coyKBTR+x5wfb0/iZ8dq92B/6W3rsZmYx5sa9ZDiCeZhxTaX2PoJXesmGAh2QNOJYQWE
         /leEZWfou6/hefbt+hWXFHU7Jg5nt7Wy3BcZH6/h2Mx0BSkneg61rhS8D10kFxyFepXu
         q81d/2HPF+N5GSRPD3tBgW7V3DorwUsD53ARgcy7FBdEc8yKxjeoBgCcd8Vb4OQhz9g0
         D32bz/CTnROYPh5WV4onoKGn4s/8DQZ/w3UfGKAh3mKuP+IbVYrbIXqws4VroFFVtkrm
         pZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OzNDaj+DZhSHMIrNJY7lm71T3WkSPnzySsNM702N+zE=;
        b=sFKHw/YSHfAt68k/lVDNcpEGbcPPaozAeQe5ypydWWo5I+G2Do3MnIUw6DVQsd1DHT
         fJ0kBXAVfqnW9NCAJo404gxHquxBTa1MjOgy/Hh0ZdM/bkveMNxMopTZqvCGnZ5cFHPa
         olfwK7R7cre1m0jXAO/AHTGpnVkO21oDOtjeLos1eTdOLG6n2QYiyORFAka8QgKw0dS/
         KhSyy5jT721jviRy2DjBdbyY9ga1TpUm7QB18JA8YHT81e75zfeu9YpBZ08EHF0GRLvr
         yX3v8xy033mufn+FfvxzEvkTE/NlnvcRsYXqTmCFWQv5gg3hQJ8TjYE24f+vNCx789pd
         SUuA==
X-Gm-Message-State: AJIora+Mtr+AQZVhCPlDstXwersjI/PL72bomFD2lu0BSkFSzG3sW3KI
        O89hOoZb7SYtvEcV5/oGHOo=
X-Google-Smtp-Source: AGRyM1t2SRY22FUnIBxr79BTWXtaLzb3OzYXyF2ywpYjSlpK3tyLidmTDuUPD/cRYOA9B9u9dzOEJA==
X-Received: by 2002:aa7:d60a:0:b0:43a:5795:b729 with SMTP id c10-20020aa7d60a000000b0043a5795b729mr38562794edr.230.1658166710821;
        Mon, 18 Jul 2022 10:51:50 -0700 (PDT)
Received: from localhost (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id t21-20020aa7d4d5000000b0043a5bcf80a2sm9013260edr.60.2022.07.18.10.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 10:51:49 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dipen Patel <dipenp@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] hte: Fixes for v5.19
Date:   Mon, 18 Jul 2022 19:51:45 +0200
Message-Id: <20220718175145.1945060-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 5dad4eccd2b4316a84209603a28d34c6346392bb:

  dt-bindings: timestamp: Correct id path (2022-06-02 15:56:59 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/hte/for-5.19

for you to fetch changes up to 85ff37e302efdf173cff6d1a310c2f7f38f1d069:

  gpiolib: cdev: Fix kernel doc for struct line (2022-06-17 12:58:57 +0200)

Thanks,
Thierry

----------------------------------------------------------------
hte: Fixes for v5.19

This contains a single fix for an out-of-sync kerneldoc comment.

----------------------------------------------------------------
Andy Shevchenko (1):
      gpiolib: cdev: Fix kernel doc for struct line

 drivers/gpio/gpiolib-cdev.c | 4 ++++
 1 file changed, 4 insertions(+)
