Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002AC59981F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347795AbiHSIyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244382AbiHSIyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:54:08 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1837390E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:54:07 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id gi31so1095116ejc.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=lgIH+anOUapmsDT3madCqkJtVLuh/Inv9K5cFDxhThs=;
        b=Oh9zPK94Un8fe7pcbMnsK/FIG9oexvu+SEqI4AyylhS+RG8LRAqWzTa6PLdYrqYOOs
         UDKJzLpmoQNEfwX758srbGm5yM7auR7ZLiZahTVPfcCIu5rXCcJyknnRSM0dcJKPYBos
         4ikZgl1KiavaemU1RwCOupVTMEoJnew/tDp75Pcu5ZDq32gn+V/lun6teEyK/jv7yvHW
         I80/JZI60mVAerWg88PYR4VyqVEsOcl6h2DY8kjLWIn0j/XHTeUYZdHVOaxjAmogf4HG
         oYl9G93PZ66ILwCavLMpgk9kKqq26jJBTM9VRKHFuEd2bdySoy1vt1YrkHCwzvtDaULD
         bNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=lgIH+anOUapmsDT3madCqkJtVLuh/Inv9K5cFDxhThs=;
        b=wXVwbHkG5Ict1PnCME4vQfW6KXGKB6kRmKHX0K1ScPaBgDWjHYo9AQv9vAfYK+S0wr
         sr6J5Xdj3w1vuzwdhUOcY0nQtmUGgm/hgn9AlZfqfEc0xutok2qjtIdLptUrfGMkl79E
         74bFQjKf14nvzfG1JWCHyCVPpBw4Bo4CCcdt2XHHapma5GtI7hE8rHGyTboXYb/GYPU8
         GQ9pGzXlxf7pE3t1xM0w5C7d7T9GNS1XRrNFhjVCAC0QmhmtgGEAY4u/9dp+bFD1BwWu
         bUpvHQeJ6C3X2m3v6yR26QMYzX90nB1ZYMIRDV7ULs5eSmTYjlFcxoOjxPxl8UJP/jUr
         jT0Q==
X-Gm-Message-State: ACgBeo38tMGhiqQPNHIhk7Ibu+Kxc/+A/XepHtZK2yXImcTDSBRqH53i
        65/pexG1FRcirCqmsa8wPWo=
X-Google-Smtp-Source: AA6agR5oGhiIgaRuZCuyvZPAgLaEKfWKYc7sQTTjsVGONpso3TbsB11bAN332qpegNz+MDrOEc0i+A==
X-Received: by 2002:a17:907:1c89:b0:734:d05c:582e with SMTP id nb9-20020a1709071c8900b00734d05c582emr4320699ejc.282.1660899246114;
        Fri, 19 Aug 2022 01:54:06 -0700 (PDT)
Received: from nam-dell.ucebne.fiit.stuba.sk ([147.175.148.17])
        by smtp.gmail.com with ESMTPSA id b9-20020a17090630c900b0073c9d68ca0dsm1084261ejb.133.2022.08.19.01.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 01:54:05 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        namcaov@gmail.com, hdegoede@redhat.com, Larry.Finger@lwfinger.net
Subject: [PATCH 2/7] staging: rtl8723bs: remove function rtw_get_ch_setting_union
Date:   Fri, 19 Aug 2022 10:52:52 +0200
Message-Id: <c8c5b0c78ee9a4cd8304efeff22b51049c75a3f2.1660898432.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660898432.git.namcaov@gmail.com>
References: <cover.1660898432.git.namcaov@gmail.com>
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

because this function is not used.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 21 -------------------
 .../staging/rtl8723bs/include/rtw_mlme_ext.h  |  1 -
 2 files changed, 22 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index f878b04076d8..8e74b4f47b94 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -5945,27 +5945,6 @@ int rtw_chk_start_clnt_join(struct adapter *padapter, u8 *ch, u8 *bw, u8 *offset
 	return connect_allow ? _SUCCESS : _FAIL;
 }
 
-/* Find union about ch, bw, ch_offset of all linked/linking interfaces */
-int rtw_get_ch_setting_union(struct adapter *adapter, u8 *ch, u8 *bw, u8 *offset)
-{
-	struct dvobj_priv *dvobj = adapter_to_dvobj(adapter);
-	struct adapter *iface;
-
-	if (ch)
-		*ch = 0;
-	if (bw)
-		*bw = CHANNEL_WIDTH_20;
-	if (offset)
-		*offset = HAL_PRIME_CHNL_OFFSET_DONT_CARE;
-
-	iface = dvobj->padapters;
-
-	if (!check_fwstate(&iface->mlmepriv, _FW_LINKED|_FW_UNDER_LINKING))
-		return 0;
-
-	return 1;
-}
-
 u8 set_ch_hdl(struct adapter *padapter, u8 *pbuf)
 {
 	struct set_ch_parm *set_ch_parm;
diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
index 89b389d4c44b..65e138a5238f 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
@@ -662,7 +662,6 @@ extern void adaptive_early_32k(struct mlme_ext_priv *pmlmeext, u8 *pframe, uint
 extern u8 traffic_status_watchdog(struct adapter *padapter, u8 from_timer);
 
 int rtw_chk_start_clnt_join(struct adapter *padapter, u8 *ch, u8 *bw, u8 *offset);
-int rtw_get_ch_setting_union(struct adapter *adapter, u8 *ch, u8 *bw, u8 *offset);
 
 struct cmd_hdl {
 	uint	parmsize;
-- 
2.25.1

