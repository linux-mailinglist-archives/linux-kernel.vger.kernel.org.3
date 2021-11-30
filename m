Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3712463CED
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 18:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244880AbhK3RkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 12:40:00 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:49432 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244873AbhK3Rj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 12:39:59 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 4J3Tt013DHz9vf8Y
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 17:36:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Vva9f5JB9unI for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 11:36:40 -0600 (CST)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 4J3Tsz60dvz9vf8R
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 11:36:39 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 4J3Tsz60dvz9vf8R
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 4J3Tsz60dvz9vf8R
Received: by mail-pf1-f200.google.com with SMTP id m16-20020a628c10000000b004a282d715b2so13245573pfd.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 09:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P5cblcIjdeCMfmyjDsX3UotdjIWrFfTaBh8mADY3+xM=;
        b=FUENcG5Qe/ALF7PQ2LjG97LD8lSia2k26JzFlv+uX/u62oSjm42FHUVXgzDNpMkPff
         b+1cGw+QgNft8C+iUuJ52UTC32B4yNn36j7BggIjztyZ81A+fUghF53m7zlmyEg1x88u
         HUQyh3qvPmWS0N+6rlDm3OnFmuhZ9eEmu4OTK7LS93TlNVBFWCnLMVIG4m4g4YxlPf4H
         OidgSdguEzAr2iu/h2ob1vYA0T9ZRt2KnaoG51I6SOvA9ykg/5wJe3JSmW612o7xmLGF
         vrAmyJFq8ixnbHaHeUkB65gfeOwjDIgmTc25Hjt+SBV38hwrDcYzL6jSkiXJam/A1AkF
         7BLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P5cblcIjdeCMfmyjDsX3UotdjIWrFfTaBh8mADY3+xM=;
        b=EvGd5X2D5LvNS3C3TrAMa1IMU/ggk//Sf8s5ISxEIEWnMncYgNjRdR0QZ8CAdelmje
         45gsRtadldRiWb61M+DUzjBs2Zri/iyDiB66lKejvOlpEoKIE3dh6hEeybFtY8wdccxc
         8GKQhGRuNFrWplWhjr7T7xKIXfM0I+B6SqiYB8LWMcTC0WXJyfZyNbs2zHaCwV7rYlrG
         cijsF5YBmJMoNKsIlZ7S9Ope2YZYxJPgOEcsLHfWVz+cJPqqsCEDUyO8ztR0ky3ZaRcl
         RqouSaG2laXJOwxjQoRo3MBO6trgluysTN0+wYw3U988S7Wab8nRRIL72ELdFY48XizP
         ie0w==
X-Gm-Message-State: AOAM532RNRzBsrKfrgqIoSYSuJXXIWSlNRZ4LoWY4/QuGgq+xwtIAdYw
        UwTXMn7btsgEBK+305fmaCRdAB8M7fu2Cxw2Evm2Td5qLQ/XvJJxmYWD+BAuEo/bLy7cZHBOVqx
        +9MB+ODSlz8pcXecn32xMi6cRcGHn
X-Received: by 2002:a17:90a:e7c2:: with SMTP id kb2mr434908pjb.200.1638293799037;
        Tue, 30 Nov 2021 09:36:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw187bYFOnFYXpjl7iwYSNqNVZ0EgJuuUWNuhT3gfgeEjsME32I8/ofS4pvOfIww2f6a5taZQ==
X-Received: by 2002:a17:90a:e7c2:: with SMTP id kb2mr434878pjb.200.1638293798822;
        Tue, 30 Nov 2021 09:36:38 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id y8sm22470105pfi.56.2021.11.30.09.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 09:36:38 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miles Chen <miles.chen@mediatek.com>,
        mtk01761 <wendell.lin@mediatek.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: mediatek: mt6779: Fix a NULL pointer dereference in clk_mt6779_top_probe()
Date:   Wed,  1 Dec 2021 01:36:32 +0800
Message-Id: <20211130173634.212143-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In clk_mt6779_top_probe(), mtk_alloc_clk_data() is assigned to clk_data
and used in mtk_clk_register_muxes(). There is dereference of clk_data
in mtk_clk_register_muxes(), which could lead to a NULL pointer
dereference on failure of mtk_alloc_clk_data().

Fix this bug by adding a check of clk_data.

Another way to fix this bug is to add a check of clk_data in
mtk_clk_register_muxes(), which may solve many similar bugs but could
cause potential problems to previously correct cases as the API is changed.

This bug was found by a static analyzer. The analysis employs
differential checking to identify inconsistent security operations
(e.g., checks or kfrees) between two code paths and confirms that the
inconsistent operations are not recovered in the current function or
the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

Builds with CONFIG_COMMON_CLK_MT6779=y show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: 710774e04861 ("clk: mediatek: Add MT6779 clock support")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/clk/mediatek/clk-mt6779.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt6779.c b/drivers/clk/mediatek/clk-mt6779.c
index f22bf4025f55..fb43d23b715b 100644
--- a/drivers/clk/mediatek/clk-mt6779.c
+++ b/drivers/clk/mediatek/clk-mt6779.c
@@ -1239,6 +1239,8 @@ static int clk_mt6779_top_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
 
 	mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks),
 				    clk_data);
-- 
2.25.1

