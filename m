Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880DE46305F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 10:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240419AbhK3KBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 05:01:18 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:59596 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235604AbhK3KBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 05:01:18 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 4J3Hhk6tMFz9vBtN
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 09:57:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id c2f2YpSEHHB5 for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 03:57:58 -0600 (CST)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 4J3Hhk4lxwz9vBt2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 03:57:58 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 4J3Hhk4lxwz9vBt2
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 4J3Hhk4lxwz9vBt2
Received: by mail-pf1-f200.google.com with SMTP id w2-20020a627b02000000b0049fa951281fso12562873pfc.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 01:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MrDmOmqy53ncuiVE/GEYR1H1+QCkQb8baxwPMZ1tiko=;
        b=bzUs68d9T5urMxTKmIOyZFIVWQNM0enC8qVpTkeU6GGTbxGaHO2Y1eA5KwwMlg1hIY
         ONUFYNTTmKTp9uHx5zb99/5WZ95Yzw5z7wu2l5XyLEN/VRZdqobUvl/dpns5/+6LQZZf
         M2xUwQqyQTo3lhQBYvnss4YCuOvNsXDCU+JQQOtATxaJFClmqt8/M+wSddCu8UwRTLln
         N2DtnIEEPPQXjU6lLHh4mFhZLs+oD4pgmwCrSpmkethS51Xatkm/lh8Y+wnZCamQ5TCz
         xGTEE01kGoxa4T0ArRKugyOAnek/W1htiYzUpSM4cum6LW1W3wyLFYHxtVuihnsBMmid
         0scA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MrDmOmqy53ncuiVE/GEYR1H1+QCkQb8baxwPMZ1tiko=;
        b=q6im+boqkVCxBtErXtHQhb8SD3q6jKDcKvU2A19/zkOZoHh84xFBPOHYjTrUU3yNro
         MukVM/u4Nz8SOQNLIHn15EsyEOqalvSe/f5lWvOXzps2GJKL5ZfGsfunUVAhLSO0ZLEe
         /9+WAvFYdJpoIjg4JdtDCVQ/YWi6NQojYEeNZSMT7nE5pRiyK4a1eG1wkkl75Bw8eDqy
         PVXyumz1RZtJpgNr/vfZs1mzo5D4FaZbJVTt3HoqEGt0CBTlaA0zObwcZp8xBi3M7xpG
         I7PXFFoxs37qh+vRdXErrMf3OvVoXIqv/Mslwj086zi0FGGh4NdqxfziXI6RaZ73ovlB
         IL0Q==
X-Gm-Message-State: AOAM533c8n/IH4pwPA0FrhsPB0S8jUTp6EZg0RpnjVZtY+gkXjXJnwUw
        ur2j17K5lwSGZcAwIdi+FY/DKO8U/fvro3DrOMh7CaR9fq+XIzXgSP5RHeVf9AjVCdj7q6S58Is
        vI+38E6xosSA+CmnrCUUClbHk5MvO
X-Received: by 2002:aa7:864f:0:b0:4a2:ea0a:a16d with SMTP id a15-20020aa7864f000000b004a2ea0aa16dmr45599380pfo.11.1638266277959;
        Tue, 30 Nov 2021 01:57:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyz0S5KZw1PVwUuiwDkP9/RaONTERv32EcCQUY7AvGGsmbqzODVGFX2Awn3Qo0pkVauxwXzKQ==
X-Received: by 2002:aa7:864f:0:b0:4a2:ea0a:a16d with SMTP id a15-20020aa7864f000000b004a2ea0aa16dmr45599362pfo.11.1638266277757;
        Tue, 30 Nov 2021 01:57:57 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id v3sm7229121pga.78.2021.11.30.01.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 01:57:57 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: mediatek: mt8167: Fix a NULL pointer dereference in mtk_apmixedsys_init()
Date:   Tue, 30 Nov 2021 17:57:50 +0800
Message-Id: <20211130095752.98821-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mtk_apmixedsys_init(), the return value of mtk_alloc_clk_data() is
assigned to clk_data and used in mtk_clk_register_plls(). There is a
dereference of clk_data in mtk_clk_register_plls(), which could lead
to a NULL pointer dereference on failure of mtk_alloc_clk_data().

Fix this bug by adding a check of clk_data.

Another way to fix this bug is to add a check of clk_data in
mtk_clk_register_plls(), which may solve many similar bugs but could
cause potential problems to previously correct cases as the API is changed.

This bug was found by a static analyzer. The analysis employs
differential checking to identify inconsistent security operations
(e.g., checks or kfrees) between two code paths and confirms that the
inconsistent operations are not recovered in the current function or
the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

Builds with CONFIG_COMMON_CLK_MT8167=y show no new warnings, and our
static analyzer no longer warns about this code.

Fixes: a68224832118 ("clk: mediatek: Add MT8167 clock support")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/clk/mediatek/clk-mt8167.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt8167.c b/drivers/clk/mediatek/clk-mt8167.c
index e5ea10e31799..7b18b751487f 100644
--- a/drivers/clk/mediatek/clk-mt8167.c
+++ b/drivers/clk/mediatek/clk-mt8167.c
@@ -1047,6 +1047,11 @@ static void __init mtk_apmixedsys_init(struct device_node *node)
 	}
 
 	clk_data = mtk_alloc_clk_data(MT8167_CLK_APMIXED_NR_CLK);
+	if (!clk_data) {
+		pr_err("%s(): could not register clock provider: %d\n",
+			__func__, -ENOMEM);
+		return;
+	}
 
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
 	mtk_clk_register_dividers(apmixed_adj_divs, ARRAY_SIZE(apmixed_adj_divs),
-- 
2.25.1

