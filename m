Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50254463D5E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 19:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239230AbhK3SGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 13:06:07 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:52732 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245251AbhK3SGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 13:06:06 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 4J3VS62tK5z9wNLX
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 18:02:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HmoikajH8ec8 for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 12:02:46 -0600 (CST)
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 4J3VS60qf2z9wNLG
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 12:02:46 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 4J3VS60qf2z9wNLG
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 4J3VS60qf2z9wNLG
Received: by mail-pf1-f198.google.com with SMTP id y5-20020a62b505000000b004a804839861so9441281pfe.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=94FUHYbL48FTKXxIcPe01xLMBfPTMNQQ7bJWYC1FWVY=;
        b=XQ1yQvWlIQV8/P81taYysSBz9syihh9z8HDlaEZRaz951rIA9xY7Bhwyv7EjeJWsPm
         YE2J1EoHPYroJ1cOI6/l4hnz4tO1dIMRlFr1It3XDEGcFB9DL2F02ieuyTuNW95NKcoQ
         Uqfy9bsgL8B0/Up8f4KXOEL8Mdu3uA5mzhBE/venDBWqRCvEDDTHEO1+9d/OLLQbcNlp
         u6lH7Zxha8YyVSh/UuR0t1EjZhI+8XerFwlN+oUAHV9dSphllgXJKGFjhlR+zV6jQiUy
         guF4RFfDKbfNns7AsC7WzSS1RTKITHIBCUX6NwQLA8Xjf2fr+dgIaMIc063hvmnxpoHf
         QB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=94FUHYbL48FTKXxIcPe01xLMBfPTMNQQ7bJWYC1FWVY=;
        b=DoMOmIQinUyNu3CY+9mk/BzX+DZQVshkStBrDZ6CqPs0+fTXm130u8vd4QiW2LuTGB
         GnEHX41RAmYFEBnrOXEc26ofBWZJMz41qDJuT0nEzC62r3/u5UDFzyfHJo6C51/CTMeg
         0lA/TKxdCjXyaRk5YSre8ddROM0SYZJt8TqZ8n7AMxrA4AFsr5szl9iGd9zK2MIXsRJf
         5EuUxhKq0TUWNrf4/E/GX2gWu2JGcOSY4GG35orobPm0QfQyRQhqrPjRd6cYDNn+9uSk
         C+Jtv821OOrbMv18BQalJxqXkGUTlDu7gkKEZdr7PmvnW/FHyJHVQDm/tIt5QOH/nDlM
         Elhg==
X-Gm-Message-State: AOAM532shW8eIABuf+53j2NSwfan1cgpc0euO7KoCyes8kuh3aS6CCP6
        +SZqkOqX8J6B5llAlm6Z6LYVuhn/hVictWYwCl2VbfcnRWJyDs7mDkC4jtIYCZju+RB2dtuR6NW
        d3XNiEONlEgVLgLbI8i8JbwYfFRam
X-Received: by 2002:a17:902:aa89:b0:144:ea8e:1bd7 with SMTP id d9-20020a170902aa8900b00144ea8e1bd7mr907539plr.65.1638295365216;
        Tue, 30 Nov 2021 10:02:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxbCSXQBUYQ9W478PfO3HLXqUjgvGStEcVvVvDkr1fi99WW7iwMEvkwA+RyYe74PrMkLotyzQ==
X-Received: by 2002:a17:902:aa89:b0:144:ea8e:1bd7 with SMTP id d9-20020a170902aa8900b00144ea8e1bd7mr907505plr.65.1638295364975;
        Tue, 30 Nov 2021 10:02:44 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id lr6sm3595044pjb.0.2021.11.30.10.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 10:02:44 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Henry Chen <henryc.chen@mediatek.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        James Liao <jamesjj.liao@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: mediatek: mt8135: Fix a NULL pointer dereference in mtk_topckgen_init()
Date:   Wed,  1 Dec 2021 02:02:36 +0800
Message-Id: <20211130180238.218178-1-zhou1615@umn.edu>
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
cause potential problems to previously correct cases as the API is
changed.

This bug was found by a static analyzer. The analysis employs
differential checking to identify inconsistent security operations
(e.g., checks or kfrees) between two code paths and confirms that the
inconsistent operations are not recovered in the current function or
the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

Builds with CONFIG_COMMON_CLK_MT8135=y show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: a8aede794843 ("clk: mediatek: Add basic clocks for Mediatek MT8135.")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/clk/mediatek/clk-mt8135.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt8135.c b/drivers/clk/mediatek/clk-mt8135.c
index b4e20bd7680e..556153379c3d 100644
--- a/drivers/clk/mediatek/clk-mt8135.c
+++ b/drivers/clk/mediatek/clk-mt8135.c
@@ -526,6 +526,11 @@ static void __init mtk_topckgen_init(struct device_node *node)
 	}
 
 	clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
+	if (!clk_data) {
+		pr_err("%s(): could not register clock provider: %d\n",
+			__func__, -ENOMEM);
+		return;
+	}
 
 	mtk_clk_register_factors(root_clk_alias, ARRAY_SIZE(root_clk_alias), clk_data);
 	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
-- 
2.25.1

