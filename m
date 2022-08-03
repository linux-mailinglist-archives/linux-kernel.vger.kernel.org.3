Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3431C58874D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 08:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236553AbiHCGXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 02:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiHCGXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 02:23:03 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD67422D6
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 23:23:03 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d16so7403307pll.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 23:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=pofh/mBkV9iyAkeXPvhTnC/91KwnyKUAxl/+MJcDnJ8=;
        b=Xbp0g8fX57U6TlkZXO9/p38tBgYrr5OiEcJnmkdc8AE8Q197Qk8nfzZWyFtkx6cqCC
         Nq0XKqMqtrpo9BlRKpxC1MCqvfSPlNVtLtrHFd1hpG0H23QINjZN7Q1DqDg45kf0XNdc
         QrRunSuT9DIXuNjC8s7v17thS6IEoDnj5am3zdtgNGx3SM/QvjaPxmocH2W5eQHXlB1q
         imrdEsnG86XSH0nzz7oqGbY/abogh8MGLxiXo0eMJ8W5fPHQOsVXsQw7FYcYIOCK8ojq
         ndILB4WJIpfdgi17uiPUcMxJ8qNaHVH0ucEdJhY3h5vfIYKnK91ND+GahrpTbDpgSGDx
         YZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=pofh/mBkV9iyAkeXPvhTnC/91KwnyKUAxl/+MJcDnJ8=;
        b=XjWIhq/npQ/F0ZKhtOVtqYOmntZDavebwkD4XtrzNYapIK53tfUNbTwpy+VATGzHEX
         SGR3JQz+hmRbpLKi+JixZOj/ikxz4oEuJh96ZBbiTTZgkP0U1WuU6rl8bPc9xdG1OHWs
         X5znbKWP4eL2b9wWjyFTxlYd/11ZorzYafm7dcT4gQDnJtRXnS8azTRP6KVtIrKGI2J+
         E49fMWHPg5UihF2HkLajpVZzNgnngeBz+JupEWW/CBxxrXc8DpL+Ji9OGAHTJEu77h3Z
         l1iVMLCPbuwVecrmttYzr8r9DqVRr/GR52jbc/oQI15oiEb7bWmWqnhU9hAu9UGEzODt
         pS3g==
X-Gm-Message-State: ACgBeo202yhOXZmwzp9bdJkFexdYaca4JW2+d0rraWfy7tw0iWO7aFrO
        twSGBFHi5jjpyF29n/4BuJW1LMdtCSQ=
X-Google-Smtp-Source: AA6agR7KIVRrBG/gZyKSvIANK9GZgONbH3AY03GLwWLZOMa1sSrXo77cPF8AkrFEcyh18eVvY7X8yw==
X-Received: by 2002:a17:903:1c3:b0:16f:878:ed42 with SMTP id e3-20020a17090301c300b0016f0878ed42mr5555777plh.163.1659507782442;
        Tue, 02 Aug 2022 23:23:02 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id k12-20020a170902ce0c00b0016bf9437766sm865885plg.261.2022.08.02.23.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 23:23:02 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] staging: greybus:using the
Date:   Wed,  3 Aug 2022 06:22:58 +0000
Message-Id: <20220803062258.1650792-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Using pm_runtime_resume_and_get() to instade of  pm_runtime_get_sync
and pm_runtime_put_noidle.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/greybus/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/greybus/core.c b/drivers/greybus/core.c
index e546c6431877..b9063e86534b 100644
--- a/drivers/greybus/core.c
+++ b/drivers/greybus/core.c
@@ -174,9 +174,8 @@ static int greybus_probe(struct device *dev)
 	if (!id)
 		return -ENODEV;
 
-	retval = pm_runtime_get_sync(&bundle->intf->dev);
+	retval = pm_runtime_resume_and_get(&bundle->intf->dev);
 	if (retval < 0) {
-		pm_runtime_put_noidle(&bundle->intf->dev);
 		return retval;
 	}
 
-- 
2.25.1
