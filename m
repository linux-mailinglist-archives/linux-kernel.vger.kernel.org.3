Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33462462F7D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 10:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240129AbhK3J1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 04:27:55 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:35388 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240123AbhK3J1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 04:27:54 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 4J3GyC4BG8z9vC8C
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 09:24:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Rw2wextg1wpm for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 03:24:35 -0600 (CST)
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 4J3GyC26zGz9vC7k
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 03:24:35 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 4J3GyC26zGz9vC7k
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 4J3GyC26zGz9vC7k
Received: by mail-pg1-f200.google.com with SMTP id o11-20020a635a0b000000b00320daef2ad6so10015059pgb.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 01:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Kpv95WvUkW/Ud7pYJF6QRY1ECX/+UULSLWzxdPLIgk=;
        b=Fw5Z8AyCfUSIgxqiupoCR9sjMbdmQ29AFdnEjQPhopEri3nPVfkJbbGXd6nS/bLtFS
         zJ1IE20IzWpQ5+g4mkZh0efIGFxNISOolZx8KzAjvK62U2xWPwSELLRUFvMzGdRQgGjK
         3JSQdoGAolMpLrYM08uIBskshSCFQI0Ku+X4icBsRT1XAZDWFNO6iHcOvhMVfqpAP/gz
         Cu75DjY0gzdTU1ghoWOTAOwBmjSMMMYX0mmH+jO45HeRyCOYnPkSsBLqBwGPhZt5TLx5
         v1IMQ+rr7RXzh5BohSs3s98ln71POKNNZhxZbNolKcIT9KWiYqbbhtypq7744QDgI+pg
         RudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Kpv95WvUkW/Ud7pYJF6QRY1ECX/+UULSLWzxdPLIgk=;
        b=yUgYysGR5NH2MgOWaOCqP5LN9UFdSbKgRRQJmmMuAKGmLEBUm+P/6mWjnQz/rlC2ra
         yS7XkD3D358ZJ6NqcsTTnBOwEOVvTG+3wveRt1AK30n3Aa1wlcHUuI3lfLpe8JZkofK5
         hID8nRmuLyGYkIIzrROKIrMCqnIYcf/iDAOgfHrf+bBMYiSfiZNU2cEVBwAqx/25qDUC
         /uyz0vYoLjfFzOjjED62bAsUUM7+nHF5CJ7O+JClKISs1CEE3fbD0DWwtnld6hjrmLBD
         EZ4aZsq2jcZHgTn5Q+kVcfnHdOkUfI918VN67Yo5uR38SL4rQFSp0mwcWG0VFQEuoCHb
         hzXQ==
X-Gm-Message-State: AOAM531pqAFyDdGvZeU8oiN1S1PJZ1vR2bqwbsHIK6EbTA7KjcR3b1+9
        XVb+R2qOQH/4s850xfu9rmJIJeEOZMiyQ2XhEolBN+H6HxGzmBzMxRTDq1c3CKFp4JB3/NBlKDp
        xPX29jpLiU1swSdKljSgl3LXCgtD6
X-Received: by 2002:a17:90b:8d6:: with SMTP id ds22mr4588535pjb.194.1638264273957;
        Tue, 30 Nov 2021 01:24:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwDBGO+aaLim+LpVySQCOJYODPf3ehU0UEx5GMCZAkK4vXF25CONHenek8Yf1aGNTHZ8rqCww==
X-Received: by 2002:a17:90b:8d6:: with SMTP id ds22mr4588512pjb.194.1638264273756;
        Tue, 30 Nov 2021 01:24:33 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id b8sm1921015pfr.213.2021.11.30.01.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 01:24:33 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miles Chen <miles.chen@mediatek.com>,
        mtk01761 <wendell.lin@mediatek.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: mediatek: mt6779: Fix a NULL pointer dereference in clk_mt6779_apmixed_probe()
Date:   Tue, 30 Nov 2021 17:24:26 +0800
Message-Id: <20211130092428.82262-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In clk_mt6779_apmixed_probe(), the return value of
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

Builds with CONFIG_COMMON_CLK_MT6779=y show no new warnings, and our
static analyzer no longer warns about this code.

Fixes: 710774e04861 ("clk: mediatek: Add MT6779 clock support)
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/clk/mediatek/clk-mt6779.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt6779.c b/drivers/clk/mediatek/clk-mt6779.c
index 9825385c9f94..f22bf4025f55 100644
--- a/drivers/clk/mediatek/clk-mt6779.c
+++ b/drivers/clk/mediatek/clk-mt6779.c
@@ -1217,6 +1217,8 @@ static int clk_mt6779_apmixed_probe(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
 
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
 
-- 
2.25.1

