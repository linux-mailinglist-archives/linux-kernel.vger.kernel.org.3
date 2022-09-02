Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF915AABE5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbiIBJxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbiIBJwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:52:44 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15B83CBF4
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 02:52:42 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id t5so1922243edc.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 02:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=B/LkNIri/1WQtL+Q7NWsRVHWzRnp/SVBkeL4p3lzvpc=;
        b=UmGoUW84f46bOOkqLOrVsz1cuIelpw1AyuKVUsSLOuGDx49DKX2HTCfP9L3NRQfAtw
         nWG0XzxJysDol1nrBVzg11l8wvAsKib0aopEWwPNEvFS+L7bNykbDBdbqcoyACogYaaR
         5Z8+AkYIgYRjGpKDfW7FNOBNoSPhvl6FSyYiY/8bZmVtZDGc7Onnk+YCyqLGNTUIuMNs
         4q2bqwgIz8vXZt+C9m4aa8IQIvpIRbDamSqp+1YzTg0fsfQsw+0cJlTHzMkqNkm5+OvH
         j6zfwlRhigMXrNSgFHON5TrRBgkUEV4KZ7Df0se4QhFJT7s+SCfpi8B6B+dnvn3Pbsi+
         FenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=B/LkNIri/1WQtL+Q7NWsRVHWzRnp/SVBkeL4p3lzvpc=;
        b=XxmaqTK7FWhKvZhrZgiv7ZIvI8uVqeFaGDNfGUY5rsUgrWcS0T35Ayv/qU5uhnPTKl
         AphXNb0J3oy7qGDBb6dJ6K9qHPYIMy0ucrlHcByetu5dzTRiFNTDjgiPRonmZCYphPH2
         LufTz6v1+UweJryCWHONpNY65kYN9xv1+SNRzt4/6JL72vVJXfoC4nq6vW46Jojoxs5n
         mfXq76ob3udrt0gydBwSBx6Ft+sAKrz4lWvt3f+95sVQXlECDoJPTyjDRZKsEFdeDq3Q
         BohpuiioGLAl6WjXSMIzJ8KeatpuzKR1OBCEuDPi7SVM2N6mDXMDrcs/+eIOu3Thba/H
         jSuQ==
X-Gm-Message-State: ACgBeo2t9Farwdyqt94EeWBuiX8NC20K1izCSth6rUUU4d44lkKdhNEs
        Ud6FN/5dbRe2YFf4amrB9ZhSQx15jus5WA==
X-Google-Smtp-Source: AA6agR40Enx2VtA1BLjCCmzHZy2HEipEPMqS4wC6H84sCs4J8CSggN68CqgbJCTcJcSaTw52twxEIQ==
X-Received: by 2002:a05:6402:f1d:b0:44a:ec16:df56 with SMTP id i29-20020a0564020f1d00b0044aec16df56mr5793191eda.74.1662112361386;
        Fri, 02 Sep 2022 02:52:41 -0700 (PDT)
Received: from localhost.localdomain (ip-217-105-46-83.ip.prioritytelecom.net. [217.105.46.83])
        by smtp.gmail.com with ESMTPSA id h6-20020a170906828600b0073d6234ceebsm959601ejx.160.2022.09.02.02.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 02:52:41 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        hdegoede@redhat.com
Cc:     namcaov@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH 10/10] staging: rtl8723bs: remove rtw_is_wps_ie
Date:   Fri,  2 Sep 2022 11:52:00 +0200
Message-Id: <69f128559008c94e29eab511a92964810688288e.1662111799.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1662111798.git.namcaov@gmail.com>
References: <cover.1662111798.git.namcaov@gmail.com>
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

Remove function rtw_is_wps_ie because it is not used.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 17 -----------------
 drivers/staging/rtl8723bs/include/ieee80211.h  |  1 -
 2 files changed, 18 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 68e41d99679d..3d8a64f69448 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -634,23 +634,6 @@ void rtw_get_sec_ie(u8 *in_ie, uint in_len, u8 *rsn_ie, u16 *rsn_len, u8 *wpa_ie
 	}
 }
 
-u8 rtw_is_wps_ie(u8 *ie_ptr, uint *wps_ielen)
-{
-	u8 match = false;
-	u8 eid, wps_oui[4] = {0x0, 0x50, 0xf2, 0x04};
-
-	if (!ie_ptr)
-		return match;
-
-	eid = ie_ptr[0];
-
-	if ((eid == WLAN_EID_VENDOR_SPECIFIC) && (!memcmp(&ie_ptr[2], wps_oui, 4))) {
-		*wps_ielen = ie_ptr[1]+2;
-		match = true;
-	}
-	return match;
-}
-
 /**
  * rtw_get_wps_ie - Search WPS IE from a series of IEs
  * @in_ie: Address of IEs to search
diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index 1e627dc0044d..9041d8dc5fb1 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -746,7 +746,6 @@ int rtw_parse_wpa2_ie(u8 *wpa_ie, int wpa_ie_len, int *group_cipher, int *pairwi
 
 void rtw_get_sec_ie(u8 *in_ie, uint in_len, u8 *rsn_ie, u16 *rsn_len, u8 *wpa_ie, u16 *wpa_len);
 
-u8 rtw_is_wps_ie(u8 *ie_ptr, uint *wps_ielen);
 u8 *rtw_get_wps_ie(u8 *in_ie, uint in_len, u8 *wps_ie, uint *wps_ielen);
 u8 *rtw_get_wps_attr(u8 *wps_ie, uint wps_ielen, u16 target_attr_id, u8 *buf_attr, u32 *len_attr);
 u8 *rtw_get_wps_attr_content(u8 *wps_ie, uint wps_ielen, u16 target_attr_id, u8 *buf_content, uint *len_content);
-- 
2.25.1

