Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F375E463C1F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244233AbhK3QsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:48:05 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:55440 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbhK3QsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:48:04 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 4J3Sk44n7Cz9vwRk
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 16:44:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bOFkWnvaLVpq for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 10:44:44 -0600 (CST)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 4J3Sk42gHLz9vwRh
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:44:44 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 4J3Sk42gHLz9vwRh
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 4J3Sk42gHLz9vwRh
Received: by mail-pj1-f71.google.com with SMTP id gf12-20020a17090ac7cc00b001a968c11642so10139431pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PaeiLQYvyxb/egvfxneLGShNKX/REnwSjHvw37uaFCI=;
        b=kAglzTGrPgxrNYWpODLwneomdarMnjBmCEYpHzg0mlyiVGI8yhZ1Xw14DA/bayXBVe
         Rvl0VOLQ4PfZsfMPAOYNe1uRNZ/53wiOyS0KL4koX1fOTDxWq1OVasd1H4ZR9Aa2cgaM
         i/VZuQjRQU2Sx1fZrVJR6rdTlzlBy+67tzFvX2W5cyv5ykIfljv8lbxm/GjagVUZdbPa
         sNkJmQWE+BWadlmYSikko3EY6/p7tfaEbzuyTL1h5+ZsuquCHRc8Pi3j5+kHCz+Aqj8w
         +IAQ4N1+Ngwj6jGwvH/wLj0k9cHN/35oFv4MTr8NUyK1IblMMUC8X10oBjhpBJ3Bnnav
         kQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PaeiLQYvyxb/egvfxneLGShNKX/REnwSjHvw37uaFCI=;
        b=UO8k5ZbVHV7Q8zOLVqupAOxFQ5I86fH+wJEEiJsq4oAI/XngFFma7i/S+khsrbWqtu
         uT6AP68d5dqr40m4Kac4daTgJazfmhEL7PJStQZgoC0dRUyTvQ3GknlpiRc9cSdtLcAc
         i9yv72r0gIH0dP8CppwbkVWQN8+zO9zZGEm9qwhmbfNLw9bVBtQKnPsUaGVvuzWLTkRo
         LDzCh2IygA+54x8e9utzY2o7/soiU8iaLlxIVmzwUULF2vy61smhOMZJZB/XURN146a+
         T13KgVxQUiyhHorWOR4bCxFHW7RILONi3G2rFLoFA5TlIjjmDwrLsE4JEzreqhTTaIr+
         hIGA==
X-Gm-Message-State: AOAM533oLhIveH28CXXDH0eQhfMLv0NEru7fiBbclwBLswE8A55whFa9
        1R5NkwIK5QNLRdO3BjfPopXQOoa07MJT+TcQ7hf7bZmS3X1QkmxG3vWaoD2g/OGbNO13SpwRIA5
        odcA77v7EFaeV8S1afrHr/6iLbmCj
X-Received: by 2002:a17:90b:1b4b:: with SMTP id nv11mr33540pjb.131.1638290683711;
        Tue, 30 Nov 2021 08:44:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx6D96bJSvgqWrNljSraQswVWeIyQsJHaWNZcj0Nla/JfAsxMD4xnJDOQqOo92m0zTctmI0rw==
X-Received: by 2002:a17:90b:1b4b:: with SMTP id nv11mr33518pjb.131.1638290683492;
        Tue, 30 Nov 2021 08:44:43 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id c35sm15304312pgm.67.2021.11.30.08.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 08:44:43 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Tariq Toukan <tariqt@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eugenia Emantayev <eugenia@mellanox.com>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net/mlx4_en: Fix an use-after-free bug in mlx4_en_try_alloc_resources()
Date:   Wed,  1 Dec 2021 00:44:38 +0800
Message-Id: <20211130164438.190591-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mlx4_en_try_alloc_resources(), mlx4_en_copy_priv() is called and
tmp->tx_cq will be freed on the error path of mlx4_en_copy_priv().
After that mlx4_en_alloc_resources() is called and there is a dereference
of &tmp->tx_cq[t][i] in mlx4_en_alloc_resources(), which could lead to
a use after free problem on failure of mlx4_en_copy_priv().

Fix this bug by adding a check of mlx4_en_copy_priv()

This bug was found by a static analyzer. The analysis employs
differential checking to identify inconsistent security operations
(e.g., checks or kfrees) between two code paths and confirms that the
inconsistent operations are not recovered in the current function or
the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

Builds with CONFIG_MLX4_EN=m show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: ec25bc04ed8e ("net/mlx4_en: Add resilience in low memory systems")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
index 3f6d5c384637..f1c10f2bda78 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -2286,9 +2286,14 @@ int mlx4_en_try_alloc_resources(struct mlx4_en_priv *priv,
 				bool carry_xdp_prog)
 {
 	struct bpf_prog *xdp_prog;
-	int i, t;
+	int i, t, ret;
 
-	mlx4_en_copy_priv(tmp, priv, prof);
+	ret = mlx4_en_copy_priv(tmp, priv, prof);
+	if (ret) {
+		en_warn(priv, "%s: mlx4_en_copy_priv() failed, return\n",
+			__func__);
+		return ret;
+	}
 
 	if (mlx4_en_alloc_resources(tmp)) {
 		en_warn(priv,
-- 
2.25.1

