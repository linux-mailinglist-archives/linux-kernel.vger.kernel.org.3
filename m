Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35AD247CA38
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 01:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239309AbhLVAYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 19:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhLVAYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 19:24:20 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843ADC061574;
        Tue, 21 Dec 2021 16:24:20 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id i22so1219674wrb.13;
        Tue, 21 Dec 2021 16:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jEyMqzkS51XAJJ1/Omp/HczmnDjl+OSGTWIN9RbcbIo=;
        b=mSeGdHTUaQ0S3YZbBJMgSn7kybGHB5mdK9Tn1EkiZewutNDlAaBdKmZcbIj0SIbhFB
         Yau5+h90uCGNsOGZ4qEKDBbqexUdLoca9cflA5q9Qyb0TUxbUaMervI+9AJSqm47mc6n
         mFXAyCK3Hu8VkEY5YPBt8Pk5H2m2nBUNdzthl58UkZ9Dnyn+UraD2E2nki+yKOLlyF5h
         KNHwP7Ft+VBU/2CgZz/udV+IhDiEWhShNUjfOIfppUWheCMA+hRKoVrPlO1S65Cg3fAG
         gAugE3is+ejTjJi4+R9iOf1lGWvjRrmxcqBDBa1iaU4+Q7ML9Q+mB+L12AhmSmiNQkd9
         L/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jEyMqzkS51XAJJ1/Omp/HczmnDjl+OSGTWIN9RbcbIo=;
        b=PpGKycfQft5ACZCf5mAVJS3tZn0e62yi/Uay974uZuBnL3OyPNFdNFrqq+S3n1H83g
         iX9+MNL9HV77T/cPILi6Dv05ThA6pMjDI1UQXcZKs2P6eKwLz5jawBZsv3LMBmXUgAFe
         lGNGiW9xr+E7vqQ60b+DxjkUWvKNZFKkDarB7DQVmuXTJgDZvg6nEvVEjiPo++fSJehh
         PfQE0iIi7FRpmGn/QNf3b9OKusdWGlbxgd4nvlB1p5Jaw3gyGfQ2EGtHD2AyUqRIv11u
         8auUM8pbliTKR87IXcfEiFYWOmdmOiuP2oBkviJ9K/M6Mzt2Z4EhFpPKaxsJ5iLJS9Lc
         Q59w==
X-Gm-Message-State: AOAM533xrmh3GnttM57/Dm3Fc4HrL+n3aUfikG8cA+kWVWyd+dGNuJ7J
        EoaVDwzrVUAWnDp4sJaeJt7Rf9u9EljMB/F/rkHbXQ==
X-Google-Smtp-Source: ABdhPJxmZxsECAhaFEZxHz6PaqauHgfvx2vyFr7JtKkfW+FTInG1ukgDnG/mCFvoziQrTNHpYXIG7Q==
X-Received: by 2002:a5d:6d8c:: with SMTP id l12mr363622wrs.55.1640132659189;
        Tue, 21 Dec 2021 16:24:19 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id m21sm405504wrb.2.2021.12.21.16.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 16:24:18 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zheng Yongjun <zhengyongjun3@huawei.com>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: host: u132-hcd: remove redundant variable l
Date:   Wed, 22 Dec 2021 00:24:18 +0000
Message-Id: <20211222002418.725999-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable l is being used to summate w, however the value
is never used afterwards. The summation is redundant so
remove variable l.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/usb/host/u132-hcd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/host/u132-hcd.c b/drivers/usb/host/u132-hcd.c
index d879d6af5710..ea4f66e66372 100644
--- a/drivers/usb/host/u132-hcd.c
+++ b/drivers/usb/host/u132-hcd.c
@@ -2335,14 +2335,12 @@ static int u132_urb_enqueue(struct usb_hcd *hcd, struct urb *urb,
 			char data[30 * 3 + 4];
 			char *d = data;
 			int m = (sizeof(data) - 1) / 3;
-			int l = 0;
 			data[0] = 0;
 			while (urb_size-- > 0) {
 				if (i > m) {
 				} else if (i++ < m) {
 					int w = sprintf(d, " %02X", *b++);
 					d += w;
-					l += w;
 				} else
 					d += sprintf(d, " ..");
 			}
-- 
2.33.1

