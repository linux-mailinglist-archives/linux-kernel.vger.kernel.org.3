Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1F34631CD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 12:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237116AbhK3LI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 06:08:29 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:37302 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237098AbhK3LI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 06:08:28 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 4J3KBC5zx5z9vKY6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 11:05:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ff1BgYjVVWDk for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 05:05:07 -0600 (CST)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 4J3KBC3v6xz9vKYD
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 05:05:07 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 4J3KBC3v6xz9vKYD
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 4J3KBC3v6xz9vKYD
Received: by mail-pg1-f197.google.com with SMTP id d23-20020a630e17000000b003253ae2b081so5887388pgl.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 03:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mYStvUvCLlqlzrJP1ZcXjQVOD32ssfsnDJadt3mGWKM=;
        b=lFthXgcyVrcbqYBoATpa5XDWbmejulAFFfM9XZLlakuL7daf0/mlgAfWFUgerg3dq6
         3Q5xI5rGgBmVevdeIK3lUwtxxfqephqSkN8n9zebZ/r3e0kyu7hudrL9iIpPJTRstcxQ
         lUziE4gN2a8aJpXnUzluq8+AnfI+jAWLJivmPkAHjIZRoSMNOzp+KKaYmfQsTrgQWKpF
         AXqgVGvHIOE/0XwIQR/iuVKeVHhbxxeHKQIa79yp400jQxw8FELSm0Dr7S2jpgZhZdpK
         nx7D0/VnEUlljbs+Ib0ri7pMI77Os9ligCbBe+rQ6ThngsT8/TsTANrrC+xVl187gnBH
         7lVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mYStvUvCLlqlzrJP1ZcXjQVOD32ssfsnDJadt3mGWKM=;
        b=A2Tg5luZISlPjAPNI3WErXdaptVXFLLJy5yOkJZqJlx52wdg6xgZwfKaNW2dLOttRw
         8po1iPImd5hiJpFCPJFfJho4KIE32GAFsQLJuBt51p7589fGLM7U0Q/zibrG0CyJou9t
         5/7DdpQy469upo1lHjXaNyJ+okOkpRX/aKA8f9mLkDN3QnroRdMTZnMAGeS7OXp5rwVL
         fv9ldKCxZUXzpN8s2vuS6t7pVSLaYYGFORfZ2S6hZFYp2/xmSQ76q3cn6W5QzdNAF/Uh
         zsbovSTpL5aU6FG/GaeLYqRMdSjwKb9jvcW+xdovh6t1Cn2jetXv1O3GGlYIfYL/KmR7
         /ySw==
X-Gm-Message-State: AOAM532NKf3OxFpUj8lhDKMiCB2LqXVzyb+aEvru0yWmXeAka8XxS6ZP
        4Z2lP5AOSKzupvXOykBK8y1G294mMSR07YVd2t7YR8aFDnTm3ed2NkEXmWmlzovaamPubODIAby
        /84TA7ZXQnhxJoqnzyAXz+Rfd9vgy
X-Received: by 2002:a05:6a00:1741:b0:4a6:3de7:a816 with SMTP id j1-20020a056a00174100b004a63de7a816mr46192555pfc.29.1638270306501;
        Tue, 30 Nov 2021 03:05:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwn1J4uGsH9bOXbYC4WdRrabZwYPOV9g2tM96wV0janBLZf7MKyPwzEO7JdaXL78rb0c2Ua7w==
X-Received: by 2002:a05:6a00:1741:b0:4a6:3de7:a816 with SMTP id j1-20020a056a00174100b004a63de7a816mr46192519pfc.29.1638270306176;
        Tue, 30 Nov 2021 03:05:06 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id h22sm14774116pgl.79.2021.11.30.03.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 03:05:05 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: mediatek: mt8516: Fix a NULL pointer dereference in mtk_apmixedsys_init()
Date:   Tue, 30 Nov 2021 19:04:27 +0800
Message-Id: <20211130110429.107577-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mtk_apmixedsys_init(), the return value of mtk_alloc_clk_data() is
assigned to clk_data and used in mtk_clk_register_plls(). There is a
dereference of clk_data in mtk_clk_register_plls(), which could
lead to a NULL pointer dereference on failure of
mtk_alloc_clk_data().

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

Builds with CONFIG_COMMON_CLK_MT8516=y show no new warnings, and our
static analyzer no longer warns about this code.

Fixes: db077febb774 ("clk: mediatek: add clock driver for MT8516")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/clk/mediatek/clk-mt8516.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
index 9d4261ecc760..1f209f569f3d 100644
--- a/drivers/clk/mediatek/clk-mt8516.c
+++ b/drivers/clk/mediatek/clk-mt8516.c
@@ -797,6 +797,11 @@ static void __init mtk_apmixedsys_init(struct device_node *node)
 	}
 
 	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
+	if (!clk_data) {
+		pr_err("%s(): could not register clock provider: %d\n",
+			__func__, -ENOMEM);
+		return;
+	}
 
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
 
-- 
2.25.1

