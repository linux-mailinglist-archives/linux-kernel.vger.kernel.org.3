Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A0749E3DC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237656AbiA0Nvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238954AbiA0Nvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:51:49 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1565C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:51:48 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id u18so3741835edt.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fCtzGFDWXZIRWa9EIjewA9l/yH/0lbsxp9H12GNr7H8=;
        b=h//7KP1Hd7CASDP3P8I64s89xhRVbqbDRK0oe1LtbA/YKb7hcD2vdXR3siyU/4kLdE
         FI2qDQkCZODfCMtB2tQYFQRfU6UevHo6l3T+MkvS+H5QJNROvdfkDrf5k2g618bo7YT5
         q8Ncdn/j0XVvlq4Ngp+0x3KjzJrPPWhk3R4SEeRmCje8MknkDQoV/ivBMuYwVfXmxHYn
         asPLgF2Kl963H6UXQP3eDLoPhvSbN0f7uRLaOmEBo3W246rs7df98Lqy4DX5FHcof9hn
         Q95IfEskcjlJeoLQSCelKDd2rrKfMeRi2jDkypu/6XGOFesPE0BtCbbP/tqFrLEd/c2O
         DHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fCtzGFDWXZIRWa9EIjewA9l/yH/0lbsxp9H12GNr7H8=;
        b=gNgSZxLqIT/fciXq/Up8n+rWgF0bdeov3EHlV6BOtfMAnxx4UzXvgYADJIAz/7suCv
         IpjWaVsNog3Y8+h8yLXeWgUbw7A+oUH/phV0B1ifeSHuR41Tf7tRVPaQL7dba/MCVmJK
         Pz4lSkLwttGwnUZHA3EwqmLcWqPIQo+afGhaAcPQw3VX+lpCWCJ+NAryAmu2gLD96GM3
         TqXRd1ruEe7xN3wQmFHjoE8VA5UQxILK1imVdpWGu7YreTC440xdnlZF+sQCEfoqe53l
         qIbeM189xdRDtbnSWqK4EG5h+z7Dl97WYzrdgzRpypi2ejfRGdRbE9o4RedpmmUvw2aY
         RPog==
X-Gm-Message-State: AOAM533IS+P8CgsDR/AcUR42AMNKRjFW3nLdNRzoSWRthVeGvnCTaPuF
        XuQbHIRBkQS6zNfDl0N/0cI=
X-Google-Smtp-Source: ABdhPJxVa9wrmAQDJwcXHI7Tyk4EYpZ/+t1LQFZmHt+bIX1HHwxukJ4ZwHHMRznqiSL7JaGj8kklvQ==
X-Received: by 2002:aa7:d312:: with SMTP id p18mr3586531edq.49.1643291507449;
        Thu, 27 Jan 2022 05:51:47 -0800 (PST)
Received: from localhost (cable-89-216-134-246.dynamic.sbb.rs. [89.216.134.246])
        by smtp.gmail.com with ESMTPSA id b16sm8810564eja.211.2022.01.27.05.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 05:51:47 -0800 (PST)
From:   =?UTF-8?q?Aleksa=20Vu=C4=8Dkovi=C4=87?= <aleksav013@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     salah.triki@gmail.com, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Aleksa=20Vu=C4=8Dkovi=C4=87?= <aleksav013@gmail.com>
Subject: [PATCH 5/7] drivers: dio: space required after that ','
Date:   Thu, 27 Jan 2022 14:50:52 +0100
Message-Id: <20220127135054.27281-5-aleksav013@gmail.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220127135054.27281-1-aleksav013@gmail.com>
References: <20220127135054.27281-1-aleksav013@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl error:

< ERROR: space required after that ',' (ctx:VxV)
< #239: FILE: drivers/dio/dio.c:239:
< +                strcpy(dev->name,dio_getname(dev->id));

Signed-off-by: Aleksa Vučković <aleksav013@gmail.com>
---
 drivers/dio/dio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dio/dio.c b/drivers/dio/dio.c
index 87f5f3cc270c..2b2600c20ffb 100644
--- a/drivers/dio/dio.c
+++ b/drivers/dio/dio.c
@@ -236,7 +236,7 @@ static int __init dio_init(void)
                         dev->id = prid;
 
                 dev->ipl = DIO_IPL(va);
-                strcpy(dev->name,dio_getname(dev->id));
+		strcpy(dev->name, dio_getname(dev->id));
                 printk(KERN_INFO "select code %3d: ipl %d: ID %02X", dev->scode, dev->ipl, prid);
                 if (DIO_NEEDSSECID(prid))
                         printk(":%02X", secid);
-- 
2.35.0

