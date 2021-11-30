Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B930462F0E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 09:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbhK3I6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 03:58:36 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:46060 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239962AbhK3I60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 03:58:26 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 4J3GJ733mPz9vBtK
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:55:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2-kfnICuxTEn for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 02:55:03 -0600 (CST)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 4J3GJ70zKZz9vBtN
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 02:55:03 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 4J3GJ70zKZz9vBtN
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 4J3GJ70zKZz9vBtN
Received: by mail-pj1-f71.google.com with SMTP id h15-20020a17090a648f00b001a96c2c97abso6586353pjj.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 00:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JwkYqyhX5smeL+L/r125AuKqmjcCfxTAw1WF1G/WgUo=;
        b=qStNVhS9s5xxEQjiT7/N1C0yco9IimARTtUel0RW79VmbmaqIDeUZxIOZ4qRbiCLzp
         JTjLuzCVsb9gCo20eVWkSin+Hykeec6Wl/yzLiv251iBuMwsOZdw3dcCSVKVtPdQzdRN
         a7z1Akh3RsfthmSHhC6WelA+HwY5p28vGLrzIw98rvHrQbAPQj24oEy5EZWcHOo21dOz
         hRTAm8nc/oUI7BTQ5QQMuLokd8GpE+c2xvjrRtmXLDB6CxpsYA3BA4AMj9kn4Lq8hXr7
         HYzPPuKArjH809WyANHlez0j0WfpAYI/8zJwNrTXIhvwS1Xdug8TXkmvVyLD2kiFcFzY
         z0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JwkYqyhX5smeL+L/r125AuKqmjcCfxTAw1WF1G/WgUo=;
        b=YkjIUol6FODCrNkA1sdlsnqfN976mz11I7V7a4cvEqCNWih5QMGF4NoeSZ6Bk4BLsx
         ohm8IVtROcBQ3qICb+LwUyhk0r9B8p9KWSTddtTlaTBjO7Vx6bE5fitEOnnHcBlovmcf
         uYyfwqwmOniOCSvPjVZ8Hso2R5JdOZbmQzD/T6UlnXWKKEhTZ20F2inNWMWrFFZHs4Qb
         UE3NnGCGywLdfqWH1+EcIQcHxcyStyv24eZwldQtSq9GdK2ZZla/9cde+3NqZOetEmls
         RThiUEIlDviS1a1a7TtEU5jvfIThsEosSSjIj2oC1REKAg2VYTJbJB5Ci4LGPhAwQU5d
         i09g==
X-Gm-Message-State: AOAM531vASa6aM/ejanmx4hVj+rzKV2eMxXth5yaipdTecO3906jaToq
        oadQj2p+Xj6BXbMIe7a52kyE2SVrYExSx7QHa6QCADRvpM5O7m+YMepX+NyHJ5GBwZoMyl7qGQ7
        wHRdOp3/Fx1Njp9J9BhXDSJTWDOvo
X-Received: by 2002:a17:902:aa43:b0:142:6919:73da with SMTP id c3-20020a170902aa4300b00142691973damr65882694plr.39.1638262501524;
        Tue, 30 Nov 2021 00:55:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxt84MXmo7Ca8vyZxDhDjFTkMtVX+MNijU4eYMPkHKjS5V/seglj6amrRunpcPVSJcRS2e72A==
X-Received: by 2002:a17:902:aa43:b0:142:6919:73da with SMTP id c3-20020a170902aa4300b00142691973damr65882664plr.39.1638262501288;
        Tue, 30 Nov 2021 00:55:01 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id l6sm1934745pfu.129.2021.11.30.00.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 00:55:00 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Shunli Wang <shunli.wang@mediatek.com>,
        Erin Lo <erin.lo@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] clk: mediatek: mt2701: Fix a NULL pointer dereference in mtk_infrasys_init_early()
Date:   Tue, 30 Nov 2021 16:54:54 +0800
Message-Id: <20211130085455.75537-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mtk_infrasys_init_early(), the return value of mtk_alloc_clk_data()
is assigned to infra_clk_data and there is a dereference of it in
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

Builds with CONFIG_COMMON_CLK_MT2701=y show no new warnings, and our
static analyzer no longer warns about this code.

Fixes: e9862118272a ("clk: mediatek: Add MT2701 clock support")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/clk/mediatek/clk-mt2701.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index 695be0f77427..9ba30089cb9a 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -742,6 +742,11 @@ static void __init mtk_infrasys_init_early(struct device_node *node)
 
 	if (!infra_clk_data) {
 		infra_clk_data = mtk_alloc_clk_data(CLK_INFRA_NR);
+		if (!infra_clk_data) {
+			pr_err("%s(): could not register clock provider: %d\n",
+					__func__, -ENOMEM);
+			return;
+		}
 
 		for (i = 0; i < CLK_INFRA_NR; i++)
 			infra_clk_data->clks[i] = ERR_PTR(-EPROBE_DEFER);
-- 
2.25.1

