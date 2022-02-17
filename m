Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6F34BA943
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 20:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245003AbiBQTIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 14:08:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242994AbiBQTIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:08:19 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325DC2B254
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:08:05 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id v5-20020a17090a4ec500b001b8b702df57so10295713pjl.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e/N0Rhhzz5vwAvXJwS8oHDh3H0bU+N1BFIY6++JNrEA=;
        b=I32ZG9aSf+guazsrpIpkMpf9UReyMsE3bpQQZ6ri67ToYEBZCORnXry2tmSi5TjU8J
         382+l2UPVDCC6WMcYhrQ4Ql/C8KnmmSsv4eN0pdwoUq1qX97hUA8y+pJAapfOixKQ08J
         xDyub5BY2k73NG/rjsLLz16hejmske6xZghcN+bObChI4+Pf44Y8Ozd+J561ppOjx8KG
         Wko6+4R9koNHhmnLe/PcG43TKfJBkI8+Iy3Dgj3fpFfZXe90ToFMip+4QGGO0AfHKjMn
         ACq4PbZBwJQOQuhsDZwgyrDhYNvCzkNIzJt3dK9rMHZTA5VcVOUWnxWe3DNrfdJbHG4P
         FQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e/N0Rhhzz5vwAvXJwS8oHDh3H0bU+N1BFIY6++JNrEA=;
        b=tufoaNdUyvJ2l7onOW9evVso1cuL2lPnImn3K9iYDCUaB57oNPxGBey0d5wnS9FDFF
         jvBxYgc+z9GYq/XMyGvGGAB/fomVZMa2zYHvsaIT4YmwHji3TOCe8yHG3Ulkk9Wog/fY
         DhnHu0DdYWYTavv0ysye5fv5co/r6II0iZDwu5XWb4CRtVHnTV0PhglOQpi4wfwLfPeR
         517LgThmXoJLAJvNmGOpDuYHvyJAj0GHkYd7VP3271KFRJ3pZAgZr5Aq6DTGldSDUpwr
         1vPHoEv1SoE5WZ5XXJ+9WEWYu8EQb1ZJJUUU62PbQ+O6pMDYuNZAbnVkeTmWaHeoFqA/
         MqIA==
X-Gm-Message-State: AOAM531fUkJQtMBIOTD/h4vLq++bE26NXOVnl8MEzN1KfEvOFK1DhCu/
        ROt6XCv/FDI5PzH7cWUd35kAYblLJGTxZANY
X-Google-Smtp-Source: ABdhPJylnRawVBSxsrWOtnvbZ8+881zQg6NSzIk9BizDTRVi2RHzCfV/Mdkmj6BMxBV3JDIVtD7fHw==
X-Received: by 2002:a17:902:b288:b0:14d:5f1e:4ff3 with SMTP id u8-20020a170902b28800b0014d5f1e4ff3mr4109531plr.24.1645124884621;
        Thu, 17 Feb 2022 11:08:04 -0800 (PST)
Received: from localhost.localdomain ([123.231.106.116])
        by smtp.gmail.com with ESMTPSA id k62sm8707864pga.86.2022.02.17.11.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 11:08:04 -0800 (PST)
From:   Husni Faiz <ahamedhusni73@gmail.com>
To:     pure.logic@nexus-software.ie, elder@kernel.org,
        gregkh@linuxfoundation.org
Cc:     Husni Faiz <ahamedhusni73@gmail.com>, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: greybus: loopback: Fix Coding Style Error
Date:   Fri, 18 Feb 2022 00:37:22 +0530
Message-Id: <20220217190722.44894-1-ahamedhusni73@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Macros with multiple statements should be enclosed in a do - while
block.

Signed-off-by: Husni Faiz <ahamedhusni73@gmail.com>
---
 drivers/staging/greybus/loopback.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
index 2471448ba42a..33666a49e0a8 100644
--- a/drivers/staging/greybus/loopback.c
+++ b/drivers/staging/greybus/loopback.c
@@ -162,10 +162,12 @@ static ssize_t name##_avg_show(struct device *dev,		\
 }									\
 static DEVICE_ATTR_RO(name##_avg)
 
-#define gb_loopback_stats_attrs(field)				\
-	gb_loopback_ro_stats_attr(field, min, u);		\
-	gb_loopback_ro_stats_attr(field, max, u);		\
-	gb_loopback_ro_avg_attr(field)
+#define gb_loopback_stats_attrs(field)					\
+	do {												\
+		gb_loopback_ro_stats_attr(field, min, u);		\
+		gb_loopback_ro_stats_attr(field, max, u);		\
+		gb_loopback_ro_avg_attr(field)					\
+	} while (0)
 
 #define gb_loopback_attr(field, type)					\
 static ssize_t field##_show(struct device *dev,				\
-- 
2.25.1

