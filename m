Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B30488251
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 09:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbiAHI1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 03:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbiAHI1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 03:27:46 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7505DC061574
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 00:27:46 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id l10so15625820wrh.7
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jan 2022 00:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=opcJou2QKZvpZH47htaA4xNqATRUo6eWlvXfZY39el4=;
        b=nOQZj1onBzDYlaJN1PlgdYElMGxvr/tNW98NxsFmb3IurHk5NXNA3vMnfzXO8zHVj5
         Sf/pTxk0gDNZlYbukNIjbA6dxaDuU9QLrcC/GUYUm0OxMAXTtMxHdZSIeDO05TZnvOJC
         e7CNpr3NMtW0aO0IA/kKrAHfaxPufZdMWo8MXch7bhJljfhTSKtdgVfL+mR5SEC0sRHW
         LzdlRnw+X2IZY9VRFpXVfpdjYgqVVMuyzJ0ATscpjk/tCogEj/b3mCDgBexNCBc9y7GV
         j/TQT7bPSlD610VwUi528RS6iLxP7kEooNXsqV019cA+ef/3WiwCuoC33T7iRy3uwsHx
         k+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=opcJou2QKZvpZH47htaA4xNqATRUo6eWlvXfZY39el4=;
        b=qLogqC6fcFGHVQoxvBfTSFiZpQpszZ0sirndnWDJvsPBL7VcEUaL/t6pk/vGJxTLyR
         qINgQDK8F2hrW/6NSsvxRlGVmTgVBfhMuP0yefxZkYowh9QtKlC7dOpDAeQgJCqbS/6s
         m7WT9FnXHuddbPBIvKtB0hgu367AUkLK/TGDf8vT7ka09btAn/rf47ul5DAus+L+Q2Tw
         Z/95JJ6RrrPD2X7tWIYCOdmLM7Rsg3Q+NhhDMtoEfcHHG2u0lViz3OdI+b76PgtN2I/F
         sKWqnZ5E5VNmOl/sP52V1fYjiq1/ZS79VccD8pTAvTrmcoTsGir05S6Hx6bjZcTZE227
         jPVQ==
X-Gm-Message-State: AOAM533n2oYbqu1Geggl4A5Pptv0sTen3JK5zBK4NiC0E5dO9feKvIPe
        dSZRAGFnrCkLdfyVlKbz4to=
X-Google-Smtp-Source: ABdhPJyPFf14zcqBjofnAyCSqwP5j6ImF0l1eXdd8vn/EQE269wYzrcAz/GNZHYi56K3XgSTlv6Bug==
X-Received: by 2002:adf:f68b:: with SMTP id v11mr8735309wrp.260.1641630465164;
        Sat, 08 Jan 2022 00:27:45 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::51e2])
        by smtp.gmail.com with ESMTPSA id az1sm964536wrb.104.2022.01.08.00.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 00:27:44 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/5] staging: r8188eu: rtw_os_recv_resource_free() is empty
Date:   Sat,  8 Jan 2022 09:27:34 +0100
Message-Id: <20220108082736.16788-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220108082736.16788-1-straube.linux@gmail.com>
References: <20220108082736.16788-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function rtw_os_recv_resource_free() is empty. Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c      | 2 --
 drivers/staging/r8188eu/include/recv_osdep.h | 1 -
 drivers/staging/r8188eu/os_dep/recv_linux.c  | 5 -----
 3 files changed, 8 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 51a13262a226..72007952ee74 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -100,8 +100,6 @@ void _rtw_free_recv_priv(struct recv_priv *precvpriv)
 
 	rtw_free_uc_swdec_pending_queue(padapter);
 
-	rtw_os_recv_resource_free(precvpriv);
-
 	vfree(precvpriv->pallocated_frame_buf);
 
 	rtl8188eu_free_recv_priv(padapter);
diff --git a/drivers/staging/r8188eu/include/recv_osdep.h b/drivers/staging/r8188eu/include/recv_osdep.h
index 4b5e3dde4590..4c6cf5b1ac76 100644
--- a/drivers/staging/r8188eu/include/recv_osdep.h
+++ b/drivers/staging/r8188eu/include/recv_osdep.h
@@ -21,7 +21,6 @@ void rtw_free_recv_priv(struct recv_priv *precvpriv);
 
 int rtw_os_recv_resource_init(struct recv_priv *recvpr, struct adapter *adapt);
 int rtw_os_recv_resource_alloc(struct adapter *adapt, struct recv_frame *recvfr);
-void rtw_os_recv_resource_free(struct recv_priv *precvpriv);
 
 int rtw_os_recvbuf_resource_alloc(struct adapter *adapt, struct recv_buf *buf);
 int rtw_os_recvbuf_resource_free(struct adapter *adapt, struct recv_buf *buf);
diff --git a/drivers/staging/r8188eu/os_dep/recv_linux.c b/drivers/staging/r8188eu/os_dep/recv_linux.c
index 41c4e35d967f..0d3110a4c3d2 100644
--- a/drivers/staging/r8188eu/os_dep/recv_linux.c
+++ b/drivers/staging/r8188eu/os_dep/recv_linux.c
@@ -28,11 +28,6 @@ int rtw_os_recv_resource_alloc(struct adapter *padapter,
 	return _SUCCESS;
 }
 
-/* free os related resource in struct recv_frame */
-void rtw_os_recv_resource_free(struct recv_priv *precvpriv)
-{
-}
-
 /* alloc os related resource in struct recv_buf */
 int rtw_os_recvbuf_resource_alloc(struct adapter *padapter,
 		struct recv_buf *precvbuf)
-- 
2.34.1

