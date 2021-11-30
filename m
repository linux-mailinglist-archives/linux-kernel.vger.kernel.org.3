Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25119463CDD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 18:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244827AbhK3Rfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 12:35:42 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:55490 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238828AbhK3Rfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 12:35:42 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 4J3Tn13pfxz9vZ8B
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 17:32:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ku_o_-EHFocu for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 11:32:21 -0600 (CST)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 4J3Tn11ms8z9vZ8D
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 11:32:21 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 4J3Tn11ms8z9vZ8D
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 4J3Tn11ms8z9vZ8D
Received: by mail-pj1-f70.google.com with SMTP id lj10-20020a17090b344a00b001a653d07ad8so11884252pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 09:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0Up/NfjS7VaEB7cP0OIMaR/6NGfFlxGpUC060f7VlH8=;
        b=LgbIzllkX7OSlmNsxiG9OyhKA9X8UUrr90oDFyxdQ+6FldFgZ8OhhiTr6jrVGJVYxX
         ak2A0Ye/ZBh6tUuTMvOqcMrw7VPz11kYIhLhpXz12X5ydvHHg+rOvXSIWq24u0dqifXb
         XtObr0aB/0rORTIujfzrno9fV2Y58GG7QwMmpbc/eWvHV7SiJzuzFcyEelXQ2jqXwfpr
         BnuBDW/e480tQO66CQRRyD0HGN9LQ056YdZqJgWekP++dGT26QNhjsH1DsSujWu3oeml
         WbKzePa+fT/5g8RC2OXMpb/ae0UE+BvMvjkPF9963Z9e1Zb1rAWZStGyj6+n7JXb31p5
         0QEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0Up/NfjS7VaEB7cP0OIMaR/6NGfFlxGpUC060f7VlH8=;
        b=j8Mf9AOxe0SfwnM+SRQqRO5DNhCnZ+vl+Ep9ZPubUQO6ysThSZySXs69to9bW/T4C3
         JCLm+YjOkvnWRLgkzbhYnFWyytgwaBRLz1VALQqA7eGSCGuLtteJprpuENQSR+m31hW9
         +6eLtsn/Y7ZbOP2hnJt6qk3ivT9Jh/dfUb02qchqLFrqlKYcjRIHS9BrhVp6DbCFJVcg
         Kimx9GFAGUvpDbotxTG8xVkcqc503fCzl9udovGyBsIb/i2CcXxUQZlaN3PSZ5VhgOk+
         eQOPjH5AEBrJghgStY2WIjeRc29uZf3tLDN0JuFfr/vxrhCHViLQGHW0zYrRpoGBQAAQ
         qKzA==
X-Gm-Message-State: AOAM533YA5nRKpgxpDnjNIWJda7saBQNokNwT7Ax6DB5+OCtNyzcOJ3w
        VkVLIp35lTasKmkCWDIkzX2K+/8nux6HdCwnHMF0KgM3I0ictBlqbPk0eWsF5wJ17ucgfybGq6s
        2FTKMQChquywTCcJLo5MfL4CXih5d
X-Received: by 2002:a17:903:4053:b0:143:6d84:984c with SMTP id n19-20020a170903405300b001436d84984cmr722902pla.37.1638293540394;
        Tue, 30 Nov 2021 09:32:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwmkvtdqC18D6/hPwj4l6CmxtmSs28zk1H/DR8W4JVcY3gJp4sR6QDyUJeABZtby3y19rakqQ==
X-Received: by 2002:a17:903:4053:b0:143:6d84:984c with SMTP id n19-20020a170903405300b001436d84984cmr722863pla.37.1638293540151;
        Tue, 30 Nov 2021 09:32:20 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id l9sm1342900pfu.55.2021.11.30.09.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 09:32:19 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "weiyi.lu@mediatek.com" <weiyi.lu@mediatek.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] clk: mediatek: mt2712: Fix a NULL pointer dereference in clk_mt2712_top_init_early()
Date:   Wed,  1 Dec 2021 01:32:13 +0800
Message-Id: <20211130173215.209258-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In clk_mt2712_top_init_early(), mtk_alloc_clk_data() is assigned to
top_clk_data and there is a dereference of it in
clk_mt2712_top_init_early() which could lead to a NULL pointer
dereference on failure of mtk_alloc_clk_data().

Fix this bug by adding a check of top_clk_data.

This bug was found by a static analyzer. The analysis employs
differential checking to identify inconsistent security operations
(e.g., checks or kfrees) between two code paths and confirms that the
inconsistent operations are not recovered in the current function or
the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

Builds with CONFIG_COMMON_CLK_MT2712=y show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: e2f744a82d72 ("clk: mediatek: Add MT2712 clock support")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/clk/mediatek/clk-mt2712.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index 08ef56f68c7a..9050927d2d5d 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -1286,6 +1286,11 @@ static void clk_mt2712_top_init_early(struct device_node *node)
 
 	if (!top_clk_data) {
 		top_clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
+		if (!top_clk_data) {
+			pr_err("%s(): could not register clock provider: %d\n",
+				__func__, -ENOMEM);
+			return;
+		}
 
 		for (i = 0; i < CLK_TOP_NR_CLK; i++)
 			top_clk_data->clks[i] = ERR_PTR(-EPROBE_DEFER);
-- 
2.25.1

