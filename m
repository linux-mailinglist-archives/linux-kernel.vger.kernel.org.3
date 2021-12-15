Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B19475278
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 07:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235845AbhLOGDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 01:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbhLOGDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 01:03:45 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77FBC061574;
        Tue, 14 Dec 2021 22:03:44 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id i12so19387255qvh.11;
        Tue, 14 Dec 2021 22:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=00gvlCVZoUfNgXMNllOlq06WfYH2Dl5nJAnc2H0V/zY=;
        b=aLSBeezUnCNnj/bCBkX1EsTgVKD2EOSq1GAje6VHOxZFdXqZScTUkvriUssoGFQyfO
         zjZ8Im6yeZ7ijfyUFK7PJQSQPtgsS2DqhcdHtTaRkoiO4jFQAAckIHjcwYC1VBD2XzDo
         qBgYRuIKIjugjtvNcOqRg7Q0PLo74VmRWf20DRDeFJhGczGs2OSCuVTn3fin70nttBMm
         9166IUNxR8eaFTNIDRS4l4mFuAn9I5vTyqx1/MoSAz+y/l0W3CbCXi4SBBh4EDMZls3A
         QRlYfXE7k+BDTpJc5JTe8qIwTe4y0m90NA6ijBAONQEviMU2ZbYT+VcQ+8tPc2RkQe5x
         GM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=00gvlCVZoUfNgXMNllOlq06WfYH2Dl5nJAnc2H0V/zY=;
        b=B/5PxAFNI9wPftBZYFJCFdLJgRpCm/9CKXEAjbTtdyDU2fIzN/PSLWeOiBRmv/QFwH
         iTeJO2iRsrKVLC4vu4lgmDL+RxWnfJukVqTO3anxIyFOiM9c6tVAkrzITWs8R+AWDvgq
         XVEEBWuO7gEdmL5QQKQJ/D6zBm1gOiA5YYsMjqmR00zvKQiDhPtQPDLuvXYNqw0BrPdZ
         y1lX9gHGZA0WsMHYZu7Iwumqh1JWViPj6W+gDgdnRqoGl2dh6zCgEp3qigudjMLusEyN
         5xtokqdLPESBaL7jrZpWE1KIUk68i3poXYqO6fzP2dtA9cmkd4dWCGOQhiV/sbqplLYu
         UtYw==
X-Gm-Message-State: AOAM533qIbylXzk4lKVsFGwyUEtCWshHQtd4HkXdxqln2CwdIPMNpp5y
        ccd0pho7klkEFy9kV5XUj88=
X-Google-Smtp-Source: ABdhPJxky32i2ceyaBkcawpbUORnlOolabOZmtCf4ffSu5T0Y4eZkjDb1LJMY3itCtAnyEKlAiotwg==
X-Received: by 2002:a05:6214:4005:: with SMTP id kd5mr982227qvb.80.1639548223748;
        Tue, 14 Dec 2021 22:03:43 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y6sm723746qtn.23.2021.12.14.22.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 22:03:43 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     prabhakar.csengg@gmail.com
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH platform-next] media/platform: remove redundant bpp variable
Date:   Wed, 15 Dec 2021 06:03:39 +0000
Message-Id: <20211215060339.441820-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value directly instead of taking this in another
redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/media/platform/am437x/am437x-vpfe.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/am437x/am437x-vpfe.c b/drivers/media/platform/am437x/am437x-vpfe.c
index 2dfae9bc0bba..dc3ef0708f14 100644
--- a/drivers/media/platform/am437x/am437x-vpfe.c
+++ b/drivers/media/platform/am437x/am437x-vpfe.c
@@ -143,13 +143,12 @@ static unsigned int __get_bytesperpixel(struct vpfe_device *vpfe,
 {
 	struct vpfe_subdev_info *sdinfo = vpfe->current_subdev;
 	unsigned int bus_width = sdinfo->vpfe_param.bus_width;
-	u32 bpp, bus_width_bytes, clocksperpixel;
+	u32 bus_width_bytes, clocksperpixel;
 
 	bus_width_bytes = ALIGN(bus_width, 8) >> 3;
 	clocksperpixel = DIV_ROUND_UP(fmt->bitsperpixel, bus_width);
-	bpp = clocksperpixel * bus_width_bytes;
 
-	return bpp;
+	return clocksperpixel * bus_width_bytes;
 }
 
 /*  Print Four-character-code (FOURCC) */
-- 
2.25.1

