Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F4A4C3982
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 00:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbiBXXHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 18:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiBXXHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 18:07:31 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999AE14FBDB;
        Thu, 24 Feb 2022 15:07:00 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so725278wmj.0;
        Thu, 24 Feb 2022 15:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wbra4FEQu0N4mKrIa+OeGATLAQAZRowiOgXpL7J/xdw=;
        b=LsHQmedqI0UuvSsT/Sa28pwoSgDdgSdH3VFHn5qorZTLNoeeyCK4We76nwt9cag6J0
         SxXuQ4jfmAzcVD8dl9JkwpGCsjp6IVOz0rj1zGzcXRjuJAsGYm4xQRTi94dsKIKT9SkE
         P5dcflfhbRgfIg1D991mL/pDK++aP/95GT8gweqXqTByr5ZcWL9cN4dZRFj32d98t8TY
         5hAfnK+kztK19VM1nvYQiBZ9jLzrkRHmLArDHQHx3cuZ98n5Ak+C+KH1klJdIeG9BUA0
         oBODIgyzlf0aL8GjfgX+LuERKe5l6VeAr62qhgMAT1xIYm5xdpV3OYWrfn3pAfELos7Y
         pAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wbra4FEQu0N4mKrIa+OeGATLAQAZRowiOgXpL7J/xdw=;
        b=5pcBJzO9Cf0iqqSBdhgB7acjoIuKxXXi0tWa06vztJn6eGOWomKVB4A48ZZU+F0It0
         W7k2pI8Iz4ceGj6Wpri/lusZW0OuHWRv4FFrE2WXdFETQ+43NsQEPrPZcjETE6h18iMU
         m5BtrNav+kMtY4X7xVsyXUa2rzD2Y/4TqezHMLdX8pFulJA+OoEnui5c28StHCNiaPFY
         MOcWcSAcyhB8foKilDOAFEe4eYnnXOtbxeOiswroPoEDGf6RZJ9No2wggdFuUp4goEhW
         M3Q5TVPhDyg9IyyMvfySCknb/H41G3jKgvEo8iq53avZpk9qaqkdfABs6uX11Wo5wfbP
         6ITw==
X-Gm-Message-State: AOAM530L019libqP5wVA6YaUBxcghYwVsEjDaXtn6fOVcesJaOdBekLA
        BfaG3XeDCdrkiYpdsNM4Qi4=
X-Google-Smtp-Source: ABdhPJxZaMBZe4P0qOe+ykgYjJYjNIWkvfk4T8H5ECaKz8j0I8xOAgTO42Ecmlg6mvTcu9izMXSlSg==
X-Received: by 2002:a1c:f705:0:b0:37d:f2e5:d8ec with SMTP id v5-20020a1cf705000000b0037df2e5d8ecmr268682wmh.21.1645744019245;
        Thu, 24 Feb 2022 15:06:59 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id q11-20020adfcd8b000000b001e320028660sm521461wrj.92.2022.02.24.15.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 15:06:58 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] staging: r8188eu: remove redundant variable reg_0x143
Date:   Thu, 24 Feb 2022 23:06:58 +0000
Message-Id: <20220224230658.151338-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Variable reg_0x143 is being assigned a value, however is not being
read. The variable is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index cf58dfc3ff4d..53ebea311723 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -189,7 +189,6 @@ static void efuse_read_phymap_from_txpktbuf(
 {
 	u16 dbg_addr = 0;
 	u32 start  = 0, passing_time = 0;
-	u8 reg_0x143 = 0;
 	__le32 lo32 = 0, hi32 = 0;
 	u16 len = 0, count = 0;
 	int i = 0;
@@ -209,7 +208,7 @@ static void efuse_read_phymap_from_txpktbuf(
 
 		rtw_write8(adapter, REG_TXPKTBUF_DBG, 0);
 		start = jiffies;
-		while (!(reg_0x143 = rtw_read8(adapter, REG_TXPKTBUF_DBG)) &&
+		while (!rtw_read8(adapter, REG_TXPKTBUF_DBG) &&
 		       (passing_time = rtw_get_passing_time_ms(start)) < 1000)
 			rtw_usleep_os(100);
 
-- 
2.34.1

