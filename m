Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AEE4E4CB1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 07:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241953AbiCWGXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 02:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiCWGXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 02:23:51 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1202C710D6;
        Tue, 22 Mar 2022 23:22:22 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-d6ca46da48so721955fac.12;
        Tue, 22 Mar 2022 23:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=grFZwEsQWpWncst5X+cDiG4KOzVxeLA+y9QLQa2rrmQ=;
        b=I+do0ehq1vQ7xsIvxZ2qrFFOCrx8RKyYGDgwiB33K132241YVdJ9rdtJlpaUM6D6Em
         lv8Z5Ycm/z0cjZOR6LoCYoCkFMq5QdCC47ECKkhj7KaOaedGBH4/VZ1tk8TFDX6hs2Dq
         cw347VhHFht8tTwvkCs/rrzDIgvpLKO55PZtHGocmO9EkKJJQ8t2aNG8sR/fABm/sxeb
         YUDpJK9JweeO31WEWvLKzE+KyTkUt7BJbjHFy06JfTzrpICy7eIUYkHrKsSpJHowste6
         9sMFomrdOREveqnxVVyMDDZWYdLrMJ1gjG3UA7t3dDGny5xN84joC+6LZCYlz1kpgxAR
         fm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=grFZwEsQWpWncst5X+cDiG4KOzVxeLA+y9QLQa2rrmQ=;
        b=ujT6zWF7z8r48K6pg5wGqmUuY+vdtYvQC3kZ6mMb0OIbAsQ0AiIKYh55ffNpSOABJP
         ySOWpTd+tNtXMadoPW7Yid9KjHk/vvfQZAHi6hvZENugFa0qPT8DwDd/6rw7oWGsUjLV
         LnkbAUSMe/74unMNJj1ksm2vIBJzEm/HkQEuHIVxLNshilAJ+m7dNcV6qeQtLbvdvcPm
         4pbZGAHTeJ4z5Bu1c4xUbZy/09Igab2AFkBEubw5aNURH8XwwTm0w1RH7M2azIpcWuR/
         3zwQ+wOICbdd0sXjusLQTRvR2fUKr4lsl8OhUmrLq7kY/+JpKXaA4gi0ucpxoD7++dIY
         lJ6A==
X-Gm-Message-State: AOAM530enQD1PSL3hOENqCScOpTui3dU0/Q44bxpyqmtNqctyI6pxVXW
        Q/wSsNshAQ0AfxhTI5h5/ZP+8lxFxeQ=
X-Google-Smtp-Source: ABdhPJzKQZaR2GpNXw3rxv0Xx0KJvZWCO17cET/0Wv+JDuiUN/a1dNNcAvDFm1GSHH4EsaPOPSA44g==
X-Received: by 2002:a05:6870:4617:b0:de:7c85:37e6 with SMTP id z23-20020a056870461700b000de7c8537e6mr60283oao.169.1648016541028;
        Tue, 22 Mar 2022 23:22:21 -0700 (PDT)
Received: from localhost.localdomain ([187.39.20.187])
        by smtp.gmail.com with ESMTPSA id 22-20020a056870111600b000dd9d1d656dsm8405550oaf.2.2022.03.22.23.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 23:22:20 -0700 (PDT)
From:   Diego Viola <diego.viola@gmail.com>
To:     damien.lemoal@opensource.wdc.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, Diego Viola <diego.viola@gmail.com>
Subject: [PATCH v2] ata: libata-core: fix "it's" typos
Date:   Wed, 23 Mar 2022 03:21:50 -0300
Message-Id: <20220323062150.25229-1-diego.viola@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use "it is" instead of the possessive form "its".

Also, replace "isn't" with "is not" and add a missing comma.

Signed-off-by: Diego Viola <diego.viola@gmail.com>
---
 drivers/ata/libata-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 0c854aebfe0b..7d5d0dbcfdc5 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1398,7 +1398,7 @@ unsigned long ata_id_xfermask(const u16 *id)
 
 		/* But wait.. there's more. Design your standards by
 		 * committee and you too can get a free iordy field to
-		 * process. However its the speeds not the modes that
+		 * process. However, it is the speeds not the modes that
 		 * are supported... Note drivers using the timing API
 		 * will get this right anyway
 		 */
@@ -5603,7 +5603,7 @@ static void ata_finalize_port_ops(struct ata_port_operations *ops)
  *	Start and then freeze ports of @host.  Started status is
  *	recorded in host->flags, so this function can be called
  *	multiple times.  Ports are guaranteed to get started only
- *	once.  If host->ops isn't initialized yet, its set to the
+ *	once.  If host->ops is not initialized yet, it is set to the
  *	first non-dummy port ops.
  *
  *	LOCKING:
-- 
2.35.1

