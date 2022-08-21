Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5814159B3C4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 14:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiHUMbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 08:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiHUMbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 08:31:46 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BBD24BE0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 05:31:45 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id tb26so958037ejc.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 05:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=nzDM6yHUA8UXtKytIIvP0GY/mpFQQhGXhLPbv8JE064=;
        b=EiryiyVZF2bAyMX0Et7vzZUKUQeBTFHDAgzzygMcxMvNqnM4DrZA9ID+2pALxq9CUW
         DqH0buWgwFdFE33oThOwd2UJTHpzE4D/OldBUi2NYYMd+eM8QlxbVVmAjW8J/XU2COQP
         PG3X2ML5s5dxemxoC/tvz8CIzDtDH7r5jqORkichdgW9FQiS6qNBU0iSgUZAMPCIDM1i
         70ZNGUVE3UHcoJb3JLj/pipprIv52Zpk2IWuoBGhwJVTe4sskTZzoKujTvFcip9kSOLy
         QYt9zjjVG2lNNnkA04qKznHvlcpgPteyiLM9WMmKvh9Gq5Rl+lbVw/BoHftgdO9z3Lj2
         RMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=nzDM6yHUA8UXtKytIIvP0GY/mpFQQhGXhLPbv8JE064=;
        b=QtBGTkx4W7JrjB9RvRvJrtMaojOOb36ncYAzMJ1m8byP5BtW8TRHcKsm1i2XkzgwPx
         Q7BU61inDpg4O/yg/HCvfWFryZD/wIrV9Qkx+pFcF6L93q0fZMyP8vuULqOkbpJlH4CW
         gmNXQXr9hlrik4GTGC5aKIlox8NXHS3MOsfdAdk3mITrqWXznAqZ5yeai8sXH4IyySSr
         eBCC/1i575ubDCCkvD69e9by2fMd3YSnsaQ85V3Xyt/BDPn/d2WCd20O/mb8x9Y3ofYG
         lDtuknQnJpOtOFfNq0RJJdju6K33dq4r+5Oau7MJM5e+BNyzFgRYN0O0f0LGdpk5CuCj
         LJDQ==
X-Gm-Message-State: ACgBeo1U25WX5M1iXNmVvAy9DioGzzVKMYt1KsbOmFxdHYjoFZJ4cxgW
        dqggOvpFqKgSnSsG2LUrZ4M=
X-Google-Smtp-Source: AA6agR4yBca1QLYow0zf0rc/ZKzcwoAhK1MSz8z3TIS9L+wqoR9VeDzaUlYvtW58E+BQ4gVx25mzhg==
X-Received: by 2002:a17:907:9686:b0:73d:1de0:7fbe with SMTP id hd6-20020a170907968600b0073d1de07fbemr7007717ejc.500.1661085103901;
        Sun, 21 Aug 2022 05:31:43 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb77.dynamic.kabel-deutschland.de. [95.90.187.119])
        by smtp.gmail.com with ESMTPSA id d7-20020a056402000700b004460690f9d5sm6355568edu.81.2022.08.21.05.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 05:31:43 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: remove unused module parameter rtw_chip_version
Date:   Sun, 21 Aug 2022 14:31:38 +0200
Message-Id: <20220821123138.8070-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.2
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

The module parameter rtw_chip_version sets the chip_version field of
struct registry_priv but that field is never used in the driver code.
Remove the unused module parameter.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/drv_types.h | 1 -
 drivers/staging/r8188eu/os_dep/os_intfs.c   | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/drivers/staging/r8188eu/include/drv_types.h b/drivers/staging/r8188eu/include/drv_types.h
index 79351b3aa60d..1bd0c8f3a358 100644
--- a/drivers/staging/r8188eu/include/drv_types.h
+++ b/drivers/staging/r8188eu/include/drv_types.h
@@ -37,7 +37,6 @@
 #define FW_RTL8188EU	"rtlwifi/rtl8188eufw.bin"
 
 struct registry_priv {
-	u8	chip_version;
 	u8	rfintfs;
 	u8	lbkmode;
 	u8	hci;
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 2d2a1c27d433..dd4e6aac3509 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -22,7 +22,6 @@ MODULE_FIRMWARE(FW_RTL8188EU);
 #define RTW_NOTCH_FILTER 0 /* 0:Disable, 1:Enable, */
 
 /* module param defaults */
-static int rtw_chip_version = 0x00;
 static int rtw_rfintfs = HWPI;
 static int rtw_lbkmode;/* RTL8712_AIR_TRX; */
 static int rtw_network_mode = Ndis802_11IBSS;/* Ndis802_11Infrastructure; infra, ad-hoc, auto */
@@ -104,7 +103,6 @@ char *rtw_initmac;  /*  temp mac address if users want to use instead of the mac
 
 module_param(rtw_initmac, charp, 0644);
 module_param(rtw_channel_plan, int, 0644);
-module_param(rtw_chip_version, int, 0644);
 module_param(rtw_rfintfs, int, 0644);
 module_param(rtw_lbkmode, int, 0644);
 module_param(rtw_network_mode, int, 0644);
@@ -151,7 +149,6 @@ static uint loadparam(struct adapter *padapter)
 {
 	struct registry_priv  *registry_par = &padapter->registrypriv;
 
-	registry_par->chip_version = (u8)rtw_chip_version;
 	registry_par->rfintfs = (u8)rtw_rfintfs;
 	registry_par->lbkmode = (u8)rtw_lbkmode;
 	registry_par->network_mode  = (u8)rtw_network_mode;
-- 
2.37.2

