Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235B75A747D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 05:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbiHaDdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 23:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiHaDdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 23:33:11 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0115B6E88F
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 20:33:10 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id w88-20020a17090a6be100b001fbb0f0b013so13763784pjj.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 20:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=07kADcidHjuB+Zmfi9pW30oDxS6PMQtLtwVQUMEE3p8=;
        b=W4n5HGp1uqRBf+urkbXzHyzmnpXgQ3zSUt1wl8xWOv4rV5WfIygy6yufSv1NH0OZat
         ZRezN2aqcjzZWQxkWTKn+de+qkrid5JOHB5qQUFw9wmP0ZA1AUCK9S9Ml6WHgpzqIZN6
         9vXFk0kY7b8cZ5QW6APNJk9fJJpzIRmdFMQ8u0jmL8HHuIOzom7vZDEbovwVbuAN1x/U
         GrvanzmRgv0zxVuz+6KvRIgSg9YOURahPDoFoa0SfR8J9/YVYEy8HQ5xPUPqCry5kYMC
         K1l6OR8fJ6MkYV/Z7PCKhzyIFniAJdCG6W65fPxapPrmEj/EhT0cHQLwbHL1Vs6tIH0B
         8yMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=07kADcidHjuB+Zmfi9pW30oDxS6PMQtLtwVQUMEE3p8=;
        b=FQMdHId4n1BbZX5HoO4CkVblLJJtPx1rTeoC35j+Ufk9fDmGCNANn9eJz57Vd0Fbb4
         cjPWFmtW6Snh0FzShGZe+h++CkA6WwW7kBToWBtSW7wbki8i0YWamQFaIclk4hYgYsI6
         9bbKUarwNDbvUSf3FmBchR8xLkC6k+hrZITxRn61Wy075awlHs21kYD6ai0yeTFbu5OO
         P8Ej2pgD74N6YjWf9UsWrvNAU6sOC/VZmjuXAPgO/7eQnQpDfRJKBXiu6COHBWF1s78s
         FvJbkGA1SvoOGzVw4kXHDVc7Dk/3iJ9xtoItNYtx+f70lSGCre1UpsBk/8joTJQKyHsV
         jfVg==
X-Gm-Message-State: ACgBeo3UxEwzv1rV1cslQY1fTOJRfe0KRxQQQ8Ut6+n3ALctBhDK5m8E
        BtgN3t3ADMV21sBecuLRAFPoaR5+f+g=
X-Google-Smtp-Source: AA6agR6HHRLsIEseMQjMkDurFXXKbwIy6vzrqpXrQFq7JfR6kdzF1mrc7a8WL1EamBO5Iw8ZZhsm7w==
X-Received: by 2002:a17:903:18a:b0:16f:8a63:18fe with SMTP id z10-20020a170903018a00b0016f8a6318femr24439522plg.174.1661916790375;
        Tue, 30 Aug 2022 20:33:10 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s4-20020a17090a2f0400b001ef81574355sm327503pjd.12.2022.08.30.20.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 20:33:09 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     airlied@linux.ie
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] drm/gem: Remove the unneeded result variable
Date:   Wed, 31 Aug 2022 03:33:01 +0000
Message-Id: <20220831033301.302121-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value drm_gem_handle_delete() directly instead of storing it
in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/gpu/drm/drm_gem.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index ad068865ba20..3fa0deff3014 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -782,14 +782,11 @@ drm_gem_close_ioctl(struct drm_device *dev, void *data,
 		    struct drm_file *file_priv)
 {
 	struct drm_gem_close *args = data;
-	int ret;
 
 	if (!drm_core_check_feature(dev, DRIVER_GEM))
 		return -EOPNOTSUPP;
 
-	ret = drm_gem_handle_delete(file_priv, args->handle);
-
-	return ret;
+	return drm_gem_handle_delete(file_priv, args->handle);
 }
 
 /**
-- 
2.25.1
