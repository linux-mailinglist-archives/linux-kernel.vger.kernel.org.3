Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422B24630A8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 11:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240706AbhK3KKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 05:10:06 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:34964 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240700AbhK3KKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 05:10:05 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 4J3Htt2Xw9z9vBrl
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:06:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sC0m5tfGGpFD for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 04:06:46 -0600 (CST)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 4J3Htt0SkZz9vBsG
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 04:06:46 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 4J3Htt0SkZz9vBsG
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 4J3Htt0SkZz9vBsG
Received: by mail-pl1-f197.google.com with SMTP id h8-20020a170902f54800b001454402c33dso6709842plf.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 02:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r7G1TmK41rnyV4TkIbbUQW1TkiKZi87yD3Zt7PBsc3c=;
        b=YCnUhEKkb/jOCfjUjRF0e27/qXa3DYamYPdLTGBf2SvomkMp/VQ0e4cwEBzp/oqLjR
         kx/zhyOcbMXkNiiHOQgaIWpELLwu6gX3QESWnU6z7qrhyNOlWPbm+MtiebPXxJo8eaXg
         zlgTm/4weBP3ORs721TMP06TyZRvhHVgXV3uGggl+4AInBwMfNtq2InBWs+EqEaijWEo
         ZqECz/st6OzilUmwocSLZFrNxBJw9G3Uih0nqqUXMPDisYneHJ9gWrrSGBWYrNY8j8UB
         pwmPNJRgxyKDGgrx3oHVhLKTxPUj74YQEGXS1n/i3ZKML89CpVhH+gIWo4w797PNjkDY
         ETAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r7G1TmK41rnyV4TkIbbUQW1TkiKZi87yD3Zt7PBsc3c=;
        b=3V33ECRXZlV5Ubt3BwjFbOtJV9tb1mxqZFpAqo188mmzNqF5T/aWWAynP6+scbUPFA
         NNvKJg7DqGeKuh4Vs7/v1QpfhYhPVn/hpxxdr4Kkp/9r0Hj2ReqdsJMjffYiOyQDrJpA
         LwrZBrRwVrRORxKonpk4SZXDB+T/dOD66U/6TAnTviY1KqLjSJT4APFkEgfaH+Dsz3qn
         Wdg8mDASfSlstloBAOx2aZT2BIAdMLook/2JdsBKaixFPKkMGqtHjxuiDtz5mVPdE3B7
         vFGOSQfB8ZucJRIkEhvagSeXnj9AbGIj5m83sCsAuaRlk0TBlt1zzGLUK4CAMqR0EbAr
         Wd3Q==
X-Gm-Message-State: AOAM532z2/tBB+BipBtS9cJZR5qrX9798dHMT3+4w//s9uPcTgXFZl8w
        LMF5rBrKoS4ce0GRNBU16MFBweE4WXvRrnYYqpBMTi6nCnxQqDm0oYJM965YcUxSs3+Kg0nZWVA
        WlY1kYleEiw7PTZ1guFgYSOhpyyEY
X-Received: by 2002:a17:90b:3849:: with SMTP id nl9mr4853380pjb.145.1638266805312;
        Tue, 30 Nov 2021 02:06:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzqlVi4gUEZnqMEVQTnjH2GvhflnCPZQmVNPYts+3MdwetGMoE49AEmyYr8Z+B8s90BXPoQRA==
X-Received: by 2002:a17:90b:3849:: with SMTP id nl9mr4853350pjb.145.1638266805060;
        Tue, 30 Nov 2021 02:06:45 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id j22sm21003399pfj.130.2021.11.30.02.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 02:06:44 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Pi-Cheng Chen <pi-cheng.chen@linaro.org>,
        Sean Wang <sean.wang@mediatek.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: mediatek: mt8173: Fix a NULL pointer dereference in mtk_infrasys_init()
Date:   Tue, 30 Nov 2021 18:06:37 +0800
Message-Id: <20211130100639.100722-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mtk_infrasys_init(),the return value of mtk_alloc_clk_data() is
assigned to clk_data and used in mtk_clk_register_cpumuxes(). There is a
dereference of clk_data in mtk_clk_register_cpumuxes(), which could lead
to a NULL pointer dereference on failure of mtk_alloc_clk_data().

Fix this bug by adding a check of clk_data.

Another way to fix this bug is to add a check of clk_data in
mtk_clk_register_cpumuxes(), which may solve many similar bugs but could
cause potential problems to previously correct cases as the API is changed.

This bug was found by a static analyzer. The analysis employs
differential checking to identify inconsistent security operations
(e.g., checks or kfrees) between two code paths and confirms that the
inconsistent operations are not recovered in the current function or
the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

Builds with CONFIG_COMMON_CLK_MT8173=y show no new warnings, and our
static analyzer no longer warns about this code.

Fixes: 567bf2ed86d1 ("clk: mediatek: export cpu multiplexer clock for MT8173 SoCs")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/clk/mediatek/clk-mt8173.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index 8f898ac476c0..a350e5c637af 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -868,6 +868,11 @@ static void __init mtk_infrasys_init(struct device_node *node)
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
+	if (!clk_data) {
+		pr_err("%s(): could not register clock provider: %d\n",
+			__func__, -ENOMEM);
+		return;
+	}
 
 	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
 						clk_data);
-- 
2.25.1

