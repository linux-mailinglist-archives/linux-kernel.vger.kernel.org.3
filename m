Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518FB567298
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiGEP2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiGEP2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:28:09 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134FE19298
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 08:28:09 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id b2so11248220plx.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 08:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=d982/aSW19dbRHulNAiy7axeXdDcRD3fsM+YQicazi0=;
        b=EKdjMKfs452wCzel49Z3vg4sLT3orBHKGXGCCJagraRHEw1bZxyGDTvoSE7VQ1CxPs
         3LfQR5W0Y1EYGPwK0SqOuya3qRP9M76JmGu904uF9n+VqSQ3I5EYKWmA2INsJV100fYY
         fhpqd7nBIneF8wZXjlILq/Fg6dM+VbULw50xCP+6UVWMp3XPt7XnugGrNh46kPF79FJM
         wu66cmQp22JLEn+EEoGUpq0sx2dQaIcv0MQLXbNkt3XF2L/G6hYC/14s2HMlO16d8vSv
         EwH3FnOHNqKBtJxxSJyUf1C+3pBUDQcav9xw3z3BZnbdbK6sweYNS5H6jbbsofOCZJbE
         EqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=d982/aSW19dbRHulNAiy7axeXdDcRD3fsM+YQicazi0=;
        b=0LhZT9B+ABwD/nrXuY6FJ58ml17k55mqTGSL0qr4kDU+2zhg76JrHT6BSsUaQTl+AB
         Q1ku3SLk/y6gRRG6cp0KfOW9YSNh1RwffZJM22eR+a53EdoyzPssjvpSM/wZU7hKjgI7
         njmXhIIKr9EfTSX+IdeB3PYtrtpKlvnqIYWwyrHb9+REcuBdvdOvLn2/JKOsdkrEwGrC
         P6GH8cbbk/VkLhWQaHj9Z0fSNeZZGsK9hY56U1HdoGWfm9o3lRyDR3l55qFBpDhE5keb
         M+ELba1K7haP5ny4tiRAL09EDDucMqGbUA1Ioaa75rHQ4J58NPGNoyy7zu2ACBUdvevK
         sQdg==
X-Gm-Message-State: AJIora9iSxCsW0SmOwc3wvpRm14YNwg9jcFYQbpkfSUApZLP+8hw934y
        4n9MhWC6g51ymSD63KAJOlxxcSctBZJmZSRz
X-Google-Smtp-Source: AGRyM1vDQwSAbOSLALJx7Y4mNzY32EQ2hCpyPUHIPWR6/ZdKQfIcFthzQwOB6UAAThcQ0MYczR+UbQ==
X-Received: by 2002:a17:902:8344:b0:16a:6e99:de2c with SMTP id z4-20020a170902834400b0016a6e99de2cmr41916987pln.130.1657034888573;
        Tue, 05 Jul 2022 08:28:08 -0700 (PDT)
Received: from localhost.localdomain ([120.227.32.112])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902ce8400b0016bf4428586sm1641471plg.208.2022.07.05.08.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 08:28:08 -0700 (PDT)
From:   Luo Xueqin <luoxueqin66@gmail.com>
To:     jk@ozlabs.org, joel@jms.id.au
Cc:     alistair@popple.id.au, eajames@linux.ibm.com,
        linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Luo Xueqin <luoxueqin@kylinos.cn>
Subject: [RESEND PATCH v2] fsi: Fix typo in comment
Date:   Tue,  5 Jul 2022 23:27:57 +0800
Message-Id: <20220705152757.27843-1-luoxueqin66@gmail.com>
X-Mailer: git-send-email 2.15.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luo Xueqin <luoxueqin@kylinos.cn>

Spelling mistake in comment.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Luo Xueqin <luoxueqin@kylinos.cn>
---

v2: add discoverers

 drivers/fsi/fsi-master.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-master.h b/drivers/fsi/fsi-master.h
index cd6bee5e12a7..4762315a46ba 100644
--- a/drivers/fsi/fsi-master.h
+++ b/drivers/fsi/fsi-master.h
@@ -51,7 +51,7 @@
 #define FSI_MMODE_CRS1SHFT	8		/* Clk rate selection 1 shift */
 #define FSI_MMODE_CRS1MASK	0x3ff		/* Clk rate selection 1 mask */
 
-/* MRESB: Reset brindge */
+/* MRESB: Reset bridge */
 #define FSI_MRESB_RST_GEN	0x80000000	/* General reset */
 #define FSI_MRESB_RST_ERR	0x40000000	/* Error Reset */
 
-- 
2.25.1

