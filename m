Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FA15020B3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 04:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349010AbiDOCva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 22:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349112AbiDOCvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 22:51:16 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F2AB3697
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 19:48:45 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id t2so3327068qta.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 19:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fqkAa0xDrLSxFAeOhD4dr36p7/F0dV1HG8oV8HDPNB8=;
        b=WlMDhbSX4y+lb1Nsiiuf/Cuc2eHIAw+CSaCHR0Ri0OAHahn6QuwAhOjhaDnASaEIIw
         6Jpx7fOUliznPDroTk0iFfV5hbfPacaNZQHslC/57B1jP+yYfhv1/AvFp4d76PpPRgHQ
         D/O3ytuYuLIPFvuEN83kpzHh6ZCJ7Qg+1AOOwokcpEpY3+Bm7HTSyzkv4nu8dfNwIZ2S
         tp8V/F9bAU8CIkw3cXt5Jw8aEhbHZgNdBRGfgMyshZTVRS+axX72ZJ3nPnS0u8vzisxa
         rVQ5c7zhLZezX50SJy3xu6J3hfpOBO+qNuxip5pfM9rsKDgmOk+iJipQOrupJxtUXmBU
         0B1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fqkAa0xDrLSxFAeOhD4dr36p7/F0dV1HG8oV8HDPNB8=;
        b=JMPT/r40/i3lieWfRgFdYjMXeO+HX9pv2IMelNu7JcIVHGPoCwTxSD/Q7aTHKFw9Fe
         qhLJaBrPbOn3jkMjExppJUOcbPp/Fk0UH4lB3l1w2lgo+4yJJgD20eLa5UNsWb3YFBNi
         syuEhQhmv3/ALfukUNij0q2Q2RZyln6soKUlGnYY0RUzsmsy7j/vc+DaGo+OLxMco7Ak
         /f9nWd9C/aixQMu+dBRb3TddO3nT4V2bcoh0lEprlLBmgajwwbPIV3sxq3z+QRWOeOMO
         RkdlRn18FH9yzupg+qWhm60oqw6wYcWJAm2Pmsf703KelGqaqbBBAu9GEFZt/ge2wbxW
         PpyA==
X-Gm-Message-State: AOAM530jW5JHg2DmyRwuy3Cq0qEW96OjxSE21esy1g5gRENmH0XhQuBi
        IZ1GX4Ywut3ddiRX3QaBAbEtv2RWnIPYHvN7
X-Google-Smtp-Source: ABdhPJwqZmj0qfgUb0PIyWQKSkAGo3aGIiwqrMOqrEBaiKBaOHLJA3RT1XS74B6DOSUOSsx4eSKqyA==
X-Received: by 2002:ac8:464e:0:b0:2f1:e40e:6e80 with SMTP id f14-20020ac8464e000000b002f1e40e6e80mr3452448qto.587.1649990924575;
        Thu, 14 Apr 2022 19:48:44 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme.lan ([2607:fb90:1b7a:2349:50b1:5db4:a2d5:7054])
        by smtp.gmail.com with ESMTPSA id p7-20020a05620a22a700b0069c37e2c473sm1800085qkh.94.2022.04.14.19.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 19:48:43 -0700 (PDT)
From:   Jaehee Park <jhpark1013@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, jhpark1013@gmail.com,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH v2 1/6] staging: r8188eu: remove unused member free_bss_buf
Date:   Thu, 14 Apr 2022 22:48:32 -0400
Message-Id: <e41e0d3b62395d04f41d6934074074c431e7aacc.1649990500.git.jhpark1013@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1649990500.git.jhpark1013@gmail.com>
References: <cover.1649990500.git.jhpark1013@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The free_bss_buf member of pmlmepriv is unused. Remove all related
lines.

Suggested-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
---
 drivers/staging/r8188eu/include/rtw_mlme.h | 1 -
 drivers/staging/r8188eu/core/rtw_mlme.c    | 7 -------
 2 files changed, 8 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_mlme.h b/drivers/staging/r8188eu/include/rtw_mlme.h
index 1dc1fbf049af..0f03ac43079c 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme.h
@@ -319,7 +319,6 @@ struct mlme_priv {
 	struct list_head *pscanned;
 	struct __queue free_bss_pool;
 	struct __queue scanned_queue;
-	u8 *free_bss_buf;
 	u8	key_mask; /* use to restore wep key after hal_init */
 	u32	num_of_scanned;
 
diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 3e9882f89f76..aed868d1d47b 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -61,7 +61,6 @@ static int _rtw_init_mlme_priv(struct adapter *padapter)
 		res = _FAIL;
 		goto exit;
 	}
-	pmlmepriv->free_bss_buf = pbuf;
 
 	pnetwork = (struct wlan_network *)pbuf;
 
@@ -109,13 +108,7 @@ void rtw_free_mlme_priv_ie_data(struct mlme_priv *pmlmepriv)
 
 void _rtw_free_mlme_priv(struct mlme_priv *pmlmepriv)
 {
-
 	rtw_free_mlme_priv_ie_data(pmlmepriv);
-
-	if (pmlmepriv) {
-		vfree(pmlmepriv->free_bss_buf);
-	}
-
 }
 
 struct	wlan_network *_rtw_alloc_network(struct	mlme_priv *pmlmepriv)/* _queue *free_queue) */
-- 
2.25.1

