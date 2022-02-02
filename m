Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F18B4A7BA0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 00:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348062AbiBBXR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 18:17:27 -0500
Received: from mx-lax3-1.ucr.edu ([169.235.156.35]:5130 "EHLO
        mx-lax3-1.ucr.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239155AbiBBXRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 18:17:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1643843845; x=1675379845;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XA4HzDe0AEvwI/VRCaorqRe1KBJyowOMBeCxGfa6hn4=;
  b=RYGSZ8zv3ITIOjgDjJ8slDBjBbOHHtZ5odt60X8gi+e1dtGoJ5RIZh0X
   cgmLQ999y6X2IFhJTdYtfpwqgxvvlnL0Cv0ys+R7Bfot0DIbyGbjevw81
   0bvk9056Rj3HZNeCqF4VEOrcunbJ8EpvDuhcFwJyhO91brrNYi2gizOdE
   +KMWR9u21R4W4syKY3PwrEmewj9kpmrl0aJLwpY5o6XTzzrO3kttMPXjD
   c7FpydZLEyzCbTsk8oR3cdcxkJV7zIQfYQ6Lx63zNPqSovKNAKFhGzp9o
   mFmyx22mze0Nse9XJQIQ1sx8evyr1r7SNZm3q8PxoiRI7v3zYoXFBz6va
   g==;
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="102019921"
Received: from mail-pl1-f200.google.com ([209.85.214.200])
  by smtp-lax3-1.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Feb 2022 15:17:25 -0800
Received: by mail-pl1-f200.google.com with SMTP id k7-20020a170902ba8700b0014c7e2870d4so136747pls.21
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 15:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x0gpjDLXaul+KimMP/te05qJYZBYJvmQ+lbw67iuhZI=;
        b=FLTFy7FMQp58INHLttCuIHz294nTMtd3aPRvSF4FjqWZkgzHuAVT593n57gr6D3wr9
         4So2/UsjM0gDmRsmqeuunUSEgE4Kov61tpxCHiUoF4ry6ArVAmuwNLKe8BL9PEdP3Ru3
         MjqLnU4S6ttaaqm14Expc2Ep0ssiU9Ny3LUTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x0gpjDLXaul+KimMP/te05qJYZBYJvmQ+lbw67iuhZI=;
        b=SpVMBi8GvK5xOLx+QgfnLsMguM3uZGY9BNSMJVnl8HV9bmza25LgDaRouzNywIA4kE
         MwBZZ11bNI8asIYkBzoYQ1bGGnzugpDc2aP8BphmdKWe0d1524g+YyP4ohwnNvORAEmB
         ut2gCtbcR+ODocFzsLqxzMkEVd5T7dB3E+5oq+md6aiUJO5vo+V7bR8QqwG09ApjLFAp
         le/O+5C0vMc4L6PGdnELWTvQemUoXhxKdIcalkCWlztmZIquHRnvsXW7diX+j2SXNaqF
         0Us5L3fRx4id0FhtvlAsm6szQsiQ+Szkh+uKyqKxCL0LVDXrdSwxwECVrRaOWfyLu/F/
         NwPg==
X-Gm-Message-State: AOAM530xrIaniSGw8hUXezBFhXAW+5eHQ6TNzaIRaXQyW9+dkNpAWqE6
        1gUp7WF3VwmJ9abJSu5pS6Fr5opofihqJMuOCHgAC/TENpMSAhfCHZ0nNZuD3fBDiYbaDaADN8E
        dMkK5bD49jBVyT73cqNNWPExSng==
X-Received: by 2002:a17:903:2307:: with SMTP id d7mr34166968plh.52.1643843844241;
        Wed, 02 Feb 2022 15:17:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxysLdmzckR8L/Q+cSNZ4JMxUGdQpQyEn+58bq1m8yYLz88d/OhDa7N65YARWKJRnqVgxOtgA==
X-Received: by 2002:a17:903:2307:: with SMTP id d7mr34166950plh.52.1643843844033;
        Wed, 02 Feb 2022 15:17:24 -0800 (PST)
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.googlemail.com with ESMTPSA id j14sm27383525pfj.218.2022.02.02.15.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 15:17:23 -0800 (PST)
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Cc:     Yizhuo Zhai <yzhai003@ucr.edu>, Helge Deller <deller@gmx.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Matthew Wilcox <willy@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Zheyu Ma <zheyuma97@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] fbdev: fbmem: Fix the implicit type casting
Date:   Wed,  2 Feb 2022 15:16:34 -0800
Message-Id: <20220202231636.1433050-2-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220202231636.1433050-1-yzhai003@ucr.edu>
References: <882bfe4e-a5b6-2b2c-167b-eda8c08419e3@gmx.de>
 <20220202231636.1433050-1-yzhai003@ucr.edu>
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
index 0fa7ede94fa6..b3352e23caaa 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1162,6 +1162,8 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 	case FBIOBLANK:
 		console_lock();
 		lock_fb_info(info);
+		if (arg > FB_BLANK_POWERDOWN)
+			return -EINVAL;
 		ret = fb_blank(info, arg);
 		/* might again call into fb_blank */
 		fbcon_fb_blanked(info, arg);
-- 
2.25.1

