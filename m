Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A5F52B7E0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbiERKVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 06:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235044AbiERKVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 06:21:09 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7F7245AF;
        Wed, 18 May 2022 03:21:07 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id p189so855335wmp.3;
        Wed, 18 May 2022 03:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eUUlK8gFbeLL/gYwSjFGB469B2p9AZAbiDBrzDvrtBo=;
        b=fsf86z7GL8uF7oZ5/oy9mXJ6AULhTE6lCbK45kPP/MAeFwfZ93zHQhHHqEo/CFsHsf
         VwnnkepekExon2JWjTKDoW77pOOFU/NTFA7VcM9vSy1ZhcOddPr/ZcUfD6qV7xZzxcYI
         iSTe4Dp9qLyqM2t5VrPqBbdkptiRvF5YZZHKduRHT3B4LlHjCAkFrl2H6yyK/9ZOfhk6
         /7Qt7rhvuloB47St1MzDb0d3NnR/2JOBJlGVUKIH8NHzAn7kQlJUBdeAfEQqYIW0jl6m
         QDZqYuGnkLOPCFkJ4P+aHqRO6ZtrbCu/mIMd2VI3kUxhlMS57qHtl8csewvsxZ3cL5t/
         QvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eUUlK8gFbeLL/gYwSjFGB469B2p9AZAbiDBrzDvrtBo=;
        b=XB/iMeivhP5YEpQsOKMjsnNyVWGwEUwg/8uwEHwsWN/Ta7ahcTt4MNYNDZF6LCjCHX
         ZaqnS0fn4nCU3r3EA8ZQnPbEnruVIqEnufV6Z9ICDHtz8vC6j2Ef+f1/LLMqeXH2UDTS
         5AAiKX9ZKQdK8GXXOX7CksWsQvwr7+WckN8/9FFaDkygE09kJq1OYsoNEEDAILUAGAU/
         YH4BlPejmuDhhvnS2R6kmz0MCRXNC8H8tQZRoZKcwWNK2hwqgTZoBjLdXEUwS1Iy8JPs
         cwkj2Ck/krjHMaXYi/TgiIIiiWFDNb1tXmGmUfFKB/WCTYHkEmF1GA5fv58twWbiiqMf
         YsdQ==
X-Gm-Message-State: AOAM531bRhB+yh2b10qy6bApX6ENopujVdTYgi7gvYk1xGbHEu3rThWr
        OI43c0N3qChHktbJCPQEaOUvhoCjGqM8cGiy
X-Google-Smtp-Source: ABdhPJw0Vi8wDw1/SK4QCP1kbEUaMv4b2Gmx0J3BodCQOZvKsbN5fZv2CUpVSJGGsMFA+UDfXbzX8g==
X-Received: by 2002:a05:600c:3490:b0:394:5616:ac78 with SMTP id a16-20020a05600c349000b003945616ac78mr25610460wmq.80.1652869265875;
        Wed, 18 May 2022 03:21:05 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id v9-20020a056000144900b0020c5253d8d8sm2039780wrx.36.2022.05.18.03.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 03:21:04 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Michael Reed <mdr@sgi.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: qla1280: remove redundant variable toke
Date:   Wed, 18 May 2022 11:21:03 +0100
Message-Id: <20220518102103.514701-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable toke is being assigned a value that is never read. The variable
is redundant, remove it.

Cleans up clang scan build warning:
warning: Although the value stored to 'toke' is used in the enclosing
expression, the value is never actually read from 'toke'
[deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/scsi/qla1280.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/qla1280.c b/drivers/scsi/qla1280.c
index 0ab595c0870a..1e7f4d138e06 100644
--- a/drivers/scsi/qla1280.c
+++ b/drivers/scsi/qla1280.c
@@ -4037,7 +4037,6 @@ qla1280_setup(char *s)
 {
 	char *cp, *ptr;
 	unsigned long val;
-	int toke;
 
 	cp = s;
 
@@ -4052,7 +4051,7 @@ qla1280_setup(char *s)
 		} else
 			val = simple_strtoul(ptr, &ptr, 0);
 
-		switch ((toke = qla1280_get_token(cp))) {
+		switch (qla1280_get_token(cp)) {
 		case TOKEN_NVRAM:
 			if (!val)
 				driver_setup.no_nvram = 1;
-- 
2.35.1

