Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260AB47F418
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 18:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbhLYRfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 12:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhLYRfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 12:35:06 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33727C061401
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 09:35:06 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id q14so37041765edi.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 09:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YgTnPIC9YP7wdodBdY0fSo9j7jZM6/evdbFzplwCYO0=;
        b=genMatVYTiM84x5h3vOTjUgU3vXcIy8B17eW2WodptBO5iex7nBrazzcfUuK+p+r2H
         PPs0xI/tZCm7uUehlhsuWpYSP1dzPZr3EANIoodRd8ZG6HDohYu+cZeFLqoKdXRi8IS8
         wyA1nCpVgOlG5MC421Uxxjp1J5iOmPfksENNYS2HHnbPrkXT2C7clO7aUNr+p/27a6lI
         7HpopZnrUvlCW/c1lrlHKg6L1Hv9EH7B/ALnL2YTeTf4PXWp1SAI/9I9jOmF/n8MFgfa
         SbzOkno7Y932J5tm2v4QbeWXS+cBqaPD9AqQe93DyiN2AT6BQ/wR5TsBpZ9Kn2rvTQF1
         YP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YgTnPIC9YP7wdodBdY0fSo9j7jZM6/evdbFzplwCYO0=;
        b=XvM44IIZi9ohZm2XjPjE6Gtcy7m31NklragRHTsI62snBt2WY/fWK/P9FrDfzBEeZ7
         XpOGbNFrEJxoR9+7kThhGYwMy0r4sI5J02XD8mjw17iv/7WlIJ2ASv5FRLv9BaQZHAor
         VyuXu4O4lvkG+akt9JBewvIYec48lTQf72luJdis7md56kh8ZHL5gcbQbKcYjt36ngtx
         ljNreLUK4uwmfT0e5xXxEL2RWtd7qDPFfMr7sigZpsi0PIlH7FnYjMb9u87FWwGl+XCx
         3cIM9/VAZ/FblYzSxa44OEry57EpfRrTZyMEzDLvTFJgB+ff+asE64Ly0w25XIrbsCwu
         C7iQ==
X-Gm-Message-State: AOAM530U7Yhcp2xP+9ASf986vagQg79SnmTQGkXGBwoJR6ptFgmmzxKc
        Djt0/XC/jnrLR8CGngLoJxI=
X-Google-Smtp-Source: ABdhPJy7+K89Yfy2APO+P/Soru9MTPkun8qF5b+pJCTKsObTEow/pIRzpUnqiJXunbDcTa/4ut+p0w==
X-Received: by 2002:a05:6402:5112:: with SMTP id m18mr6085207edd.191.1640453704659;
        Sat, 25 Dec 2021 09:35:04 -0800 (PST)
Received: from tom-desktop.station (net-93-71-218-227.cust.vodafonedsl.it. [93.71.218.227])
        by smtp.gmail.com with ESMTPSA id j5sm3596102ejo.177.2021.12.25.09.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Dec 2021 09:35:03 -0800 (PST)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     tomm.merciai@gmail.com, linuxfancy@googlegroups.com,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        =?UTF-8?q?Aldas=20Tara=C5=A1kevi=C4=8Dius?= <aldas60@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: vt6655: drop off byRxMode var in device.h
Date:   Sat, 25 Dec 2021 18:34:57 +0100
Message-Id: <20211225173500.5459-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop off unused variable byRxMode in device.h

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
Changes since v1:
 - Remove trailing whitespace in changelog as suggested by gregkh

Changes since v2:
 - Fix commit body as suggested by gregkh

 drivers/staging/vt6655/device.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index 4706bde1ec1d..84b1dcf80e47 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -128,8 +128,6 @@ struct vnt_private {
 	u32                         memaddr;
 	u32                         ioaddr;
 
-	unsigned char byRxMode;
-
 	spinlock_t                  lock;
 
 	volatile int                iTDUsed[TYPE_MAXTD];
-- 
2.25.1

