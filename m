Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2699C5AABE2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235834AbiIBJx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235727AbiIBJwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:52:43 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC599D8DB
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 02:52:41 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id w2so2032184edc.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 02:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=I2CMut/xLnohqiOeRPhToMpVupJG8sBwirkVo5Ugtp8=;
        b=XPkVhpajSgeOl3jthw2K/4L0o4HgIOYtqKy89UewAW8VI7GJKiow4qs/dz4Hxni2MP
         tMBMJRJIt2LVZvILffAhp0Jvbp6lF3aVP6Xo4HqlNP5eJAlkGhfgNUuU4Q38tNCHMpHf
         +n1WyvQg43+bIF41LzjxefD7G46+CGaob1A0/17TgdzVq+GrYMJHiR6zRvazTIrYkny6
         lN2sHhFnrG29giXrwrZxDJUCIvK7+zUddzSOdvG7/+CE8nEeRjwkG8xryAxroTU0EWok
         5M+E5TX5mrlDEVQ85DHFKD3u3P1HJ2LsJ8PSge0zkAAd8vhVELM4JhftxLqio6TSuDgs
         nmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=I2CMut/xLnohqiOeRPhToMpVupJG8sBwirkVo5Ugtp8=;
        b=eHg5znWdMZaUiMAxyDApd3fuNVk/IaJ/SQd9RD1xGRcspELtkskXK1nai7imKsrCuG
         mweC2ueXeT9klNky6mqwz0Wlz6mIyALncU1KJWPzxlJozW2Aac5omosMEQwYU7uCRkXU
         WXLEGs2pDuD8JkYMPXLXUTI1DrweBFDkyX8yBaNCyXklEZmmz+QU5B+caNQ4gVdRSbRe
         OOqKiku7keBlKxrgBXuMc3luqpJkYWAYTGOWun5ap55rmSeqyMVaA6RI+oOuUIv/Y+ZB
         KuiHqj782ahhP9DV2W3/u6W/UsDPlvNf7I2LiTb/JNaj2VpRf2k72ayN19xgon2a6kG8
         X4IA==
X-Gm-Message-State: ACgBeo3OxKpO9sf7iJEWDazG92ILAPtym3jozD2hsqKTfDdjem3tJ8Zo
        diA0tlBlhEvOFIcfl8caOsQ=
X-Google-Smtp-Source: AA6agR7p5DBC0WFY2HjkeGarebVEyMN8s5tyoWDQRslbSRMaLvPkWm5S6dMsnJ2VWitJzSCtcSCXKQ==
X-Received: by 2002:a05:6402:378f:b0:43a:d3f5:79f2 with SMTP id et15-20020a056402378f00b0043ad3f579f2mr32546430edb.338.1662112359933;
        Fri, 02 Sep 2022 02:52:39 -0700 (PDT)
Received: from localhost.localdomain (ip-217-105-46-83.ip.prioritytelecom.net. [217.105.46.83])
        by smtp.gmail.com with ESMTPSA id h6-20020a170906828600b0073d6234ceebsm959601ejx.160.2022.09.02.02.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 02:52:39 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        hdegoede@redhat.com
Cc:     namcaov@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH 08/10] staging: rtl8723bs: remove rtw_hal_is_disable_sw_channel_plan
Date:   Fri,  2 Sep 2022 11:51:58 +0200
Message-Id: <4398fec06b0f8defaa7da9d6abbc155cbb7ae630.1662111799.git.namcaov@gmail.com>
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

Remove function rtw_hal_is_disable_sw_channel_plan because it is not
used.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c     | 5 -----
 drivers/staging/rtl8723bs/include/hal_intf.h | 2 --
 2 files changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index 94ecefb9113d..6bb0ff8d7c78 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -400,11 +400,6 @@ c2h_id_filter rtw_hal_c2h_id_filter_ccx(struct adapter *adapter)
 	return adapter->HalFunc.c2h_id_filter_ccx;
 }
 
-s32 rtw_hal_is_disable_sw_channel_plan(struct adapter *padapter)
-{
-	return GET_HAL_DATA(padapter)->bDisableSWChannelPlan;
-}
-
 s32 rtw_hal_macid_sleep(struct adapter *padapter, u32 macid)
 {
 	u8 support;
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index 45bebbadb7ca..5cffab2d06ff 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -353,8 +353,6 @@ bool rtw_hal_c2h_valid(struct adapter *adapter, u8 *buf);
 s32 rtw_hal_c2h_handler(struct adapter *adapter, u8 *c2h_evt);
 c2h_id_filter rtw_hal_c2h_id_filter_ccx(struct adapter *adapter);
 
-s32 rtw_hal_is_disable_sw_channel_plan(struct adapter *padapter);
-
 s32 rtw_hal_macid_sleep(struct adapter *padapter, u32 macid);
 s32 rtw_hal_macid_wakeup(struct adapter *padapter, u32 macid);
 
-- 
2.25.1

