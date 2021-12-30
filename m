Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA564819FD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 07:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236519AbhL3Gia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 01:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhL3Gi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 01:38:27 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A72C061574;
        Wed, 29 Dec 2021 22:38:27 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id m18so20492295qtk.3;
        Wed, 29 Dec 2021 22:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DHepH6WFdLmTwtF4ySUnxzCwyN0QrtXXmuhORtez5fw=;
        b=C++FEa4oW/Hj3h4Imvj4O+HA304cNyM39J+rHxY6yVKfUqvg/QvlOi2PvNyQm+chFF
         RI+9H0RcG4X0wv7pQFf1RNb1DwENR0oT9w0YwVOM5P9Iv/hsaGw4nk2QHhaaKQE70as4
         cXQFB22wB+58cUeJXohJmb/a0vHSDbx/F/ODvZv6L2z+NAASirnNEautXfxiLU/WJgjO
         K5DlJ/QfDiMSDV0gnrjur04VrehL2iEy9dDcBBdivgeIowPpp6B1BKBnUCzb0593+/sW
         7Wnx5PIcZkZJJjxxvtQC7B6bv6YIQfmzyP44+NBHLySil2TCoCnZ6W2tv28Fr5w3ehkQ
         E/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DHepH6WFdLmTwtF4ySUnxzCwyN0QrtXXmuhORtez5fw=;
        b=PeT2QfctpAupvOv5NV2H+8ZLG8IOkuEAqwK3k+1cxrkYQ6Dnzlfz0w+V5P80wekmpF
         W1vKZNdgGP99f82T8NABlHEkW3ESErxbmlXzM4JqTogwBN2IXl/wdzBF7JAfECnVJqLh
         uqcRnI4/PHfhduji3G8hiMbrIo93hrdjySYMS+OzSnXpLpzRxXjp+PytclForT7ey06z
         W/NAE9zSBZEmsu6HvPuoj7Td3GgClqQDcUKC7bn21CZpdskyX1c1FPBYsd0v8lFSkYVy
         QUj1vnt6gcfj1PAGJS7wqAKJeNYKtGgMuxSQghVxusOVnEmxA6NLHlcAM5hj4f3S7vcp
         R5HQ==
X-Gm-Message-State: AOAM531ka7KGPxAkZi/fpFgr00sX/n3cEC5c7NIn4sdGhum8L6oeLUl5
        GEiz741t/ikLjHwnkss+Wvbodc14qiI=
X-Google-Smtp-Source: ABdhPJz8s/cHPhanDMG6LppHwvPgDSGzd+eWEAGfrkJk9Fma13DbIqhW16HcBTr81KC2VwGt91qqMA==
X-Received: by 2002:ac8:5bca:: with SMTP id b10mr25682665qtb.170.1640846306237;
        Wed, 29 Dec 2021 22:38:26 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id l15sm20505059qtx.77.2021.12.29.22.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 22:38:25 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: luo.penghao@zte.com.cn
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org, luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux] usb-storage: Remove redundant assignments
Date:   Thu, 30 Dec 2021 06:38:19 +0000
Message-Id: <20211230063819.586428-1-luo.penghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: luo penghao <luo.penghao@zte.com.cn>

The assignments in these two places will be overwritten, so they
should be deleted.

The clang_analyzer complains as follows:

drivers/usb/storage/sierra_ms.c:

Value stored to 'retries' is never read
Value stored to 'result' is never read

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
---
 drivers/usb/storage/sierra_ms.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/storage/sierra_ms.c b/drivers/usb/storage/sierra_ms.c
index b9f78ef..0774ba2 100644
--- a/drivers/usb/storage/sierra_ms.c
+++ b/drivers/usb/storage/sierra_ms.c
@@ -130,8 +130,6 @@ int sierra_ms_init(struct us_data *us)
 	struct swoc_info *swocInfo;
 	struct usb_device *udev;
 
-	retries = 3;
-	result = 0;
 	udev = us->pusb_dev;
 
 	/* Force Modem mode */
-- 
2.15.2


