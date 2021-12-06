Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174E8468E40
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 01:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241568AbhLFAXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 19:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhLFAXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 19:23:21 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DA1C061751
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 16:19:53 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id k64so392832pfd.11
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 16:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=npw7Iyxq7UD84uzsZEwuks/5/kqnSFKjH/ECcHsrdZ8=;
        b=L+s3HRBbl5GITywCslsXWINBV6KwCmLDEWLFowcoXw7YDtbxCyAFdZS+mnTtiShdjn
         F4DPetkLgxLFyRdjZtFZN+C17fQpYDfpbJKjjJcaETL04lRVzIhnZi7fJaxdLD4mUdvn
         wUl/MQT0iG5kSSbxwAnxmnbwuMxynGCg1JNj4x1vGDVo33uu1xRftmV0OHVPiQozN6bh
         6PhbK0DCjQKFFlOZ+I9Loc/XyPT4qR3NcR7bawfGQruFzuhEwzNGg/SE5KkRYxTfpfLG
         dVeUfM7PldmUAZfuc2CzuuTaK8X8ZmBxfpbLRcq5uXfbY43OmB2ug9hy+WYTR/IP6/am
         xb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=npw7Iyxq7UD84uzsZEwuks/5/kqnSFKjH/ECcHsrdZ8=;
        b=q3Vc1D+my22p0eU03dnug3v9/JeviMZ1pSDc5C9gwpvJO1kBh4WGIR4remtubZG1kt
         jqPp9lvwz+t++aKXLT6mcNHWi5uHrJK8fKHcj9WOzz4iwsUe6unnPwevDXzNcMoAOBiQ
         OGZBGETTFsRqGY0n5lun536L0t/HaZudoMszsRKb02I0xoOQ7gwIrMJ0HWITllwWnbvj
         K++pmQ4FPcWU5VoYrj70SJuTxPFQoL5TUPZsh4Uc3tUavUH+iOIJAYXuyOvO/S6VpEs9
         HldEXRnfTx8kE50vXOn+h1l3o8lwNMryw9J9vpQ26iPHHQvH0tlU0HW/TOjpRgXtwl/V
         5TAg==
X-Gm-Message-State: AOAM533wEYcJx62HMXaeuu9oMKJf3fsIf0iE/zoGf/ynjp6IlI29tAfg
        qCYDez8fEGfGbLOE0pwrzKg=
X-Google-Smtp-Source: ABdhPJyyUa4Bp2L6x4ocg2xm2Cz0zvFsl3W3opLW77ig1VXdMHwlA6LVOWCWq8s6eWXJ0QcGBQpDxg==
X-Received: by 2002:a63:1ca:: with SMTP id 193mr16152398pgb.88.1638749993042;
        Sun, 05 Dec 2021 16:19:53 -0800 (PST)
Received: from simon-desktop (n112119139022.netvigator.com. [112.119.139.22])
        by smtp.gmail.com with ESMTPSA id k16sm11053134pfu.183.2021.12.05.16.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 16:19:52 -0800 (PST)
Date:   Mon, 6 Dec 2021 08:19:49 +0800
From:   Ngo Tak Fong <simon.fodin@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8712: Fix alignment checks
Message-ID: <20211206001949.GA54773@simon-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed two CHECKs of Alignment should match open parenthesis.

Signed-off-by: Ngo Tak Fong <simon.fodin@gmail.com>
---
 drivers/staging/rtl8712/rtl8712_efuse.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl8712_efuse.c b/drivers/staging/rtl8712/rtl8712_efuse.c
index 4f3b54a7c3be..3555f612a066 100644
--- a/drivers/staging/rtl8712/rtl8712_efuse.c
+++ b/drivers/staging/rtl8712/rtl8712_efuse.c
@@ -300,16 +300,15 @@ static u8 fix_header(struct _adapter *adapter, u8 header, u16 header_addr)
 		for (i = 0; i < PGPKG_MAX_WORDS; i++) {
 			if (BIT(i) & word_en) {
 				if (BIT(i) & pkt.word_en) {
-					if (efuse_one_byte_read(
-							adapter, addr,
-							&value))
+					if (efuse_one_byte_read(adapter,
+								addr,
+								&value))
 						pkt.data[i * 2] = value;
 					else
 						return false;
-					if (efuse_one_byte_read(
-							adapter,
-							addr + 1,
-							&value))
+					if (efuse_one_byte_read(adapter,
+								addr + 1,
+								&value))
 						pkt.data[i * 2 + 1] =
 							value;
 					else
-- 
2.32.0

