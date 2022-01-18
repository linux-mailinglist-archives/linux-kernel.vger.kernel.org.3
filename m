Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F94B492098
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 08:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237252AbiARHxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 02:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343636AbiARHxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 02:53:00 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B47FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 23:52:59 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id 15so20575009qvp.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 23:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VBlOWvyY2SmpZB2Tqnzs1ZgQLC9p2YmtpYpG/cWvBw4=;
        b=Y+QDTdJW+XOFpy+w4shaBvWJSumKU6nS7ZMm6ReG5uupqHvDtl1AQAOXO0bg6PT/s7
         8gAhxlL4njWthXWa8/UvIMxfVoARJLPbbAFzrELf1Pd9wGcz7uVT+sd6MeJtF9FHQxHI
         Jl1QcF/SwyoaJwJfRieK1IknT8G7iUhv8jjjZvvxYxfOx3SdxYHp3cf14TYW0l0IGGCt
         Rpm4UYSdog2ONxDwxFd4kl2fJcn2gvSgks2xf6/ROiQnx6NpaZrdUgAYWmgaRFC89Uqp
         XT+ZG+fAPu0vBxzYYqfuL9f8ziH8vtP+n6JLla9MU8ajdXWbj6it/j0yXPRF56kAD+hV
         rQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VBlOWvyY2SmpZB2Tqnzs1ZgQLC9p2YmtpYpG/cWvBw4=;
        b=wcyD8XKHL1y2FaWEN1dCW9S7xMrabNwH8hJJmeYfyu7IAgZ+1MWnTU2ZrMSOi30f/Z
         D0iUHUJITqZne0QlYm3mNKFqaIM1skX7nIwdrh0ERJty+8vssAe3xXPN74kBf6ICPWOd
         t7mr5zV9Aq6nJ3QUiVbquNxiDTJV2LH88THfCpUnUVUXpHqIz8iuF9lKuYr0TcuHqU94
         Let6h1lzanxuTrOs6LNuHjnqIUPU+Qjp45DBycN6vO7V9nmbK6IyT0ZRBaBUfAV5Yb2a
         5yANJnp5CJf9skOgpV9GLqkCZP3ocmzIJVEBIGpi0GCerbIElsKH1klDStQgGV9g+HAC
         izvQ==
X-Gm-Message-State: AOAM530b2B1SYrn0GKAjIDvlUQimoBRsMj8tCcfYglmotRnIBQ2mgLsC
        K3TcoxFaYurx7WMhtLIRULg=
X-Google-Smtp-Source: ABdhPJzf9SYlLCupfoYWn6qvRNV7M6JE5qKHdoaCT2448kfZJsuLn51JrTLymofObBG949m4H1eU/Q==
X-Received: by 2002:a05:6214:21ea:: with SMTP id p10mr21593510qvj.65.1642492378797;
        Mon, 17 Jan 2022 23:52:58 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id w17sm9347975qtj.58.2022.01.17.23.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 23:52:58 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     benh@kernel.crashing.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH] drivers/macintosh/ams: remove unneeded result variable
Date:   Tue, 18 Jan 2022 07:52:52 +0000
Message-Id: <20220118075252.925616-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value from i2c_add_driver() directly instead
of taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 drivers/macintosh/ams/ams-i2c.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/macintosh/ams/ams-i2c.c b/drivers/macintosh/ams/ams-i2c.c
index 21271b2e9259..d2f0cde6f9c7 100644
--- a/drivers/macintosh/ams/ams-i2c.c
+++ b/drivers/macintosh/ams/ams-i2c.c
@@ -256,8 +256,6 @@ static void ams_i2c_exit(void)
 
 int __init ams_i2c_init(struct device_node *np)
 {
-	int result;
-
 	/* Set implementation stuff */
 	ams_info.of_node = np;
 	ams_info.exit = ams_i2c_exit;
@@ -266,7 +264,5 @@ int __init ams_i2c_init(struct device_node *np)
 	ams_info.clear_irq = ams_i2c_clear_irq;
 	ams_info.bustype = BUS_I2C;
 
-	result = i2c_add_driver(&ams_i2c_driver);
-
-	return result;
+	return i2c_add_driver(&ams_i2c_driver);
 }
-- 
2.25.1

