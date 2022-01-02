Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C68482B5A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 14:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbiABNMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 08:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233022AbiABNL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 08:11:58 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7C2C061784
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 05:11:57 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id k18so28166800wrg.11
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jan 2022 05:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6ZgZw9wf8OGtp2Nl0K0C4zc2uLMgL4ndeZt9CPVyiWU=;
        b=pa3dIGdaZfWPxIEeb379ecQ0Vmos1Eo9DsFATDbGnN4AbMCGxE8HEHh/7TaHHe+NSp
         EjLELbMWCyGbRT1yWVfmeCHouEIzhdNMOXQZEP0vzPzcdquxqxEZtiN/DFaJ3bKxGwzV
         OktsjJKFeJxrQT1h6Z/pyloFO8ipam52YDpgl6IlcO2Nr1+lM6zPH49KEkEjsNWhYVkI
         T9dfRxG/IP342b3VyaSqDzL7wNH/54uxvABiDHlL4oC/t80imtFLLfZikDtMvh3PYKUW
         KYe/FF2Vv+SOD5h+Cz7ik6ZqH3owEkgh8KpS6wbydHkATC5tvuLeiVfwXlVVtH765SSh
         GMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6ZgZw9wf8OGtp2Nl0K0C4zc2uLMgL4ndeZt9CPVyiWU=;
        b=6OMA8z0TN+YJLOrOTVCZzjR7tfQwFx0tc8QZ143lqLQaEAA6WkXHXrGzTr3jsxJNkH
         p+KMBWx0oJpnuKhWKsQu80+AC6iS8C0kyvMOhG5bPGT+tcDKDJzrPWXP/gWUJvTdEjvA
         DiUVYJ8+m0JOpm/kiNqvTwRES+tjmiHpX73KtruSyRDH3HGTaiVAcfS7O3c0R3wZsOSD
         pHiNhAxbUSYqivsKmguDJHiDme0zvH9HnbY0IEU8VfUoxVfEjzKCBrHuqdEDZMtdgAwf
         ZMFpBbcLyT66EA5l6xBLgbwvCGvFyj4DWz4cHwlgFSL4/dLmQSEtP/3Ib5hX4mgFCpGS
         6ZpA==
X-Gm-Message-State: AOAM532YtPQBZ+JTwCBRPbLXx89pz8kRNAQT2g/tEd0PJEIwrrHPTj8+
        BaOPaLFmGSPINAE09rRXXM4=
X-Google-Smtp-Source: ABdhPJzAqgsEsLfXaAbvpa/F/JEGaNjegI+7/8b29VEC/agbUon4ouMME5AZZdwEwkM7HcJeWnJwVA==
X-Received: by 2002:adf:fb86:: with SMTP id a6mr34467549wrr.35.1641129116622;
        Sun, 02 Jan 2022 05:11:56 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id m35sm65640044wms.1.2022.01.02.05.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 05:11:56 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 04/11] staging: r8188eu: struct rx_hpc is not used
Date:   Sun,  2 Jan 2022 14:11:34 +0100
Message-Id: <20220102131141.12310-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220102131141.12310-1-straube.linux@gmail.com>
References: <20220102131141.12310-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The structure rx_hpc is not used. Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/odm.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 793068778833..46fdc87a5e2f 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -75,20 +75,6 @@ struct false_alarm_stats {
 	u32	Cnt_BW_LSC;	/* Gary */
 };
 
-struct rx_hpc {
-	u8		RXHP_flag;
-	u8		PSD_func_trigger;
-	u8		PSD_bitmap_RXHP[80];
-	u8		Pre_IGI;
-	u8		Cur_IGI;
-	u8		Pre_pw_th;
-	u8		Cur_pw_th;
-	bool		First_time_enter;
-	bool		RXHP_enable;
-	u8		TP_Mode;
-	struct timer_list PSDTimer;
-};
-
 #define ODM_ASSOCIATE_ENTRY_NUM	32 /*  Max size of AsocEntry[]. */
 
 struct sw_ant_switch {
-- 
2.34.1

