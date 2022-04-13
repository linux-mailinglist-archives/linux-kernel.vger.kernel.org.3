Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF4E4FFFCE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 22:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238659AbiDMUOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 16:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237250AbiDMUOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 16:14:08 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8BF7CB24
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 13:11:46 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id o18so2191848qtk.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 13:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mu1OAjP3SMnZkiz81iTb0qSVH6tSWJDl8+n68t1vXxE=;
        b=BvJqGIXBkaxZ6cFuP/skqWxhW0WFquWrQFsXQyCwtTZDbrsG7wPCFnMl9VAo1hRimX
         5K4rp/x3o6C2ap3DrWJculrIIVqUrjX4f2Z5EBQAzoamuHRAB5jxD3z2l0nwzgunCtwi
         buWTwmi9fLz09m6yv/ENfSUlEwADTUpUeQesL+JCgKyT6LqcZa9yK0dRabPg67s/nLmr
         clYqTZFuFcTn8xL31/iIhirgMMZq8/9p+j+do206zI8XSNr1a7jfRFlYteLTMK82xQtk
         /wNUqhrx3gPIEEBhtUEXJ/bmZ9K1TIyI+0ufOFWsjpdbRnOwbxgUbpcLGPQqBqkZiEA0
         fnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mu1OAjP3SMnZkiz81iTb0qSVH6tSWJDl8+n68t1vXxE=;
        b=lozzwQenzVXSvZsT4HJnJcWVJjq++BW5duQ3hgT2SbwqtekIFbNnVe4S660USuj8wj
         qW1FRKRHRR7nxelbNXSIavoY1cEgR71HXLTpmxJ1Y9uX9w8JyQLsK4JHmCk6vIE91Mpx
         Dd4hNbEVTXyMmFBmrbiSZ+Fhk3X02psxcTGZ6H5+D+T2GdZ5pAknwsO5/ia7EBNDBRcx
         U0R6EnbtFR3MqmtDd/UuBRlwoAKXjG7A864RfRSLWxISYADpVOI5A/A5qrwmw1LfVTqJ
         Gqp6jHtLCC3uIE9GIHvsDCBMKl1X6r2Wb3dTLs+wH5KOhBfcqZ+ZBj30e+B/BUVNQO/R
         qMzQ==
X-Gm-Message-State: AOAM532ic7oxwzTiZwNDcuQrsqULwqDRvyLjjc/cmOYdxHNpGCvhbjw8
        ao/1P55ce02v5mhG2mbOaAI=
X-Google-Smtp-Source: ABdhPJzWCouMMzzabzOWqJItVPit5N6AJ34ifKNKxlogdLuP54DDtWbfXAVgf9JrI/WQqR5+J+CISg==
X-Received: by 2002:ac8:5f46:0:b0:2e1:da61:9734 with SMTP id y6-20020ac85f46000000b002e1da619734mr8625056qta.205.1649880705951;
        Wed, 13 Apr 2022 13:11:45 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme.wework.com ([4.34.18.218])
        by smtp.gmail.com with ESMTPSA id 7-20020a370907000000b0069c5598584esm1469827qkj.105.2022.04.13.13.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 13:11:45 -0700 (PDT)
From:   Jaehee Park <jhpark1013@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, jhpark1013@gmail.com,
        Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH 3/6] staging: r8188eu: remove 'added by' author comments
Date:   Wed, 13 Apr 2022 16:11:31 -0400
Message-Id: <c0c0a0e748ad85585b65e73841d431adefe86a59.1649880454.git.jhpark1013@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1649880454.git.jhpark1013@gmail.com>
References: <cover.1649880454.git.jhpark1013@gmail.com>
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
through the file. Git will keep history so these comments can be
removed from the code.

Suggested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 2cfd8e8d74a4..5adef9b9108d 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -909,7 +909,6 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 			memset((u8 *)&psta->dot11txpn, 0, sizeof(union pn48));
 			memset((u8 *)&psta->dot11rxpn, 0, sizeof(union pn48));
 		}
-		/*	Commented by Albert 2012/07/21 */
 		/*	When doing the WPS, the wps_ie_len won't equal to 0 */
 		/*	And the Wi-Fi driver shouldn't allow the data packet to be tramsmitted. */
 		if (padapter->securitypriv.wps_ie_len != 0) {
@@ -1628,9 +1627,6 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
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

