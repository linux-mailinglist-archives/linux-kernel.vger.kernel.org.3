Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487D148BFC9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 09:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351549AbiALIYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 03:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349226AbiALIYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:24:30 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596BBC06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:24:30 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id 193so993959qkh.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mDyDHXSTcP/fcz/Ik9my/MjZZmU+tdvjzX7IK6WOHyU=;
        b=MHRvZCNyGu0ty3Xw/vdKOR14gyy1jXuC34+QwC6mTBBrtbdx+e14gB3bx9RAl1JZag
         83nL5r0nKOB2mgEvpAo4blkkCddcNy0GqbrUpLwlTv2VdnBYYe7Ltndok0AcV1aNwX3U
         nJY1iV9rHpYc2dz0n/OBMO1IoIyp0VpOhUaYxETsixC/YA9y+JV+YvbEedBwimGq77ha
         dn0ANOT1EFBKYp/tLD7isna8qE2vN3EVnWpKdNBJsfdmme1yqdgh9ivstWiJX3klpcJU
         qmRSjktGRrE2jqD13y0pw8lfPSIAuCDqtm8sOl7Z7TC2gfWu/HI6km9H/NglYzmVNz49
         79BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mDyDHXSTcP/fcz/Ik9my/MjZZmU+tdvjzX7IK6WOHyU=;
        b=VIIHhjkUfL4F8GvCyojzzqd2yJNObA1soP3EBy4Pse6VDZmB7LP0cuRvMNnHuyJjVx
         1vheFTiWju4GIRSAr7QJncZn06VYxqacriRB3Yc3J2j+JI5IAVOzplpdbffj68W6X2vB
         H8kTAIT6BxEqvFuyPuGjAPKJ4Pcsqp4pFMt2wE7cGxGhPZTB99yYYzU2fd6sGeI17bRD
         9C2pTrBNMBKNfVvxzp5VsEBzzGsGd0uZRHcs0AYGkU4QiSIKaLJx/qRy0vkJTK9CgxMO
         RWza+KBRmxxKxIqXXG3t/lnKI6dtK5JuJXuEDl9VFJzsuPUAuHJHpOogAuFIFbinQmUQ
         xtGg==
X-Gm-Message-State: AOAM530wH6bFNYCUJb936EaypU0lIkrjIAiJTlaz3a4arCldPILcVDJe
        Wyb6F8618IeaJmD9uJqtS9QGxsNN/74=
X-Google-Smtp-Source: ABdhPJzjJvX46JrQ96a1bwmjMBHsAyGa/toJgTZnywoNAX4sA5CUUyIkx12IMLkzklCoHTSq6PoOfQ==
X-Received: by 2002:a05:620a:10ac:: with SMTP id h12mr5443748qkk.467.1641975869522;
        Wed, 12 Jan 2022 00:24:29 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 8sm4902248qtz.86.2022.01.12.00.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 00:24:29 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     linux-graphics-maintainer@vmware.com
Cc:     zackr@vmware.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH] drm/vmwgfx: remove redundant ret variable
Date:   Wed, 12 Jan 2022 08:24:22 +0000
Message-Id: <20220112082422.667488-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value from vmw_gem_object_create_with_handle() directly instead
of taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
index 31aecc46624b..91b03f1dbbf0 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
@@ -778,18 +778,14 @@ int vmw_dumb_create(struct drm_file *file_priv,
 {
 	struct vmw_private *dev_priv = vmw_priv(dev);
 	struct vmw_buffer_object *vbo;
-	int ret;
 
 	args->pitch = args->width * ((args->bpp + 7) / 8);
 	args->size = ALIGN(args->pitch * args->height, PAGE_SIZE);
 
-	ret = vmw_gem_object_create_with_handle(dev_priv, file_priv,
+	return vmw_gem_object_create_with_handle(dev_priv, file_priv,
 						args->size, &args->handle,
 						&vbo);
 
-	return ret;
-}
-
 /**
  * vmw_bo_swap_notify - swapout notify callback.
  *
-- 
2.25.1

