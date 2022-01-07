Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2333848748D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 10:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237011AbiAGJOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 04:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346396AbiAGJOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 04:14:03 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCED9C061212
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 01:14:03 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id lr15-20020a17090b4b8f00b001b19671cbebso5901156pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 01:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=u41zQxzUJskSm1JtWiXabOaQySyrCGnhUZ53TnpbGpY=;
        b=smwDmME3VUxoGMc9YFhEy4pLhEavyaB4mrYD6YOUUV2UMjIpj1rXZqNOUPOjaioQ93
         OdOPUk2uiCO77dEpNQkomtg7a6gXVl35D5jnFvzcmNQ60UxERhZzNS7Pnno+3YcG1cYD
         9yVGsYf55ORxXJrblJnJ/0cwIlu3VGaqhhsoUH5UyB+VB3x4AFBu+29QAQFLSG/ZjJmB
         d3GStGrFLjR6NTsEQB3/hOMZfsCpAMkPM+agm8e/3lMLKI1LQkWVOuc1m6i2vAWbm9s5
         YqdScY6iNYEjVLuiL/FbKA4GkzHnyLoo9EDAtHb/CwvHL8/xv00IPn3+Z+w7MGPhZW8V
         2DpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=u41zQxzUJskSm1JtWiXabOaQySyrCGnhUZ53TnpbGpY=;
        b=jdyudkl+l0yJjITWXz7TuP1wHkDw7791FQx2K9GZNJ95PSEz9sAIVD5v8LxTW41e12
         Mo0m8oL/I1LMHJv3PZSdVTKkP3fsJ5NHZWVu1qCEBktl1U5L3e+4ViJDxli1trlcMr1i
         zjqL1odRQqPG+SjvMef9nttAD3n3CbxmRLnhZCF+1oO4EExJqaOfEwH57odQCGosM3SS
         bs2BmcXtooSldhhDCeclvE17uGYy1qPDqvsTRW3HwO/boTCHxC7Rd3IqfI1IPljQI21Z
         1Pjn8kmVEeDUv2k9q6+c8CqDUpGXrd378TiFFp8m49m3wzWnEx0IEdVsNIPmyvcjPZkV
         sO3A==
X-Gm-Message-State: AOAM532oXKr0G+fy6peDwlV8Nrxvk0yO0uz6stsx5MEEIziJN4wdf37O
        s3c5D0BoYVETRjGBo7Xa51In2aG925JsiHvb
X-Google-Smtp-Source: ABdhPJwQjt9ERBNHx2f2cwuGqlzpQGsV3rxZnAtnOpFt8SIitKk7KLdF/dpiL5GSeDMQ/98D/7MSQw==
X-Received: by 2002:a17:902:e541:b0:149:2af:fa6a with SMTP id n1-20020a170902e54100b0014902affa6amr62348194plf.27.1641546843300;
        Fri, 07 Jan 2022 01:14:03 -0800 (PST)
Received: from ubuntu.huaqin.com ([101.78.151.213])
        by smtp.gmail.com with ESMTPSA id my5sm5814653pjb.5.2022.01.07.01.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 01:14:02 -0800 (PST)
From:   Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dianders@google.com,
        Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [PATCH v2] HID: google: modify HID device groups of eel
Date:   Fri,  7 Jan 2022 17:13:57 +0800
Message-Id: <20220107091357.28960-1-xiazhengqiao@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If HID_GROUP of eel is set to HID_GROUP_GENERIC, Whiskers Tablet
Mode Switch of eel hammer will not be detected by system. when it
is set to HID_GROUP_VIVALDI, system will detect Whiskers Tablet
Mode Switch successfully.

Signed-off-by: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
---
 drivers/hid/hid-google-hammer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index 0403beb3104b..e5acd15f4a55 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -585,7 +585,7 @@ static void hammer_remove(struct hid_device *hdev)
 static const struct hid_device_id hammer_devices[] = {
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
 		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_DON) },
-	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
+	{ HID_DEVICE(BUS_USB, HID_GROUP_VIVALDI,
 		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_EEL) },
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
 		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_HAMMER) },
-- 
2.17.1

