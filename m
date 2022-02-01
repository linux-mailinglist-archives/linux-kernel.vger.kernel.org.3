Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2865A4A5555
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 03:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbiBACms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 21:42:48 -0500
Received: from mx-lax3-1.ucr.edu ([169.235.156.35]:8645 "EHLO
        mx-lax3-1.ucr.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbiBACmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 21:42:44 -0500
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 Jan 2022 21:42:44 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1643683364; x=1675219364;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q7G0r3sT1MHBeLXqshEFeURJWbJGybewYjiLKBDF12A=;
  b=K5QyAv9F0pw60Rmmg5kzfADUosMiM64YkVjdDsKZNvWntMj3dCYbwnB/
   0yvsorQPrarf1iHtc0L9Hkd0fDU+lrQregFb+3OWrLYJU4AlN7xHutI8Z
   a5wHhcBd3DCIrZbytlO3b8dn7F6TjOQsa99VB0pNZaTWMVOpoiUgKxsTP
   qZev13fq7P5aJhsrFdFXe4eqprdIhUSVnrr5rJRn6Q2NeAd33ogetpK9N
   Ooy04CgZntzQCFjK9k/LZj3DlsqEGBwnVgWov0WLRimqli/L3VLyG9DH/
   J3qvCmekP9gcjojAbgo0gjCkhe1jwMddBSCr+D71rVo6mTVVITlcWXMMT
   g==;
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="101468546"
Received: from mail-pg1-f200.google.com ([209.85.215.200])
  by smtp-lax3-1.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Jan 2022 18:35:37 -0800
Received: by mail-pg1-f200.google.com with SMTP id 125-20020a630383000000b0035d88cc4fedso9572495pgd.20
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 18:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aSa2J7js34wpdjauwfhqRxuvRU1TQ5o8RuxTIvDH3Cs=;
        b=d+GKQPnu9sR+as+Dvt+t9kLxoUDj0AOCQ88bxnUZ1ZmN/OJIeRDt5oGyCLVrP9H1yK
         +9Z50pGEpQ1XuWd6YK8UDEwQw7l0MfzsatDiBLn1TD/TdZZ/Y2hKgEGiQXBirm1lBYcV
         uSTbZx7J6eJOcScJQWhFq3UwERSqjHNHM+fys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aSa2J7js34wpdjauwfhqRxuvRU1TQ5o8RuxTIvDH3Cs=;
        b=xU8OPj3WsRFrmZBEbsGh76CeIOHg8Rt3ViOpWNqecuI4IvuSedhtNswKoSCy76fC3x
         3K7j4gG6cIIwiu5EwAdDixBcwR3LFUsAeyYC4YQOlALrnduPXfjOJ4+j0M3sReofT/Qw
         T/7l+XLwIjQu76IXH2ckt2Q5yR4B1PfERJyr587IVcYefMsl1Kt8ylywJ7/vjl0qtHPQ
         YS62SrBSStVf6xsFkkwPKCMUBQGr925YikmOmaVbgKgEjNQjjDRxKHi2jx5t7mbQCF+6
         IEgrJivJ8Yeo0UhoJOWf7CeSArDyhfTrGSsIo+eMcy9sObvn/+YztMwioyMEtXuUZvAS
         31ZA==
X-Gm-Message-State: AOAM530WuZuw7wtsgNZ0QFVQUg5LrY/PcjGcoTfQtIxnAyueDGKzQ1lR
        YzZIHyri3du0rcygRAYjdFnNQsLlNO/o9VvrYq9CrVTyeTLW0JMYVXSOI1Wc7kadAOmbwoFTHUm
        gfU/iOTS3KSIu5q4kaXBseNiR4w==
X-Received: by 2002:a05:6a00:98d:: with SMTP id u13mr22561444pfg.83.1643682936939;
        Mon, 31 Jan 2022 18:35:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyQjGWejUV92C73WZlbo37LitJ/aFNM3AcfTSBcRBOYPWcQdX8WwT1o2NE9voSONanMEb9GWQ==
X-Received: by 2002:a05:6a00:98d:: with SMTP id u13mr22561430pfg.83.1643682936703;
        Mon, 31 Jan 2022 18:35:36 -0800 (PST)
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.googlemail.com with ESMTPSA id d1sm20083105pfj.179.2022.01.31.18.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 18:35:36 -0800 (PST)
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Cc:     Yizhuo Zhai <yzhai003@ucr.edu>, Helge Deller <deller@gmx.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Matthew Wilcox <willy@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Zheyu Ma <zheyuma97@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] fbdev: fbmem: Fix the implicit type casting
Date:   Mon, 31 Jan 2022 18:35:57 -0800
Message-Id: <20220201023559.2622144-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <202201311943.VXU6K1gH-lkp@intel.com>
References: <202201311943.VXU6K1gH-lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function do_fb_ioctl(), the "arg" is the type of unsigned long,
and in "case FBIOBLANK:" this argument is casted into an int before
passig to fb_blank(). In fb_blank(), the comparision
if (blank > FB_BLANK_POWERDOWN) would be bypass if the original
"arg" is a large number, which is possible because it comes from
the user input. Fix this by adding the check before the function
call.

Signed-off-by: Yizhuo Zhai <yzhai003@ucr.edu>
---
 drivers/video/fbdev/core/fbmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 0fa7ede94fa6..f08326efff54 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1162,6 +1162,8 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 	case FBIOBLANK:
 		console_lock();
 		lock_fb_info(info);
+		if (blank > FB_BLANK_POWERDOWN)
+			blank = FB_BLANK_POWERDOWN;
 		ret = fb_blank(info, arg);
 		/* might again call into fb_blank */
 		fbcon_fb_blanked(info, arg);
-- 
2.25.1

