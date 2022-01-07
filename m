Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387154875B4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 11:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346777AbiAGKhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 05:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346803AbiAGKgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 05:36:43 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D35C034009
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 02:36:40 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id q25so11820842edb.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 02:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X7rszZizH89dSbfSfGmlz97XSOoPDVqc24nyseEzr4c=;
        b=CqUJ/ETNRo08TkqIWFe64tXrwbngg+wRvlCRwV/VPrLRl3jAs+S4QASRoWP5eHiryO
         mn+4fQ6X10UUV08opZ5ACbfQxvCLxhvAf9+VBD2uE+qycUCIuY3xL01iytUvao1KZKjX
         Y00GcasC+q607lyK2u6hhAHLPIL+mV4EBXCY3ZUSMvMT+DJpLmJCDZ8/IhoSB3uyGpjr
         RJLaU548rSMKJ2+D+XKMwcxn4fYYN9sVrkGOWmQo8g4JakX3+MFwA0kxMrQGol4cu4N9
         jezWijyriqqumPtwfLzoWWIzXqcSq5z36iTvtBvsXIlrBF2d91+aJMfbwC/LqLmlTBmH
         QzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X7rszZizH89dSbfSfGmlz97XSOoPDVqc24nyseEzr4c=;
        b=340iv0plw+/iauB20ujqREEUZZXtnOH87JXMaVs1i6nqLwe1asjCJtONAg18fwtUhC
         NP7AmKPFgMmbnVThiS6OIowW19KefkhuetWrogXOksoaTZAsI4dwdpTTDAsRu8l3eB3m
         skzgJvWN2Yx1ZBcAxu61vPx0L2W6QNShu/QQAeqqyD8l2tE0GZtkhdPCzk0BrTQTGmpt
         zfGCv3nNg4/xtjXBujUcMGcD4hLkILwzqXLKuON2bvk+WNxaDPBeoVFXdhGeXMLeZmq3
         /vcvlcU4u/qBGVnlcC2wPmfidG1NGi4EjjDugkccMBPB/35LJNP2qjwKp02MVTSC+aQ2
         CFZQ==
X-Gm-Message-State: AOAM532Zk3zMlE42XbvbpUbPiF/jKo2ihDlmfJX79D1U+9fxyNx4+BAB
        n0XN8Kv7OIPpuQMsmry2AYE=
X-Google-Smtp-Source: ABdhPJxezvuXX8rUJcgdt9IHum4R/sSKlaHQJqtHAYz90KNedXscKdejd9i726iRiZQG1R7BFDzLog==
X-Received: by 2002:a05:6402:2686:: with SMTP id w6mr60509694edd.79.1641551799372;
        Fri, 07 Jan 2022 02:36:39 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::51e2])
        by smtp.gmail.com with ESMTPSA id v8sm1869857edt.10.2022.01.07.02.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 02:36:39 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 16/19] staging: r8188eu: rename writeFW_retry
Date:   Fri,  7 Jan 2022 11:36:17 +0100
Message-Id: <20220107103620.15648-17-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107103620.15648-1-straube.linux@gmail.com>
References: <20220107103620.15648-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the variable writeFW_retry in rtl8188e_firmware_download()
to avoid camel case.

writeFW_retry -> write_fw_retry

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 6c23966ec785..15e8dc0b9a37 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -542,7 +542,7 @@ static int load_firmware(struct rt_firmware *rtfw, struct device *device)
 int rtl8188e_firmware_download(struct adapter *padapter)
 {
 	int ret = _SUCCESS;
-	u8 writeFW_retry = 0;
+	u8 write_fw_retry = 0;
 	u32 fwdl_start_time;
 	struct dvobj_priv *dvobj = adapter_to_dvobj(padapter);
 	struct device *device = dvobj_to_dev(dvobj);
@@ -594,11 +594,11 @@ int rtl8188e_firmware_download(struct adapter *padapter)
 		ret = write_fw(padapter, pFirmwareBuf, FirmwareLen);
 
 		if (ret == _SUCCESS ||
-		    (rtw_get_passing_time_ms(fwdl_start_time) > 500 && writeFW_retry++ >= 3))
+		    (rtw_get_passing_time_ms(fwdl_start_time) > 500 && write_fw_retry++ >= 3))
 			break;
 
-		DBG_88E("%s writeFW_retry:%u, time after fwdl_start_time:%ums\n",
-			__func__, writeFW_retry, rtw_get_passing_time_ms(fwdl_start_time)
+		DBG_88E("%s write_fw_retry:%u, time after fwdl_start_time:%ums\n",
+			__func__, write_fw_retry, rtw_get_passing_time_ms(fwdl_start_time)
 		);
 	}
 	fw_download_enable(padapter, false);
-- 
2.34.1

