Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF4B48791D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 15:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239462AbiAGOgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 09:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbiAGOge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 09:36:34 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD14BC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 06:36:33 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id q25so14220481edb.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 06:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gEWeNIEj4706/zj4lUnxZgjHllySGSpEuZM0Df7nbPA=;
        b=Jmjz7vbDBiU4Nxyx51tIBLQhABG+k3vXyOgOf9OcCu/ivEjqWGSfLaqekjcvfuSQac
         cX0mFcTsFxOuYfTCCtlfFansEe6Rjwx7InbgX/QVd3PW4+m1787hX5MSkAvjkLZhS92k
         qENB5Z/dxST2Y0cC9M4jf4/whFe9FRYfRDsQw887Aff3YFgDma2/BiHvDmFU3LD5yjZ+
         2rlljwEgEB5K3Vv+A2gMNZcuVOFd00ILklnp+fT8+qgImRi+gsHPnfN8/40xh2NGZBiF
         G093prkTEnFB4lxVEj9zDv74qAJP3Jblp5ajBQyLz7XHuGIOJpEUtRGm2d+Xy8kbRhFZ
         6IJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gEWeNIEj4706/zj4lUnxZgjHllySGSpEuZM0Df7nbPA=;
        b=dBcTTnhtE3edY6b0s/5F8VNJKTwPdikF/3l9y2zgrNPxIX2wmvCAOs1r9foLSEFJkp
         /EgEKQNERt53c5KLr7TKXZcuJRaMgMk28WowX2FYLGQnfWIyDwy9NXCY00jnbUXTgYkK
         nBCh975mp+vgKGk/0zJzb/cZtrRZVCGlYHgsQmiF5lsWrRVwB026r67HBNgRQ2VucsCV
         tlACqOba2f5rM89mn7nlavHTQA5cyD0Sh+cozdma8EXBXTt5N1eQakE4b5eRDTDYO7nQ
         XMup9HVUL2jBfQB0pEyZ7gAVIBcgRzY61ihZA1oY+bqYaWfcxcGSUh5BsH0hE4t0iFG2
         n4Ow==
X-Gm-Message-State: AOAM531IXxyu3K4VkmubaKW6boEnhvE9vr5OOWkH3NzoiCY3sHvHUaOW
        i0PF292gacT8dTGAkV/7AT4=
X-Google-Smtp-Source: ABdhPJyKQfaPj8uxkmWEE02vF5KjOMqrmzMyM5/JShuXC1Bg9/XtimQSi8Ul2SHvEuH2RgSHKcv5VA==
X-Received: by 2002:a17:906:c14e:: with SMTP id dp14mr586731ejc.138.1641566192390;
        Fri, 07 Jan 2022 06:36:32 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::51e2])
        by smtp.gmail.com with ESMTPSA id b4sm1445181ejl.206.2022.01.07.06.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 06:36:32 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/3] staging: r8188eu: add spaces around & operator in IS_FW_HEADER_EXIST
Date:   Fri,  7 Jan 2022 15:36:16 +0100
Message-Id: <20220107143617.2214-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107143617.2214-1-straube.linux@gmail.com>
References: <20220107143617.2214-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spaces around & operator in the macro IS_FW_HEADER_EXIST to
improve readability and follow kernel coding style.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/rtl8188e_hal.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index d8892acad224..dad2aa473a1c 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -40,10 +40,10 @@
 #define MAX_PAGE_SIZE			4096	/*  @ page : 4k bytes */
 
 #define IS_FW_HEADER_EXIST(_fwhdr)				\
-	((le16_to_cpu(_fwhdr->Signature)&0xFFF0) == 0x92C0 ||	\
-	(le16_to_cpu(_fwhdr->Signature)&0xFFF0) == 0x88C0 ||	\
-	(le16_to_cpu(_fwhdr->Signature)&0xFFF0) == 0x2300 ||	\
-	(le16_to_cpu(_fwhdr->Signature)&0xFFF0) == 0x88E0)
+	((le16_to_cpu(_fwhdr->Signature) & 0xFFF0) == 0x92C0 ||	\
+	(le16_to_cpu(_fwhdr->Signature) & 0xFFF0) == 0x88C0 ||	\
+	(le16_to_cpu(_fwhdr->Signature) & 0xFFF0) == 0x2300 ||	\
+	(le16_to_cpu(_fwhdr->Signature) & 0xFFF0) == 0x88E0)
 
 /*  This structure must be careful with byte-ordering */
 
-- 
2.34.1

