Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5B9462F2F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 10:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236028AbhK3JF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 04:05:57 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:54644 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235527AbhK3JF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 04:05:56 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 4J3GSs0pYKz9vCGM
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 09:02:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id E7cQlpPON30A for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 03:02:37 -0600 (CST)
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 4J3GSr5xR6z9vCGR
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 03:02:36 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 4J3GSr5xR6z9vCGR
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 4J3GSr5xR6z9vCGR
Received: by mail-pg1-f200.google.com with SMTP id k11-20020a63d84b000000b003252e72da7eso6396828pgj.23
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 01:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JB/xnaYRERTHfThz3BeKOjYTQVcTowsU7QWWYd5kA3k=;
        b=OS2U0S97KdtYbru48E9PVinKaS8ajlz38Gs67N+WmxDHN5E7BtqqyV5aIK2NPvJQ7x
         JnMQ/apjMmGUkZ92r5R9HAojVBAZhdTKUh6DPCIMJNouHmuw1p9EJGxa0RcvhBle6/Kx
         m786DzGuNV2R4f4fbq/yI7qy7m4befRm+Q8j/QuytpySgeWe1rwPHQox2XB3lM7JXAB6
         zX8OGrkXmsbxg4lSPTuyHi0R1uEzWSlbeHJbaBszcw1K3NgSSbAP0cUln+bLUYSjBOsO
         93LxR8K4FvuTe0lJsLNRItn79ygLkvNyK6dxH/ZulD7Z9yhJOqhETWx97nB+lS33YKkw
         Pjdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JB/xnaYRERTHfThz3BeKOjYTQVcTowsU7QWWYd5kA3k=;
        b=TQVBLfjFGfL7QdTeRnqA/cfAJSiCWjwH/tUPnrze9RqLcTOpfJwNv85mH/WZ/VCFE6
         kiWAI6vUcyTO/kjb19kUpt91upBKIM3m0asJbqM7hWq2M1dDqhqSrIG/WPXhKxQxrZMB
         Bg3WOUlRUdul/LKhvchr6NiOaRqw0mckM2Mh2AXmvRlUuyWmMyeFLvPKwM1+LhNYhr0l
         ysgJG059p9uEPytVQI1oCfDv+oXWZKS/U9z19ePj9VeHX9oaSb3FHB2sXOT3St5exHMd
         QPaXv3kGx6r2fLX1UMMFwa9oRYXNidAibe3UOX2CvxdJti0dmKsv/4LZ2jPmUTewpHiJ
         Y9FQ==
X-Gm-Message-State: AOAM530a8HcCKVioWFz8gqOn1ZLTCQQL26Roe6vC7NZmSgbOMmeHxqoM
        IY1R2AWfqOc6N+vUYSwaLhd4U3u1w387tVG1dq30E4XbdtTisJv+kdYmF3aqJzv3pB7ZPyTGay/
        VB89tl05/dLufdIggRTVKGmhrZMat
X-Received: by 2002:a17:902:9349:b0:143:88c3:375e with SMTP id g9-20020a170902934900b0014388c3375emr66274433plp.16.1638262956059;
        Tue, 30 Nov 2021 01:02:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxFrEQrsuwZ277titXaqT8fk1JaMbrMsWZ/xVKNYBxWfn8JVIFmUsszxNKjkAxJJjqUoJjMLA==
X-Received: by 2002:a17:902:9349:b0:143:88c3:375e with SMTP id g9-20020a170902934900b0014388c3375emr66274403plp.16.1638262955785;
        Tue, 30 Nov 2021 01:02:35 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id j38sm14209940pgb.84.2021.11.30.01.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 01:02:35 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "weiyi.lu@mediatek.com" <weiyi.lu@mediatek.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] clk: mediatek: mt2712: Fix a NULL pointer dereference in clk_mt2712_apmixed_probe()
Date:   Tue, 30 Nov 2021 17:02:28 +0800
Message-Id: <20211130090230.77618-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In clk_mt2712_apmixed_probe(), the return value of
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

Builds with CONFIG_COMMON_CLK_MT2712=y show no new warnings, and our
static analyzer no longer warns about this code.

Fixes: e2f744a82d72 ("clk: mediatek: Add MT2712 clock support")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/clk/mediatek/clk-mt2712.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index a3bd9a107209..08ef56f68c7a 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -1266,6 +1266,8 @@ static int clk_mt2712_apmixed_probe(struct platform_device *pdev)
 	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
 
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
+	if (!clk_data)
+		return -ENOMEM;
 
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
 
-- 
2.25.1

