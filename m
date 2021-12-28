Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F205D4808DC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 12:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhL1LrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 06:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhL1LrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 06:47:01 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A8CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 03:47:00 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id s1so14286038pga.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 03:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=VG7KyxTaUf/eyRSLoJnf587wVcr4KonBHcygE9AihEs=;
        b=ygiXfKHADaYagc4gRoF4K9GtsMwpXFC0AcLV2REVS39Fn9jgPyuZvq4YQ5FtjTlDLv
         n6hhIAXTjCZWQtM72JQrdCQZ8X9fJ0DgLCoN5NrIxqy9qBhPJXppTtEHytEveSYw2M6z
         dV8TIUS/MRKKgP1NyJRZ1dVtV6H2tH5VN5cZWhFdhCBRBJvPasty7QdmlA6gHjg8CcZm
         Hn++TMEx2hqz1yvWed3W9ro3wBhBTkD67otji/uBL4AE//KKiWvIcPC9J/+2gP9WoDQ8
         dQ0UpVMKGcj8QDG+EVFCYxEj9b2hz0+kwUEP2M7zRDczPYRT61fmGGsCors1yjWh3M5M
         aepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VG7KyxTaUf/eyRSLoJnf587wVcr4KonBHcygE9AihEs=;
        b=4GRDs027KlDEsKOdRxaDJFPycHJ6nAgQOWMQFn1AkCVBYVJ9q3TaTk4d7GxIrJb1Xl
         X4MAVyJRsgFCKmrw2++l3nWvhhmXODa2n8fDwaD4f35gR7DaYlhSgDOx2UUGpkauPb3m
         lcOWaE7Jb8eeloiBagujrspf5CetvG/K4NMneS5FPorTgHQXZuXPquvCKxVXWNrBdw5t
         068FQj18DGBAqLkUCowpFHFTsvqgc0xFqk6OzBECxdUqjp1/qguPyvwrbh1fKlGZGfL7
         4z38K0VrWHT12QLfH5xjBzbcOXzemYmUGMHx1JCyCYjpyk99Oo/93D1zNzvO7DK8BNmw
         DuwA==
X-Gm-Message-State: AOAM530kQRYgKrvr9rLrqK0dA5wPGPxhVINj0J6MQl183hfl9nDbsyCY
        CNN2A/MZb+BB6bCJrvArhhEQsfbJJ5Xy8a/Q
X-Google-Smtp-Source: ABdhPJxxuAuozQsGJwZ4VQJyuFw+kEYr05hzrhB2Uku7icwKgov0nfDSoHDclcKVQDNmhqNP3gYVBw==
X-Received: by 2002:a05:6a00:acc:b0:44b:ff29:621b with SMTP id c12-20020a056a000acc00b0044bff29621bmr21749712pfl.32.1640692020201;
        Tue, 28 Dec 2021 03:47:00 -0800 (PST)
Received: from ubuntu.huaqin.com ([101.78.151.213])
        by smtp.gmail.com with ESMTPSA id k9sm12026296pgr.47.2021.12.28.03.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 03:46:59 -0800 (PST)
From:   xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     phoenixshen@chromium.org,
        xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [PATCH] HID: google: modify HID device groups of eel
Date:   Tue, 28 Dec 2021 19:46:50 +0800
Message-Id: <20211228114650.31981-1-xiazhengqiao@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EEL keyboard belongs to VIVALDI	device.

Signed-off-by: xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
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

