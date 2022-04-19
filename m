Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6610507931
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357197AbiDSSbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357364AbiDSS2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:28:03 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CE6101C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:19:50 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id x24so4477498qtq.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zAEWfiSxwr2Il19zyqW+S8ONLOaXBz+c5Ud0bIaAXWg=;
        b=IxLrn3O0wpui7HsyiCQ+VSsXdeY4MZ3MV2nsNb6ykBxKxnQTRond47N06Nn/FFNwsD
         nMIA1MmhCc01FPfh1wQLL50iq/cDc9lGGGAgd/xCFqsw33CCu1LR3AVaO5aLrYK9e8EZ
         IQ0hQ/DqZ1m8+bIN4qDI8h3ohDnQiZU09EURm+m8TrwJqN2Cog19Jrm6ovFmOWKmmiEQ
         o77/l8blGpVO1bbfxN8nkqj4S9+EM1E4D6E/rjN5CcXMcBJ1UMvTEFw12fW4Im2+o42U
         0KQPBDPaHp64UvPO7gkR34+aJY92TOeNMR6/uC5/rMjs2lRfZELEA4WYS3yRUe7l1Kub
         ajwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zAEWfiSxwr2Il19zyqW+S8ONLOaXBz+c5Ud0bIaAXWg=;
        b=uKjYoE+htMLyMKhJjxn0PCxxMzpLfNjC0JuX2+sySUrViEegOWnJ8A9bqKAoYztVnu
         Ck6OV4P8jB5JcNu/iYZxHh9mtNwp0aXSxeKB0gxmBw/aNTtM6kjabKCjTvwBJGESAKZj
         nTEaegShtCWyefuqAkjEyVnYVYs2dCUrh/uTuifXTSZtLLxJhI84jKyfBfQTYMdM+HxL
         p1OPloZ2NuCz0WMkkhzOpYwk/T3n2mSKcJcIq98mWNBf5XxwIipuVB5kria64Vg3XYDD
         J9Y8rHrCYsvkmQC2VrfbADqG+nVKTatkylmnloGHtGXxQl8DKgSAUc8xwaagap7Faj3j
         Dvyw==
X-Gm-Message-State: AOAM531oRS45qfzhKVaab0MbZM3WgC0KJ+hWO0tOGlX8sHDAR6LIrUdu
        vylCNnBCSms1oJcOd6KHXM4=
X-Google-Smtp-Source: ABdhPJyCQuDGwrjDv5Mynk98pWFI0CjX4ZZdb9g3WEcuWhKRC7H6R2h+Y3gBstV0smAuwS3n9aGr5w==
X-Received: by 2002:ac8:7e89:0:b0:2f1:e3b4:d596 with SMTP id w9-20020ac87e89000000b002f1e3b4d596mr11701645qtj.432.1650392389685;
        Tue, 19 Apr 2022 11:19:49 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme.wework.com ([4.34.18.218])
        by smtp.gmail.com with ESMTPSA id e126-20020a376984000000b0069c86b28524sm373334qkc.19.2022.04.19.11.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 11:19:49 -0700 (PDT)
From:   Jaehee Park <jhpark1013@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, jhpark1013@gmail.com,
        Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH v3 3/7] staging: r8188eu: remove 'added by' author comments
Date:   Tue, 19 Apr 2022 14:19:34 -0400
Message-Id: <dca590fd83ccf81b2ad2980eb00819e78ab0580e.1650392020.git.jhpark1013@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1650392020.git.jhpark1013@gmail.com>
References: <cover.1650392020.git.jhpark1013@gmail.com>
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

Suggested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 72963ed7b665..47f528c14b25 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -891,7 +891,6 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 			memset((u8 *)&psta->dot11txpn, 0, sizeof(union pn48));
 			memset((u8 *)&psta->dot11rxpn, 0, sizeof(union pn48));
 		}
-		/*	Commented by Albert 2012/07/21 */
 		/*	When doing the WPS, the wps_ie_len won't equal to 0 */
 		/*	And the Wi-Fi driver shouldn't allow the data packet to be tramsmitted. */
 		if (padapter->securitypriv.wps_ie_len != 0) {
@@ -1610,9 +1609,6 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
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

