Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03AF7481DAE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 16:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238283AbhL3P3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 10:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236492AbhL3P3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 10:29:37 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACD1C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 07:29:37 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id mj19so21452317pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 07:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=DfKSM4slpHzll8KI1SeyD0sbe9XXp4yDafX/XdIzOm4=;
        b=L5aB5CptZtyhJNX7xwv2wp+8LqN6wgd1jvWHBbMxeoMBA/QOmbvxc8GiDnFy1b6F15
         Qli5IaOsPC9ScPzMpQ5yBfTe1eQHVAbO+7o5QG74twFAvh2FNo/2I45NsSxgawom2vzN
         08HQ33qmA8nIgJyVG1vtijj0aN3azjgs18IIROMskrlYPIzVRO0kXIGTLjWGIoHue9Q4
         s15zQxglXgAIRUOvChlfOgtFA6n4jCWYccUbb8SWAGFcdsttq616eBlHq0S5a1Cp1TXq
         CrV/4dkMBBD4+8YQmd3iBBX0Mdv1tfzH4KtpKMD9f0Oo/l+C/8KmaQcXesbGzgUZt1Oq
         wcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=DfKSM4slpHzll8KI1SeyD0sbe9XXp4yDafX/XdIzOm4=;
        b=dJ0fefcHPYNZ30f4Vs0SgDIIqv557qPcy3bRxrDkn5p+jHrha3YCTzcHDTQ1lWCtbA
         oaSs/BJAbF8E81PULUg9KvctmSfpd2OtgfLNIBo64ZW0vpf66HMMWdRoStedhSJMUVJy
         AWoq15BkJLl55nBtsCN/Cot1XJ52oMOVpLes4sUZikZtuD9o4BkPU0NdCvsE4TBjoubE
         hWjgq0OoJ2ucWjAdNq1GOWTr1U/I4/bcJTryCEcbNHBw+EAPwyD40tOONgdPh8xeuzAf
         WJyBf+0BtFg3n8Cg6bzRT9qg/lJnDRUNJ4/fjOzrWUNuryWjNemzr3ySnj7C2hqOOeiT
         o5Pw==
X-Gm-Message-State: AOAM5318qXarUl+P+Seopd8L3d/+yYag/DbGUGpdxi1k1RdgBBwKS+Nw
        +wRgJtL9qmGLhmQI+lkWCrE=
X-Google-Smtp-Source: ABdhPJy18VHoyexWgS3Rlc3AmrkMTPwrHjuL1y6L904p+94Om3PReo8J+N0VFuR+KDy5SoqJUtunQg==
X-Received: by 2002:a17:90a:a60d:: with SMTP id c13mr18232470pjq.72.1640878176839;
        Thu, 30 Dec 2021 07:29:36 -0800 (PST)
Received: from localhost.localdomain (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id h2sm26080085pfh.55.2021.12.30.07.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 07:29:36 -0800 (PST)
Date:   Fri, 31 Dec 2021 04:29:31 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, realwakka@gmail.com,
        paulo.miguel.almeida.rodenas@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: pi433: add comment to rx_lock mutex definition
Message-ID: <20211230152931.GA6157@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch reports: CHECK: struct mutex definition without comment.
Fix this by documenting what rx_mutex struct is used for in pi433 driver.

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
v3: wrote a more succinct desc so it doesn't become out-of-date (Req: Greg k-h) 
v2: ellaborate on reasons why the mutex lock is used in the driver (Req: Greg k-h)
v1: https://lore.kernel.org/lkml/20211222093626.GA13332@localhost.localdomain/

---
 drivers/staging/pi433/pi433_if.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 29bd37669059..68c09fa016ed 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -92,7 +92,7 @@ struct pi433_device {
 	u32			rx_bytes_to_drop;
 	u32			rx_bytes_dropped;
 	unsigned int		rx_position;
-	struct mutex		rx_lock;
+	struct mutex		rx_lock; /* protects rx_* variable accesses */
 	wait_queue_head_t	rx_wait_queue;
 
 	/* fifo wait queue */
-- 
2.25.4

