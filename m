Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFF54F012A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 13:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345096AbiDBLjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 07:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241009AbiDBLjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 07:39:42 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7795055487
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 04:37:50 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r7so3153301wmq.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 04:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UNK8OhCeK4rmwZvR4A3qAZLXLFUIr17oQ7dG4uqRe6A=;
        b=ELPhKmWuSQKrDY4BEa3MKUAqJF1yY1ZI0idrpW1+DxhhugWw2GK8dy9P9PML4TdVI/
         dNKz/RmqH59NgHuqS7+XHMRxAn/fa0t/j4BRXMsx57S63M7hJVyrJbxkV7JwYcb2e0Ql
         hMeUDFGpTQU7c9YCDW/5aR+4+wolzmmiRcmtY4py0KJ2dbFUxpH0uW/NqOEXMOf4cJY4
         RJa81IFzU/JUIFIAVLPA+O+L8ImbuyTNoJKjzqWZFT+FHRYsg5WcWRdF8ohLgYMKtOhj
         +yFehLsVRUmTq+XvJzKyZ9kGjuVhT4pE1jNNiQaTcxD9Q4tcz30SCyoIRYlpGkz5/w7A
         wsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UNK8OhCeK4rmwZvR4A3qAZLXLFUIr17oQ7dG4uqRe6A=;
        b=iNjjceFewHHLTLa3/aVWjvyuzlksHfdAopO3G27Ewlf3J+qg1ZGC3VZeX7/wdyC2XH
         cKk1cnkigrPGrevv9Z4Bc2JIyHWCnqNU6s1wEvpXG933irWuQPh0Vlg0gddcQsZ+fvDA
         fo9yZSARe/AzaUeWIEQA4Ge8bmdMzOkH3Os0B1kuf9idJIEFp3wChV+RbVNhFtN6Hlwv
         qfYu04gxxn76L7/AnJEkq2AuQ3zkI2apJnhYQTcVwI0304l6Id4uoD5GR5k5TJoFkfcz
         Va8y4/UP+PGzxC1VRN92jOkMYZcyKtA1OUybL/ASnWSThKgShIYMitPJlsf2gYk4qLUr
         nAOw==
X-Gm-Message-State: AOAM530YSuR8c2QSE36uwum9L7VYVOY/wy/pzmwXyDQpxrxg+OgXbWLg
        6hPRtfxTQOGe3eh1AAsMiao=
X-Google-Smtp-Source: ABdhPJxYQqilR+RsfX9il5l3P37nHrs4rE4fexyfQ9QHCWriRz+cHYB8jomIVj7JjfJgz++5+wlauA==
X-Received: by 2002:a05:600c:1d04:b0:38c:ba2f:88ba with SMTP id l4-20020a05600c1d0400b0038cba2f88bamr12142174wms.137.1648899468986;
        Sat, 02 Apr 2022 04:37:48 -0700 (PDT)
Received: from alaa-emad ([197.57.138.121])
        by smtp.gmail.com with ESMTPSA id az19-20020a05600c601300b0038cadf3aa69sm18132376wmb.36.2022.04.02.04.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 04:37:48 -0700 (PDT)
From:   Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, eng.alaamohamedsoliman.am@gmail.com
Subject: [PATCH 2/2] staging: wlan-ng: Fix Alignment with parenthesis
Date:   Sat,  2 Apr 2022 13:37:33 +0200
Message-Id: <08641d36aaee60797f8c68683b013ebf0215ba2e.1648899123.git.eng.alaamohamedsoliman.am@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648899123.git.eng.alaamohamedsoliman.am@gmail.com>
References: <cover.1648899123.git.eng.alaamohamedsoliman.am@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix " CHECK: Alignment should match open parenthesis "
Reported by checkpath

Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
---
 drivers/staging/wlan-ng/cfg80211.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
index 69d616f19cff..87379edce9a8 100644
--- a/drivers/staging/wlan-ng/cfg80211.c
+++ b/drivers/staging/wlan-ng/cfg80211.c
@@ -475,7 +475,7 @@ static int prism2_connect(struct wiphy *wiphy, struct net_device *dev,
 				return -EINVAL;
 
 			result = prism2_domibset_uint32(wlandev,
-				DIDMIB_DOT11SMT_PRIVACYTABLE_WEPDEFAULTKEYID,
+							DIDMIB_DOT11SMT_PRIVACYTABLE_WEPDEFAULTKEYID,
 				sme->key_idx);
 			if (result)
 				goto exit;
@@ -587,7 +587,7 @@ static int prism2_set_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
 		data = MBM_TO_DBM(mbm);
 
 	result = prism2_domibset_uint32(wlandev,
-		DIDMIB_DOT11PHY_TXPOWERTABLE_CURRENTTXPOWERLEVEL,
+					DIDMIB_DOT11PHY_TXPOWERTABLE_CURRENTTXPOWERLEVEL,
 		data);
 
 	if (result) {
-- 
2.35.1

