Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF215424FA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiFHFWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 01:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbiFHFVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:21:47 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725B8158962
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 19:38:46 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id g13-20020a9d6b0d000000b0060b13026e0dso14218274otp.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 19:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=seHIkk6akkyF7CqpwiNW+0WVZl9SkWhR+b/C+2qe9G4=;
        b=YOK0HcWAA90YodJ2nL05eBhKnHKJXgatVghFjMzOLBeY1sO5XlswkS3tJx5kaP+cq8
         suzLXkqWriK1TtM5RyuKk7dlUms0biHQSVFubv9pd/lZ4ICHLX3jIZcWhj5dQRY7KOhQ
         4ygfWNfkBaNSLhxl7blJ1A/0MP4kSfJFSYzACHbNWt2lBMuPcRdWGA+7kyGqaV+qkk8b
         3Y3UCQA39cbugLFYyUAdFWpFsju0CFIyOO9TY/V5nRn/NjvSkDKyFtG6k8deDQ+DLl+i
         /h1JDHTv1Zf2WN6KHBMakK3bufIDewRW1DlTP+qPYaNmZHSbiKPRQEdDs6XsKe8vDfJ6
         3Xow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=seHIkk6akkyF7CqpwiNW+0WVZl9SkWhR+b/C+2qe9G4=;
        b=J/4dOSNz5zhzwGr6e4FAuJsRRar0jNDYK2ixt2B39bTpYU++VxwLwopKZqzRv9OWLY
         R4nyczuLjwFp92D6SoWaZEcdIqgeTg3tLbxNq7jri6Kg+M97KXiCZXT+ZlDp9E0T9jN9
         //NFjp0DZJ1p+7iavdOq/gd2R/7pbmCOkgaeGnUGVozOJL26zdlRPZ1jffBGiS3AMgmJ
         OHNsZliGsNp246tDGgaeuHBL1Ie4If/CSG7+M3tAaBzJa8TP33UDgAiCMKaY/1tJ6N7C
         JtWC0WuhES2ob9cJCPbtBrUsmDS4A5N1TLc1KJiW1D2qtvpMdO6dGb0PIJMUDCnsHKsr
         ScRg==
X-Gm-Message-State: AOAM530nrbvrS2dB8qsOHjf2k4hB0HsAsCCJB5jRKazTym71Px+Y14vJ
        qy61Dl2/ciGfBeJ6t7N3u9kPj39OSyOvO1z5
X-Google-Smtp-Source: ABdhPJwN579Dw9mL+NEXRXZaW2uFpTDJdVCKJLuPfabUSx+mjo9tNzxNHAigIK7k4SvU6sPAnbQIKg==
X-Received: by 2002:a05:6830:919:b0:60a:fe63:e321 with SMTP id v25-20020a056830091900b0060afe63e321mr13208882ott.227.1654655925801;
        Tue, 07 Jun 2022 19:38:45 -0700 (PDT)
Received: from debianmain ([190.236.207.56])
        by smtp.gmail.com with ESMTPSA id eg21-20020a056870989500b000f31e826f15sm9015107oab.24.2022.06.07.19.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 19:38:45 -0700 (PDT)
Date:   Tue, 7 Jun 2022 21:38:43 -0500
From:   Rommel Rodriguez Perez <alrodperez@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: r8188eu: Add blank line after declarations
Message-ID: <YqALs/7VkGsYUngw@debianmain.debian.pc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a blank line after the variable declarations,
it should remove a checkpatch.pl warning and improve readability.

checkpatch output:

WARNING: Missing a blank line after declarations

Signed-off-by: Rommel Rodriguez Perez <alrodperez@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ieee80211.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index 385a9ed8eff7..bc8543ea2e66 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -1048,6 +1048,7 @@ static int rtw_get_cipher_info(struct wlan_network *pnetwork)
 	unsigned char *pbuf;
 	int group_cipher = 0, pairwise_cipher = 0, is8021x = 0;
 	int ret = _FAIL;
+
 	pbuf = rtw_get_wpa_ie(&pnetwork->network.IEs[12], &wpa_ielen, pnetwork->network.IELength - 12);
 
 	if (pbuf && (wpa_ielen > 0)) {
-- 
2.30.2

