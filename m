Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE962497920
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 08:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbiAXHKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 02:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiAXHKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 02:10:50 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40663C06173B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 23:10:50 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id o64so15559970pjo.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 23:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=sEQRu2hrB2sPswCDMnmdwB6n6ZIOI2c/Ar/qj62wZNw=;
        b=LtRXGd1Xwau4iR9TPk8ZNc/AAofWCFhgjY4+3jptvVFAbgRsq0n9jD7RUJp7Kt/Rbb
         Zi2h4F8HbtjLZtUHp4V5L8CXvTMQhMN6QbAP4q7Dm5UndqhZsUnHW2XRvzvUUin+YQoT
         C9ByfCW16cLxpehf8KJBXiToeOvIWbsWnHVPeqXxNluX5zkliF77CETg6Fi2pu/V7bNG
         v6GLI+rxJhIoRWUEnleHkclSHdW8c+JUhFVe70vW/PVUROWTewBKExQTb3iT6aeYCkQn
         +C3ZI+0PTbnm14G71mdYGkSn+X29n2XIwVwnqFw6S/Mkwe0hi+NA4EjDkHl/FO/moxmC
         I8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sEQRu2hrB2sPswCDMnmdwB6n6ZIOI2c/Ar/qj62wZNw=;
        b=elsHuZj91V7QlD8f2NcWS6wmAwtdTy1a2hjQkAkT2XzM+FSxNSzIiJrsANmNdF/FGP
         Ni6IzilLFxWmoRCp+WaVwFAgLWYHA3+V5Ta/wtD6rLe08R0AXGxOI8lnOH0wLpmTFt57
         ZWWDKsIblMjGb4usHGZRIn5sx+iBGMl8G2L7SU3ANt6k/TCESamxvk5WNBSwcErX2gal
         qwIID4hUEgytrbs8suGh65dK5j7do0qu5+YzlBuNf8RF8f0wJdUDBGPhGGy/PYYZEbWe
         EGJBpsVilnlh4iXzt0dPuuCzT8SzhMFjm3vchXhLUuXuIbttwPsamQff0fI/e4z/xUi5
         hEKw==
X-Gm-Message-State: AOAM532lkob4PU8YZ7ev0CFWREsT3k9Cp/hjXB0H0Lxb8QxAHCxvDve5
        Ee+MvQTgtliU2vODcb65f4qq1dooblT7faKW00k=
X-Google-Smtp-Source: ABdhPJwzBAA/WVEgDuvbUnJne28mTYr8W1qMmOloeue2QXinYSsYc2kyOHWwnWqdzSewd68salm2YQ==
X-Received: by 2002:a17:90b:384d:: with SMTP id nl13mr656306pjb.46.1643008249678;
        Sun, 23 Jan 2022 23:10:49 -0800 (PST)
Received: from ubuntu.localdomain ([103.226.226.130])
        by smtp.googlemail.com with ESMTPSA id k15sm2548575pff.39.2022.01.23.23.10.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jan 2022 23:10:48 -0800 (PST)
From:   ratnesh-r1 <me.ratnesh682@gmail.com>
Cc:     me.ratnesh682@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: android: ashmem: Declared file operation with const keyword
Date:   Sun, 23 Jan 2022 23:09:47 -0800
Message-Id: <1643008187-75859-1-git-send-email-me.ratnesh682@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

warning found by checkpatch.pl script.

Signed-off-by: ratnesh-r1 <me.ratnesh682@gmail.com>
---
 drivers/staging/android/ashmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
index c05a214..f9cfa15 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -367,7 +367,7 @@ ashmem_vmfile_get_unmapped_area(struct file *file, unsigned long addr,
 
 static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	static struct file_operations vmfile_fops;
+	static const struct file_operations vmfile_fops;
 	struct ashmem_area *asma = file->private_data;
 	int ret = 0;
 
-- 
2.7.4

