Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BD44ED88B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 13:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbiCaLeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 07:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbiCaLef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 07:34:35 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F291834C9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 04:32:48 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id kl29so19480812qvb.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 04:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=bc/PXIbfsZzVLQeoRR3CqcpGDJosJWCkO2fVBiONc1Q=;
        b=IuANEAlikqk+/VwxizAK1a+Ql93DgV1MBbrzqKiKcQ6uMpYb+HW9tBrX71WStTgsQL
         ark9m1886ou6JooOdEUxV3R+yAlu3Vb3UtEd9HO/E0JexD5S+/GyMPLze5coFzguUS96
         D2JDmXv/wxVhS4HUcvf+xfRk9PQuNueIOMloGKTZCqlfMs6V8fjpShlajBOue4QV4+nU
         p7ioBtADZ9jKIrXJDS1POSpS2OtBS/HtXvcsyYY+Fxwn/d7BbERl2L/LesgYFXK9ZkGm
         NPrGK40P4wq+nxf73GxvyJFRlsULnWgCJ4JNk9MP8FttHmb2awxZoJA/xTocCI6fpecA
         GHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=bc/PXIbfsZzVLQeoRR3CqcpGDJosJWCkO2fVBiONc1Q=;
        b=GzscHYgReSkHQoLXkE/NjUGpaNCDnQN5eXdxTQiRwqE6x84bcrJXB1aKN46B46TR7q
         U0T2gVN0KgjfvHKzIF8NSmhzgutxo5amRh/xwzgknyv9fGa7okyjliSczfoVnj/8qM8b
         1wDStlxdjp+yE5j8lTu6bKZqgrP0B6Sy6akCvJwApJ3Xqiwf3PY5mJgV1/efJYWGJBAA
         usrmBfg9ROyN0SUuqXqgydi4GinaN9J2z0097YxLb4tK4sNjO/U7RTQsFqyXaBd091Q5
         YT7pUnna/8Qcp1CH6UlOZ4bhD9G+uqVKIlVHuSX/cCuKQiqjhH8EP6CnZ5xN6IjQPevu
         7OWg==
X-Gm-Message-State: AOAM531EFxUpIWXWwVWIXApLR3TsMC+cog454rkg1miE33ZcnRZMO5WT
        ofM1w6udFWzXUyixW/rizdxxA3CdNsoPKRft
X-Google-Smtp-Source: ABdhPJwZk6l8e5XgH/f35IcfjChMbG+vK++077j9LhGcXMxWN6sv/fSrQ9EjdnlX0JxKc2zNdYlYaA==
X-Received: by 2002:a05:6214:528d:b0:441:4702:6263 with SMTP id kj13-20020a056214528d00b0044147026263mr3373484qvb.125.1648726367405;
        Thu, 31 Mar 2022 04:32:47 -0700 (PDT)
Received: from euclid ([71.58.109.160])
        by smtp.gmail.com with ESMTPSA id bs32-20020a05620a472000b0067d4560a516sm12743636qkb.32.2022.03.31.04.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 04:32:46 -0700 (PDT)
Date:   Thu, 31 Mar 2022 07:32:45 -0400
From:   Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: [PATCH v2] staging: rtl8723bs: remove redundant braces in if
 statements
Message-ID: <20220331113245.GA425141@euclid>
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

Adhere to Linux kernel coding style.

Reported by checkpatch:

WARNING: braces {} are not necessary for single statement blocks

Signed-off-by: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
---

v1 -> v2: Rewrite the commit message to confirm to the established conventions.(Thanks to Alison Schofield <alison.schofield.com>.) 

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

