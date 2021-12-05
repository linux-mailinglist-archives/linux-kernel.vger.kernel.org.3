Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E5A468C5D
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 18:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236773AbhLERSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 12:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236692AbhLERSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 12:18:09 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7238C061354
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 09:14:41 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id r11so33197155edd.9
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 09:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2glchpcv+1d/9FAJVmf1wbGz2GHlcABraoRmMcJeBDE=;
        b=ThYljT54KLw3VNere9tNFOHbhwbiqMGLUJ1Cghoq/4+n4ArDolUzG129vx3WOnVRye
         F2s5Zv1ynSF3xs/Gkk5ifWa8DhlBPr1J/vjeazJb7MpJ3WsQfd9zehqGZ116MT5THjka
         eU3wJuVluhFO9nFYqBYDRzuAGB+MSeTfRHXrVQKPdZXTqoDGxYNnC5KlSsQ62JFK1jqY
         jp7wxzfCCtCTMR78/0gxucj9r6Q9kBXaRtji1SuG80iMEwX59fUJRh5xO+y1+gTmdMzC
         Imqmp89vyf0GKENM8228mrehrPgPLIfLrOJRn5Cww4E9QCtAaGRp8ehEVZs/qAwjY8MY
         n7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2glchpcv+1d/9FAJVmf1wbGz2GHlcABraoRmMcJeBDE=;
        b=sO0is60FTuQUDrPXn3dP+4myxcBuczW6+fwsEoyKB/580Je/EmN3rMouqz+6wgFEHq
         6TOl0AQRy3RiQsKFYlBQ8lwRHuFSLC0mkhiY/aG0X3dXUg1z00+5INTdRQ9Td8dnToQs
         FCu76K9h4kGzRgYhl0kHpeplMMoM1U7y6xApwtK/hcxPoR1kt9FL30pgg4a4z3RlHCsQ
         ySju1hvbhg7V5hV6glwwfCN6KDarfqO/VNdxKhEWMJn0OSPbmweqxCA+bNslaPgN80Dh
         Aq/4DIjQMZCGofHkcAml7K8Zdwe/PBnkh7qEtYu8XF4/S3hmzApQZ8+g4LcSuAAXRz4X
         JqhQ==
X-Gm-Message-State: AOAM5304tPSKAt8CsgMTKoFzfjo3xVQkp9gcdMeoxnyL8rYAfOYWFsLw
        eNc41TAfTIQ2wisunDPUiJ8=
X-Google-Smtp-Source: ABdhPJw9Y2h/cjKEeFIrXABQtA9tN4szsCU5TyPSrqIYeNmC4EofUggbMakcoU0aUNPkedE9O/ZjXA==
X-Received: by 2002:a17:907:3e22:: with SMTP id hp34mr39616946ejc.491.1638724480370;
        Sun, 05 Dec 2021 09:14:40 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::b792])
        by smtp.gmail.com with ESMTPSA id ch28sm6071773edb.72.2021.12.05.09.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 09:14:40 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 10/10] staging: r8188eu: remove unused macro IS_FW_81xxC
Date:   Sun,  5 Dec 2021 18:13:42 +0100
Message-Id: <20211205171342.20551-11-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205171342.20551-1-straube.linux@gmail.com>
References: <20211205171342.20551-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro IS_FW_81xxC is not used. Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 5791172fa5c4..3fbaccbbe775 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -508,8 +508,6 @@ static s32 _FWFreeToGo(struct adapter *padapter)
 	return _FAIL;
 }
 
-#define IS_FW_81xxC(padapter)	(((GET_HAL_DATA(padapter))->FirmwareSignature & 0xFFF0) == 0x88C0)
-
 static int load_firmware(struct rt_firmware *pFirmware, struct device *device)
 {
 	s32	rtStatus = _SUCCESS;
-- 
2.34.1

