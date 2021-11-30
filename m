Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2299463D75
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 19:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245343AbhK3SQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 13:16:51 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:41914 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245335AbhK3SQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 13:16:50 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 4J3VhV0Bqlz9wBch
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 18:13:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EplzrCGr9mVW for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 12:13:29 -0600 (CST)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 4J3VhT5Fd4z9wBcZ
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 12:13:29 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 4J3VhT5Fd4z9wBcZ
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 4J3VhT5Fd4z9wBcZ
Received: by mail-pf1-f199.google.com with SMTP id c21-20020a62e815000000b004a29ebf0aa7so13294546pfi.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=220zujd2LnwZ+qWoN2OFoXSWEsex+z6W8IrJCkY4jhY=;
        b=ZGyfpYm35uM7GtoYgg0W5R/GsfxmodWoxbIFpG0XbdXLx7umNFD/3t6jA5ADPmZStW
         yoCZlWAH7xuftrqPs/n50g/MwgWebKFWTI8XIov+C8yH9mhSQW2TZsO+VJTx0W0P409g
         1tVXAIFz6VfAofRhpiu0hNUcumbQUCl1Bl/81JJKBKjDO4b7DbPlBRpffuCWQK45WeWp
         BA3AReN9ibCT2CxihTONnorU3IU7nvezwp+2wrRgVAOtoLtZIV2uXPmXHrXhKC42HnGv
         NEbKk6uUH0ysWIaKoIDCkN9GkPAH1qwyuHJfkmVrFlaB+8MQpYbzJXCtye4fP4zzUaU3
         /w7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=220zujd2LnwZ+qWoN2OFoXSWEsex+z6W8IrJCkY4jhY=;
        b=PiKqs4es+0bx6/qmBLBlexy+3pAdN54Ii7rHprCw6lhLJTzxdNdEp2Px7tHhaStCvP
         TgHT/FjiAxcK2DpWeIMeDNxJGS1txJEJIxLvX6wIjqJXjDUH3amaFGLafwWGuaOgivP3
         wCF1EASty0lUxrCDSrdu/5S0jdHLr1/k1vkOd/jUvqlXD/FA+A44LaXgjrnVNUnKPAEa
         VlFxtDd8Jw3OBWpBFFbqH4pv9ulgQzqqmAI0WM21YAPOuP7EzBEl8EHK84d1pSkaOqvn
         YOZnbObEOBTD1sPkcQsxo2jrShyEJfJeN9QUJ6/zYnE90GlwWciWWYgKUQeKtdETmEPs
         WAvQ==
X-Gm-Message-State: AOAM533f75V+ZqpChXKzoIWF+0qbYGqrgPB7ftIACTTAUxEYMV2nQ2zd
        O/Dn4PLcc7dHJXv5P5YGo3MPhZ9dvHpRfkrCzbbzaTETf4wwoYGpO/R/Za4BXXWdGKV+R1TfhT6
        x4bRS3dd2ykxJhRP+Aw02Vy2qpOot
X-Received: by 2002:a17:902:b712:b0:143:72b7:4096 with SMTP id d18-20020a170902b71200b0014372b74096mr877714pls.25.1638296008899;
        Tue, 30 Nov 2021 10:13:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwgW4A3Ixgqz8PI+64TVMK7ojwTAntrTP8fA/jFfS7xXKT5qCeh/rTbSqa900wm32oO2zIfhA==
X-Received: by 2002:a17:902:b712:b0:143:72b7:4096 with SMTP id d18-20020a170902b71200b0014372b74096mr877683pls.25.1638296008605;
        Tue, 30 Nov 2021 10:13:28 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id n16sm3230348pja.46.2021.11.30.10.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 10:13:28 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: mediatek: mt7622: Fix a NULL pointer dereference in mtk_topckgen_init()
Date:   Wed,  1 Dec 2021 02:13:16 +0800
Message-Id: <20211130181318.221401-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mtk_topckgen_init(), mtk_alloc_clk_data() is assigned to clk_data
and used in clk_prepare_enable(). There is dereference of clk_data
in clk_prepare_enable(), which could lead to a NULL pointer dereference
on failure of mtk_alloc_clk_data().

Fix this bug by adding a check of clk_data.

This bug was found by a static analyzer. The analysis employs
differential checking to identify inconsistent security operations
(e.g., checks or kfrees) between two code paths and confirms that the
inconsistent operations are not recovered in the current function or
the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

Builds with CONFIG_COMMON_CLK_MT7622=y show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: 2fc0a509e4ee ("clk: mediatek: add clock support for MT7622 SoC")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/clk/mediatek/clk-mt7622.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index e89acef5768f..4968b227b4ab 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -620,6 +620,8 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
 
 	mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks),
 				    clk_data);
-- 
2.25.1

