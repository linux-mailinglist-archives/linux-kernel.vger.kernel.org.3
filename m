Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78A6463049
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 10:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbhK3Jyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 04:54:53 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:36656 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbhK3Jyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 04:54:52 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 4J3HYJ6jnzz9vBr1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 09:51:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pzxDzhiUEnoA for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 03:51:32 -0600 (CST)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 4J3HYJ4hmMz9vBrC
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 03:51:32 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 4J3HYJ4hmMz9vBrC
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 4J3HYJ4hmMz9vBrC
Received: by mail-pl1-f198.google.com with SMTP id s16-20020a170902ea1000b00142728c2ccaso7951497plg.23
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 01:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9EkZVrHY7dDlBHaYqmsvcGz7vtd0FsbZd+iFeZSl0pw=;
        b=eX1OlLJGnlnjZkEFRXOiPM4eNd4fDrgYiEP7qGWxq8BGFuZRTX/cKs7O5X9SD7a+hQ
         4My4mGlmVkyKzcOY9EfUimRcA0afJ87YVnU1FUbgPQ8DtBc+0hKrbhI9302fijdAU8h9
         VVVGklII0T5GV58ctwpCNv6UVffytP7jaZv2T1DeXKb2R2f6dXfRTYg6o1cgxgnUFYcN
         7/MnOgpBZxXm1M6MKx4xf9qM0ridKSWofvNLlnJRSX0NB/K64tZ/M/unWdW4a4VC84LC
         VBbrkRwWUNedyaCnsiVQuHgP/LKlVeiNTdlIKbzLIBJYSk0R6ZIrjPW4aGwI112gbGXl
         PI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9EkZVrHY7dDlBHaYqmsvcGz7vtd0FsbZd+iFeZSl0pw=;
        b=TtbSeuNmk1zWb04QJoB9nQmcUK/U+l7DqQcoBWMxmP074IPP4q+8S4JVaDBMFTgkG4
         0kC9KbTs0dFB/lIgHr96ZFNiyn6qd6RKmhZfLKvP9PlxuXypunCGZJU2BXI2ZTe4XSmg
         LGOc65N829vCLG/KcUjRhipmhnppuEU+ZA564DOI1xBkyKSG+KWD+ZCt11CzFoF5cmAR
         L79XUAb0sM8/wETuBkUbwqAtx1oyGtxAnOMFjZzzKCM1VJYf+Ad/+hBvNejCv+ezAbdf
         s4FvCoFoYlt7BNUIpsBlA+mCAEX27h/W6mvz1+1tSl4Nfe6EbKNTf38ryUwHtixSB4r8
         MjFA==
X-Gm-Message-State: AOAM530yEoo+wTpahc2YHBctGb1mXfmIvBJABhMx8P2p+1Uj29kkkY8z
        S3SRGmUUOTzDOODqUaevE3pQtEY9cv4YngbkfLy5tiR/vCKg5WCfuQTW13/2cC8yVhY/jGXbFPq
        mh3HbzYE7bYa53ooaoWTsbA7jykvl
X-Received: by 2002:a62:14c7:0:b0:4a2:a6f2:2227 with SMTP id 190-20020a6214c7000000b004a2a6f22227mr44975636pfu.22.1638265891711;
        Tue, 30 Nov 2021 01:51:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyQImtzv+LIHTUu5TcQasG21GTkCIDnPySafq7nEj8Fg6iyWGGeeFw9694JEl49rBjqO97PVQ==
X-Received: by 2002:a62:14c7:0:b0:4a2:a6f2:2227 with SMTP id 190-20020a6214c7000000b004a2a6f22227mr44975625pfu.22.1638265891509;
        Tue, 30 Nov 2021 01:51:31 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id t4sm19770149pfj.168.2021.11.30.01.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 01:51:31 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Rob Herring <robh@kernel.org>,
        Wenzhen Yu <wenzhen.yu@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: mediatek: mt7629: Fix a NULL pointer dereference in mtk_infrasys_init()
Date:   Tue, 30 Nov 2021 17:51:24 +0800
Message-Id: <20211130095126.96006-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mtk_infrasys_init(), the return value of mtk_alloc_clk_data() is
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

Builds with CONFIG_COMMON_CLK_MT7629=y show no new warnings, and our
static analyzer no longer warns about this code.

Fixes: 3b5e748615e7 ("clk: mediatek: add clock support for MT7629 SoC")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/clk/mediatek/clk-mt7629.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index a0ee079670c7..30fe4b9b9fda 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -603,6 +603,8 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 	struct clk_onecell_data *clk_data;
 
 	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
 
 	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
 			       clk_data);
-- 
2.25.1

