Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23AED48791C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 15:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239397AbiAGOge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 09:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239308AbiAGOgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 09:36:33 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03047C06173E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 06:36:33 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id w16so22755614edc.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 06:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sXsSPwqaQHZc3rdefwBjL67TswiXEAP9IH6NwIoWb94=;
        b=kaRLR+EmGxAVtMfQOYYKZFZjoB9Ov6y/mgQcY3Es8F2bbV+WewoRGWP3P8Xl92sGXR
         zl5lXizb3o+MLsVJdhr+o9wUvKcpN6WgBEw3wkDYWEzZSfY2/colRoEa3T5HN3BzWoMn
         NfSRpWiIY7tjBXRxvwCEUp4tE41gx3nKoY24VuS+MhJZlENLw2wdiUhtKD9JTGVoSQnU
         S5DEcigbn6GzLqxR/ZVOI1N/dS8nRcqPFUUZ8u3FeqmV3q6prdSCdp82Ljvtg2hVEtJm
         LRL1kRzcPnN4USDr415TUAju40BYhA7CfUfwjS+U6FPD5hUfhUCUSe22q+k5iceZ8joZ
         mosg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sXsSPwqaQHZc3rdefwBjL67TswiXEAP9IH6NwIoWb94=;
        b=TuM5hqY9tSoufMkCAsrVHL2V0yqZoMiRc0XkMtdGKKwXz9vRNoC8AXggfTCMxsPP3P
         0kD/7z38k2JrBK1GPXm5TCZvs4RXFgpwLvBVL5LXdXGtM6Gqh6qqTKVqI6yu/SBnTY4Z
         oe59gXCzqW38lkZNTjSM6JxYRKv/vzAofTluPt9TOCcLENDjCiPg4XZAcJkacdhhnttH
         enA572aep1WsFZC3NBb4ddD79nqlT58K5eJ3FJ8S8gHFvDWmTK68sZ1A0QC4zRBWTsd3
         n/Zy4i8BDTJ4V3Abldi7KIGPcQ/gUx8f3mil9+mtlH0/nkDP0ujb+D6dGN96fgGOmb5i
         8XZQ==
X-Gm-Message-State: AOAM531Wk3CwVBC8h5aIw1vZSjyBdmdKVnINTjDTAm4UQWJv6d8lcoxC
        e8MDex5k7Eij/vPrrRhPagA=
X-Google-Smtp-Source: ABdhPJxcCPlpqPMUJCnpggRFbH2Q6dQZl8PkNIhMlLE88ycK4l70lZh1LGSgqzaOzfP0GeWIF0mPog==
X-Received: by 2002:a05:6402:26cd:: with SMTP id x13mr64090087edd.167.1641566191686;
        Fri, 07 Jan 2022 06:36:31 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::51e2])
        by smtp.gmail.com with ESMTPSA id b4sm1445181ejl.206.2022.01.07.06.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 06:36:31 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/3] staging: r8188eu: rename _pFwHdr in IS_FW_HEADER_EXIST
Date:   Fri,  7 Jan 2022 15:36:15 +0100
Message-Id: <20220107143617.2214-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107143617.2214-1-straube.linux@gmail.com>
References: <20220107143617.2214-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename _pFwHdr in the macro IS_FW_HEADER_EXIST to avoid camel case.

_pFwHdr -> _fwhdr

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/rtl8188e_hal.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index c614faf188bb..d8892acad224 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -39,11 +39,11 @@
 
 #define MAX_PAGE_SIZE			4096	/*  @ page : 4k bytes */
 
-#define IS_FW_HEADER_EXIST(_pFwHdr)				\
-	((le16_to_cpu(_pFwHdr->Signature)&0xFFF0) == 0x92C0 ||	\
-	(le16_to_cpu(_pFwHdr->Signature)&0xFFF0) == 0x88C0 ||	\
-	(le16_to_cpu(_pFwHdr->Signature)&0xFFF0) == 0x2300 ||	\
-	(le16_to_cpu(_pFwHdr->Signature)&0xFFF0) == 0x88E0)
+#define IS_FW_HEADER_EXIST(_fwhdr)				\
+	((le16_to_cpu(_fwhdr->Signature)&0xFFF0) == 0x92C0 ||	\
+	(le16_to_cpu(_fwhdr->Signature)&0xFFF0) == 0x88C0 ||	\
+	(le16_to_cpu(_fwhdr->Signature)&0xFFF0) == 0x2300 ||	\
+	(le16_to_cpu(_fwhdr->Signature)&0xFFF0) == 0x88E0)
 
 /*  This structure must be careful with byte-ordering */
 
-- 
2.34.1

