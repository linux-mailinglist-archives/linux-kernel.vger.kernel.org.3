Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3086548270B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 09:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbiAAIST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 03:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiAAISL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 03:18:11 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84898C06173F
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jan 2022 00:18:10 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id i22so59572386wrb.13
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jan 2022 00:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=df3Y5Bn/VrrxiPw//+w6cx+2LKPl8gWDj/0uHtI1CM0=;
        b=aOv0J6t/QsEzD6fRmR6ObgtEJcbNbQvfK0pEA6WGYf6i8L4nvmpoSjii8r6qsb/fcF
         fuwIK0b6uZayUpQGhOJUGLbr9MzhuVVK7QK1t7s73aXCZyY4AbMbRwziWV8O9tLThlgi
         YXD/ERSTYJQbrZWJ/N1TzjGjWHihfmSKXm76sb8gUQ/Q81r1Q+pAuD/No85HHPLYZXeV
         usy7g3Y49yWmQYXoP1ccA7cyyvm1pKTp/tWuj9Uq4EJs44es6/BCD4g8TYrArS8bbGX4
         f0rAMVVPF4mpUj0Yooy2xiOJrF8AlMF4zQhRwtCEixdLgGRrCriRaP041l+ItUnwPdfQ
         0mCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=df3Y5Bn/VrrxiPw//+w6cx+2LKPl8gWDj/0uHtI1CM0=;
        b=i5USDdoFaUUr4DP9ZdI/u8Vdaqw2z71RftijJ3acw7oeHePPchHZNbYY7/zJP5OWYO
         O7mrjkDSoxQn13eLZ5mdPMFEHq7bwEybdVQip6tK0XPLf9SkNGpCOlQOXJG/26cqu618
         uIRpculnmqxBpAtzzHWFX3BASVxRbNdEp8nC63iGXEn3QAlXEEuvxMyFv9ne956lz91h
         I/Bz9NRm2YCipvCX+Kk3gwWkYLsbRpXiaRrkNGrZQA53eHIwUCDBV535s0ZqPNueSO3Y
         WnwoiJT7huBGYBvef7Y+5slx64q7V7RMDPEYlMXqdm8c2ATsKlSUFWenMNEfjkYIkiVB
         aLsA==
X-Gm-Message-State: AOAM5307mjGdcqjocBC0Za0zpZchgxmN/D6QIgaXLboAxx/TpKpQlCpV
        Bc/Q9vMKjOsioZ+nFR9mYY0=
X-Google-Smtp-Source: ABdhPJxad99z1MbSk9y/fKaDaVUSYx8S6KMiDGBFiwBOoOTbvVMU66uJ0qyhawudDmYqp0HFKzXN7A==
X-Received: by 2002:a5d:6709:: with SMTP id o9mr31470420wru.356.1641025089198;
        Sat, 01 Jan 2022 00:18:09 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id u9sm30693651wmm.7.2022.01.01.00.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jan 2022 00:18:08 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 7/7] staging: r8188eu: FwRsvdPageStartOffset is set but never used
Date:   Sat,  1 Jan 2022 09:17:58 +0100
Message-Id: <20220101081758.9716-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220101081758.9716-1-straube.linux@gmail.com>
References: <20220101081758.9716-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field FwRsvdPageStartOffset of struct hal_data_8188e is set but
never used. Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
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

