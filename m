Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450694A3E0E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 08:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357845AbiAaHEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 02:04:16 -0500
Received: from mx5.ucr.edu ([138.23.62.67]:23022 "EHLO mx5.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233543AbiAaHEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 02:04:12 -0500
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 Jan 2022 02:04:11 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1643612652; x=1675148652;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eEsk92A0ZXPnX2Ki88PFE3IgBq8wg+0W/+nONtlHHnA=;
  b=Ny1qr0QjIvnaKr6FEyVe+I+vIMKFV/+nRLji6vK0p7uWygqcAddvY+k7
   liEpPB+Q79T7DVTuiCoGFCzSYpjtn8v6g12m8PSCjr8A7UWNoimvBTCCG
   0QEEzVT390FhP3j1Jt8nWAUm2LciLZZWEBpibikPExitjvolQi0v2JpsN
   ADn5hNnpuc3aYC89ZZNoN41D94mDdFqVCEGzJOgovK3HbcsAs1WsTqah8
   qL6EMCfRXRCw2du2n2z7uzp+wPs/G8ugLF7zHq5vj5ve7bCuccCov1Op1
   N59M0E7EWUvSZg84RWvnjqxdZXzEOMd+2Z38f/8aaeWfz8ybCcJlH07Ge
   w==;
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="272607408"
Received: from mail-pl1-f200.google.com ([209.85.214.200])
  by smtpmx5.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2022 22:57:01 -0800
Received: by mail-pl1-f200.google.com with SMTP id k7-20020a170902ba8700b0014c7e2870d4so4717795pls.21
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 22:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N9mTVzsHAHJ5mTM22d2IAe55DJRgo8Pr7F09OYCu4c4=;
        b=dEYxCn3BfV+JihG8ONV/WUGd8IamJ2JvzSSyxN0Yc69fn81moYaQ7zA8iO84UMQDkP
         uhUF08FkXagVOD5CW2tvG0POmWwZjo4ZdNbloTwew5BnwG9z64bC6i7JLYIlTLgUkphJ
         +ztQFc98NYZfDzfi41jfdivXxHpiLrzU8f/cE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N9mTVzsHAHJ5mTM22d2IAe55DJRgo8Pr7F09OYCu4c4=;
        b=mKFlb8oT9np0l92FvJhjyzRUmreoNHdxIB/4C8OmoAoX/ldcY9EVBnqeTmKrRlYJtl
         lxRzGP89NFSNnANjgxO2nXyZ1y35sDQNRobeVe38kjMb5gvW4D0FpzK2cIZN1He1Z5+0
         PQTcNKu5NrmBk5j6C8RBwFaAIpJX3/F4CHRktavX7PRIaPPfd23G443n8cszX2DfzFmV
         y10GTvyTo8NN35BQDTQ9NALzDfH3GCDJBPTcwNcI2gkj7uCgv4PTIv5lt5A4s8xcxWXi
         C11yDKGDR5kF00tGL6fcytOEk/KYNmVBqLJkeZdMmJ7yOd59X1SvKj1nuWU0U9vXICBX
         r4bg==
X-Gm-Message-State: AOAM530IaYaeXByCo6q+SS3GZlgIcyiBRnpqj+UaB+msIjoQjvJTAagu
        fjhArZdoVx9m5keyN9n5PAzC+sYhM/QSZp0RvYKgOGHdY873w9GeeCVn1qln5oz9FvKXuQGUNS1
        CZHZT/l5Bwc8QaDJoReZ29nsPJQ==
X-Received: by 2002:a05:6a00:1394:: with SMTP id t20mr19171341pfg.70.1643612219929;
        Sun, 30 Jan 2022 22:56:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyYqb47bfhGvFHVqHFtNpiuYQ+NsZNuHIRbT+5N2iRk9p02bVcswfTGcUNfips3vZNzbIN8WQ==
X-Received: by 2002:a05:6a00:1394:: with SMTP id t20mr19171333pfg.70.1643612219691;
        Sun, 30 Jan 2022 22:56:59 -0800 (PST)
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.googlemail.com with ESMTPSA id h3sm9641434pfo.66.2022.01.30.22.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 22:56:59 -0800 (PST)
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Cc:     Yizhuo Zhai <yzhai003@ucr.edu>, Helge Deller <deller@gmx.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Alex Deucher <alexander.deucher@amd.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zheyu Ma <zheyuma97@gmail.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: fbmem: Fix the implicit type casting
Date:   Sun, 30 Jan 2022 22:57:17 -0800
Message-Id: <20220131065719.1552958-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.25.1
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
the user input.

Signed-off-by: Yizhuo Zhai <yzhai003@ucr.edu>
---
 drivers/video/fbdev/core/fbmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 0fa7ede94fa6..a5f71c191122 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1064,7 +1064,7 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
 EXPORT_SYMBOL(fb_set_var);
 
 int
-fb_blank(struct fb_info *info, int blank)
+fb_blank(struct fb_info *info, unsigned long blank)
 {
 	struct fb_event event;
 	int ret = -EINVAL;
-- 
2.25.1

