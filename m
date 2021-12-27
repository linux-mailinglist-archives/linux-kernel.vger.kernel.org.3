Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB4247FBE1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 11:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236122AbhL0Kn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 05:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236006AbhL0KnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 05:43:25 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46628C06173E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 02:43:25 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so10740928wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 02:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6D1iaBgXOAkMH79XbQmEXP2lg5qLQCLAwgOT3lAeyto=;
        b=jVLvQO/SkxwSpmG2aYr+vTlUlNYWzDiK8cbDvVIMs/ifRD/i2BmYE9rFPu5ximZqG5
         7p0fllhwni7cE6XGcp46ssIipffO6Ji+5BzpzyyE49Gxik7fna7WnodGaA7HUiIOUrCj
         KH3I1dPmJ3ROYEi7hP6hhlZjVjr3Mdiq+lSyptO8CHvGAIa+qQTQhpdfsIcDt+2NsHdp
         RNrnxgWPs6HgOs59tpRznxDKDTL5CMkBFww0AN75UsT0a2pJN3dzDWttf0/BUMa9AGyS
         xAdxMEjb6lxmm98ohwbVroKcGUPI5Wuxf/1URtckLVFyCQaqKmv61Cfc8dQa94m2l68M
         IBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6D1iaBgXOAkMH79XbQmEXP2lg5qLQCLAwgOT3lAeyto=;
        b=BTCN7rhi7sDd6svh0qpfsBEtBvEzgdIMdRzw0VrFXzg02wIiEgtjTlOvNX+Ngr6gfE
         YI/WoxzJE9wU9MsOk5JAU0wNth7edFx011sxANKdwPM/67cbB5rUrZ2QL35GYKyM7f0m
         pSfgrhp1iY2QSt7RqCYvvWrn1SLSLCXUPRdxLn5dWOpOKlR3ngx2NzchYPtAGyW7jVeG
         N1jOauBljImahcTZmqV6xLJT5Umn1CbhRXPtkDewCkoF5TKJpAEsdBcASoX8eqrydnd/
         W//4RNkFgDovvS4s4LRxjl0envYR+CDveMJjduEC5yuOC8ARO/PWErzm5CgIchYUdGIY
         embA==
X-Gm-Message-State: AOAM533PTbkPyUglyi2txuVmIHjuhIJmvNN5VAcve9ZB4M0Reo7F3YXm
        zrQTZFCty1x4+YRBl9pOQgUAbmgcyds=
X-Google-Smtp-Source: ABdhPJxhedIKRHvaF6GcsvxZqnYw0kYidOc1LXXNsn+OGSOKPv04pzC935HNvh57x5N694hQ3DiXrA==
X-Received: by 2002:a7b:c3c5:: with SMTP id t5mr1403286wmj.168.1640601803924;
        Mon, 27 Dec 2021 02:43:23 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::abe6])
        by smtp.gmail.com with ESMTPSA id w17sm16089205wmc.14.2021.12.27.02.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 02:43:23 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: remove unused enum odm_h2c_cmd
Date:   Mon, 27 Dec 2021 11:43:12 +0100
Message-Id: <20211227104312.13163-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enum odm_h2c_cmd is not used in this driver. Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/odm_interface.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
index 64c29c1da19d..e27ba77577a7 100644
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ b/drivers/staging/r8188eu/include/odm_interface.h
@@ -4,13 +4,6 @@
 #ifndef	__ODM_INTERFACE_H__
 #define __ODM_INTERFACE_H__
 
-enum odm_h2c_cmd {
-	ODM_H2C_RSSI_REPORT = 0,
-	ODM_H2C_PSD_RESULT= 1,
-	ODM_H2C_PathDiv = 2,
-	ODM_MAX_H2CCMD
-};
-
 /*  2012/02/17 MH For non-MP compile pass only. Linux does not support workitem. */
 /*  Suggest HW team to use thread instead of workitem. Windows also support the feature. */
 typedef void (*RT_WORKITEM_CALL_BACK)(void *pContext);
-- 
2.34.1

