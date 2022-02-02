Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767B24A7C0D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 00:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348202AbiBBX6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 18:58:09 -0500
Received: from mx-lax3-1.ucr.edu ([169.235.156.35]:12195 "EHLO
        mx-lax3-1.ucr.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348185AbiBBX6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 18:58:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1643846286; x=1675382286;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xYvx8fe8wRHtOQTQUEuPl7xZb+NEUT35cy+DHSkqPn4=;
  b=CPFrLbHLUEruZERJu8vJSXVoF0H0+jypGndiTU28gwejER9Y9m2iKCaU
   cm8CKYjsv2nBMeQmMjCyVjdwivrO3rSigtER9g07Enz+jEH1J64rWmrKo
   jPmVoUhvSdoS+/4eY7rU+gbARDb5n1Szj1CGVdT9S/23xWgR04ynHFEzH
   vyjWOIYhpX3cfszj9Rb7l6q1FscaV5bOWoNZ7VB75Dn7XPFH5AdK36fxh
   JbxesJxg1Yv/hYNLFfXADF2rcnoPaXGg2unJdGSQtQr3eDUlBHrRILyRg
   RXpB2bdj636yLhwHFkIJeOOgegaOmimy3R3tTHKM3huDzxLNoF38XPzKc
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="102028824"
Received: from mail-pj1-f70.google.com ([209.85.216.70])
  by smtp-lax3-1.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Feb 2022 15:58:06 -0800
Received: by mail-pj1-f70.google.com with SMTP id i10-20020a17090acf8a00b001b82365dbcfso556062pju.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 15:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GUOM8bvwC+la2NKqFvk2uI9Asw+K/wrTaRpdb2Kdz7U=;
        b=HrYsDT4AbEktOiXWlPEMn/m7e6zv2dsefdTeMC5C2hJLezPbv+I1/ftDBXrJt6Un0z
         GqSD3kzgEw3q1pfOdDoOgKDJvmgHKg8NIkh4s4COvIsupoE4p/b9lbZQZ4gbhXZtj7sK
         4vUh0ntfzQGjCKF3AZQ0GIBqkvnKIMkIts8xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GUOM8bvwC+la2NKqFvk2uI9Asw+K/wrTaRpdb2Kdz7U=;
        b=Czb0ZL/a9kwF01M/K+m1uGcYQrJMR9X9Xig7kIevNEAP3Enyi5jlLGfHCEPYBeNo3Q
         lNhdC4RVydHEzUbrtatAQI5YinMNw/Nxh0MElEqlvZwEmlbTyhuEnaqcqz1zQ1YC+U8H
         KFuD/VbeUK6IEoXrjju8EoFuwQ1wc1FSHXJ+M8fmam5HqAJCylJ3a6tvXWf/Rpm++kNJ
         WFjZUiBmURfYcEuB2YTzPBtcs2f7bnH3lyM8mbpWQBl1LCGgAakrWOOPzlwVV3JbdUe7
         AFGM6TNHrk0NT8JM0w5rvnSiMaC9ZEip+nkIEUNBDGPX6PutilhqOoPL5D66hLsEDevF
         fogw==
X-Gm-Message-State: AOAM530joS2svCLmQcNfR3evX89beQpcD3w/Eo5jLrcQOLp8Uo+Ep4vx
        R4zlJ53ttdZMwXlfI35/J42u4j7FMkrdTEFZz+LRQYUO1HFX1X68VzYiKzB9sIit+n5ncq1Jzpo
        g3KULklGyA2VCCw2dTKqaMoEoTg==
X-Received: by 2002:a17:903:2310:: with SMTP id d16mr33430925plh.20.1643846285923;
        Wed, 02 Feb 2022 15:58:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxZKL++WYDLmSn9xU1SSYz871Lo6pf/fCV7Hf709Wi2UHiygHMvfWHZxapRrgqd4vPTs3zu2w==
X-Received: by 2002:a17:903:2310:: with SMTP id d16mr33430902plh.20.1643846285669;
        Wed, 02 Feb 2022 15:58:05 -0800 (PST)
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.googlemail.com with ESMTPSA id b22sm27854781pfl.121.2022.02.02.15.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 15:58:05 -0800 (PST)
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Cc:     Yizhuo Zhai <yzhai003@ucr.edu>, Helge Deller <deller@gmx.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Xin Tan <tanxin.ctf@gmail.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zheyu Ma <zheyuma97@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6] fbdev: fbmem: Fix the implicit type casting
Date:   Wed,  2 Feb 2022 15:58:08 -0800
Message-Id: <20220202235811.1621017-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <f3b28143-5f59-ad77-f2b8-6274a6edbfdc@roeck-us.net>
References: <f3b28143-5f59-ad77-f2b8-6274a6edbfdc@roeck-us.net>
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
index 0fa7ede94fa6..13083ad8d751 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1160,6 +1160,8 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 		ret = fbcon_set_con2fb_map_ioctl(argp);
 		break;
 	case FBIOBLANK:
+		if (arg > FB_BLANK_POWERDOWN)
+			return -EINVAL;
 		console_lock();
 		lock_fb_info(info);
 		ret = fb_blank(info, arg);
-- 
2.25.1

