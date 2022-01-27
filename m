Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A2B49E3DB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239239AbiA0Nvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236379AbiA0Nvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:51:47 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0502CC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:51:47 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id b13so3829209edn.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QatU+RMAy8EimQv3M+CfUbyEneFCcr1SElh+ochZl24=;
        b=OQUypgefCD7s70mN7sHSU9WVhKFcZZkSsxMJAD/qRkZTotTlQ8HUeK1QZ9uo5fyFpd
         3CggCF1NqgqH+s3Z8j3f3EBcfFMXLJiC+j4EuduroEveZmeT0NUGygGcszokwOa2SweR
         0sNUt4XJsSJ0kPsgFuLVfkgThl+qFbHL4ppOaw9fe9yFyVj4Is5lMs4Dak8kMLmFyR0S
         vOoGrk02T5C8jaCVkgayLMAuIZbxxW6wW9iFLwwhvivnVBjyp2gFoKnC/Nt/qdFnxVJ2
         bPu+ez2IlnsVa8RcwD4rDXyOlFx2pKDDP6vvcmh8Nx7sYo99LCGBSsS6YOjxoUN9RGrN
         oijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QatU+RMAy8EimQv3M+CfUbyEneFCcr1SElh+ochZl24=;
        b=ehvNL30NloTcV5jj1uixhU/mAkb/TiZ7sU1WI1PiLlhcLYHp3i0hdXPlVkoukLa3KN
         sQct2X3cxkpsuU6qQl2A/ihUd0Lv2DzyVO4vjLQvLIDgxwf0oQ0CkOJvVOluYIhsw7LF
         MPh0he3HVmDYaDK/ndon5xmaseEDJ3+KPueVFK967nuiSbqfLIr04DsaYMBPEL8Ybjbi
         TVhOO2GztM10IL90jMxYn0I540uLXLISnYON58dxMsLpVita4fhe67aylPFJhcLGnoU1
         3QTtbUn7ADyj4i928IPu8lFFuW5OpvsIZeXKXwbxmMfdnIrqcBRgS1NaH1WvAtmhT7cd
         rTJw==
X-Gm-Message-State: AOAM531pb/zJw54NTn7GSIBfTPv0p97kbiNAOsEj7gpu84JYG0RqKXK5
        D62RRYyfYwBJD6mUDPS6t2q2xmPRNbTeqA==
X-Google-Smtp-Source: ABdhPJz9n15iGCVIWGqQijrIVa0sQp1NYOJFD/YzBPQzhtlFRuqKR2z5MmV45L3+y/8d1xYELWSNrw==
X-Received: by 2002:aa7:cdd9:: with SMTP id h25mr3700203edw.95.1643291505588;
        Thu, 27 Jan 2022 05:51:45 -0800 (PST)
Received: from localhost (cable-89-216-134-246.dynamic.sbb.rs. [89.216.134.246])
        by smtp.gmail.com with ESMTPSA id n11sm11445720edv.52.2022.01.27.05.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 05:51:45 -0800 (PST)
From:   =?UTF-8?q?Aleksa=20Vu=C4=8Dkovi=C4=87?= <aleksav013@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     salah.triki@gmail.com, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Aleksa=20Vu=C4=8Dkovi=C4=87?= <aleksav013@gmail.com>
Subject: [PATCH 4/7] drivers: dio: space prohibited after parenthesis
Date:   Thu, 27 Jan 2022 14:50:51 +0100
Message-Id: <20220127135054.27281-4-aleksav013@gmail.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220127135054.27281-1-aleksav013@gmail.com>
References: <20220127135054.27281-1-aleksav013@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl error:

< ERROR: space prohibited after that open parenthesis '('
< #67: FILE: drivers/dio/dio.c:67:
< +#define DIOFBNAME(x) { DIO_ENCODE_ID( DIO_ID_FBUFFER, DIO_ID2_##x),
DIO_DESC2_##x }

Signed-off-by: Aleksa Vučković <aleksav013@gmail.com>
---
 drivers/dio/dio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dio/dio.c b/drivers/dio/dio.c
index 06e248933dde..87f5f3cc270c 100644
--- a/drivers/dio/dio.c
+++ b/drivers/dio/dio.c
@@ -64,7 +64,7 @@ struct dioname {
 
 /* useful macro */
 #define DIONAME(x) { DIO_ID_##x, DIO_DESC_##x }
-#define DIOFBNAME(x) { DIO_ENCODE_ID( DIO_ID_FBUFFER, DIO_ID2_##x), DIO_DESC2_##x }
+#define DIOFBNAME(x) { DIO_ENCODE_ID(DIO_ID_FBUFFER, DIO_ID2_##x), DIO_DESC2_##x }
 
 static struct dioname names[] = {
         DIONAME(DCA0), DIONAME(DCA0REM), DIONAME(DCA1), DIONAME(DCA1REM),
-- 
2.35.0

