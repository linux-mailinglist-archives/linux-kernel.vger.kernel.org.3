Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06F8463CE3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 18:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244840AbhK3RiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 12:38:22 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:39956 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244138AbhK3RiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 12:38:15 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 4J3Tqz0lymz9vjCf
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 17:34:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Zp0X_8R03dJ1 for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 11:34:55 -0600 (CST)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 4J3Tqy5dlFz9vjCc
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 11:34:54 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 4J3Tqy5dlFz9vjCc
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 4J3Tqy5dlFz9vjCc
Received: by mail-pj1-f71.google.com with SMTP id u11-20020a17090a4bcb00b001a6e77f7312so10208914pjl.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 09:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dOBvN2QUGpMPNx3hDsPrLwgawMqc9DMK+yT23YcRQV0=;
        b=Piw3E/h4nz3Hmm6jMuTe6NyYfw93oH7f6Bk37gJ2JH7leQVc5fgyno5NZs3EnuPxRq
         RDKgy+pCb3cU3+ulIwiCiks/Jcdq9QXy/aCMyIoLC0MZSt0zjFugBSkHToRaiBaR8/XN
         1eEnGjTpU2etzHjW8g/iewBjqLAbvdYNxNFhh8tgeEPF0G3HU/WpE7oDHVmgU7/nFHv/
         CBuq706vQ9bPKZWNvoFL+oCmPOR4NaAfs+6sqoFwHinxNV96b7QSINNm9nQDDn6msrcO
         ANLaVGCld7BFsKvY5MEZh8CESsvwIgu4hMRkX0F/bnd+N2jYA2wko896EIEyd+H2L786
         xuwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dOBvN2QUGpMPNx3hDsPrLwgawMqc9DMK+yT23YcRQV0=;
        b=Bt1IewdFL6V6TQjgwNxQwft4/MOuq2bTfe/wTiabkWLAFjmFjUwIE3vwt64v/A6ett
         TXJok6qYCqvmamU2axutbGr6nbmzrxf4HbjwDmNmzQJpFhj3Iycrbo/cT6EAt0hOUHLp
         cg3HCdQh3cS1z4lczTDKU+O2R9FrcPcY+YjIvMbugNlgPwck36rc/Fdxt/uBcXEG25TH
         Sf3/mPQc6KjEFiGjQA1kisHpwJbTkajoivToSlLZGl+2aOjlWtXb2TJnRpcV9gVrJnFJ
         enntVoVvK7W9+jNSvQhcyFjn7Jroz3AS/Et96giR9L4C4FweLDq+Rn0ZQttXX+nPZAcQ
         1eMA==
X-Gm-Message-State: AOAM530Httt8t2nQonaoW0VKz/CU9t4+3eH0WQsz6cnz816RUC9AS/EQ
        P+4m7Ie3h/YjhUkt4MtyXC8QC6fY5jXxRaT24rzC8YRUhMXgBOztNUyWJ5KG7zUcqOh7qFJgxgs
        3T3jfeNVEE1lrXb6XcH14oIA0I13F
X-Received: by 2002:a17:903:285:b0:142:7a83:6dd2 with SMTP id j5-20020a170903028500b001427a836dd2mr601088plr.59.1638293693977;
        Tue, 30 Nov 2021 09:34:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyNU8qSzls16yiH++Ty7UQju3BhW5xo3F9PUbFfgFnOlvAGIsDEDMQXBQuWW3dTCI9wWnfuSQ==
X-Received: by 2002:a17:903:285:b0:142:7a83:6dd2 with SMTP id j5-20020a170903028500b001427a836dd2mr601056plr.59.1638293693712;
        Tue, 30 Nov 2021 09:34:53 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id p16sm22928114pfh.97.2021.11.30.09.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 09:34:53 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Owen Chen <owen.chen@mediatek.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: mediatek: mt6765: Fix a NULL pointer dereference in clk_mt6765_top_probe()
Date:   Wed,  1 Dec 2021 01:34:46 +0800
Message-Id: <20211130173448.210986-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In clk_mt6765_top_probe(), mtk_alloc_clk_data() is assigned to clk_data
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

Builds with CONFIG_COMMON_CLK_MT6765=y show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: 1aca9939bf72 ("clk: mediatek: Add MT6765 clock support")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/clk/mediatek/clk-mt6765.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt6765.c b/drivers/clk/mediatek/clk-mt6765.c
index 5f723906675b..26d367d0e189 100644
--- a/drivers/clk/mediatek/clk-mt6765.c
+++ b/drivers/clk/mediatek/clk-mt6765.c
@@ -822,6 +822,10 @@ static int clk_mt6765_top_probe(struct platform_device *pdev)
 	}
 
 	clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
+	if (!clk_data) {
+		pr_err("%s(): mtk_alloc_clk_data failed\n", __func__);
+		return -ENOMEM;
+	}
 
 	mtk_clk_register_fixed_clks(fixed_clks, ARRAY_SIZE(fixed_clks),
 				    clk_data);
-- 
2.25.1

