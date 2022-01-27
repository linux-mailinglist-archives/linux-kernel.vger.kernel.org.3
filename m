Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF4149E3DE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241413AbiA0Nv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237425AbiA0Nvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:51:52 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F66C061749
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:51:52 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id me13so5886319ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nbDz0B65QLVJQ6roePaU2QNS2lANckTUDFJTbCrnfiI=;
        b=jsB7lbQkOdXyisDyqHx1fh14xZwEqFsIxJEMhVT8Zb5weE0BIiTHVZ8Sokrq1ew1Zl
         gGsKH+ATMxqqcel9qBIemYQGXnp+owQPblmCDavDHS+d1s/NbqQWtDLHW6e4rz4i88xb
         IHhPbbEDZTK4s9aLHRC6oCJqzJjbadd76PwTsA807DK0nD0Mv6K0bbmkC3L23lZROp/U
         V4Ob+KavM9qeVpHdy61r7Ftbx84v4iGFjwjXVGifKoj966NKbY742aOQFMB9KdNi4iTT
         DR01u4x2BveOAZnjXQgf8E9Q8s5hLAdMa5urVaDi2hL8kHc7c6E50cTJ1myLxIqzDTm5
         K76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nbDz0B65QLVJQ6roePaU2QNS2lANckTUDFJTbCrnfiI=;
        b=l1G7xcrBIjHcJ6M5Kpp2vbq008MXqz5axs/8xG9vSW5QkuSIu+0Np9iWrVTS1qgrDB
         5rZdkZTmZqgTwXwGus2u66TrjSthdVtWwP5kMi8W2mcTb2LrgFRzOS7U0ciTo61VYyXp
         0p/Z0Ta7ypnNmh5P+kycSJoWXQcmZQTakavcuTnrNCTNkNl9INp1kpwh/j86lptU99ak
         eQsNFnjvJ/8oP0Px559BTIsNjlEcjca7hObMmeXdXsLRWqFvFA3SVaNmE2TwqU4ZnETb
         fdt0hlsRfa7na08SkNyKm5tmyhipJfTTw2PRBJj3TJ8EvzJWXPBUBCaI1NxOxY6/GvcU
         X0FA==
X-Gm-Message-State: AOAM532211YE/ZsDXSE9aEJKvNNOW2rkajB9zmv1ovtmCCtGmkYjapL5
        C9XJ5vEIqNK9sh1PcedL5v4=
X-Google-Smtp-Source: ABdhPJyFz7A9S0xen4VdhmGNpQqlUKQ8IVPNPELuTeeNfBX95Jdsm99+1HVe7EqmsocBtFy0YTq0Lg==
X-Received: by 2002:a17:907:d8a:: with SMTP id go10mr3160262ejc.242.1643291510616;
        Thu, 27 Jan 2022 05:51:50 -0800 (PST)
Received: from localhost (cable-89-216-134-246.dynamic.sbb.rs. [89.216.134.246])
        by smtp.gmail.com with ESMTPSA id z8sm8698066ejc.197.2022.01.27.05.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 05:51:50 -0800 (PST)
From:   =?UTF-8?q?Aleksa=20Vu=C4=8Dkovi=C4=87?= <aleksav013@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     salah.triki@gmail.com, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Aleksa=20Vu=C4=8Dkovi=C4=87?= <aleksav013@gmail.com>
Subject: [PATCH 7/7] drivers: Missing a blank line after declarations
Date:   Thu, 27 Jan 2022 14:50:54 +0100
Message-Id: <20220127135054.27281-7-aleksav013@gmail.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220127135054.27281-1-aleksav013@gmail.com>
References: <20220127135054.27281-1-aleksav013@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl error:

< WARNING: Missing a blank line after declarations
< #97: FILE: drivers/dio/dio.c:97:
< +     unsigned int i;
< +     for (i = 0; i < ARRAY_SIZE(names); i++)

Signed-off-by: Aleksa Vučković <aleksav013@gmail.com>
---
 drivers/dio/dio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dio/dio.c b/drivers/dio/dio.c
index 36ffa3c839f5..005a82f671c3 100644
--- a/drivers/dio/dio.c
+++ b/drivers/dio/dio.c
@@ -94,6 +94,7 @@ static const char *dio_getname(int id)
 {
 	/* return pointer to a constant string describing the board with given ID */
 	unsigned int i;
+
 	for (i = 0; i < ARRAY_SIZE(names); i++)
 		if (names[i].id == id)
 			return names[i].name;
-- 
2.35.0

