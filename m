Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD4C4A5AB4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 11:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236983AbiBAK4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 05:56:03 -0500
Received: from mx.ucr.edu ([138.23.62.3]:17094 "EHLO mx2.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236772AbiBAK4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 05:56:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1643712961; x=1675248961;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N87/Yfcs/eolC23BLtRDzeHlHtMpAA1EhSMYLZCuSgg=;
  b=ESDLEatwTCCxgA5jYhBiaTiUStLjX2Y81H1aKQGkOpncIvKrPgfnI/DV
   iQWNnjNaQoyorOMpEXagaDrYxHUOcvkC29qddmrmaWI6X0C6Llw9usYCZ
   OGQPU5gafB3/VexxTbJsmpC6DiyZVu0h2b8c2MC+ctK+uwMZPIYoz3gJC
   XJ0qxjDFoXYwN/fiW+hu8GgcQ8wVhkoOSen0MZvnf3PFjEdF3Lr6xiqtf
   MDb6xHfnsFOoXgwug6cCNsdVFzVa4l9fdsBkO4gxKehQpNJoQ4FqFUnIY
   mRQzdZNtfK9uJqxV0IM37HX2yFIKcxeUOG1q3CmSdpyvXL5N6n211kRYA
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="216745322"
Received: from mail-pg1-f199.google.com ([209.85.215.199])
  by smtp2.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Feb 2022 02:56:01 -0800
Received: by mail-pg1-f199.google.com with SMTP id u24-20020a656718000000b0035e911d79edso10243878pgf.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 02:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PQBU+rnQ5my6cghLd5mHteSqBsmjbcfDnGbLH9g2K+8=;
        b=Kp+L/NXLOT26so2b9sKhMnvfFfAOWX2LvoHcv+Y79qAJpkTqghLmqcuxSdhQq4LvKc
         sFDd6zoymWPC37y2O0KKu+BDk+7xTDK+4VvFJ9ELAUbXMwgNtOcas2ir9izjxhd9RklV
         Oinco7mkkofgTbTvtdOMWBxc04FCfIqk8RnmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PQBU+rnQ5my6cghLd5mHteSqBsmjbcfDnGbLH9g2K+8=;
        b=V7o0/XZbJTCR6HXdoMvYVu6T1atujwvH1qbJLJHk0LrJXaRLz++QQRgLxH4yKuhcqo
         8Da7/7R9GFe66F+sRJFhQBjSWOZ0u13h0HtZ3+WLV5ls31KA5bei7jUytprqyZ0fDvEN
         xgcBxNnO43VyAx3F5CQCEg4IpbYxnrayluIB28WabqI2MivschJt0VNIV9SuMdE+JHve
         1sfMH05jCScmUjpxXn3lrjeJIpSBoX9HFOzkkLQS6N0EyVHg/BUzTKe3PMsjRwz9FYxZ
         cIZHbQ0nNK22vpp+JB7drMZNZQ25TQf4oi1bUmJj63lD4W1tE/0Ho4e8IDqqPLfUC/jq
         Kd0A==
X-Gm-Message-State: AOAM533AQqEvFFAEaiCMfbol7pkThwk2v03NrrXRV2nRLglA9CHydDwf
        eDtnRMNSQkCUXn5nTfBi7B4J2Gbz6dGafvNbqxuJeWrCP5KoOQ+Pxh0EVEq+E0MhfsUKAlTzHSm
        Cl7kLlfyjpAKa1hIDqVb9wlbgWQ==
X-Received: by 2002:a17:902:e5d1:: with SMTP id u17mr25442904plf.40.1643712960617;
        Tue, 01 Feb 2022 02:56:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy+4Bx2r2dBQG35mt2wEHOqbwiXd+lGZCO+bfqdjhApNLkZyLU6LTpemTtlr9KBpq1jXc4xRQ==
X-Received: by 2002:a17:902:e5d1:: with SMTP id u17mr25442869plf.40.1643712960369;
        Tue, 01 Feb 2022 02:56:00 -0800 (PST)
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.googlemail.com with ESMTPSA id b6sm22349723pfl.126.2022.02.01.02.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 02:56:00 -0800 (PST)
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Cc:     Yizhuo Zhai <yzhai003@ucr.edu>, Helge Deller <deller@gmx.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Matthew Wilcox <willy@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Xin Tan <tanxin.ctf@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Zheyu Ma <zheyuma97@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Alex Deucher <alexander.deucher@amd.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] fbdev: fbmem: Fix the implicit type casting
Date:   Tue,  1 Feb 2022 02:56:08 -0800
Message-Id: <20220201105610.2975873-2-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220201105610.2975873-1-yzhai003@ucr.edu>
References: <202202011802.cpmdbzHR-lkp@intel.com>
 <20220201105610.2975873-1-yzhai003@ucr.edu>
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
index 0fa7ede94fa6..991711bfd647 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1162,6 +1162,8 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 	case FBIOBLANK:
 		console_lock();
 		lock_fb_info(info);
+		if (arg > FB_BLANK_POWERDOWN)
+			arg = FB_BLANK_POWERDOWN;
 		ret = fb_blank(info, arg);
 		/* might again call into fb_blank */
 		fbcon_fb_blanked(info, arg);
-- 
2.25.1

