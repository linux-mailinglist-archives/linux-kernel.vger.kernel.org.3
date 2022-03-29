Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DC14EB299
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 19:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240130AbiC2RXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 13:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbiC2RXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 13:23:07 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0EA17942F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 10:21:23 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id t2so15841427qtw.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 10:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=Kf1v8hS8vyA7Y5W9J43n/PAPUIUn4eGCoQYkh6AdKJ0=;
        b=Aa/bMcJenjtxFF5mhNT5iiE4M9JTC0iCsIzerOh5vuhT2TOu1A0cg7mP0Cly9SodV2
         1sfMfIIv5yxlIzS3b2XjQXxA1qfklG08+dQ8Uh2nIqSPX5g5MFT6oZ+VH4KJXzBUsgDZ
         tc0oUyCIOW3XL++hTPLa5WRZnog1dp3/QPxwgG8Vij6MOyXe2/0Xw5VVtFo3vlXqOogy
         3qyJDw8++eNDXTqH9XjUAmkVmkmS1IfjdoH0hzCyuT6Wzdioo8/59H+lZfGHHCZgqe2A
         dt7Olf5cRk5+BZ5K99oi+NaU80jGDnDRXhCJjPYNLCQ4H/Y9jmwpeukOvdiF0Jb8yXV8
         VSZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=Kf1v8hS8vyA7Y5W9J43n/PAPUIUn4eGCoQYkh6AdKJ0=;
        b=vVGT5tXdEO45fHXFJRnkI+fadOy9CSc6zSN5oIoFgp2Ced5HW8dujK0ARhNj1HXp4v
         TRx8jc904QbN2D0bKHyMpyKyucxEqbhs/NUPM8PLNRfb1dA2gSPpltPY/S4yJrI+v7d+
         9g6wnb0yupvVHuy3SpQ9UO/Tcvgtfk5945eP6R9Ji7Fcf1K7SoB55Ebly5f1MN9rhiMM
         E/sUwmw55RUvPV8jY/UyNLIGLwyvHGx6ef2cFXnYqwfhbKtgAmHMmZCHB6+rOiZMHrNB
         2pxc7VzUWkApeQXCDDXhNSTYrgquiiqh8HBZfSni5P+tTTxjXhAkbCHYOQ0o4DNu/RkK
         cbNA==
X-Gm-Message-State: AOAM5306tQPIHf4D0HaGo00v4Hz+wPtN8l6BdaygGWdvRgVBJkZ2m+9a
        ocUxCeikzqjTdeRReMZiEiw=
X-Google-Smtp-Source: ABdhPJzd+TvCfuNO8xYNBI86wdS+kYFzzEDJm5od6F+y3VVnDsW2sUTNvvOelHDWj5ejtlr0wtf54w==
X-Received: by 2002:a05:622a:1994:b0:2e1:a3dc:23dd with SMTP id u20-20020a05622a199400b002e1a3dc23ddmr29120672qtc.203.1648574482441;
        Tue, 29 Mar 2022 10:21:22 -0700 (PDT)
Received: from euclid ([104.39.252.111])
        by smtp.gmail.com with ESMTPSA id k73-20020a37a14c000000b0067b316a4161sm10082583qke.120.2022.03.29.10.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 10:21:21 -0700 (PDT)
Date:   Tue, 29 Mar 2022 13:21:20 -0400
From:   Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Muhammad Usama Anjum <musamaanjum@gmail.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: [PATCH] staging: rtl8723bs: Remove redundant braces in if statements.
Message-ID: <20220329172037.GA208840@euclid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following checkpatch.pl warning:

WARNING: braces {} are not necessary for single statement blocks

Signed-off-by: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 27de086903e2..68e41d99679d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -335,9 +335,8 @@ int rtw_generate_ie(struct registry_priv *pregistrypriv)
 
 	ie = rtw_set_ie(ie, WLAN_EID_IBSS_PARAMS, 2, (u8 *)&(pdev_network->configuration.atim_window), &sz);
 
-	if (rateLen > 8) {
+	if (rateLen > 8)
 		ie = rtw_set_ie(ie, WLAN_EID_EXT_SUPP_RATES, (rateLen - 8), (pdev_network->supported_rates + 8), &sz);
-	}
 
 	/* HT Cap. */
 	if ((pregistrypriv->wireless_mode & WIRELESS_11_24N) &&
@@ -366,9 +365,8 @@ unsigned char *rtw_get_wpa_ie(unsigned char *pie, int *wpa_ie_len, int limit)
 
 		if (pbuf) {
 			/* check if oui matches... */
-			if (memcmp((pbuf + 2), wpa_oui_type, sizeof(wpa_oui_type))) {
+			if (memcmp((pbuf + 2), wpa_oui_type, sizeof(wpa_oui_type)))
 				goto check_next_ie;
-			}
 
 			/* check version... */
 			memcpy((u8 *)&le_tmp, (pbuf + 6), sizeof(val16));
@@ -493,9 +491,8 @@ int rtw_parse_wpa_ie(u8 *wpa_ie, int wpa_ie_len, int *group_cipher, int *pairwis
 	if (is_8021x) {
 		if (left >= 6) {
 			pos += 2;
-			if (!memcmp(pos, SUITE_1X, 4)) {
+			if (!memcmp(pos, SUITE_1X, 4))
 				*is_8021x = 1;
-			}
 		}
 	}
 
@@ -514,9 +511,8 @@ int rtw_parse_wpa2_ie(u8 *rsn_ie, int rsn_ie_len, int *group_cipher, int *pairwi
 		return _FAIL;
 	}
 
-	if ((*rsn_ie != WLAN_EID_RSN) || (*(rsn_ie+1) != (u8)(rsn_ie_len - 2))) {
+	if ((*rsn_ie != WLAN_EID_RSN) || (*(rsn_ie+1) != (u8)(rsn_ie_len - 2)))
 		return _FAIL;
-	}
 
 	pos = rsn_ie;
 	pos += 4;
-- 
2.25.1

