Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7563A48390D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 00:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiACX0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 18:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbiACX0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 18:26:22 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74562C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 15:26:22 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id h1so22608614pls.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 15:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=TImvYhTQWFr0YfBVbpdLjvTy76TIgj121A4b+zqdZXg=;
        b=Zkkzhoe4agRWHMotPs+Mof8gpE/7yF/Lo7HcEHVkqDLyS7yl7k7X4kovUADnYCRvct
         ThFimL4c/NLbv4sgzVjfE6dat0CFb6GogVwF55Sm6WgnIoHxNscF5T/L2Pftxr4XWdid
         RZd5ltdt6mDGuYu4bVbdFiSmPU/963gQYFkjEIiBBJBElWrnqcoEdSaJoej1fss+nbAM
         RzL3v2nI/rDhcLRcFDeWGl/8200l0663KfWGRk012DKJw8G8W4n3INrx7H692lmxccdo
         3pZlMSFlzmGuJEb18ZrkD7055cMrVPNhLNXd1OXcHMl+/sTH6CaloT6tXx0ND7QtMlMh
         JzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=TImvYhTQWFr0YfBVbpdLjvTy76TIgj121A4b+zqdZXg=;
        b=scSEP7qCnyItxC3323EJqe3Bn7TTrBrNjyqPFOW6MNXBoq3DdeZsdZOtnfTi7kdu2u
         HsGelxp839MWLO98HX6UahVwL0qQgdA090pmKGF6lZrVf62oHsBcgkA8YP5iWW08T0HL
         KcKS9LqytoNdG5P78QNXBQSXfXCH9WwpyHaOfSPymYWKXbYVBL18pjzj3nvFZ0wpte5V
         qVPPbAxD8hz//htaHzsW8uK9eLd863N/GKE/9ZVxqjJwhke+m5PWWF4ZGbu3dL+PWV4z
         uhN0lJuQkobncS6bdF9y5+WyiDIQjUjFsAE3i5OOUhtiW4qo84pOOzbra70NXRXsk5Qf
         /uFg==
X-Gm-Message-State: AOAM531Wvng3jWMM20ArMnfMwZFfo9iFeLhemkeBl9kOo9hd6yp/JSAq
        TnApQUD6qt7Kua8TdSMJwmk=
X-Google-Smtp-Source: ABdhPJxFB/gL4NQWSORjKPYNmCqHT7u3Y87gUgAVvHj8FiNUnY88bZEjcOB8VCbtuf6lD9mXakaa1w==
X-Received: by 2002:a17:903:228b:b0:149:29da:e624 with SMTP id b11-20020a170903228b00b0014929dae624mr47136411plh.77.1641252382016;
        Mon, 03 Jan 2022 15:26:22 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id q19sm40531132pfk.153.2022.01.03.15.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 15:26:21 -0800 (PST)
Date:   Tue, 4 Jan 2022 12:26:16 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, realwakka@gmail.com,
        paulo.miguel.almeida.rodenas@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4] staging: pi433: add comment to rx_lock mutex definition
Message-ID: <20220103232616.GA11161@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdL6QzDK26W5WnaD@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch reports: CHECK: struct mutex definition without comment.
Fix this by documenting what rx_mutex struct is used for in pi433
driver.

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
v4: wrap changelog comments at 72 columns where possible (Req:
 Greg k-h)
v3: wrote a more succinct desc so it doesn't become out-of-date (Req:
 Greg k-h)
v2: ellaborate on reasons why the mutex lock is used in driver (Req:
 Greg k-h)
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

