Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E841488253
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 09:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbiAHI1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 03:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbiAHI1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 03:27:48 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400DDC061574
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 00:27:47 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id h10so5472941wrb.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jan 2022 00:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=avAv+SjmzSPk3oTkCTZAzHE4JzLH4DnHeEbaVJD8pf4=;
        b=lAOtfrSUhTIldjcpHxr7p8tG44vGhspLxjVquuuVLTlKNMLbKDENid1yNs2h5ceSOr
         FKd38fGV76Q59suDPEo/hXvva0fCdMdZJONnhFp6Ugj/HSIU/Po90PxYDWB10n4cRAzt
         wpVOgLROa2IJREYON/alDuAEYI7NsbmBpx8Re+2EfWj25pDtAGjcR4p5makvrIhWirOx
         n/VMuERtOMlDJTSVO/ufFvA9EekyDHNwW2hMAwzA+3jZvA7dnqy5QFmqSCcx5JPHqtFr
         eMSuT72FiIZWfj3RYBwc1Z+p14fUf9NMJOFP9mmF3MKy4+ouf+J6/EM+1G9uen4ESrJm
         MBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=avAv+SjmzSPk3oTkCTZAzHE4JzLH4DnHeEbaVJD8pf4=;
        b=3YF0hRUL8eFxdp6efragiMOuWm/FUOEdS7za53DgFWFMgzankJ/VpF0rfqE2lMfhyJ
         kpY8qX9Z4VgLGa15zdlHacFz/y6UwcU7x8UmBbTysL8SssIChEzs8x3ncJO+OA2t5Yn8
         UGJaNAfAHMMWohkVPSloRukBORNvvzpQlb2046PghKvO9HOGodCzYyU2RmfpruNpTWDB
         Ff/118WzS3ujAZ71vbtGBrwx+WUc5rhZUU8lHfGYjN2wfMVqIJ1Pv0L4KpRM2X2uqcbI
         kijgYgVa8AOOJQpwTkH8xsc5QphrQMhF5023uG7FiSJRqFs/4Y3EKmW8ld2SMvqDKDRB
         b5nQ==
X-Gm-Message-State: AOAM5333uDHLWsq9rk1Rrp6TVbCP9PnD2LvlLiiK0uYle4thnmunNYE9
        7kqCSjSpDfuTBAOoxXwA/eNCsw4FHp8=
X-Google-Smtp-Source: ABdhPJzUwTCfBbq+Z6JY2QNO4VXXTtvIMXsOJshn6iiVvdXOZUX67Uf131NQOD+3zrl32D/XQAsM3w==
X-Received: by 2002:a5d:4c82:: with SMTP id z2mr8270620wrs.605.1641630465879;
        Sat, 08 Jan 2022 00:27:45 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::51e2])
        by smtp.gmail.com with ESMTPSA id az1sm964536wrb.104.2022.01.08.00.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 00:27:45 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/5] staging: r8188eu: rtw_os_recv_resource_init() does nothing
Date:   Sat,  8 Jan 2022 09:27:35 +0100
Message-Id: <20220108082736.16788-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220108082736.16788-1-straube.linux@gmail.com>
References: <20220108082736.16788-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function rtw_os_recv_resource_init() just returns _SUCCESS and
the return value is not checked by the caller. Remove the function.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c      | 2 --
 drivers/staging/r8188eu/include/recv_osdep.h | 1 -
 drivers/staging/r8188eu/os_dep/recv_linux.c  | 7 -------
 3 files changed, 10 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 72007952ee74..26893f36d1ff 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -54,8 +54,6 @@ int _rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter)
 
 	precvpriv->free_recvframe_cnt = NR_RECVFRAME;
 
-	rtw_os_recv_resource_init(precvpriv, padapter);
-
 	precvpriv->pallocated_frame_buf = vzalloc(NR_RECVFRAME * sizeof(struct recv_frame) + RXFRAME_ALIGN_SZ);
 
 	if (!precvpriv->pallocated_frame_buf) {
diff --git a/drivers/staging/r8188eu/include/recv_osdep.h b/drivers/staging/r8188eu/include/recv_osdep.h
index 4c6cf5b1ac76..71fe581fbc85 100644
--- a/drivers/staging/r8188eu/include/recv_osdep.h
+++ b/drivers/staging/r8188eu/include/recv_osdep.h
@@ -19,7 +19,6 @@ void rtw_handle_tkip_mic_err(struct adapter *padapter, u8 bgroup);
 int rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter);
 void rtw_free_recv_priv(struct recv_priv *precvpriv);
 
-int rtw_os_recv_resource_init(struct recv_priv *recvpr, struct adapter *adapt);
 int rtw_os_recv_resource_alloc(struct adapter *adapt, struct recv_frame *recvfr);
 
 int rtw_os_recvbuf_resource_alloc(struct adapter *adapt, struct recv_buf *buf);
diff --git a/drivers/staging/r8188eu/os_dep/recv_linux.c b/drivers/staging/r8188eu/os_dep/recv_linux.c
index 0d3110a4c3d2..da21490fe168 100644
--- a/drivers/staging/r8188eu/os_dep/recv_linux.c
+++ b/drivers/staging/r8188eu/os_dep/recv_linux.c
@@ -12,13 +12,6 @@
 #include "../include/osdep_intf.h"
 #include "../include/usb_ops.h"
 
-/* init os related resource in struct recv_priv */
-int rtw_os_recv_resource_init(struct recv_priv *precvpriv,
-		struct adapter *padapter)
-{
-	return _SUCCESS;
-}
-
 /* alloc os related resource in struct recv_frame */
 int rtw_os_recv_resource_alloc(struct adapter *padapter,
 		struct recv_frame *precvframe)
-- 
2.34.1

