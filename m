Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68873482720
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 09:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbiAAIuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 03:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbiAAItz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 03:49:55 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46220C06173F
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jan 2022 00:49:55 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id k18so22955036wrg.11
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jan 2022 00:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8r+cRr679ExYoNRZPV7FmhdQZm1WdYwZAxdxXDZnMJQ=;
        b=GLht4rLA6h25YdxDNBMSrXKlaclXLj6ZPHy2SE2xoG06FSzNulJFqPfD34NR3NQa7Z
         pC58ydUPVE6Gp5zQ4DcXAHWmI+EpYnSBmKeNjE6g8IOB4kVa0cQ1aH2E5n52PILWvVL0
         r5TBPpUIOxQY5lCGUfMyRDmsFXD27LLMPZ5vMbJcJN7uqu/ov81M62pFgWnoGci7wOtW
         SSfKjLvhs2EgvksgGkjkQG2QPvLmt1sL2pPANWN411nk2mppbvQc9qCVV6wW0d0H/rok
         Zf6okrSLm+Vfp7DFHmKudTZPVCZzmIAyHaa1tebY9zWznjL2qYOupmP3eIATa74d2fqi
         HDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8r+cRr679ExYoNRZPV7FmhdQZm1WdYwZAxdxXDZnMJQ=;
        b=AESpRAuutXj535QLQ6yiqVnwCxbBSKoi4kqDI+TFi+MP5EfOtX4xRTRks1N8Q8/G/N
         FC3YjsqduXBJx7YXLs5FIsCxM3A12YZkm3Cr0pUD4erZz6yWrpLg631N50BqJFvdeFhD
         sI5n/MQJ9zkFQ8zfAcSwQh5msGgi0cOelLYjajddr3uleCMN/QxxDYPsqUu5iQtCkoBB
         YhatL+LH/nYWuzOf/+A0mRbiq45Rbo5t08lWFgStHjcWndvoXX1GEuzHxWKDiXqLBPZN
         r5GK5RxYv/Sz3sP3dqlth3bgw8JpZK7O2ratnVWMrZGOeFsVcyzCb/dwFOYa0v4Rng3O
         WuXg==
X-Gm-Message-State: AOAM532cp0kFXK1UGlJYg2VNoDZoulbnPi53REyMbZ+HGTVPo8sfhdBk
        5s/t6gL7p3S6Peew2l7IaN4=
X-Google-Smtp-Source: ABdhPJynMXEHJPJe6VUcIi1V0sBoXvz6fresJ71AOZRmZg6VFV3q4fZWNMnSHgWyXgQxjbz2zuJevA==
X-Received: by 2002:a05:6000:2c2:: with SMTP id o2mr31923464wry.210.1641026993909;
        Sat, 01 Jan 2022 00:49:53 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::d7e8])
        by smtp.gmail.com with ESMTPSA id o9sm14806578wri.97.2022.01.01.00.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jan 2022 00:49:53 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 7/7] staging: r8188eu: FwRsvdPageStartOffset is set but never used
Date:   Sat,  1 Jan 2022 09:49:37 +0100
Message-Id: <20220101084937.3411-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220101084937.3411-1-straube.linux@gmail.com>
References: <20220101084937.3411-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field FwRsvdPageStartOffset of struct hal_data_8188e is set but
never used. Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v3: no changes
v2: no changes

 drivers/staging/r8188eu/hal/rtl8188e_cmd.c     | 3 ---
 drivers/staging/r8188eu/include/rtl8188e_hal.h | 2 --
 2 files changed, 5 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index ca24e17c369d..a491c37777df 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -440,7 +440,6 @@ void CheckFwRsvdPageContent(struct adapter *Adapter)
 /*  2009.10.15 by tynli. */
 static void SetFwRsvdPagePkt(struct adapter *adapt, bool bDLFinished)
 {
-	struct hal_data_8188e *haldata;
 	struct xmit_frame	*pmgntframe;
 	struct pkt_attrib	*pattrib;
 	struct xmit_priv *pxmitpriv;
@@ -461,7 +460,6 @@ static void SetFwRsvdPagePkt(struct adapter *adapt, bool bDLFinished)
 		return;
 	}
 
-	haldata = &adapt->haldata;
 	pxmitpriv = &adapt->xmitpriv;
 	pmlmeext = &adapt->mlmeextpriv;
 	pmlmeinfo = &pmlmeext->mlmext_info;
@@ -480,7 +478,6 @@ static void SetFwRsvdPagePkt(struct adapter *adapt, bool bDLFinished)
 	if (PageNeed == 1)
 		PageNeed += 1;
 	PageNum += PageNeed;
-	haldata->FwRsvdPageStartOffset = PageNum;
 
 	BufIndex += PageNeed * 128;
 
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 239d0db55639..25f3c04e81b7 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -230,8 +230,6 @@ struct hal_data_8188e {
 
 	u8	bDumpRxPkt;/* for debug */
 	u8	bDumpTxPkt;/* for debug */
-	u8	FwRsvdPageStartOffset; /* Reserve page start offset except
-					*  beacon in TxQ. */
 
 	u8	OutEpQueueSel;
 	u8	OutEpNumber;
-- 
2.34.1

