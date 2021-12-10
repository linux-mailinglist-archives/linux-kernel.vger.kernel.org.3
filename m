Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E9E46F958
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 03:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236171AbhLJCvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 21:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236135AbhLJCu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 21:50:59 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB27C061746;
        Thu,  9 Dec 2021 18:47:25 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id f18-20020a17090aa79200b001ad9cb23022so6395738pjq.4;
        Thu, 09 Dec 2021 18:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HFjP5yys5IDHQWYAUzGuN/Cv6LM+IWrecQEiC4DzVFU=;
        b=O1087wv/kihX7s74BGkNcBvX3ArBLzG46naDUvSZLzF1Q7am8XFE0hA7jm+dGQHila
         Uex59Duj+48yP/NYfaa8AFhu2IjAPRiBpDRSzJJMvjtqnY8BBGp8B5deL0hzUAxpUl24
         JGBbjIXZOoOKNByInD64BS/fJNCDCLh56yapBNSd0uNH4j/y/LmoSt0HZz3THgPGPLrv
         DNMe7uELo6PbaYlddHX5UWRpl0Vfc7HJ9p/XLhOdYJ2NUaoZUkkMGTTtMltIOgV81+n4
         GQ2gFMV93v3UAXPeIEWeVFAtPuaxFck3FYGnNwn+LpwH2sX9tERmhcLF7ZOp0CjMNAxN
         x1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HFjP5yys5IDHQWYAUzGuN/Cv6LM+IWrecQEiC4DzVFU=;
        b=M1kyItp8OsZOrOI7WgImRwROP4kc883dSPJUEzHZ1VPACO/RaaQmORb1Ea6st8c5Np
         NEyXBfosCJdOCYxhjIEBV20L22c+vYVHCj5zwX5SmW+YFJVp8hmk9uipFEOkz+bOMF6F
         O+9ulcxewPGDDUZtY783wAX6/P08NBvMlBCoMyELZGRPTamwckpOZ1c9xd1bqckMioFC
         s86AC4d4oVH8vc5DABH04ah8XRhYQEIOfEWJlFez5SkCXSrvB/y1Cc8l4hkqm5b1uJFM
         Vo+DeBMR2EVLmBsAUuV6r/REYVGI6b1yvneWAe04ojTvj9v6mPbMbf+ljkYTiIEg196t
         EVkA==
X-Gm-Message-State: AOAM53066d5acncYnTqGB0hCmw9uE8ERnke5SWZGkzApVgp9lj53nOoA
        zzNQO35n1lYHCHof4jszECY=
X-Google-Smtp-Source: ABdhPJyaVfUp3xVppisHdyvCrx0MGagHrEA5QOR43Ab/35cJQ5/B4IbC4ohc+GDBia5uELf6OnFHYA==
X-Received: by 2002:a17:90b:17cc:: with SMTP id me12mr20490287pjb.179.1639104444655;
        Thu, 09 Dec 2021 18:47:24 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y25sm1022220pfa.12.2021.12.09.18.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 18:47:24 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     dwlsalmeida@gmail.com
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cm>
Subject: [PATCH] media:vidtv: remove unneeded variable make code cleaner
Date:   Fri, 10 Dec 2021 02:47:21 +0000
Message-Id: <20211210024721.425145-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

return value form directly instead of
taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cm>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/media/test-drivers/vidtv/vidtv_psi.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/media/test-drivers/vidtv/vidtv_psi.c b/drivers/media/test-drivers/vidtv/vidtv_psi.c
index c11ac8dca73d..a5875380ef40 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_psi.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_psi.c
@@ -94,34 +94,28 @@ static void vidtv_psi_update_version_num(struct vidtv_psi_table_header *h)
 static u16 vidtv_psi_get_sec_len(struct vidtv_psi_table_header *h)
 {
 	u16 mask;
-	u16 ret;
 
 	mask = GENMASK(11, 0);
 
-	ret = be16_to_cpu(h->bitfield) & mask;
-	return ret;
+	return be16_to_cpu(h->bitfield) & mask;
 }
 
 u16 vidtv_psi_get_pat_program_pid(struct vidtv_psi_table_pat_program *p)
 {
 	u16 mask;
-	u16 ret;
 
 	mask = GENMASK(12, 0);
 
-	ret = be16_to_cpu(p->bitfield) & mask;
-	return ret;
+	return be16_to_cpu(p->bitfield) & mask;
 }
 
 u16 vidtv_psi_pmt_stream_get_elem_pid(struct vidtv_psi_table_pmt_stream *s)
 {
 	u16 mask;
-	u16 ret;
 
 	mask = GENMASK(12, 0);
 
-	ret = be16_to_cpu(s->bitfield) & mask;
-	return ret;
+	return be16_to_cpu(s->bitfield) & mask;
 }
 
 static void vidtv_psi_set_desc_loop_len(__be16 *bitfield, u16 new_len,
-- 
2.25.1

