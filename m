Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B513C5AABDE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235605AbiIBJxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235715AbiIBJwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:52:42 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12EDD11FA
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 02:52:36 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y64so1982004ede.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 02:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=1DfksHW7Ish2UvigiC+OsNMircH0PL3M9sKVGJTg530=;
        b=GwURQpXCkXATE+oyuEySbyquqLfL6FdQvLFR57Y9myNNAv/qP+Ou99yQ18r0Vw6GNo
         kAR2W2v1eD/sr/fPmVCE4h9HfHzWuvJ+uXPCvTa9n7QqTTiZk4VDlbvBp79G85MRsmKS
         sR47+F1D92cK9CEbW87GgJoEp4hRgBXQEs6D5oQrq3qjonZcDvQhmgEaIKJPaEukssaZ
         5vXcv4DPa3mG8ovOGuFXmJysv2P/EV2qfiap5oC971/5LD9BwS4wlAcX4CWolRkMNbqw
         vVRDf5jDw+zNiYGYzSSyAv5tFkPMuqyhxw8GVI1JXTGPrqNyz274IDh59YN7nMgjb/YW
         Fafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=1DfksHW7Ish2UvigiC+OsNMircH0PL3M9sKVGJTg530=;
        b=ePapEXJq4P3rQbjr1PRFT9RbmHHGKdfceGxShAIv+tnORCi7gd9gX9cEDBmHE8+zXP
         28pHkSKsf0K5zixDg8FsA6b4pgd4apcfMjWiGqJ+Kd7lAri+e2U8YNMl0aY2VueafVfI
         0p8YiIOehAcaKjWI/fuJWuOICl3q9s3lku2TGGiaHRqI4T6GpNN40vxnFllTReHTnpew
         WGg/ttOnJofY8G6QL3M0kWpqKaG5GxfbCrFhSEaTV7NYHg6JtW399+eWGsdnJoIxjMR6
         1tnT5xeSmHLa4SUUOjvJx4bHzlERTDuc6mlngGSCXvkIV6Jj6hPt+O7uZajiIRjr/I4W
         zIIw==
X-Gm-Message-State: ACgBeo365ZD3UKZxcE2Bv+ffkkMTvdCXH6vco65Yoa7v05JGiQ7VxEiX
        /DKv23D8Kg15I3cMX6+iy5k=
X-Google-Smtp-Source: AA6agR55x2wjYUvZMbG74LyI3iQ3j9xx4uDuayhtH6FQD3FRbSBS5lG6m5cyMaQ3IDBJsEijGQ/y/w==
X-Received: by 2002:a05:6402:1d54:b0:447:b1f7:9ecf with SMTP id dz20-20020a0564021d5400b00447b1f79ecfmr31881111edb.425.1662112355310;
        Fri, 02 Sep 2022 02:52:35 -0700 (PDT)
Received: from localhost.localdomain (ip-217-105-46-83.ip.prioritytelecom.net. [217.105.46.83])
        by smtp.gmail.com with ESMTPSA id h6-20020a170906828600b0073d6234ceebsm959601ejx.160.2022.09.02.02.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 02:52:34 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        hdegoede@redhat.com
Cc:     namcaov@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH 02/10] staging: rtl8723bs: delete function rtw_set_chplan_cmd
Date:   Fri,  2 Sep 2022 11:51:52 +0200
Message-Id: <b5a1fe5bc7bc8eb154247ee8eafafe6af266dab9.1662111798.git.namcaov@gmail.com>
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

The function rtw_set_chplan_cmd is not used. Remove it.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c    | 55 ---------------------
 drivers/staging/rtl8723bs/include/rtw_cmd.h |  2 -
 2 files changed, 57 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index a5e66b9868ad..5e82d491ad75 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -1111,61 +1111,6 @@ u8 rtw_dynamic_chk_wk_cmd(struct adapter *padapter)
 	return res;
 }
 
-u8 rtw_set_chplan_cmd(struct adapter *padapter, u8 chplan, u8 enqueue, u8 swconfig)
-{
-	struct	cmd_obj *pcmdobj;
-	struct	SetChannelPlan_param *setChannelPlan_param;
-	struct	cmd_priv   *pcmdpriv = &padapter->cmdpriv;
-
-	u8 res = _SUCCESS;
-
-	/*  check if allow software config */
-	if (swconfig && rtw_hal_is_disable_sw_channel_plan(padapter)) {
-		res = _FAIL;
-		goto exit;
-	}
-
-	/* check input parameter */
-	if (!rtw_is_channel_plan_valid(chplan)) {
-		res = _FAIL;
-		goto exit;
-	}
-
-	/* prepare cmd parameter */
-	setChannelPlan_param = rtw_zmalloc(sizeof(struct SetChannelPlan_param));
-	if (!setChannelPlan_param) {
-		res = _FAIL;
-		goto exit;
-	}
-	setChannelPlan_param->channel_plan = chplan;
-
-	if (enqueue) {
-		/* need enqueue, prepare cmd_obj and enqueue */
-		pcmdobj = rtw_zmalloc(sizeof(struct cmd_obj));
-		if (!pcmdobj) {
-			kfree(setChannelPlan_param);
-			res = _FAIL;
-			goto exit;
-		}
-
-		init_h2fwcmd_w_parm_no_rsp(pcmdobj, setChannelPlan_param, GEN_CMD_CODE(_SetChannelPlan));
-		res = rtw_enqueue_cmd(pcmdpriv, pcmdobj);
-	} else {
-		/* no need to enqueue, do the cmd hdl directly and free cmd parameter */
-		if (set_chplan_hdl(padapter, (unsigned char *)setChannelPlan_param) != H2C_SUCCESS)
-			res = _FAIL;
-
-		kfree(setChannelPlan_param);
-	}
-
-	/* do something based on res... */
-	if (res == _SUCCESS)
-		padapter->mlmepriv.ChannelPlan = chplan;
-
-exit:
-	return res;
-}
-
 static void collect_traffic_statistics(struct adapter *padapter)
 {
 	struct dvobj_priv *pdvobjpriv = adapter_to_dvobj(padapter);
diff --git a/drivers/staging/rtl8723bs/include/rtw_cmd.h b/drivers/staging/rtl8723bs/include/rtw_cmd.h
index 0af8215e2f2f..fe1b03101203 100644
--- a/drivers/staging/rtl8723bs/include/rtw_cmd.h
+++ b/drivers/staging/rtl8723bs/include/rtw_cmd.h
@@ -612,8 +612,6 @@ extern u8 rtw_ps_cmd(struct adapter *padapter);
 
 u8 rtw_chk_hi_queue_cmd(struct adapter *padapter);
 
-extern u8 rtw_set_chplan_cmd(struct adapter *padapter, u8 chplan, u8 enqueue, u8 swconfig);
-
 extern u8 rtw_c2h_packet_wk_cmd(struct adapter *padapter, u8 *pbuf, u16 length);
 extern u8 rtw_c2h_wk_cmd(struct adapter *padapter, u8 *c2h_evt);
 
-- 
2.25.1

