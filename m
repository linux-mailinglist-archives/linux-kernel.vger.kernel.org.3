Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70BF64688C1
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 01:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhLEAlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 19:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhLEAlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 19:41:14 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43F4C061751;
        Sat,  4 Dec 2021 16:37:47 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id t9so14074867wrx.7;
        Sat, 04 Dec 2021 16:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7VjfZ6s7OTc7tj3N8PNJEcBVhsk9b4bji9ek2g0iMm8=;
        b=QRjIsvieoWsDfUbKAe/qb+/1XMZw7UDe2ZNqCOA/IoJqfT/xmqD4Uerap97yZEreZI
         cAM28FVHU1PtO8BcC9o8Rf7bhMb+O2lxzE1qYL5CRbI5p9FPoQOaSxlrhKXjkJS1upRF
         kQbkWVKcPT8yirzOG6UmwihOE4+SRAZOXmL+L4F4Tdh6vusSA0CmiB7YzAkL0AWORUfS
         BOV0pVelm4uLpXb16CgGeayJmBt5zWV41Air+gbfPt3K1+zfivOlNwBJ23zQMKa4PZ1h
         BlTadp0H5+/XpY70E9mxFHeVzdQF3hMQmuM7hsAaRkNpf+SwBrGUHEdKJklbc9dDNsxn
         EHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7VjfZ6s7OTc7tj3N8PNJEcBVhsk9b4bji9ek2g0iMm8=;
        b=4eDn7nH9W1dBRL6X/mtjbqJZ62Eg+0Bnn9IQAw71803/rMtoD1TUl11bauAoA3wG0o
         1rfNkpYcQJw3/X2ddWfVVAO1J3Jg4SR8eOMsXrjkSEFxbAeXQRW7bdb2WWSOT5fOgBm3
         J0F1gzCQFWBD1qfIDwwVRLVYX3fi4pVBkZO/ScBU5FTuDKvw7MdhG3nrrbU/HJCKPD4m
         Y1FRnWVLtaRgJph683jSGEvzy107azM4tMu8KYooR+BDDcH25hYhWEox8MP3du9mQO9N
         NS25aOJBXOZvMx85UG9M2qo7GKAjsSTdjp1HaHgMMLooYPOxeBJLWsUoeKRBTVy6ym7g
         b7AQ==
X-Gm-Message-State: AOAM530D5XayRDlSWjxB/dWBXI3y2dnsYEHNMuFYrUi3XKokYC7GO1vr
        a4KeuJV+rnM2bcxRmQ1Vosw=
X-Google-Smtp-Source: ABdhPJzFE+gCgORKcPtapxdDM4kC/m0056wPHWLT4KpUmCb7sZ82E83O+cRXsYqLCWNjOgQMAt8FJQ==
X-Received: by 2002:a5d:54c5:: with SMTP id x5mr30920385wrv.607.1638664666339;
        Sat, 04 Dec 2021 16:37:46 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id w2sm6771582wrn.67.2021.12.04.16.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 16:37:46 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: c8sectpfe: remove redundant assignment to pointer tsin
Date:   Sun,  5 Dec 2021 00:37:45 +0000
Message-Id: <20211205003745.227491-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointer tsin is being assigned a value that is never read. The assignment
is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
index 02dc78bd7fab..e1f520903248 100644
--- a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
+++ b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
@@ -930,12 +930,8 @@ static int configure_channels(struct c8sectpfei *fei)
 
 	/* iterate round each tsin and configure memdma descriptor and IB hw */
 	for_each_child_of_node(np, child) {
-
-		tsin = fei->channel_data[index];
-
 		ret = configure_memdma_and_inputblock(fei,
 						fei->channel_data[index]);
-
 		if (ret) {
 			dev_err(fei->dev,
 				"configure_memdma_and_inputblock failed\n");
-- 
2.33.1

