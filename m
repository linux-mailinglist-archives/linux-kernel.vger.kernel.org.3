Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C77468484
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 12:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384812AbhLDLjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 06:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236588AbhLDLjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 06:39:22 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C99C061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 03:35:57 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id x6so22165658edr.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 03:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u2R0orPglkc/iYke1YrfwxBgDd6DiAIV0f2a8XXmni4=;
        b=Z6xyFcHRMe7fS0uKkQjJLvUlqdakl4vneZpTnP46Z8P9NziSx3xfA2jD2o9aQ5eqL4
         j/yAltV0+wSVjCXFg8qgza4l6X0i3+GQowTrE3uECYPrjbxcr0XCrOA4PAls37QdDI19
         CzX78x9Hkcxb3WUiWzDSiQMaNu4n3PKxW2luN/+ePE6fIZwy0UY+Im+cLxLVI5CZKrCr
         HYGPVhzIw+Pot+PF/joHi9yI3GPSgu1bVvzVymUrht7F1SB+XDXChk5RLSC/jDqVY61a
         XxknRJ1zsimNARAal4fvwLCz7WWDx0C6PkrRn2Oq87Ra/AJ10gIlLacA+aYXAoRXOdRH
         m1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u2R0orPglkc/iYke1YrfwxBgDd6DiAIV0f2a8XXmni4=;
        b=YL47pvoDlLBUdeUWwEIKWTn4QCl3VUYSf+3ca09IYROFSLwRdmKMK1AsjpGRzAfGR2
         z2EDX+MsZkIrecE0fjZJfaVwD6Mb7ulF7RHaHcjcLYnxytsj8teNQBqla5NLeExTK8hN
         CvxSRUlhTkBCPqOF7Cg6zgLwFNDbmbtJxKH7MOpE7/MDKAiOU1/F4N5z7V8C3Kk9r+ID
         QBIguHeZcLGk/CAnwfYTZzFUFpHwGreVqpIFlXL1dK+zng0D+uVJfrqg5nhpqbJHsYgt
         WFzj92TkI7XMDIZp8/e73zOW322s/7cTcPMrCj4IKqDviBjw94rDuMZysaV47m9XS40a
         dU+w==
X-Gm-Message-State: AOAM533mOlmooKwFv87xTLeXnqnhHhLjeSOC3u19S026FoLgbvAToPFv
        7JjzDzz4agV4+VphYjkQqps=
X-Google-Smtp-Source: ABdhPJwHxWRE3xt6pWka7RVepmGrrBgBaSNEpnE7EqgwKTpqyxIW0+BEb2jA4w3DhX+fdgsQH34eyw==
X-Received: by 2002:aa7:d5d6:: with SMTP id d22mr34864522eds.364.1638617755845;
        Sat, 04 Dec 2021 03:35:55 -0800 (PST)
Received: from bulldog.fritz.box (host-79-17-112-183.retail.telecomitalia.it. [79.17.112.183])
        by smtp.gmail.com with ESMTPSA id he17sm3657577ejc.110.2021.12.04.03.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 03:35:55 -0800 (PST)
From:   Alberto Merciai <alb3rt0.m3rciai@gmail.com>
To:     alb3rt0.m3rciai@gmail.com
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        =?UTF-8?q?Aldas=20Tara=C5=A1kevi=C4=8Dius?= <aldas60@gmail.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: vt6655: remove unused variable byMinChannel
Date:   Sat,  4 Dec 2021 12:34:04 +0100
Message-Id: <20211204113407.3941035-1-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove set but not used variable byMinChannel.

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---

v1 -> v2
- Add Signed-off-by

 drivers/staging/vt6655/device.h      | 1 -
 drivers/staging/vt6655/device_main.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index 9e5f060f3784..b2aee3b8bc8d 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -200,7 +200,6 @@ struct vnt_private {
 	unsigned char byTopOFDMBasicRate;
 	unsigned char byTopCCKBasicRate;
 
-	unsigned char byMinChannel;
 	unsigned char byMaxChannel;
 
 	unsigned char preamble_type;
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 6c5140e29f6b..d008b22cb98a 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -227,8 +227,6 @@ static void device_init_registers(struct vnt_private *priv)
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	/* Get Channel range */
-	priv->byMinChannel = 1;
 	priv->byMaxChannel = CB_MAX_CHANNEL;
 
 	/* Get Antena */
-- 
2.25.1

