Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24AFE49851E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241196AbiAXQpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:45:42 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:60474 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243781AbiAXQpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:45:33 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 4JjG7c3pSbz9vC8y
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 16:45:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xHppgTBzXuJD for <linux-kernel@vger.kernel.org>;
        Mon, 24 Jan 2022 10:45:32 -0600 (CST)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 4JjG7c1k7jz9vC8v
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 10:45:32 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 4JjG7c1k7jz9vC8v
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 4JjG7c1k7jz9vC8v
Received: by mail-pl1-f197.google.com with SMTP id cp2-20020a170902e78200b0014a9f3e3c1fso3626869plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 08:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=djkJvPzkQRLMPwigXx2q/PnzxUoF5zQXKI2ZeQZ9B6s=;
        b=fOZiKfn07UXaKCOkHaNtClM/MEf7BTq75piNz4qWhO2dhkvJy68A9cl1/+jEOut2YN
         gvEhq+1z93ib+Z/QOL88narBG7FiUZVlN2ZbG22nXv95XFg2eaw37iwJXHYBH1WD3imF
         +JeffRTJ0NXXNAB/o+0YmFvtWuptqmmX9W4W/WnREepCUxSh98vU7xJKazuOi8FpFXwP
         5e/YLd1g25nruFJInu4sqgyCahvJSrE9pULL3PKKsjjOWEQO92itWZ+/m3OkdUtvkdAs
         nmUjZM+bDJZRRysa2EUeQ6QoVGNUHOY4HDad8G5RWETVjI5Uyz7ZVHzfzrIiYjjFgvFD
         GTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=djkJvPzkQRLMPwigXx2q/PnzxUoF5zQXKI2ZeQZ9B6s=;
        b=AJ5UgqM/fo14mWGd29bj/+SCgOMM2YXcuo5jroRUvpYjo5DqnqSjkTC9Y4kPSLct1o
         xofVK8M0tcD6xxzisakXkWCTbLpRf3R/Kb/HDDawvi6/3z5U+cXsm016GF1sCXXYkglR
         kM3tl086GTtqKCIawh4jwSpVZcJXCD/dsgkOde6Ckl/s2JAQ63f4NbB3d9lOoojxqMn4
         F5hGZZqO1jyS5gvDUbFl9dTKneahb3SsjNhvOeTGDW14Z1YAhKLxtjyk1hOPG6OXI2dJ
         C3ujnqeF8BCYWhC8NaaVfV6Wz1sVeUfOsXtLH+8I+u+9PamHVoHyWe7GhAu6h2eKThQU
         yl9g==
X-Gm-Message-State: AOAM530/QYkcXCYPmqHjbENaPbQjk5M5Ck32C7w/LvW76uRu2YNYUtBx
        QBACkp4gKdDL442iGw/ZXZKgfJXN9OK78lp1/QzFBZnhnHVMuBEDqb/DEMk0u2mi/F/9BBBZbMz
        JqyHh1LeIAMpGWyKk/SAwbE8dRhOo
X-Received: by 2002:a17:902:d4c1:b0:14b:4a0b:79bd with SMTP id o1-20020a170902d4c100b0014b4a0b79bdmr6444148plg.170.1643042731390;
        Mon, 24 Jan 2022 08:45:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwpyQjGPPn2EhhJAhMlokks0xQvRxA7QZE9Ic+dNtUz3PJOX2gO13nba6OZiazWAlZ8Qi83jw==
X-Received: by 2002:a17:902:d4c1:b0:14b:4a0b:79bd with SMTP id o1-20020a170902d4c100b0014b4a0b79bdmr6444129plg.170.1643042731180;
        Mon, 24 Jan 2022 08:45:31 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.4.61.248])
        by smtp.gmail.com with ESMTPSA id z14sm8151922pfq.3.2022.01.24.08.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 08:45:30 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ata: pata_platform: Fix a NULL pointer dereference in __pata_platform_probe()
Date:   Tue, 25 Jan 2022 00:45:25 +0800
Message-Id: <20220124164525.53068-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In __pata_platform_probe(), devm_kzalloc() is assigned to ap->ops and
there is a dereference of it right after that, which could introduce a
NULL pointer dereference bug.

Fix this by adding a NULL check of ap->ops.

This bug was found by a static analyzer.

Builds with 'make allyesconfig' show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: f3d5e4f18dba ("ata: pata_of_platform: Allow to use 16-bit wide data transfer")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
The analysis employs differential checking to identify inconsistent 
security operations (e.g., checks or kfrees) between two code paths 
and confirms that the inconsistent operations are not recovered in the
current function or the callers, so they constitute bugs. 

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

 drivers/ata/pata_platform.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
index 028329428b75..021ef9cbcbc1 100644
--- a/drivers/ata/pata_platform.c
+++ b/drivers/ata/pata_platform.c
@@ -128,6 +128,8 @@ int __pata_platform_probe(struct device *dev, struct resource *io_res,
 	ap = host->ports[0];
 
 	ap->ops = devm_kzalloc(dev, sizeof(*ap->ops), GFP_KERNEL);
+	if (ap->ops)
+		return -ENOMEM;
 	ap->ops->inherits = &ata_sff_port_ops;
 	ap->ops->cable_detect = ata_cable_unknown;
 	ap->ops->set_mode = pata_platform_set_mode;
-- 
2.25.1

