Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE87F50A912
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391866AbiDUTXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391894AbiDUTXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:23:37 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C4E33882
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:20:43 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id bb21so4011243qtb.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jWtgrgCunJ7y2eDAedOrW5DZBPj0gqKyi2a7G2/e/4U=;
        b=kAW26HAITAbFAGVv0mM9r7y00YX31OV1dRygPiaqLdWdJzBeBEKEZNZHIxbLx9WOkW
         btvNY2sO6K/ieesQJ98dqudLJhtWtUUNyNSIRHfCnqZ5frxqHgAQz6NClgdRYAQRgZ6B
         laNadyJFcCsw67vkgQzjXdGJgo1CvPOPkD+YT4g6LeIzMMhM4uAe6SKlafNpsqb70fST
         ReP57qGKSUdcFmfRREz0jbqjLbgWoNciyjgTa1lVEnZXZHhwKHj8Hd/8NSubRJDOpl+R
         h4D+B5Fu/rXzQEpingwJDM0VKq51WLV7pRACX42n6WGxnAr5vxzv9qVoHAgkkVUpauiv
         eUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jWtgrgCunJ7y2eDAedOrW5DZBPj0gqKyi2a7G2/e/4U=;
        b=tZ13ZVJEvEik7u6+IhINKJdHoWq/9PXA6kIWrcClWq+HFbn47VBzhd4Uvw35Q+o4Re
         Is1pMpAHHFpWBap1+b1RPejD0bviQ1Cpm2gGu42Lsg5e8Zfhz9pCQ1DpqZRoyHF7Y3C/
         ZpxJLT1QxEDSFFafsrfh2lKGTZykIJhUXABD0FP8zUw1N9QctSBMw3TNTjOh1qB7movp
         uAYDqJtekG+hLmq4BJxTZvE3AiLlpMHuRdUWQ9yUZQroowyg999rgKlC7DgjaV8bWRpd
         nDFT0ebkeFFSWPoi8Kxs21SSp/XK0ABaFPJcGK/ckMzE5QFzz5tsR3mxysoY6QWOUbM6
         dnEg==
X-Gm-Message-State: AOAM533dtZEDH1y9FdgWkgmdsBAbBhuPVIUUIna06akhUAI+kYIWuYBw
        dTIme8SWf1jmdE9ahtIYnvA=
X-Google-Smtp-Source: ABdhPJz0Sf/4uOw6SGvqQ+a5x/bu+v79Td0Vm9arvLkFPYfsQM5zt7PHM/U9bdPm1KqkX8vXTmshvQ==
X-Received: by 2002:ac8:5a09:0:b0:2f1:ff1d:39df with SMTP id n9-20020ac85a09000000b002f1ff1d39dfmr731992qta.453.1650568842469;
        Thu, 21 Apr 2022 12:20:42 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme.wework.com ([4.34.18.218])
        by smtp.gmail.com with ESMTPSA id l9-20020a05622a174900b002f34421b01csm2567736qtk.23.2022.04.21.12.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 12:20:41 -0700 (PDT)
From:   Jaehee Park <jhpark1013@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, jhpark1013@gmail.com,
        Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH v4 3/7] staging: r8188eu: remove 'added by' author comments
Date:   Thu, 21 Apr 2022 15:20:28 -0400
Message-Id: <dd22bbe6b018aadec620d1ef8215e19852099f7c.1650568579.git.jhpark1013@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1650568579.git.jhpark1013@gmail.com>
References: <cover.1650568579.git.jhpark1013@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

