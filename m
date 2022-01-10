Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E419A488E0C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 02:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbiAJB2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 20:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbiAJB2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 20:28:52 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894EBC06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 17:28:51 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id rj2-20020a17090b3e8200b001b1944bad25so14274333pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 17:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gySM4oMWv1mF5kjtupUmF7Knt8DYj0ZsBjDse8zVMBU=;
        b=Ms/epKE1aC4bp0DujoXARd7xc9wPjod9KA0kIz5FoZZ5Y/h60eIeep+7B9hFx1gXR8
         feArapBDeyDpaCN1Dl510OHIrzVRLBPgc5h2e3bEsBHoSN7pc260IfHdE7RvAzihl3DD
         TknSN1xZUvb4D0pa16/tVMmznSy25nRSkUrU/kZvO6MsaikX3m4JWE/oCeeM+LyRcTpx
         bE5Z7HVuuL+7gZ0RKnXK8f21kgzH3NHbQbcyKYlukxhnYGcTKb66XxQvFg9jeXNPYgAp
         meNfUWhd6iiBRyeeGtBjVXkPs18jea06/32iM6fxowwYjfBM6S5CbCZuXgBZeS5/v55H
         Aofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gySM4oMWv1mF5kjtupUmF7Knt8DYj0ZsBjDse8zVMBU=;
        b=BXEr4wWuJR5AoiuQbkTavBa9KEJr5BotFln7IiuTdIrh1a84hdM2gybe9kmcf1r0MV
         Y/JGzDaS2hYEttld+VcO0HOC8c+VenfiAPmy87EFlFL3+lG7COY4I4e1PuD3MhHWe25h
         U47fR6tAHhPYdKbYDTarPtqiemdI3BZN7jensd0FW47Wq39JICE3u9Y14GFKWY8kuoDc
         wWEQJkgauNDtXwyBExd6gawuzDqcKhBtTjdBO8lwHQC1sN1DfExlHDAELk+zceqw9pKk
         SIHGfE7t/6QS1VR4pVLnwgxajpPwDST49HI9z9MEhRip1hawYovp5OOz+EhxE65QhHqf
         lE6w==
X-Gm-Message-State: AOAM531l/iv52/w/5+goECrbOzmbfq4OLvHyvzegbIv845axUGVE2EpO
        PNJCEJb88ajAWAiL1gWRfRu9i4lDJvs=
X-Google-Smtp-Source: ABdhPJzyxOkzsdbUmvLhY5W7m63RcqZT0C9E4jperqC7emOYj24F/JIz2O5eh1C+eq41NAtMAwWbnQ==
X-Received: by 2002:a17:90a:4482:: with SMTP id t2mr27418103pjg.133.1641778130873;
        Sun, 09 Jan 2022 17:28:50 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s14sm1513805pfw.33.2022.01.09.17.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 17:28:50 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        chi.minghao@zte.com.cn, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>, CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH] sound/soc/codecs: remove redundant ret variable
Date:   Mon, 10 Jan 2022 01:28:33 +0000
Message-Id: <20220110012833.643994-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value from devm_snd_soc_register_component() directly instead
of taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 sound/soc/codecs/wm8971.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index 21ae55c32a6d..ddf0e2f5e66a 100644
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -676,7 +676,6 @@ static int wm8971_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
 	struct wm8971_priv *wm8971;
-	int ret;
 
 	wm8971 = devm_kzalloc(&i2c->dev, sizeof(struct wm8971_priv),
 			      GFP_KERNEL);
@@ -689,10 +688,8 @@ static int wm8971_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, wm8971);
 
-	ret = devm_snd_soc_register_component(&i2c->dev,
+	return devm_snd_soc_register_component(&i2c->dev,
 			&soc_component_dev_wm8971, &wm8971_dai, 1);
-
-	return ret;
 }
 
 static const struct i2c_device_id wm8971_i2c_id[] = {
-- 
2.25.1

