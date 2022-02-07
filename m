Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E554ACD4C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbiBHBE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343611AbiBGXmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 18:42:43 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EF6C061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 15:42:41 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id s185so18818260oie.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 15:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X94FZ2c+7TUXwZqG/jE1cAOFdmfyxcJBnlGMdedsJC0=;
        b=EEKRZvEo5wj8N0q0UazmMypoDWIzYj1SS/fXmHO1sqtNkhMVbrCRUiMCrKYkMeCx/A
         P+XQa5R/00XOevC4mc/SJ8/E3zA9DemKHgMSzKxZHVE6hxcFvSWAFoW9ulhXxGeySoV0
         /65iUadXmZYasgRtATsjOhYWm7vsiO0Bzen5UU7clkaivpJwXqAZF0Fpz/StHIIsMLxV
         /qjBwGKsYY1VwF/rTtOhaZdwXGTjJV21S7sJAz3lEADVRCfouU6J1O1/BiF+O7MpBgVB
         WTtBz1CE9VWApuIMr8AHs4drbcqBr0k5xEXn+QfhPKTPNdkpgj7v1GPtF+F6/5KNYsu7
         z7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X94FZ2c+7TUXwZqG/jE1cAOFdmfyxcJBnlGMdedsJC0=;
        b=LaT78VMnD5eyCFmunISTZPOo8H81qW77Y+caIj6dHeD0ejxVVkB5nXqu1346JISlpz
         0O/v5Gl3yscmO/172lLsKmh+BX9UIvXiHxF0UAFbAvHhK8tByIsSQhL8oJ5vtnzHg2kl
         9UF8PIuiNwlTQzmjwhCG2cXQbDFPvI3YDYWiwJKtvj9HWZx98MikaBnfLxDUxsT6kmct
         gEA4rx8VlOVCUdNVvtTwOUt5+fRmnexDl7syH0J+kb+I86YWag+JhyR6tHWweiLp4n6Q
         Lccb/X9ulOqJpXsqRg9+Z/mrmA8yGWOXbmtpx1PCL1O/bMksAxlk95UcG7IpXxCMDqM1
         jmPg==
X-Gm-Message-State: AOAM53341/evPVpgkwcCJvYLij5JzpBSiu60rCbrnxWHCtr5oZjWODZG
        Uu1y9rl/BZYVa5NjI4A7DSU=
X-Google-Smtp-Source: ABdhPJwex7LwSxsPOqDgiTeSbxDjuSKwRYmdSxhr9EFfsRIDBn7ix6ZU0W0bEvpF5TJxPYOnGM5Pdg==
X-Received: by 2002:a05:6808:2188:: with SMTP id be8mr620443oib.63.1644277360326;
        Mon, 07 Feb 2022 15:42:40 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:4cd8:12bf:4134:806a:5a4a:2a88])
        by smtp.gmail.com with ESMTPSA id w20sm4590903ooe.3.2022.02.07.15.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 15:42:39 -0800 (PST)
From:   Leonardo Araujo <leonardo.aa88@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Leonardo Araujo <leonardo.aa88@gmail.com>
Subject: [PATCH] Staging: r8188eu: core: 'associcated' may be misspelled - perhaps 'associated'?
Date:   Mon,  7 Feb 2022 20:42:10 -0300
Message-Id: <20220207234210.26097-1-leonardo.aa88@gmail.com>
X-Mailer: git-send-email 2.29.0
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

This patch fixes the following checkpatch.pl warning:

CHECK: 'associcated' may be misspelled - perhaps 'associated'?

Signed-off-by: Leonardo Araujo <leonardo.aa88@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index 1675e2e8439c..e02dd8e11c95 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -819,7 +819,7 @@ static int rtw_ht_operation_update(struct adapter *padapter)
 
 void associated_clients_update(struct adapter *padapter, u8 updated)
 {
-	/* update associcated stations cap. */
+	/* update associated stations cap. */
 	if (updated) {
 		struct list_head *phead, *plist;
 		struct sta_info *psta = NULL;
@@ -972,7 +972,7 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 		update_beacon(padapter, _HT_ADD_INFO_IE_, NULL, true);
 	}
 
-	/* update associcated stations cap. */
+	/* update associated stations cap. */
 	associated_clients_update(padapter,  beacon_updated);
 
 	DBG_88E("%s, updated =%d\n", __func__, beacon_updated);
@@ -1036,7 +1036,7 @@ u8 bss_cap_update_on_sta_leave(struct adapter *padapter, struct sta_info *psta)
 		update_beacon(padapter, _HT_ADD_INFO_IE_, NULL, true);
 	}
 
-	/* update associcated stations cap. */
+	/* update associated stations cap. */
 
 	DBG_88E("%s, updated =%d\n", __func__, beacon_updated);
 
-- 
2.29.0

