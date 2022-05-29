Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A705371BB
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 18:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbiE2QCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 12:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiE2QCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 12:02:16 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BD736B75
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 09:02:14 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h11so10743913eda.8
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 09:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Y3B4JZc0tJVQibu4pURKDCtGwMrc3nd8jQV/wUq90Zw=;
        b=em1w4StfSos19j40lyb+/be22kzVxn7G/I3W4JwuNHOvN4iGIa2ef3tWsPiUVMxHNg
         85jnlzkOXrISYDMWAU6tWjuqU1HURAfeQ6ph1Xg2oAUo5sW9DsUK6GdojH/GS0s+yAUN
         iEgei2zhZq3cXN3kYvK2LkAckxMH5x5EInZl6dd7hwhq1aKvOa0wLNUU7f6ssm3z9cQ2
         R2j0nEpTrRsv+sArXatLNWurpVRibi3lOiCkYw8eelmaM72+A5EFpmTc3xMXGVGENr6l
         NCsOI7iadbIP5X7z4sA78Cpw4ccSm/iGPpC6Xz18dpQFMb7fhU4YjsITzPipVuqLE/Je
         0pOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Y3B4JZc0tJVQibu4pURKDCtGwMrc3nd8jQV/wUq90Zw=;
        b=u/7UnLxF2h705mLBFrDzDAZSDBaotzYMnk+mPQShEGmsr+3tLEGWr/y+4SyKO7pqZu
         ta94gWJLwuTIAQrL/XM4uM7pwl9OKK9OXVwhPYw89otkL7Mxqwoh0qm4866seVV6y6fc
         5+X+sxR/6cmYgInNABu/Axg3PFv775VDycm14c+jOUHFxZbyu9680eSZlgjeczNX95jD
         08zkPP9GHN0CZG+rfUE6MPqF4qc6i5iPkFpA0njsyX0FOJf528/a4UZi8zgL2vefFnyP
         KhxMtiEvH8BIt4XLvQLMXBxFTvF/WCmqUfcdv2b+XFjxfeY+oderqGtTfohT7Bj8ZUNp
         6Sew==
X-Gm-Message-State: AOAM533MMxxefX+Y7+Zl0qYcGXi9h/xhSsIeo/317/v1i+P53NoF+ZTV
        Ptgk7FMloowD5dbky3BRE7Gs6B7UmQo=
X-Google-Smtp-Source: ABdhPJwSgAn+H/JeFL/UFPK5bvm3iusctA/PYX326/2Rtqnj9KlxEiBdKsznOjfanIFSqRPagc84/A==
X-Received: by 2002:aa7:c444:0:b0:42d:d1d9:e4d8 with SMTP id n4-20020aa7c444000000b0042dd1d9e4d8mr855508edr.145.1653840132941;
        Sun, 29 May 2022 09:02:12 -0700 (PDT)
Received: from nam-dell ([2a02:8109:afbf:ed88:435:610d:d1eb:dc05])
        by smtp.gmail.com with ESMTPSA id mp33-20020a1709071b2100b006fecf62536asm3208151ejc.188.2022.05.29.09.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 09:02:12 -0700 (PDT)
Date:   Sun, 29 May 2022 18:02:11 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     forest@alittletooquiet.net, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH] staging: vt6655: Update function description
Message-ID: <20220529160211.GA5805@nam-dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function vt6655_get_current_tsf has been updated while its
description has not. Update the description to correctly reflect
what it does.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/vt6655/card.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 2cde0082fc03..ce9b2f0dbd58 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -734,9 +734,9 @@ u64 CARDqGetTSFOffset(unsigned char byRxRate, u64 qwTSF1, u64 qwTSF2)
  *  In:
  *      priv         - The adapter to be read
  *  Out:
- *      qwCurrTSF       - Current TSF counter
+ *      none
  *
- * Return Value: true if success; otherwise false
+ * Return Value: Current TSF counter
  */
 u64 vt6655_get_current_tsf(struct vnt_private *priv)
 {
-- 
2.25.1

