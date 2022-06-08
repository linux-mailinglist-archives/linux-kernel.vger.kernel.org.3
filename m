Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68FA5427B1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344034AbiFHHOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354388AbiFHGTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 02:19:33 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DAFE2058;
        Tue,  7 Jun 2022 23:09:39 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id f65so7786752pgc.7;
        Tue, 07 Jun 2022 23:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5XPLdEjhOMoKfPO/4HrcmUy4dcFm1Nhd2plHLfQ24R8=;
        b=IQuHLDlbIjp9DRwZU/OIR7MWti2kse/Nurh507vTWHUe3/erAaXfyISuSWL+fUD7i7
         2ayOLC7Gj42Lu/sgu0DMPvlBmZlVf+BM4wkFYtEUTY6Jqb3Yds1APmCl93nEubCX33jP
         QGaB/ZTVmKrx4aE1mx5tcCVGMyizFvHQLdv5xaVTJ12yXGUN1eh8xChRHZdEPmr8Rr/E
         do5+xgQpIFQD2ly1A43X+qPR7/h3rJBX7Ch3KlgKR8lzOOooOhwhqEouzZ9BSUZ5WYJe
         7EuGQcrwa8fHeV7eP/SfJ97Ti3TUPBf+hE+U+y0qZpz/mLh0LJhXd8Ww9YTawcDPtJE+
         OKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5XPLdEjhOMoKfPO/4HrcmUy4dcFm1Nhd2plHLfQ24R8=;
        b=vD+DCwlQgybdvlGD/wkxFYuqI7meZFGAcCULHDgei/ZfUzGEv4DukcGzoIwYRcAp38
         xwspBJ2a80SdktefWsfxKLJCIVc2RKrmNN4wrkPWk8QF7Y0P8TRTC5DWbGZt/JM6L8kL
         VWFsQ7d7dbB0HweYw08iGKdups1DvuWoaL0ipkIDT2q7o42Fm/1lrjg3SgL2+t7hsZFZ
         ocfNYRmYubdwDYzTUbCBy4sY4PiNLER96ggtFuGz8m+uMK97tOnLEy8UikWbnHqhBSpC
         ugF6+wSq1rV/h2Hb8rHb0eKXGIsmTu8fFma1iyq4pHsh3PZFf2SXiksYvBO10lFAoLs9
         xteQ==
X-Gm-Message-State: AOAM531AW3FR5NrY2t6pLEowzonNIR+QG3r4K7BW5/kC/GPBmyApyd3J
        rXxEilMRNACvwhsvUn7q4r1d9Sbj2zJcLxRGVtEe0g==
X-Google-Smtp-Source: ABdhPJxsG8KPgBeOiJI4hS9gvx8TWMr04L/5uTmyUY3hJG1NJLpVPAoDPEROSaIapoiX49Od4nzglw==
X-Received: by 2002:a63:5723:0:b0:3fd:d8b4:c19f with SMTP id l35-20020a635723000000b003fdd8b4c19fmr10089040pgb.137.1654668579316;
        Tue, 07 Jun 2022 23:09:39 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id u5-20020a17090a400500b001e30a63ca3asm13193671pjc.2.2022.06.07.23.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 23:09:38 -0700 (PDT)
From:   luoxueqin <luoxueqin66@gmail.com>
X-Google-Original-From: luoxueqin <937225041@qq.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        luoxueqin <luoxueqin@kylinos.cn>
Subject: [PATCH -next] watchdog:Fix typo in comment
Date:   Wed,  8 Jun 2022 14:09:33 +0800
Message-Id: <20220608060933.13062-1-937225041@qq.com>
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

From: luoxueqin <luoxueqin@kylinos.cn>

Spelling mistake in comment.

Signed-off-by: luoxueqin <luoxueqin@kylinos.cn>
---
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

