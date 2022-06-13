Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A9A547DAD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 04:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238007AbiFMCrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 22:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235026AbiFMCrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 22:47:05 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EAB338B3;
        Sun, 12 Jun 2022 19:47:03 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t3-20020a17090a510300b001ea87ef9a3dso4660997pjh.4;
        Sun, 12 Jun 2022 19:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=53Rfn29B2zfkwZtImPM98mlN5TcCCd4d2t7ScEJEx1g=;
        b=RO5IOf9oHFFgWUy2tekcJjN9UnFJb5eHRMTaOQpFbQSBy3JIBRkfQnH/IO6/vNT65x
         JJtROPgvIsfeGjbXKr86OSwsSbAuT53f6vwYx+ZtHZh4x6j31DiyGY5rLvqHyrsDfLro
         GocSnSg1Uf3sI4/nQ3mjIMHu0e2PZhCFmmKGV+vQcNGuGmq9dvGLdBgHleinrzsKj/+s
         8J2siLNA5xF4ma7bpl1kBcYS6Gm3tELfGvTaYUMfOp/RpsaPgg7tS1LZw1qRTCkzwNRt
         vQ9+/OEX+C4Mc6X3Gr/nxn0OXiFgV8ymXJOfFE5SAul1Rxe2qTpg08JEHU9iqNXoHVXU
         j6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=53Rfn29B2zfkwZtImPM98mlN5TcCCd4d2t7ScEJEx1g=;
        b=wF3QF/fjSop3iIZASPgAMTCP64j3R8Mk9nQ8NnVddHSRGNkjSA4xRgOjghdlBWWgu0
         0xgNrLZbCBJ8x1S5kYGjOrxh5YYVbfVFnGhaq7kmRNzGYgkszRRjMViZj25XT1tez4zL
         Sm24NAWKJgQqdUtzUJuOYJiFZ1YzvaG4WXcUsqjq0cxIyaStfOTog53D8lWEMpBOA19C
         KHnvvRzhXRA367eWdB71uUXB2kqZvLQUNLIM8WiMYeF63DUHlhZymY6x64nWe5gnIPAm
         t2Q8A5WrQncXXUU91HebWdvpIB3c4ZEZDzTQ642N267A0jdQM1ihW+zrCXcw3JQvI+5m
         sSyQ==
X-Gm-Message-State: AOAM533Ohp/ERWtgZwHTFxGtmhrR10+s5CqqOFHuQCP87Zi/Lo1/zDJQ
        +T9Nx56ivi9Ie0j40AvP8n1FiNjRr8naK39O
X-Google-Smtp-Source: ABdhPJxXpIz5xErkE4oqeEQAPH3CqpcHkvI0zH3mdOdI1a23a5CaVSKSNx5y8wd3LTO5pfKZEecmfg==
X-Received: by 2002:a17:903:284:b0:168:4d1a:3ccc with SMTP id j4-20020a170903028400b001684d1a3cccmr28472239plr.78.1655088423380;
        Sun, 12 Jun 2022 19:47:03 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id ix13-20020a170902f80d00b0016160b33319sm3705802plb.246.2022.06.12.19.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 19:47:02 -0700 (PDT)
From:   luoxueqin <luoxueqin66@gmail.com>
X-Google-Original-From: luoxueqin <937225041@qq.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luo Xueqin <luoxueqin@kylinos.cn>, k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH v2] watchdog:Fix typo in comment
Date:   Mon, 13 Jun 2022 10:46:56 +0800
Message-Id: <20220613024656.178757-1-937225041@qq.com>
X-Mailer: git-send-email 2.25.1
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

From: Luo Xueqin <luoxueqin@kylinos.cn>

Spelling mistake in comment.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Luo Xueqin <luoxueqin@kylinos.cn>
---

v2: add discoverers

 drivers/watchdog/pc87413_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/pc87413_wdt.c b/drivers/watchdog/pc87413_wdt.c
index 9f9a340427fc..c7f745caf203 100644
--- a/drivers/watchdog/pc87413_wdt.c
+++ b/drivers/watchdog/pc87413_wdt.c
@@ -442,7 +442,7 @@ static long pc87413_ioctl(struct file *file, unsigned int cmd,
 	}
 }
 
-/* -- Notifier funtions -----------------------------------------*/
+/* -- Notifier functions -----------------------------------------*/
 
 /**
  *	pc87413_notify_sys:
-- 
2.25.1

