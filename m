Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0DD0468DD6
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 23:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240546AbhLEXCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 18:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhLEXCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 18:02:31 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E65C061714;
        Sun,  5 Dec 2021 14:59:03 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v11so18533483wrw.10;
        Sun, 05 Dec 2021 14:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zr34TvOO3d1JB7j0fqyV15v/GgihB6ko7fQCW6kZ+78=;
        b=AaV9GNH0Zd+OZWL3E0OUtUavJOzaAJ5UpOzM114x1era4POTjWYy1aOyPUWrYtf6+m
         JHqmUtOg2m4ohAy36eORzgWhrLo6ZO/96u6smh9DWP2XBeO7LdTPolDDF8GAyqSLfZ23
         GLXWUYVgTsikaIaBAXYCJGYggTqvHzk3P3t2ArclTjUytQmsWUYadBXAdcI7bye5hiBt
         FzGpbM1pzwStE5hSVG028WfH8jrW15J+rCx0PPDCPGqrcgTesBJAfx+UxD/WnanfhZyP
         buiqBlSPuTYpfj/ijYZnRpk0AjpsXHga4gbbB68WQ9rZe0ah1hHVUswLcX3mDuKNXvWN
         dH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zr34TvOO3d1JB7j0fqyV15v/GgihB6ko7fQCW6kZ+78=;
        b=5fAhN8yOjK2saoCP7WUg+netT3M1Cj0+GVitW5oaCXK+J2kCJJWhJ4mYPkKK28OQBp
         6qxn/kAU0KPsrK6gEx7hmVsUfskBqOCfJJvbXzddjGYDxRXrOqvH31IO17kD0w9Zej4o
         kT9SsfL26JpekCechJ6pGx6xzXOdaDnzXYmMVzZLAXiSntvthvE2lOO9yZ6nZVji5A3L
         NI0LucPL2iYtRe5Wr9sHulUfwpPxrHR2tvhqeHKSefUKke/YtDpwSSRU1UnfurGE/C90
         pTT3WB31SbtORWYfsArT1dv3op6yOThpR9S0+Qr7ui0Ht8cI24uflAbhzGi+y2V1RrXH
         aGQQ==
X-Gm-Message-State: AOAM530aXU2IazMiL3h8qBcWRr0RmDxqKnbt6o3Vnk3N4R05DtYh+SOK
        NeoCCyrHLcIB4bCUDlfX75k=
X-Google-Smtp-Source: ABdhPJzfD3Pz4UhKfYwmPQpOGrTMcSC4EJBm2nc+AmxUni2rSzrx1hMSTD+1uFI9rdtqkxWkhPtEVA==
X-Received: by 2002:adf:f90a:: with SMTP id b10mr37479813wrr.255.1638745142475;
        Sun, 05 Dec 2021 14:59:02 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id q24sm11352331wmj.21.2021.12.05.14.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 14:59:01 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: mptfusion: remove redundant variable r
Date:   Sun,  5 Dec 2021 22:59:01 +0000
Message-Id: <20211205225901.54362-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable r is being assigned a value that is never read. The assignment
is redundant and so is the variable, so remove these. Remove unnecessary
the {} braces in the if statement too.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/message/fusion/mptbase.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index b94d5e4fdc23..24a4532053e4 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -1274,8 +1274,6 @@ mpt_send_handshake_request(u8 cb_idx, MPT_ADAPTER *ioc, int reqBytes, u32 *req,
 static int
 mpt_host_page_access_control(MPT_ADAPTER *ioc, u8 access_control_value, int sleepFlag)
 {
-	int	 r = 0;
-
 	/* return if in use */
 	if (CHIPREG_READ32(&ioc->chip->Doorbell)
 	    & MPI_DOORBELL_ACTIVE)
@@ -1289,9 +1287,9 @@ mpt_host_page_access_control(MPT_ADAPTER *ioc, u8 access_control_value, int slee
 		 (access_control_value<<12)));
 
 	/* Wait for IOC to clear Doorbell Status bit */
-	if ((r = WaitForDoorbellAck(ioc, 5, sleepFlag)) < 0) {
+	if (WaitForDoorbellAck(ioc, 5, sleepFlag) < 0)
 		return -2;
-	}else
+	else
 		return 0;
 }
 
-- 
2.33.1

