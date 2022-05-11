Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD87152386C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344532AbiEKQQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344507AbiEKQQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:16:35 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B92C289AE;
        Wed, 11 May 2022 09:16:31 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id n8so2369146plh.1;
        Wed, 11 May 2022 09:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T8SQnMh/E47vyAFUdZ40OQGlgYRHYSg3xuunTb/Du/8=;
        b=UMRQlDUpHvGDtuxCLGMBIl7V5WH0H2JGBXDBZLs0kLQeqFdcdz2jtDhZi/3LQ51eCp
         5Y/yMK9Ul3ZvtSECQ6HPI+YDdn5ARpxzUIDADporJbJWKK2Ck4pnZ5V8pR540/FDJ0BN
         3qFJ4TXIWeddfpKb1MZAOPWHozu7KmPFLJ5RC8xGSC/N97amDSZ1UUuXpt+gjKxvq4yp
         +ufs5irtJMDXqi42aY2P4BqdncX7EmnAznh+TOn0KRg7ZzTnu2WEwLGtbDbshtWZxgDi
         MTWmH/YnxOAhl68ZP2eT2CwYP9296yREAZGGOevBumnTH7DUkbSZlx38kAS+OCDnzSr0
         RmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T8SQnMh/E47vyAFUdZ40OQGlgYRHYSg3xuunTb/Du/8=;
        b=m/zO8wQIeKf3IPef5Qnm49Pxg1wCzJz3oxxOMwEPU0jwHvSGFEkt9KMFyA/0tC8YIA
         nWBbwjwTLOd0atUZ3tzBqzbRH/pTJkKUgKg64rVHUdOZ7XKxtOWfS/OtjUJAYd8P/ITz
         fQ75eVu/BhBo7HoTWg/uLuDDChdbT0eJvbEAMv61YcV1XL7VJRnuMNieIRk7tJHnQVWo
         7KLXOWzAhI5ZJR4zwnyUggtEFUo411LGXv6MK6kpmf/4+43pdLmjQnydbMF5lrUU+eiJ
         GmmI2A52+7w7WhhOI2PoA9ywnNfm2NcYGzLgMeiMXToyIH9HDBSTeEaUhX6tEkKM6JmL
         pKDg==
X-Gm-Message-State: AOAM530rmaZdVpqJGYsmxLcYM4atHAddMTscCA5KPkGP+QNGCNAW2xeu
        P/j5wwM+A/TTT+FQVgxe2AGpwoJV5Vh8hhyS
X-Google-Smtp-Source: ABdhPJw0c010EfWZkhOqxKl5sGlODUoeowe3AkbSVN6wOwgWZAvTuuqkP9et6hRVLXxgLW9HgkmSJg==
X-Received: by 2002:a17:90a:ce13:b0:1d9:acbe:7ede with SMTP id f19-20020a17090ace1300b001d9acbe7edemr6229030pju.16.1652285790359;
        Wed, 11 May 2022 09:16:30 -0700 (PDT)
Received: from skynet-linux.local ([49.204.239.218])
        by smtp.googlemail.com with ESMTPSA id x7-20020a17090a1f8700b001ded49491basm220322pja.2.2022.05.11.09.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 09:16:29 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     linux-remoteproc@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH 3/9] remoteproc: qcom: qcom_wcnss: Add support for pronto-v3
Date:   Wed, 11 May 2022 21:45:56 +0530
Message-Id: <20220511161602.117772-4-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220511161602.117772-1-sireeshkodali1@gmail.com>
References: <20220511161602.117772-1-sireeshkodali1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Lypak <vladimir.lypak@gmail.com>

Pronto-v3 is similar to pronto-v2. It requires two power domains, and it
requires the xo clock. It is used on the MSM8953 platform.

Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
---
 drivers/remoteproc/qcom_wcnss.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wcnss.c
index 9a223d394087..add792d752ba 100644
--- a/drivers/remoteproc/qcom_wcnss.c
+++ b/drivers/remoteproc/qcom_wcnss.c
@@ -141,6 +141,18 @@ static const struct wcnss_data pronto_v2_data = {
 	.num_vregs = 1,
 };
 
+static const struct wcnss_data pronto_v3_data = {
+	.pmu_offset = 0x1004,
+	.spare_offset = 0x1088,
+
+	.pd_names = { "mx", "cx" },
+	.vregs = (struct wcnss_vreg_info[]) {
+		{ "vddpx", 1800000, 1800000, 0 },
+	},
+	.num_pd_vregs = 2,
+	.num_vregs = 1,
+};
+
 static int wcnss_load(struct rproc *rproc, const struct firmware *fw)
 {
 	struct qcom_wcnss *wcnss = (struct qcom_wcnss *)rproc->priv;
@@ -669,6 +681,7 @@ static const struct of_device_id wcnss_of_match[] = {
 	{ .compatible = "qcom,riva-pil", &riva_data },
 	{ .compatible = "qcom,pronto-v1-pil", &pronto_v1_data },
 	{ .compatible = "qcom,pronto-v2-pil", &pronto_v2_data },
+	{ .compatible = "qcom,pronto-v3-pil", &pronto_v3_data },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, wcnss_of_match);
-- 
2.36.0

