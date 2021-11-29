Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B9A4627ED
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 00:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237386AbhK2XPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 18:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbhK2XPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:15:31 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC46C04CBCF;
        Mon, 29 Nov 2021 14:50:16 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id az34-20020a05600c602200b0033bf8662572so13464510wmb.0;
        Mon, 29 Nov 2021 14:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oCItfQrF3pFthBv5apV+T7MQM52J5h814Lyaip/Txlk=;
        b=hb2EbMBHEZsyJScJ7KTa4Tj999QAkptzC6ntYgv37EDfJ7KQgy2uS9WgvTROZyUd69
         usKJCGM9MFQkg2rAwFGk2KdDyenWV2BUblGW/9ZLiKO/De+xMEgA4nz7k8arE/zcycMw
         bsGKT75KC1H2moROa2y8XBHaNPfJo3vd4hgD8VVEBKd8cTxytrhXmomGvM9BevuZ+mE6
         X4F13c5dxL906iVWzJW77DOqyRT9SVEziiBqsq81TNhXLSwC0ZyTdO+SRMDxVz/M1PX0
         nFjfI3I8mLe66aOVh+4je8GmxxWZ+LCizALv/1QFf0zCCQehbX4BurlpQYWVrnKd5S+H
         t58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oCItfQrF3pFthBv5apV+T7MQM52J5h814Lyaip/Txlk=;
        b=aRLvD9CqfFYHzzfSBQp9DimvrbvNJPMII4lVj2z9Us8ySCFLtKtiStIztwOoYxloW4
         C9I+Huaa6EPvWKxgrPHbMNTw0Yr2g4k7hQqku1nV/gdjCJfBGk8DC7UiNVOOCLct+Wqc
         IiZe0MwoTjssiYQpQ8nmMX7OBi+QzWCH0Q5s35GleIxiL6b9feQXLcpWF30g0K74rNRs
         6uMKj+Vtg0uRY3WxfSmmvTfJoxwhMPjPXZoeUqytxNM3QT+mDZprHx9M1V1YO8q4EHHS
         lsUnMCeqSbvFyJGWYumq5qLhXfkMaJYofiu1JiaVRWYme8ZZhMwqjd+vbXZQI2QAGZTt
         Xy8A==
X-Gm-Message-State: AOAM532yaoiaM3/yDuB20C0/cnRocL2uokX9/Kk/2YU5mjWh64R+qyHz
        5BT20guXrXArIBHXjATC9OYAtj8=
X-Google-Smtp-Source: ABdhPJzUkGXOlfuxxwXQTJGUTJKT9MY35cx6i+h46PBKMoFb7jkD0GqQg0n8taYJj5JHk1LkSn6jgQ==
X-Received: by 2002:a7b:c8c2:: with SMTP id f2mr881848wml.63.1638226214843;
        Mon, 29 Nov 2021 14:50:14 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id g13sm562731wmk.37.2021.11.29.14.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 14:50:14 -0800 (PST)
From:   Colin Ian King <colin.i.king@googlemail.com>
X-Google-Original-From: Colin Ian King <colin.i.king@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192u: make array queuetopipe static const
Date:   Mon, 29 Nov 2021 22:50:13 +0000
Message-Id: <20211129225013.524016-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Don't populate the array queuetopipe on the stack but instead make it
static const. Also makes the object code smaller by ~50 bytes.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index f5d9e81f4ac7..364e1ca94f70 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -2531,13 +2531,13 @@ static short rtl8192_init(struct net_device *dev)
 #ifdef PIPE12
 	{
 		int i = 0;
-		u8 queuetopipe[] = {3, 2, 1, 0, 4, 8, 7, 6, 5};
+		static const u8 queuetopipe[] = {3, 2, 1, 0, 4, 8, 7, 6, 5};
 
 		memcpy(priv->txqueue_to_outpipemap, queuetopipe, 9);
 	}
 #else
 	{
-		u8 queuetopipe[] = {3, 2, 1, 0, 4, 4, 0, 4, 4};
+		const u8 queuetopipe[] = {3, 2, 1, 0, 4, 4, 0, 4, 4};
 
 		memcpy(priv->txqueue_to_outpipemap, queuetopipe, 9);
 	}
-- 
2.33.1

