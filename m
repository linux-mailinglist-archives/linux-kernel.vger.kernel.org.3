Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773734AB3E7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237863AbiBGFuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 00:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352002AbiBGEmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 23:42:49 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA3CC043181
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 20:42:48 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id i5so15798196oih.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 20:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9B7hEs0KWcQeTdm4T9H3BJwl4p0pXjpU9Q2BlklK5nw=;
        b=ogHtHZj5pYia9KG+9lnOx+hJUMVnASvfP2FaPZEG2F1hARL0ApwxjQ9fYXzFhdXe+w
         34eaBy8AGjbXUWPk7izMMi5b6gTWfr4/dJxp5rzqd/3maLLnmDXsUoEtgi/Bv67F3/E4
         qA68/1GFCvE5S9vQNq+E+noZH8k3MDZLsn+nXeprmVzS0tXxi3Ft1zSb/GRJa/SiYMyX
         BlEqtHX7AbkvcmLfkvrliCn039B9Q4pXQ+FAzMiDWx8TLD5H7rPZ3f3b6PlHcj6CctNP
         gQbUbYO8QNa+VUU2ar6zZrlQ0R3tcFTG1z8P7IkYaHPoGSn52swUTZCKEr/MSGEOVG7Q
         9OEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9B7hEs0KWcQeTdm4T9H3BJwl4p0pXjpU9Q2BlklK5nw=;
        b=QotZ0IRB8vOQ2cROYfq3oqhzxVIFvdvMooT0cgvlwVSO7xym7IWNSCYvKaGtLsNanS
         PpgwkAHaQp0ZtTLltc07MRcLgew/lryF+HfXtTJlC4Q1pOLvUvwoW1iKEKHVfgolgdXQ
         gxdgW+OoXEqGDF0/dckNCa9CAA5JmQsIb32fTAtZTPFVCBpqExafogXGVPsRRSBJ03cG
         wlLLedqg40ZycsRUN2oUgnN52IEUf04WMEon6IW+3YWTtgIqFfENruABYlDg19MkGdeS
         BoykKbd9iINYzjIvLUFheioKUNgqGK1fGTfPKRbpyyGViVGKNbqjEBkHwThvBOvOuEVq
         o05g==
X-Gm-Message-State: AOAM533vkZvTJsHmAY0SuPaPcWLsnFUNzqazsAMljRGoCgxSGXHM1Z2c
        CFP1VaQGz8IUUct+qut+5sY=
X-Google-Smtp-Source: ABdhPJxu2M2k7b/YsVOzH6NSYTjv7KOW6x56V4qPUAjyREt2tF9FM+ULRbOweDMT/chJW/bYqeQsiA==
X-Received: by 2002:a05:6808:2188:: with SMTP id be8mr4597474oib.63.1644208967876;
        Sun, 06 Feb 2022 20:42:47 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:4cd8:12bf:4134:806a:5a4a:2a88])
        by smtp.gmail.com with ESMTPSA id f21sm3515752otq.4.2022.02.06.20.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 20:42:47 -0800 (PST)
From:   Leonardo Araujo <leonardo.aa88@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        sparmaintainer@unisys.com,
        Leonardo Araujo <leonardo.aa88@gmail.com>
Subject: [PATCH] Staging: unisys: visorhba: alignment should match open parenthesis
Date:   Mon,  7 Feb 2022 01:42:30 -0300
Message-Id: <20220207044230.19918-1-leonardo.aa88@gmail.com>
X-Mailer: git-send-email 2.29.0
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

Fixed a coding style issue.

Signed-off-by: Leonardo Araujo <leonardo.aa88@gmail.com>
---
 drivers/staging/unisys/visorhba/visorhba_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/unisys/visorhba/visorhba_main.c b/drivers/staging/unisys/visorhba/visorhba_main.c
index 8eee131e834d..48aa18f8b984 100644
--- a/drivers/staging/unisys/visorhba/visorhba_main.c
+++ b/drivers/staging/unisys/visorhba/visorhba_main.c
@@ -192,7 +192,7 @@ static struct uiscmdrsp *get_scsipending_cmdrsp(struct visorhba_devdata *ddata,
  * @result:   The location to place the result of the event handle into
  */
 static int setup_scsitaskmgmt_handles(struct xarray *xa, struct uiscmdrsp *cmdrsp,
-				       wait_queue_head_t *event, int *result)
+				      wait_queue_head_t *event, int *result)
 {
 	int ret;
 	u32 id;
-- 
2.29.0

