Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090A74EAF13
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 16:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237771AbiC2OKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 10:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237765AbiC2OKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 10:10:50 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DC133E1F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 07:09:07 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id 10so15301403qtz.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 07:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=CadD3hhKKTwQgUWh8yT3Nub3Kin1uglS1pMurhgrLiQ=;
        b=p6ae6wHr5ltI75bmz6MP1kBq3t6Kyi7FA0hKJcpbDRrtN1+emiMtn9q17vk1zBV2zm
         BcTUziWYInXtVko7X6CC21lYmuSiw5tqdXlgZioMJV8YLSV1IMaoESQY+SZDRP7VTlDe
         38WEDcMN8YQQTmP3rVfHU7tJHQ8rbVJo2jq//xwKVDhaObQRGo5Q8ayGyB5ddYCUr8b3
         xRypqXfR/o5Yth4EzO7d+esndkg2Yv4mUxTvlT9ZOmG1HCY1ScQdVreeuOEEMBrXfben
         O21iSGpAkTrNI8F+UpmGqq2MHxUe5RbVa5BuqaGISd5QhIp8Ij/HdP4eey2j+khneDP5
         a5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=CadD3hhKKTwQgUWh8yT3Nub3Kin1uglS1pMurhgrLiQ=;
        b=zfvmegsWpp0o9F/YyEJgq3S4+cDuLeVHFXhG6OQen7s7R2dCZjfA0IxtOaRCRQYPhE
         +m5AK8h+4AOiTxmpPZIh0z1HxHrACNMbPjF01EAPwVNLScIZnQFcf4kr7sygBwvalJxT
         ax0NN3Z/1DjY8rsOwq1fRAxi7xGANrS9fmoMeZjZbfJ8auBM1aM8XCu/zEiLQwDCvqq5
         j8SxhujoGw89Nlkh+TQzL3wUMw6CTjrmGK+Z3VMrDXeIExO01qtM1EOvzAT91nGQoq00
         R3zATELle25Bw3c2gj1GwC8Vv+0rcJGfJrCObAFysrpw8Ayd3+9O1rWAkF9xoCoiMJdy
         tFGg==
X-Gm-Message-State: AOAM5318ImW7w+HZgxvD/6TS4kdnJnO++GvY92SFMQZihTzZS91Mz8sc
        oTwd2A56UtxRCt6X4zrfW3c=
X-Google-Smtp-Source: ABdhPJxGl082pU/FH/JMQ3CRB0DA7rq9puCVcTW9raR8hcfYDGRaDgRVY0o8TZLm0KKmKMEopO7FZg==
X-Received: by 2002:a05:622a:1a8c:b0:2e1:d7b8:5c0d with SMTP id s12-20020a05622a1a8c00b002e1d7b85c0dmr27944510qtc.56.1648562945903;
        Tue, 29 Mar 2022 07:09:05 -0700 (PDT)
Received: from ubuntu ([104.39.252.111])
        by smtp.gmail.com with ESMTPSA id bm1-20020a05620a198100b0047bf910892bsm10194685qkb.65.2022.03.29.07.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 07:09:05 -0700 (PDT)
Date:   Tue, 29 Mar 2022 07:09:04 -0700
From:   Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Muhammad Usama Anjum <musamaanjum@gmail.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: [PATCH] staging: rtl8723bs: Remove redundant else branches.
Message-ID: <20220329140904.GA3566@ubuntu>
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

WARNING: else is not generally useful after a break or return

Signed-off-by: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
---
 .../staging/rtl8723bs/core/rtw_ieee80211.c    | 32 ++++++++-----------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index b449be537376..27de086903e2 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -94,16 +94,14 @@ bool rtw_is_cckratesonly_included(u8 *rate)
 
 int rtw_check_network_type(unsigned char *rate, int ratelen, int channel)
 {
-	if (channel > 14) {
+	if (channel > 14)
 		return WIRELESS_INVALID;
-	} else { /*  could be pure B, pure G, or B/G */
-		if (rtw_is_cckratesonly_included(rate))
-			return WIRELESS_11B;
-		else if (rtw_is_cckrates_included(rate))
-			return	WIRELESS_11BG;
-		else
-			return WIRELESS_11G;
-	}
+	/* could be pure B, pure G, or B/G */
+	if (rtw_is_cckratesonly_included(rate))
+		return WIRELESS_11B;
+	if (rtw_is_cckrates_included(rate))
+		return WIRELESS_11BG;
+	return WIRELESS_11G;
 }
 
 u8 *rtw_set_fixed_ie(unsigned char *pbuf, unsigned int len, unsigned char *source,
@@ -151,11 +149,10 @@ u8 *rtw_get_ie(u8 *pbuf, signed int index, signed int *len, signed int limit)
 		if (*p == index) {
 			*len = *(p + 1);
 			return p;
-		} else {
-			tmp = *(p + 1);
-			p += (tmp + 2);
-			i += (tmp + 2);
 		}
+		tmp = *(p + 1);
+		p += (tmp + 2);
+		i += (tmp + 2);
 		if (i >= limit)
 			break;
 	}
@@ -199,9 +196,8 @@ u8 *rtw_get_ie_ex(u8 *in_ie, uint in_len, u8 eid, u8 *oui, u8 oui_len, u8 *ie, u
 				*ielen = in_ie[cnt+1]+2;
 
 			break;
-		} else {
-			cnt += in_ie[cnt+1]+2; /* goto next */
 		}
+		cnt += in_ie[cnt+1]+2; /* goto next */
 	}
 
 	return target_ie;
@@ -697,9 +693,8 @@ u8 *rtw_get_wps_ie(u8 *in_ie, uint in_len, u8 *wps_ie, uint *wps_ielen)
 			cnt += in_ie[cnt+1]+2;
 
 			break;
-		} else {
-			cnt += in_ie[cnt+1]+2; /* goto next */
 		}
+		cnt += in_ie[cnt+1]+2; /* goto next */
 	}
 
 	return wpsie_ptr;
@@ -748,9 +743,8 @@ u8 *rtw_get_wps_attr(u8 *wps_ie, uint wps_ielen, u16 target_attr_id, u8 *buf_att
 				*len_attr = attr_len;
 
 			break;
-		} else {
-			attr_ptr += attr_len; /* goto next */
 		}
+		attr_ptr += attr_len; /* goto next */
 	}
 
 	return target_attr_ptr;
-- 
2.25.1

