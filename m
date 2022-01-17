Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E8A49065D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 12:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238811AbiAQLDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 06:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236213AbiAQLDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 06:03:13 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98040C061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 03:03:12 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id s12so14677173qkg.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 03:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SbVlODV4oY3MJY14ZQvpHcpVV66eDE6HzjyVZGKm7pU=;
        b=gn/4hKhPCmMEDIzHzMUiIUG+C5XVOveElktJ9roxd8HK56oGntsRE5V1Lt4RL26JAa
         9jsB5RF008VgYpoKet7E0u8IWEV55t0CRsiguZmQYQpZYAXT6rbyvM/gVq4LvCi2aHBp
         Z4mJFlD96LXxkYUbCd62T6lo+kA7dbQs8JfIs5aIhL+h7DqXx/hUYCdcPdJRa8wJ+dkX
         KRd+HhQ+6ACWvWMOOP3YYaU++auHjSdTcj85wB40q+Vy3CP01Q2kYhQkmpFu4Ozj7F2m
         bDTTuZNHtpDlARhXDZ3yT3afDQiutx52FHkVY9EG45Kioi8W7+Nv7A5mSPQpvtcOVrvh
         WHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SbVlODV4oY3MJY14ZQvpHcpVV66eDE6HzjyVZGKm7pU=;
        b=fsh2N+Ey8A+sKsncyoBlW0KWmFVMeP0JstrlLZvIvgIHImLjKoLzi2zUWhAaNQsRgH
         CkZVA3z3I9/j4HN5T2Wu0rf0QaoxdY+in06501rffdaaKaQmNP2nJ/mrNiB9ObP1jYFV
         r2h3hRTV9jt/GZ0eDOEJHBihSzPW1meipq6J8Qi62MMDG+Paa3r9olKxqdeCLizbQBWj
         KXU/42ALcJi8gB6Zx0QHXfEqdfqDtc5iqbbDjwxvX7aBrHZxRDiFiDms8b/d47/4sZFO
         zChhtZz331LgOJF/Ai8XDxuUU4DLB5lg0vdGEUp8GS5IxC0mXlCOJXvwquFQHgFAkVmz
         QarA==
X-Gm-Message-State: AOAM530Z9EibbZSNGiQQ34BMrodFO4T1CNyW60PB1q0GLQmEt1ETJL6W
        YNjPdhuwQsROa1pFcknhkcE=
X-Google-Smtp-Source: ABdhPJxOtY0rJKJH+fQCPbaJDpL5px86uQEb74lQd143w8zDRXRk6ufsy8ys97auGdpJVJrNp2vw7g==
X-Received: by 2002:a05:620a:25cf:: with SMTP id y15mr14144988qko.21.1642417391698;
        Mon, 17 Jan 2022 03:03:11 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id i15sm8536677qko.18.2022.01.17.03.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 03:03:11 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     linux-graphics-maintainer@vmware.com
Cc:     zackr@vmware.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH] vmwgfx: remove redundant ret variable
Date:   Mon, 17 Jan 2022 11:03:04 +0000
Message-Id: <20220117110304.863922-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value directly instead of taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index 44ca23b0ea4e..be5b1a9b48e1 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -1263,7 +1263,6 @@ static int vmw_cmd_dx_define_query(struct vmw_private *dev_priv,
 	VMW_DECLARE_CMD_VAR(*cmd, SVGA3dCmdDXDefineQuery);
 	struct vmw_ctx_validation_info *ctx_node = VMW_GET_CTX_NODE(sw_context);
 	struct vmw_resource *cotable_res;
-	int ret;
 
 	if (!ctx_node)
 		return -EINVAL;
@@ -1275,9 +1274,8 @@ static int vmw_cmd_dx_define_query(struct vmw_private *dev_priv,
 		return -EINVAL;
 
 	cotable_res = vmw_context_cotable(ctx_node->ctx, SVGA_COTABLE_DXQUERY);
-	ret = vmw_cotable_notify(cotable_res, cmd->body.queryId);
 
-	return ret;
+	return vmw_cotable_notify(cotable_res, cmd->body.queryId);
 }
 
 /**
@@ -2576,7 +2574,6 @@ static int vmw_cmd_dx_so_define(struct vmw_private *dev_priv,
 		uint32 defined_id;
 	} *cmd;
 	enum vmw_so_type so_type;
-	int ret;
 
 	if (!ctx_node)
 		return -EINVAL;
@@ -2586,9 +2583,8 @@ static int vmw_cmd_dx_so_define(struct vmw_private *dev_priv,
 	if (IS_ERR(res))
 		return PTR_ERR(res);
 	cmd = container_of(header, typeof(*cmd), header);
-	ret = vmw_cotable_notify(res, cmd->defined_id);
 
-	return ret;
+	return vmw_cotable_notify(res, cmd->defined_id);
 }
 
 /**
@@ -2726,15 +2722,12 @@ static int vmw_cmd_dx_destroy_shader(struct vmw_private *dev_priv,
 	struct vmw_ctx_validation_info *ctx_node = VMW_GET_CTX_NODE(sw_context);
 	VMW_DECLARE_CMD_VAR(*cmd, SVGA3dCmdDXDestroyShader) =
 		container_of(header, typeof(*cmd), header);
-	int ret;
 
 	if (!ctx_node)
 		return -EINVAL;
 
-	ret = vmw_shader_remove(sw_context->man, cmd->body.shaderId, 0,
+	return vmw_shader_remove(sw_context->man, cmd->body.shaderId, 0,
 				&sw_context->staged_cmd_res);
-
-	return ret;
 }
 
 /**
-- 
2.25.1

