Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FB24EB78D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 02:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241510AbiC3AyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 20:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241408AbiC3AyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 20:54:15 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11910CA0E8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 17:52:32 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id e22so15749363qvf.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 17:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=+sHB2K20EL//AH+6So4JQczV3z9OH1YB7s4Uv15wvfE=;
        b=Jj5lL1O8uvEtVWKfr5l1tByGRVtJko2A30NFWmU4LXBvjqGKBpv5biPxbO2Ic+Qek3
         WZU21PcjfD8/n2sIDQfKpFvMgSLV8rarGp1zxW4QbskbnV6Ee3ysw835MYA0laLXpveG
         rcfA+RGtz5lAHLb1YC7wn7AxMSv1IkUz141b0XQ+HiNT+Y1IgmurJrv9WGXaLVdei7k1
         jHxNZ3v9mIKyfP+DTRb8v+0uWb75QoUio8ND3XebB1vPL6uxiJ4REpwbVbdS7rpX4Edz
         fo02KAZ1FBPZej+3U72iSvhEb17v817LPtZvS6HOCnUuz+aLs5S1c/CJZGj0tO6ighbG
         56pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=+sHB2K20EL//AH+6So4JQczV3z9OH1YB7s4Uv15wvfE=;
        b=OBiswI1V6Hd6MtGz65dmVKQhSDv3bKuvlloj3pvn3GpdCDiJ1w6ZhAQXiKQnfXone9
         yo0Zj2lQjhFdQNh4BMrxNMWQ3yxI5dV3Jur9NnADcPwtH/yBCW1cRTT52knlK2j4LIfZ
         KrxrqFS4HJRSgWlgaGPYtNMFPWaoUS0tIvNKtVd8+wA/eKlMRMomPnp7oWnoY8kaLbqE
         2c67k+cOaoPD99UCjpTO214absTjPBZnINoutmqwkDXgQX2vFOPMKhszp44DWZOX9Gn0
         kgrAGlLtdi/zuBILALvjQdWOHuKmNXGtauiIrM6GXadlph1xE4rj8EVu+R8lXNRwRvd2
         R0tg==
X-Gm-Message-State: AOAM530p+UuZ3qYMIrC5vuZ3W81z3hP7iC5yOsIECsMpVe2BD7ck3Sbm
        HoNJPmFOgmXnfhq/1J6GpUs=
X-Google-Smtp-Source: ABdhPJxgOE1NKI9hmwdJ4V0TgoDjzjZaUV1wkMv6NwanObP7mGxtBqkddhRrCrpYVMH9kHpMTNYh4A==
X-Received: by 2002:a05:6214:c82:b0:441:1ec7:a225 with SMTP id r2-20020a0562140c8200b004411ec7a225mr28745677qvr.123.1648601551130;
        Tue, 29 Mar 2022 17:52:31 -0700 (PDT)
Received: from euclid ([71.58.109.160])
        by smtp.gmail.com with ESMTPSA id x20-20020ac85f14000000b002e1ee1c56c3sm16759682qta.76.2022.03.29.17.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 17:52:30 -0700 (PDT)
Date:   Tue, 29 Mar 2022 20:52:29 -0400
From:   Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: [PATCH v2] staging: rtl8723bs: remove redundant braces in if
 statements
Message-ID: <20220330005229.GA318642@euclid>
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

