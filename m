Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525CF4875AC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 11:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346898AbiAGKgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 05:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346728AbiAGKgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 05:36:33 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE061C061245
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 02:36:32 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id q25so11819510edb.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 02:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hOYa/Gi5v31kcrKlzzu9euD1DAeNv4WGiHXPNjrNRdQ=;
        b=Vm9tZ006yUXtSWLPdam/Y3WkqL75YPp7x3/03JsC7NUYS7xDKdBWjb9H65665oRLCq
         elunfjYFhdEhJi5/v/SpjgtWLf+k11Kx6ehdLIJBZawtc8NBg8WAXd0rqvVuhdLYmu5+
         XgC5L5/k2TCxhIfHoczdWnjabCP0oxvSAeq61eVw/dfe28iThMMeCx7+eCrDVTMYWAMU
         VYElDqg5PSBNhBJO9s1QK0p9ZVHLDxwp2Bh6ZlscraJA/i6rOmZnWKMyuOIJwasA+Tue
         mUpzM+f4EkAO3zrw2FpgRGAHDplo1khNoQ1eT55trIPd1vv9iXSir9tq/hgnQk/75u13
         kcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hOYa/Gi5v31kcrKlzzu9euD1DAeNv4WGiHXPNjrNRdQ=;
        b=zp1XQMPvTo3psul01TJBzgHA7Yz7XOfvXU/+l59WLqOpUpeXUecKLR1fJjn1+gZ2F8
         Fk5wHfMLyei8Bl/+FZSfUb6nT5sncCZ3MXsAmc+n84ycYCM5DIa0KncJM8p7AujDdXxE
         MV5XtRizX2cYG37pwPXYtMDn43dfdhllpdzH8yAUfDthuDIOL1826xMrUoRMmbap5gaD
         NX7R9Swws/yKCCJT/VR7YkGPAoHy1/lasE+f9hKtGIdhNbXIO5HMYp+UXYvr2dbzWDBt
         Qr1i1KsvxDUadwvlUH52dUr/ckXqIcXWh4gFZvxS7W/bXAuwb4sB26WTsS83LpevWgka
         OEvA==
X-Gm-Message-State: AOAM530hMFMpeWwSRMubqgc1DIEv79W06RzR8Bhx/KwPjq6KoMVCbCoY
        TrVNbaipMkWOWR0pXf3AlKo=
X-Google-Smtp-Source: ABdhPJwffJ5RyBiQJqvBGnW8VmEfy2YSN1fNI1A7fb6UP79sreqXnjmgUDn2sXVeQaQ8M1X1EX0IPA==
X-Received: by 2002:a17:906:608:: with SMTP id s8mr52890560ejb.754.1641551791386;
        Fri, 07 Jan 2022 02:36:31 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::51e2])
        by smtp.gmail.com with ESMTPSA id v8sm1869857edt.10.2022.01.07.02.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 02:36:31 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 04/19] staging: r8188eu: rename Exit label in load_firmware()
Date:   Fri,  7 Jan 2022 11:36:05 +0100
Message-Id: <20220107103620.15648-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107103620.15648-1-straube.linux@gmail.com>
References: <20220107103620.15648-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename Exit label in load_firmware() to avoid camel case.

Exit -> exit

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index cfafbb6c42f7..b4f29c48d58d 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -518,29 +518,29 @@ static int load_firmware(struct rt_firmware *pFirmware, struct device *device)
 	if (err) {
 		pr_err("Request firmware failed with error 0x%x\n", err);
 		rtStatus = _FAIL;
-		goto Exit;
+		goto exit;
 	}
 	if (!fw) {
 		pr_err("Firmware %s not available\n", fw_name);
 		rtStatus = _FAIL;
-		goto Exit;
+		goto exit;
 	}
 	if (fw->size > FW_8188E_SIZE) {
 		rtStatus = _FAIL;
-		goto Exit;
+		goto exit;
 	}
 
 	pFirmware->szFwBuffer = kzalloc(FW_8188E_SIZE, GFP_KERNEL);
 	if (!pFirmware->szFwBuffer) {
 		pr_err("Failed to allocate pFirmware->szFwBuffer\n");
 		rtStatus = _FAIL;
-		goto Exit;
+		goto exit;
 	}
 	memcpy(pFirmware->szFwBuffer, fw->data, fw->size);
 	pFirmware->ulFwLength = fw->size;
 	dev_dbg(device, "!bUsedWoWLANFw, FmrmwareLen:%d+\n", pFirmware->ulFwLength);
 
-Exit:
+exit:
 	release_firmware(fw);
 	return rtStatus;
 }
-- 
2.34.1

