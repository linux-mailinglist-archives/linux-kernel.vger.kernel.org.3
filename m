Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF45462F8E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 10:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240169AbhK3Ja6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 04:30:58 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:35806 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234770AbhK3Ja5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 04:30:57 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 4J3H1k2KvCz9vC8H
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 09:27:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id F92lqGDwxyx4 for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 03:27:38 -0600 (CST)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 4J3H1k0Fjwz9vC7k
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 03:27:38 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 4J3H1k0Fjwz9vC7k
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 4J3H1k0Fjwz9vC7k
Received: by mail-pl1-f198.google.com with SMTP id l14-20020a170903120e00b00143cc292bc3so7969459plh.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 01:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UmVL6Owf91KrAVSVN4T/a2Zm/TSDiHMyV8vSNTqLEAI=;
        b=crRhkDRObsvIF6ohNtNmm/daP2G/5tvHmMBSCSNq8BRwTiWU3q1tVKg/SsO4nghCBM
         1MxPVU5HQOkhLvzYnDrF66p7fprRhHdJzXpIXcfNshGvUPaAHB92waRxBIrDtQLsFTFs
         O+UeUdEQ9puMjaR9V9o2O9h5dZX8/kxD+NlCib48py/kl5FUf8IS07jl/r1bByVipMog
         dsOT3gpJKjyaFrgkwuWYqosYPaOGApQCBKeWtSp4LfGTIuw8Hev67zxt5yLaR4ZaH2jY
         38nCHCyaJa4Q84HkjzPFwpSjpEwu3qhfn839JGSJgjBeeGBpQQA77mWECS5mbhMdUkj3
         wccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UmVL6Owf91KrAVSVN4T/a2Zm/TSDiHMyV8vSNTqLEAI=;
        b=vwf3d/cxwFcALisecrXTkeVdOAGsIHvl5PnKt6pOLMuxb8wV9Z4L6A3zr1GeFwbFDz
         +WPkkuzusYmcsC7Enwh/HRRV9tPXaC2htZg9unFjhVi9yJIuufnSyEN+EnT8+EOzZdNs
         RcMTA9uzufUtT8hoYJaavUBmIWZrmN946G5uBLewGO4zbXK6WMa5q2D5WEuBtqcZPKN9
         LrzU+Qb0Vt+59UlHDqLgTAOpyOQegfh7boNcT/ArLcugqnBHOn9rUSKTOzplaEUJv3bH
         Edz6Gg4Tx+8fke/pDyj+SUtwjvKhaxvLjqcr/PqVG+IAzOTO3+KqRUfvI8mBDBLXLFSd
         BO5A==
X-Gm-Message-State: AOAM533f6cRSL9QjJuhDgwRvkK5/PoLKm+eViD2aTOiTDasp1i9aNCZs
        Q5RMlV4bJFxz81eB8GcWvmXaBCmt19h9HLwqlxIhMJ9czd5n78QajTFYvUOV4qWv7lScnsml9VP
        pz6K77K3aSm1zJSA4zjmiyIVsVJBA
X-Received: by 2002:a63:7c03:: with SMTP id x3mr38833931pgc.394.1638264457383;
        Tue, 30 Nov 2021 01:27:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxcUS2Pm5qOUBh9nDN92KPHRcDmY3kWaqLBZdVVTaBBj/oCqWJ6lcYyk7AkcWuoMj+QeBfDtg==
X-Received: by 2002:a63:7c03:: with SMTP id x3mr38833914pgc.394.1638264457136;
        Tue, 30 Nov 2021 01:27:37 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id e6sm14397203pgr.24.2021.11.30.01.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 01:27:36 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kevin-CW Chen <kevin-cw.chen@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: mediatek: mt6797: Fix a NULL pointer dereference in mtk_infrasys_init_early()
Date:   Tue, 30 Nov 2021 17:27:30 +0800
Message-Id: <20211130092731.83763-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mtk_infrasys_init_early(), mtk_alloc_clk_data() is assigned to
clk_data, and there is a dereference of it in
mtk_infrasys_init_early(), which could lead to a NULL pointer
dereference on failure of mtk_alloc_clk_data().

Fix this bug by adding a check of infra_clk_data.

This bug was found by a static analyzer. The analysis employs
differential checking to identify inconsistent security operations
(e.g., checks or kfrees) between two code paths and confirms that the
inconsistent operations are not recovered in the current function or
the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

Builds with CONFIG_COMMON_CLK_MT6796=y show no new warnings, and our
static analyzer no longer warns about this code.

Fixes: 96596aa06628 ("clk: mediatek: add clk support for MT6797")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/clk/mediatek/clk-mt6797.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt6797.c b/drivers/clk/mediatek/clk-mt6797.c
index 428eb24ffec5..184b283b6926 100644
--- a/drivers/clk/mediatek/clk-mt6797.c
+++ b/drivers/clk/mediatek/clk-mt6797.c
@@ -563,6 +563,11 @@ static void mtk_infrasys_init_early(struct device_node *node)
 
 	if (!infra_clk_data) {
 		infra_clk_data = mtk_alloc_clk_data(CLK_INFRA_NR);
+		if (!infra_clk_data) {
+			pr_err("%s(): could not register clock provider: %d\n",
+				__func__, -ENOMEM);
+			return;
+		}
 
 		for (i = 0; i < CLK_INFRA_NR; i++)
 			infra_clk_data->clks[i] = ERR_PTR(-EPROBE_DEFER);
-- 
2.25.1

