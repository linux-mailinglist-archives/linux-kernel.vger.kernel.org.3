Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678F249854E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243961AbiAXQxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:53:24 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:34164 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243953AbiAXQxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:53:23 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 4JjGJf3xy3z9wjXj
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 16:53:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wdHVNe9zDd_u for <linux-kernel@vger.kernel.org>;
        Mon, 24 Jan 2022 10:53:22 -0600 (CST)
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 4JjGJf1pylz9wjXS
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 10:53:22 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 4JjGJf1pylz9wjXS
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 4JjGJf1pylz9wjXS
Received: by mail-pj1-f72.google.com with SMTP id w2-20020a17090aad4200b001b4c7c04a94so14564424pjv.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 08:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V0r9YN/985pm4WkH31y2XQtTcsRb/jLUskflmcZEE60=;
        b=E1ZTwHHm4md7EPnhJrWAZnKtkRuIvTvHNvNkVySo+wHtBhYnW7ZZF8W6Ah1GUt7b39
         jnvi3g9fn4nC1VsO205ro8ysDFFVneX9kxJoCnJFWIZVOhdePR/Af8rwHrVToRibSO5V
         sac/TN8ZMHZApL/BhARYX18UB06hdNVQTJQ53EG/NVuBCHnrw149fxxbc20/O/PD8Hjr
         cYiK9DJAXEKiNA1a/QcCqI8khKpc23OP4iPmd4KDYAYmpea3Eaxq0NLVYEY+oZbHKdtv
         2wJ1z5Sk2ibDy7jeQI5cd7n+kT/D1VRvSVWA0wu+lU6ZWU1D4LYNdQVq/ccZ6XtovXzf
         HAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V0r9YN/985pm4WkH31y2XQtTcsRb/jLUskflmcZEE60=;
        b=P64aEQv/gTH6I4Ty6BgjfMuvBq+AkGZsRiK7HM79HM57NNNM/8OmsmGyPk+YObKOLv
         KMKtTxat2Expa5SHsHDJfTwKRWMH8TYC7tAsyv3cQi/eZ6ovXezxRrxacUWUl+17lxY8
         89uuZR3DtJ8m7RGOrV9lzT3vwFvcIFqLStilCBHWMSneGdo9KhzKtvmm7h1ouvLD9weo
         8H7AQV+ZVVhgtwWIVW6YKUKG+LkEwqftGUtsg7DHY66tPo0GYL0ahJ/Xk+oi50WVKf0f
         GWMASXuDLT56YTE8RaKqMJXmE+KWin0DkrU5VDfLyUt/sH+1ugDsxtIHIsAsAShqcqQC
         pZmA==
X-Gm-Message-State: AOAM533ZfMrsBzc9S2jKLqhB+IiwG3YpkZszX752bjTO2JpqoMZ8TyZA
        UXphr46Ovp6xOmvUGjxCXf3M9CL6iOJ5vfZDRNogXJzfUzTqgDr8rrYagm9LMJvlJqiUadWoeyq
        x8k5PVUpC/rdeqedMqYeRqEAXRcsZ
X-Received: by 2002:a17:902:b781:b0:14b:68ed:cf6 with SMTP id e1-20020a170902b78100b0014b68ed0cf6mr1378351pls.79.1643043201393;
        Mon, 24 Jan 2022 08:53:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxXQtfiZ+amQ2asd73T+i2bIr3+FBZPrbJB4iFhv68gEh7b5lXqj0cb8bTVnoR0SssKli+OzQ==
X-Received: by 2002:a17:902:b781:b0:14b:68ed:cf6 with SMTP id e1-20020a170902b78100b0014b68ed0cf6mr1378330pls.79.1643043201161;
        Mon, 24 Jan 2022 08:53:21 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.4.61.248])
        by smtp.gmail.com with ESMTPSA id l191sm10787167pga.65.2022.01.24.08.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 08:53:20 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Dinh Nguyen <dinguyen@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: socfpga: Fix a memory leak bug in socfpga_gate_init()
Date:   Tue, 25 Jan 2022 00:53:16 +0800
Message-Id: <20220124165316.55449-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In socfpga_gate_init(), when ops fails, socfpga_clk is not released or
passed out, which could lead to a memleak.

Fix this bug by adding a kfree of socfpga_clk on the failure path of ops.

This bug was found by a static analyzer.

Builds with 'make allyesconfig' show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: a30a67be7b6e ("clk: socfpga: Don't have get_parent for single parent ops")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
The analysis employs differential checking to identify inconsistent 
security operations (e.g., checks or kfrees) between two code paths 
and confirms that the inconsistent operations are not recovered in the
current function or the callers, so they constitute bugs. 

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

 drivers/clk/socfpga/clk-gate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/socfpga/clk-gate.c b/drivers/clk/socfpga/clk-gate.c
index 53d6e3ec4309..0ca5e0000925 100644
--- a/drivers/clk/socfpga/clk-gate.c
+++ b/drivers/clk/socfpga/clk-gate.c
@@ -188,8 +188,10 @@ void __init socfpga_gate_init(struct device_node *node)
 		return;
 
 	ops = kmemdup(&gateclk_ops, sizeof(gateclk_ops), GFP_KERNEL);
-	if (WARN_ON(!ops))
+	if (WARN_ON(!ops)) {
+		kfree(socfpga_clk);
 		return;
+	}
 
 	rc = of_property_read_u32_array(node, "clk-gate", clk_gate, 2);
 	if (rc)
-- 
2.25.1

