Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04ABD462F6E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 10:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240084AbhK3JVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 04:21:15 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:58412 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240083AbhK3JVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 04:21:12 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 4J3GpR1ph6z9vBr6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 09:17:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IBSwN35FPhFe for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 03:17:51 -0600 (CST)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 4J3GpQ6rrZz9vBqx
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 03:17:50 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 4J3GpQ6rrZz9vBqx
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 4J3GpQ6rrZz9vBqx
Received: by mail-pl1-f197.google.com with SMTP id e4-20020a170902b78400b00143c2e300ddso7915072pls.17
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 01:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NIZ6/hw1XbXKmzO5MEDGHAzLrrUD6afmSXwxKYg8s/I=;
        b=D9KCbyPE8cbAAhjSIS3q2zIbB/si0IkVOWglgG0AtZmAnW1IKHFfoy2WJdoDi2jGX+
         QznQAlGRyDJG5WSjdQY5vMjgU0LqT8EQh+Kx3Gq1cyfNCNvg1XdAmr0U4omKWQQqBEOE
         UUUmF+LPHpvh2bwgooNOx1oLjvqBZaFdvFtEyAZ2so+LqJj1VOJQKYx6QhfJuqeQAE2h
         7pcSGCVua1F9BGvchX36yapYJvOVEQjMHCYYM6gnVM0eAGDtw+gFqIz1HBvyxHjCCecN
         q0ZHRBLsVU8E1Hs34Dq73AOxo8ql1lGT0GlFpeAr+1kjs3uR9K+X+PE2dgFGr3efJh7r
         CQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NIZ6/hw1XbXKmzO5MEDGHAzLrrUD6afmSXwxKYg8s/I=;
        b=YMXW9dgd1LGa4CyiP+0EhCz/zI174+XaqQX2K/xQQsyhCRS+ct5tpDGf1r1LDlRYER
         qZ0GIrJkIsvrtuDMj2ZctpBKJnwBflsaTynci8L/WUBic+Y7WIOmB7inH5eUUpJBFIo1
         FI7RKlHGloUqYKQqrZKg5XmDKJchJmr7d/j/A4VIY3oRrWMgGJN15wE1Nq+v4x1P1qIv
         Y6Zg60dXmtDEi5Y5AHvF7KyWnVjYWF13K8xEvZWmWp0YoLvulRFzEqVcefFvKOIvlkmd
         69cwT1YlOs1MpTmpSqp9ntmBCoalIAgRJMtvhKHl4EZJoJAakpkr/1thACZlB7lFScxt
         p0uA==
X-Gm-Message-State: AOAM533woFMHEmlEBwW5CGcFBTOSqdPMCp7tkd+PKGgmSCe5UYnPldeb
        4NQz/cMgjJTD6UWLxbaUXIkJNF9g37QRL8ssh3+/3y3IlGv4vBbs8SURJm8IYE9hKflBeYtwT10
        OKn/JgUkYSbPPj1XUsr55bR7j1zYI
X-Received: by 2002:a63:9b12:: with SMTP id r18mr36848730pgd.367.1638263870232;
        Tue, 30 Nov 2021 01:17:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwE9GjxEfwgileQZRn/vK5o6v6tvFGZ9TQmfO803I9D8llMPNWOFqVq3X0eX5DM9fIdE/TGtA==
X-Received: by 2002:a63:9b12:: with SMTP id r18mr36848718pgd.367.1638263870052;
        Tue, 30 Nov 2021 01:17:50 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id h21sm14275844pgk.74.2021.11.30.01.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 01:17:49 -0800 (PST)
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
Subject: [PATCH] clk: mediatek: mt6765: Fix a NULL pointer dereference in clk_mt6765_apmixed_probe()
Date:   Tue, 30 Nov 2021 17:17:19 +0800
Message-Id: <20211130091720.80514-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In clk_mt6765_apmixed_probe(), the return value of
mtk_alloc_clk_data() is assigned to clk_data and used in
mtk_clk_register_plls(). There is a dereference of clk_data in
mtk_clk_register_plls(), which could lead to a NULL pointer
dereference on failure of mtk_alloc_clk_data().

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

Builds with CONFIG_COMMON_CLK_MT6765=y show no new warnings, and our
static analyzer no longer warns about this code.

Fixes: 1aca9939bf72 ("clk: mediatek: Add MT6765 clock support")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/clk/mediatek/clk-mt6765.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt6765.c b/drivers/clk/mediatek/clk-mt6765.c
index d77ea5aff292..5f723906675b 100644
--- a/drivers/clk/mediatek/clk-mt6765.c
+++ b/drivers/clk/mediatek/clk-mt6765.c
@@ -785,6 +785,8 @@ static int clk_mt6765_apmixed_probe(struct platform_device *pdev)
 	}
 
 	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
 
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
 
-- 
2.25.1

