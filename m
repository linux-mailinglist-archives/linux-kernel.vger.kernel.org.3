Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C367463D7F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 19:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239436AbhK3SSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 13:18:41 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:33058 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239395AbhK3SSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 13:18:37 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 4J3VkY1nTLz9vvMn
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 18:15:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id F7XT4zs-9LYs for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 12:15:17 -0600 (CST)
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 4J3VkX6sPkz9vvMP
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 12:15:16 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 4J3VkX6sPkz9vvMP
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 4J3VkX6sPkz9vvMP
Received: by mail-pg1-f200.google.com with SMTP id x30-20020a637c1e000000b00324ab629735so10693992pgc.17
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8aLbqDVidZ+7wdd4GicAjvyHH7eASjXq9vZdA7OEF94=;
        b=h/zqG5CfkaTPj/bhN4usylXAlQ5g3qbkk70kfXHrteu7ovjt/eVh76QH8Bi0XLCdey
         Lf+TKwTx+LZRn+z5ZdGRTqc8PDJOux825xOZBFTdsbOGAKEYBhkKT7GULROrT2rOQ4NX
         Bo0SzKsQ2P+RpvQZNxmig4beiRzO8jxiMDmnUVPlgM6pobobo16jj9RTxOd8x/k8Bx6l
         v/L4zJiGIKdaWmgOhrQZt4v5rnT8nGpTShtgfrSAdtNG9UhWjwagJr2Kjo2p36ViCVY6
         hYBJH7k5zlfIq8v/iTS2MND/PLDf+4AlUkWy6MC7snl8knter3gEJV+sl52xlobTbYGR
         uP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8aLbqDVidZ+7wdd4GicAjvyHH7eASjXq9vZdA7OEF94=;
        b=1HT8hId7rkRRKe4fdS89gPKDSh4EkEVFShDBka/LDi/h6+ETlV/rUg9G4VGnVknJyz
         As7lUZ+4zaitHtsCx1zYqbTNQtI66JNR/Ik2FyGZsV+J3l+uEvRKdbjiI+H+4bkHY7nR
         nUAlWHHuc931QJWipXyGO5x7Unurqo09LdskXvk78Adiz7OzcYTVetsQWNGA+J9f1hIf
         q2qgw59P9uNH2tTFDIH9825IePSTYJrpfbmkyCVYZLxSEV58bg06q4TM8oi9hfX0DXGK
         A4QwZTrG/Y7jNs3/uNI7ahU0I95MuPzPZsFGInr9C8otpCTZ4i+WyonUFrRhulzy60VI
         sH8A==
X-Gm-Message-State: AOAM531aqji6uKqXOz6O2SWupeGynLVAUckVMGQmCvtp1enx5SnTGt3v
        hoZrHAGF2jGY1F0tglOhRuvxMMhCWNGDnA8i3TacR8nvPaF53o561n71cd7uuH2XzTxQDv8Y8Qi
        1LdQ+MQ3H7JKITe05m7ApshDCWBAl
X-Received: by 2002:a17:902:e749:b0:141:edaa:fde1 with SMTP id p9-20020a170902e74900b00141edaafde1mr1041436plf.72.1638296116223;
        Tue, 30 Nov 2021 10:15:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzFonit7jQbQqW7wbtpwt79Yj99amZxiuzPUHMEFm11chH74+RimyI/4fW4yprB8GZxNrvZFQ==
X-Received: by 2002:a17:902:e749:b0:141:edaa:fde1 with SMTP id p9-20020a170902e74900b00141edaafde1mr1041407plf.72.1638296115986;
        Tue, 30 Nov 2021 10:15:15 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id y8sm22530397pfi.56.2021.11.30.10.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 10:15:15 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Wenzhen Yu <wenzhen.yu@mediatek.com>,
        Rob Herring <robh@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: mediatek: mt7629: Fix a NULL pointer dereference in mtk_topckgen_init()
Date:   Wed,  1 Dec 2021 02:15:07 +0800
Message-Id: <20211130181509.222496-1-zhou1615@umn.edu>
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

Another way to fix this bug is to add a check of clk_data in
clk_prepare_enable(), which may solve many similar bugs but could
cause potential problems to previously correct cases as the API is changed.

This bug was found by a static analyzer. The analysis employs
differential checking to identify inconsistent security operations
(e.g., checks or kfrees) between two code paths and confirms that the
inconsistent operations are not recovered in the current function or
the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

Builds with CONFIG_COMMON_CLK_MT7629=y show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: 3b5e748615e7 ("clk: mediatek: add clock support for MT7629 SoC")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/clk/mediatek/clk-mt7629.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index 856929f94ebd..f791e53b812a 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -580,6 +580,8 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
 
 	mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks),
 				    clk_data);
-- 
2.25.1

