Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C75481DD9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 16:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240056AbhL3PwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 10:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbhL3PwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 10:52:04 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD21C061574;
        Thu, 30 Dec 2021 07:52:04 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r17so51212288wrc.3;
        Thu, 30 Dec 2021 07:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kfSEh+kMWcMB2oG20OjNOZJx52OyGLAU5iACdztgHAM=;
        b=LSe1c8wx29G4o6EHIysvSVoWfm8jbpRdfXqi/Sn96bwLYHcxEIPZj+58H5hzp9nxxN
         zel2M2/KB4eyjXt473MV8NzT/+bnQNccGzNvt+IR6EIUxDlgEamcQg9KFgUR+vclHNYG
         cW8NC4dpSq3YrXfs+ZCCTBs1h9Gyzci6VIhMzoAtJfMawtLoJYA6qEx4OCQVbQUsTpEF
         BPzqxwzjN8IVp2ZT/Pe826g61sr1VpRPs+a3oRuZc0BOXwTQkx/YZ9MZ3oFpYZMRKBHB
         5otKQqiTb35RreN0x2M1D2qwsK8Ik1t9fCBvKMyMd3MoF5kibR2ZnUxOJ7kIbMT+orCv
         JN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kfSEh+kMWcMB2oG20OjNOZJx52OyGLAU5iACdztgHAM=;
        b=08mZJ0x9bOh3YfNLVybTcqMJ7GYPTVpsop2oQE5RzfuJd6nZXpmDvXlvHX9XKfBoaS
         bE5+MXKfadD1NSRORUPNveLwvkhqBy6T6/wK+Fbe1qpgAHXx2oYwrcBISrf/e+xCZe9H
         KEGcQG6fu6YmB0hhsV8ji6rlPkmBJkoNn+v3rnHmgChwYVDdDDxO89OVnt9n2AWxXjVf
         ZkkAippTb+JIsS14Z4Q+74biOAzQ9gq2LVuIysC4pVw5I6qwk3v9J+psjaRHWJotnftk
         TJ+QY+wFA/OipVp1hvPTU5OVteAtYUkyu4TSTW581S3p4x+JgxXHu1T9cvP/8o9JAeic
         +2RQ==
X-Gm-Message-State: AOAM532rCRajOgNghkQAlIMSWK2QgyA2Y6n8Xk0SUz1J65ptT06uIp1p
        U4+TLbUsoS4a9QDs55Yp4yONvoY/C0OpExSH
X-Google-Smtp-Source: ABdhPJyBVYh0Oove2VBiz9Jd/MdVtDP9KyAEL3OOxOiMXWn2lKi2LyJM0+xNP1ys/VrHP42WIlCNVA==
X-Received: by 2002:a5d:4dca:: with SMTP id f10mr25977728wru.595.1640879523053;
        Thu, 30 Dec 2021 07:52:03 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id l12sm29750798wmq.2.2021.12.30.07.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 07:52:02 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Sam Ravnborg <sam@ravnborg.org>, Zheyu Ma <zheyuma97@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] video: fbdev: asiliantfb: remove redundant assignment to variable Ftarget
Date:   Thu, 30 Dec 2021 15:52:01 +0000
Message-Id: <20211230155202.355336-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable Ftarget is being initialized with a value that is never read,
it is being re-assigned a different value a little later on. The
assignment is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/video/fbdev/asiliantfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/asiliantfb.c b/drivers/video/fbdev/asiliantfb.c
index 84c56f525889..f8ef62542f7f 100644
--- a/drivers/video/fbdev/asiliantfb.c
+++ b/drivers/video/fbdev/asiliantfb.c
@@ -110,7 +110,7 @@ static const struct fb_ops asiliantfb_ops = {
 static void asiliant_calc_dclk2(u32 *ppixclock, u8 *dclk2_m, u8 *dclk2_n, u8 *dclk2_div)
 {
 	unsigned pixclock = *ppixclock;
-	unsigned Ftarget = 1000000 * (1000000 / pixclock);
+	unsigned Ftarget;
 	unsigned n;
 	unsigned best_error = 0xffffffff;
 	unsigned best_m = 0xffffffff,
-- 
2.33.1

