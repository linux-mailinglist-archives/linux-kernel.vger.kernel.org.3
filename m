Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCA749E3D9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237144AbiA0Nvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236379AbiA0Nvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:51:44 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A677C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:51:44 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id m4so5929213ejb.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QpZEPfj3YEyj/Fhl12QRSAMXG+Xus2qDHglWB8/GTjU=;
        b=cUr3q/kYI1h3M4Ro4f+v4GCuZ9mRbL97ESIJrc5CsiJp6uQELbpoWLyr1g4YcgOF+P
         4CeyPFcBO6VcYSPph8A9cPZRNTaifnC946NSaoOsr6jqdFF8H0vIKs1Kf0lNpWtteioJ
         jgXbhWbwffOX5fQiL07VKccgMF+63cdHpR7mBZ4jBJE1ab+UzvrPKU8qwPvlzScV+y1C
         Bs+pszKyx/joPn8WSfu7inBsoRDrbqmwqba01z+eFRfMsfMqomTBgObozccTm3tcNgDZ
         yWEQ6nAsDBmKEceJA4V1AHg2By0oescYMVnu3w3N2N/B2+8plwdbaOOfZ80edoHhlF1F
         9G0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QpZEPfj3YEyj/Fhl12QRSAMXG+Xus2qDHglWB8/GTjU=;
        b=NeIP7gHTOXM7a/q2XKbQ0l3BMuljvl4LNb7NnhzhxmYChFhhU/g8uFz80rwWmrEpvR
         Q9BaihWEmN8v1oUWKYXHhTTcjOywn4ffMS+MOXm1vbu4NB7jeUikiIinwheZ2ltjP4wC
         UpMBBps7ghqideonpN4mp5iM+vNNtW5Uv6bxZ/ijtu4Rmf6zCPOWOqTD8m1LHwtXrk+1
         V7/14TJBdBAOn4acb6hZq9VCRCp47yghH9lhQmRG47/ER3Rt+//yGFSYRoIqzFHQ9trz
         pHReq76cBrEtcIIblChsxz+GGYi94bcDKBvuDE9Ipo3hfRN7/Asn6CHlJLmAKWBOWEnZ
         /YbQ==
X-Gm-Message-State: AOAM5329Gw5fuMCE1a/Dr1pAb2iVluUwWSIgkn0/TFfHxvOUwqqt4fQ3
        YSPlk7KzCn/XM8qicj4uUsw=
X-Google-Smtp-Source: ABdhPJza+F/0+BnAl0gLoRYjhNeeiJHwamS/LFMqExVBfDuRUbb/KzKYJuc/38LY4Eqt/HDMh5J0AQ==
X-Received: by 2002:a17:907:c13:: with SMTP id ga19mr2931422ejc.634.1643291502602;
        Thu, 27 Jan 2022 05:51:42 -0800 (PST)
Received: from localhost (cable-89-216-134-246.dynamic.sbb.rs. [89.216.134.246])
        by smtp.gmail.com with ESMTPSA id y23sm8712527ejp.116.2022.01.27.05.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 05:51:42 -0800 (PST)
From:   =?UTF-8?q?Aleksa=20Vu=C4=8Dkovi=C4=87?= <aleksav013@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     salah.triki@gmail.com, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Aleksa=20Vu=C4=8Dkovi=C4=87?= <aleksav013@gmail.com>
Subject: [PATCH 2/7] drivers: dio: brace should be on the previous line
Date:   Thu, 27 Jan 2022 14:50:49 +0100
Message-Id: <20220127135054.27281-2-aleksav013@gmail.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220127135054.27281-1-aleksav013@gmail.com>
References: <20220127135054.27281-1-aleksav013@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl errors and warnings:

< ERROR: open brace '{' following struct go on the same line
< +struct dioname
< +{
<
< ERROR: that open brace { should be on the previous line
< +static struct dioname names[] =
< +{
<
< ERROR: that open brace { should be on the previous line
< +        for (scode = 0; scode < DIO_SCMAX; ++scode)
< +        {
<
< WARNING: braces {} are not necessary for any arm of this statement
< +        if (scode >= DIOII_SCBASE) {
< [...]
< +        } else if (scode > DIO_SCMAX || scode < 0)
< [...]
< +        else if (DIO_SCINHOLE(scode))
< [...]

Signed-off-by: Aleksa Vučković <aleksav013@gmail.com>
---
 drivers/dio/dio.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/dio/dio.c b/drivers/dio/dio.c
index 831f36ab6e2b..4a35ca2d0849 100644
--- a/drivers/dio/dio.c
+++ b/drivers/dio/dio.c
@@ -57,8 +57,7 @@ struct dio_bus dio_bus = {
  * I think we do this by copying them into newly kmalloc()ed memory and 
  * marking the names[] array as .initdata ?
  */
-struct dioname
-{
+struct dioname {
         int id;
         const char *name;
 };
@@ -67,8 +66,7 @@ struct dioname
 #define DIONAME(x) { DIO_ID_##x, DIO_DESC_##x }
 #define DIOFBNAME(x) { DIO_ENCODE_ID( DIO_ID_FBUFFER, DIO_ID2_##x), DIO_DESC2_##x }
 
-static struct dioname names[] = 
-{
+static struct dioname names[] = {
         DIONAME(DCA0), DIONAME(DCA0REM), DIONAME(DCA1), DIONAME(DCA1REM),
         DIONAME(DCM), DIONAME(DCMREM),
         DIONAME(LAN),
@@ -190,8 +188,7 @@ static int __init dio_init(void)
 		request_resource(&iomem_resource, &dio_bus.resources[i]);
 
 	/* Register all devices */
-        for (scode = 0; scode < DIO_SCMAX; ++scode)
-        {
+	for (scode = 0; scode < DIO_SCMAX; ++scode) {
                 u_char prid, secid = 0;        /* primary, secondary ID bytes */
                 u_char *va;
 		unsigned long pa;
@@ -267,9 +264,9 @@ subsys_initcall(dio_init);
  */
 unsigned long dio_scodetophysaddr(int scode)
 {
-        if (scode >= DIOII_SCBASE) {
+	if (scode >= DIOII_SCBASE)
                 return (DIOII_BASE + (scode - 132) * DIOII_DEVSIZE);
-        } else if (scode > DIO_SCMAX || scode < 0)
+	else if (scode > DIO_SCMAX || scode < 0)
                 return 0;
         else if (DIO_SCINHOLE(scode))
                 return 0;
-- 
2.35.0

