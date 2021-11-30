Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B03DB462EB6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 09:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239733AbhK3IrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 03:47:02 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:51248 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239665AbhK3IrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 03:47:00 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 4J3FtV38Swz9vCFq
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:36:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9xDCtbwGK1QF for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 02:36:18 -0600 (CST)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 4J3FtV1WDzz9vCFn
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 02:36:18 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 4J3FtV1WDzz9vCFn
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 4J3FtV1WDzz9vCFn
Received: by mail-pl1-f200.google.com with SMTP id l14-20020a170903120e00b00143cc292bc3so7900568plh.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 00:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZhEErkZCigUJYNrSyl6K06r7YUXY23GOFWnaTYadjwc=;
        b=kBI00LVU38RVTMiz4h/7y4L3o4zuRoJswbEObfowuxOhdzkCQSgLZU6JlzuCXSnuvj
         XeRmjripbTIa/RdMn4K1vfrN+Dpt0UeJzbiP3SSNFJMSNzeU52pab7XMZNOngRNlR9e2
         /CmE6OxBWDnJ7eem/R3BYgaD2ovHzMf8/HK1/tXX5+dxXMHaJjB3n/UkO0HdX8kvTua0
         Uxq1lMLzBEB9idT+E5l5MxuttW4/K0lEZg6nzY0ESVDKJ/SJ7IjYB/Y6Dc2API+Gk1Gf
         3AR9ukVCYIhfeSdSpCLywGYCRQXaEDTJz6pnX4sfixXJ0mCGCGvKQNVD4c5OT98/2EFD
         QqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZhEErkZCigUJYNrSyl6K06r7YUXY23GOFWnaTYadjwc=;
        b=WDjIyfhK3IevuAxHDCTuu41tLYHxDOa/VEKFx0Rycp1Aigr3IdWYf8F4M4gQE7op01
         5Xu9mxb+rxw0b2Me3X9WKs+m+F5iPtCHA4orP0pTAmLZgjImc5fXbaJKLxnmfUh7IDvT
         BAOy+DeNk4PnmJQNh5rxa01vfrltygRvLucC96YUt98U2NKr5+MyJ4c9M+gk3uZpj23O
         P6UH1HxcsfuH6lDdB0hQoxZV7djMy9oV+aGq2vQ7UsjJdd3VDlrrQ/8IkNUHdQDpn7wb
         yKOuORq56obH9+mfqnLPKN4MfNqZeJfSi6UNJo6FDOYmll/+z8sLIwumQSZnoVzCxzcv
         CkVg==
X-Gm-Message-State: AOAM532d2GP/KADkDWHxx+jZEPPoIryRzAk9gPjHeJ8uFcKnM6FgeGag
        k9CB3jf42G0FKvfSXOpx/lKXtaK1nhcZPXQ9L/mPSjzRzyDaL4snTitSew7Ay0C2D6SOEX4qiMx
        zsVPYAPHhS/nR7+QYDU5WXTxmOH7W
X-Received: by 2002:a17:90a:d684:: with SMTP id x4mr4400978pju.244.1638261377431;
        Tue, 30 Nov 2021 00:36:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyd8GIE6ShFTJjNUz9rIv3i6CwFmtvx34oUHqnZYANefLtL9MmSjoW2Td/4PDJWw3GcPRdKxg==
X-Received: by 2002:a17:90a:d684:: with SMTP id x4mr4400958pju.244.1638261377196;
        Tue, 30 Nov 2021 00:36:17 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id m24sm14190575pgk.39.2021.11.30.00.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 00:36:16 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: sa1100: Fix a wild pointer dereference in sa11xx_clk_init()
Date:   Tue, 30 Nov 2021 16:34:11 +0800
Message-Id: <20211130083412.68732-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sa11xx_clk_init(), the return value of clk_hw_register_mux() is
assigned to hw, and there is a dereference of it in sa11xx_clk_init().
clk_hw_register_mux() is a wrapper of __clk_hw_register_mux(), which
could return a ERR_PTR on error, and lead to a wild pointer dereference.

Fix this bug by adding a return value check.

This bug was found by a static analyzer. The analysis employs
differential checking to identify inconsistent security operations
(e.g., checks or kfrees) between two code paths and confirms that the
inconsistent operations are not recovered in the current function or
the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

Since I do not have a sa1100 machine, I can not actually evaluate this
patch.

Fixes: d6c8204659eb ("ARM: sa1100: convert to common clock framework")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 arch/arm/mach-sa1100/clock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-sa1100/clock.c b/arch/arm/mach-sa1100/clock.c
index e8691921c69a..5b4d8e556ad2 100644
--- a/arch/arm/mach-sa1100/clock.c
+++ b/arch/arm/mach-sa1100/clock.c
@@ -127,6 +127,9 @@ int __init sa11xx_clk_init(void)
 				 ARRAY_SIZE(clk_tucr_parents), 0,
 				 (void __iomem *)&TUCR, FShft(TUCR_TSEL),
 				 FAlnMsk(TUCR_TSEL), 0, &tucr_lock);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+
 	clk_set_rate(hw->clk, 3686400);
 
 	hw = kzalloc(sizeof(*hw), GFP_KERNEL);
-- 
2.25.1

