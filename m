Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5FD5672B0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbiGEPby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbiGEPbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:31:51 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02401A382;
        Tue,  5 Jul 2022 08:31:50 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id m2so11274559plx.3;
        Tue, 05 Jul 2022 08:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=53Rfn29B2zfkwZtImPM98mlN5TcCCd4d2t7ScEJEx1g=;
        b=CYuBFwV0V8k6Tp8SmOjaJUd+DuCYbdxIOW61iN6m6vuW07in5aoHci8lXSpWVn6GNl
         xmbdSGY9PWKFyV2Wf84AAEbrLQVcOIWoCdaxEm0v8cnnK2f88KTkc2PNIXipkqpox0EL
         x0gqSy+LDkKD68b0aSrZibsz6ZwmpXqE99/j+H4jxNhF3m09XqpdCceUB6vabOJxN02v
         zT+9IV2iP4ZmEWhNkzqzwEpdWzR1J6/uRB42GA5Y/tPItGIfZ27c4oGanmu+veDoJdp5
         drlEwJbMQ5+8eHu87kIel2xvZCapzPT06Py81x6qGkzvyrUpconL+GD4OSA8Zjk+v62n
         6acQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=53Rfn29B2zfkwZtImPM98mlN5TcCCd4d2t7ScEJEx1g=;
        b=MYT/IyWSKxwSUTA2z7Uab/kFuYklL1keJMItDF3awseMTKWk+UqdigrZa4wIIYoQg3
         xo4naePEgTm65iPaMoH+U468gdLjNqvniL/9rFl6i75Of2c3O2dCIoLWEcPa2QjIK+KN
         E2kiD8bIqDR+ei/j+ryMmY/IKhnHc+EshJHvpr/c74V1fio27BWahcawv/uzP73JNmr1
         M1SYeyRl9Nh2XqA7p4NqpwTWVClXaGzGXmgYIFxYUAkTGyv6Zf1dwq2lUsXEhUGopCPf
         VbiYd2g0CwoHUgjKJsjWetw4rgyXL1XGy8sNA9bQh7m3+BvmYK/ZBaY1yiu7qNF+vE2S
         nB0A==
X-Gm-Message-State: AJIora+TT31/9467xUIH8v1O3RMPMVrqjyH9PhG5cWPnL0jus/Tubg3V
        XCz7qMSoZ6vmWKfHE4sREyaRnl3P60ooLuVP
X-Google-Smtp-Source: AGRyM1unsJNgGiMbnrv8w+HbwhSzQe1wI99ddtJzAyS98O3+ErYV8knvcoGz5bTBKrS2xbQ0aLtDNA==
X-Received: by 2002:a17:90b:1c90:b0:1ee:d804:d2c1 with SMTP id oo16-20020a17090b1c9000b001eed804d2c1mr44391268pjb.92.1657035110264;
        Tue, 05 Jul 2022 08:31:50 -0700 (PDT)
Received: from localhost.localdomain ([120.227.32.112])
        by smtp.gmail.com with ESMTPSA id f24-20020a63f118000000b0040caab35e5bsm16514081pgi.89.2022.07.05.08.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 08:31:49 -0700 (PDT)
From:   Luo Xueqin <luoxueqin66@gmail.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luo Xueqin <luoxueqin@kylinos.cn>
Subject: [RESEND PATCH v2] watchdog:Fix typo in comment
Date:   Tue,  5 Jul 2022 23:31:38 +0800
Message-Id: <20220705153138.29657-1-luoxueqin66@gmail.com>
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

