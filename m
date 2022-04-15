Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEB95020BD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 04:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236622AbiDOCvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 22:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348991AbiDOCvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 22:51:17 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1410CB3DE7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 19:48:49 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id b17so5726586qvf.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 19:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5A0iA12DjE2Xj3oy9Ql9XeQvXRDjoLwHOA0RLzS8BtA=;
        b=Kt3n3LeBcKw1ZOw7sJPczy6niRGgP1zaVmb1h2ZKFd7Trl5hILhNxeAwpliosVYxfB
         rX9hRaoJWi/By5k1bWGtDyL9Wa4Skl6p/qG9S5EsZst4JfDiS+ENNJoADRE7L5sRUQcm
         8ncR+ehvbPsk3Jr8mQCrj+/zDjwtr4j5ADKT+B5VrFwKzCi9Tjapju8cpyjW1kaVMfSO
         53OwU8UazEpaA+zZXOmiV5EJu0AUWx49LNhxdt/H3HAuJtFXWCyv6uPMyowmltlv1dTF
         p2FencsA92C2GO5NPWZkCMijo4xCeDeaK1sas8n43uU8PjbMgA32ETBWrko8oPtmSZ7B
         E5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5A0iA12DjE2Xj3oy9Ql9XeQvXRDjoLwHOA0RLzS8BtA=;
        b=uGbq+Do0fGzx2nuq7AOuDsWJscUf1AvUC9EjyYlllZUTcYJEEMxFEqI0K0KR4UJfdb
         jtvUSyHRX5N/RCZhQbRpDtzsPxKLfgIiNh+bWoJnyoO6HB/hXR7JlLg23ARkNfuY4VKS
         8SpzSmEBwwHF7gPQzDPC9SkRzVAZ1aDPbrdddCk/+RehG8OQVET+Ke0fFXDM+QY7xW4c
         kRprsbI971dOWnQwgLyLZy9aNtkcPN4N8943O++Vrnu/YunpVZwsm2zjIdtN5CVbEzKE
         E3dnPc2+Timw/cUaBZ103sGKKy6IvMhDSDQ5GQfg3eFhVNOmhA/qsmZZqTZWMvRZ3c5X
         hOhw==
X-Gm-Message-State: AOAM5329x5Pli7rLWf9wRg4AK1TOtmu5md7TDCz4BtnUNB8t/5qXsLTQ
        tTIp2EYa2Bddth/clz+xiag=
X-Google-Smtp-Source: ABdhPJz1dzwq53DhHYwCxThDEjWcaTnzYPO2a0RsEGbxEj+H71G9rhqjxIqxyJwnTkp1ohzCNfJzPw==
X-Received: by 2002:ad4:5dc9:0:b0:443:b9e9:31ee with SMTP id m9-20020ad45dc9000000b00443b9e931eemr6088842qvh.111.1649990928205;
        Thu, 14 Apr 2022 19:48:48 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme.lan ([2607:fb90:1b7a:2349:50b1:5db4:a2d5:7054])
        by smtp.gmail.com with ESMTPSA id p7-20020a05620a22a700b0069c37e2c473sm1800085qkh.94.2022.04.14.19.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 19:48:47 -0700 (PDT)
From:   Jaehee Park <jhpark1013@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, jhpark1013@gmail.com,
        Pavel Skripkin <paskripkin@gmail.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH v2 3/6] staging: r8188eu: remove 'added by' author comments
Date:   Thu, 14 Apr 2022 22:48:34 -0400
Message-Id: <c0eaa7cbc61d89967d81ef864c1a791f4adb1978.1649990500.git.jhpark1013@gmail.com>
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

Author comments "Added by Albert" and "Added by Annie" are sprinkled
through the file. These comments are not useful and can be removed.

Reviewed-by: Pavel Skripkin <paskripkin@gmail.com>
Suggested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 1620ca181bf7..bb9d595a90b9 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -903,7 +903,6 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 			memset((u8 *)&psta->dot11txpn, 0, sizeof(union pn48));
 			memset((u8 *)&psta->dot11rxpn, 0, sizeof(union pn48));
 		}
-		/*	Commented by Albert 2012/07/21 */
 		/*	When doing the WPS, the wps_ie_len won't equal to 0 */
 		/*	And the Wi-Fi driver shouldn't allow the data packet to be tramsmitted. */
 		if (padapter->securitypriv.wps_ie_len != 0) {
@@ -1622,9 +1621,6 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 	return ielength;
 }
 
-/*  */
-/*  Ported from 8185: IsInPreAuthKeyList(). (Renamed from SecIsInPreAuthKeyList(), 2006-10-13.) */
-/*  Added by Annie, 2006-05-07. */
 /*  */
 /*  Search by BSSID, */
 /*  Return Value: */
-- 
2.25.1

