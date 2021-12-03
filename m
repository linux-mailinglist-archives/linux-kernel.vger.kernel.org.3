Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62BE1467A76
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 16:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381867AbhLCPoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 10:44:02 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:33886 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381866AbhLCPoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 10:44:01 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 4J5H8j0wFvz9vFPj
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 15:40:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id giWjevagt_I1 for <linux-kernel@vger.kernel.org>;
        Fri,  3 Dec 2021 09:40:37 -0600 (CST)
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 4J5H8h5vtQz9vFPR
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 09:40:36 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 4J5H8h5vtQz9vFPR
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 4J5H8h5vtQz9vFPR
Received: by mail-pj1-f72.google.com with SMTP id x6-20020a17090a6c0600b001a724a5696cso1971124pjj.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 07:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5HmoGm3B37yc5c/4jRkC+dyUrsobVh+SO553GCD8ogk=;
        b=cUeCP18DKup7EVwIWPfs0pvEzFnFk/40mKGy6/tzK+KdEQpc4T/S9071Fj9YwGgkpB
         2Gypk6OEB6gbX7uPUoiwy4ibicNO6Figl00HMDo7SeqruIT5WXO1+hkDSDu3OU277M6i
         Ek4k5VBLKf2qsx68xLtEwK9oR0iNr1PvjHfQbaiVmmM0qn9nyCBc1qLdt8qO0Cd9RIE+
         oUj4y+vBZ7GchTbo/v4JVQdiyYgxP5Cj2gbbiVvjXagdWpwfuTGEBPUgIlOrEKIs+Yf1
         rI77UZ8XWNGa+IEXvLrtX4HNQetrSFG4Vxg/2YY/g2SNzSFkGWfdlnC9Vqsr02okkIQf
         CxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5HmoGm3B37yc5c/4jRkC+dyUrsobVh+SO553GCD8ogk=;
        b=RvUMBPWHqI1h6IZCLv2VFjPR93lv1fGt4ifE8m8/4BYiqjVBfe4uKpMhH6yoJhh4CK
         YDB1VdaCHyyanEB3hk7zUl2vAN0h+VUjvMX/i0d9tfQeTvZICW3juN3C3xzaVkfA/i9w
         xDYD0JDdIF1PwZjDaJNP2s+mfPlha1tZv+QF8AzV2+Ax3dEYokzgtTbkahUGfTVsdmnQ
         LiYUMWLB0SOE327b0W0JWUMm0CtKho6HrYJOmDa0B4q89HFZ7aHFp8Fofnb8d1ngO4FN
         W1lfDC82N+QF0SZWjBHcyZ5jsp5qhjM/NfVffO1xnVtUc4fRo7nQgZ5Tnk7Q91gVwRBG
         Nk/A==
X-Gm-Message-State: AOAM532sedh3AaNYQv71QxRXmYaDcC+wmjNU6kwlomD3MLGC1lt2wVFo
        RGkIP/jx8d+CwdqU1mvHn4x1EeIOrzsM6xJ3TYsPbrO25dic/fMFinXXUiT1w161/XKTVj1uWRL
        hDhp5Xx118GdYm7Ddlp4C0MG1t1i2
X-Received: by 2002:a63:f749:: with SMTP id f9mr5037539pgk.330.1638546035793;
        Fri, 03 Dec 2021 07:40:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxac8HUOI/hkFzM/XqRZamlRCLYfN29hXMP4kgRSTrAf0JXX2AAhbP2YGlsNF+RrF10pglLVA==
X-Received: by 2002:a63:f749:: with SMTP id f9mr5037511pgk.330.1638546035355;
        Fri, 03 Dec 2021 07:40:35 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.4.93.212])
        by smtp.gmail.com with ESMTPSA id i1sm2912410pgs.50.2021.12.03.07.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 07:40:35 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] media: saa7146: hexium_gemini: Fix a NULL pointer dereference in hexium_attach()
Date:   Fri,  3 Dec 2021 23:40:30 +0800
Message-Id: <20211203154030.111210-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <b0f7ee6e-f6fc-955e-92eb-013cd96f1d1d@xs4all.nl>
References: <b0f7ee6e-f6fc-955e-92eb-013cd96f1d1d@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In hexium_attach(dev, info), saa7146_vv_init() is called to allocate
a new memory for dev->vv_data. saa7146_vv_release() will be called on
failure of saa7146_register_device(). There is a dereference of
dev->vv_data in saa7146_vv_release(), which could lead to a NULL
pointer dereference on failure of saa7146_vv_init().

Fix this bug by adding a check of saa7146_vv_init().

This bug was found by a static analyzer. The analysis employs
differential checking to identify inconsistent security operations
(e.g., checks or kfrees) between two code paths and confirms that the
inconsistent operations are not recovered in the current function or
the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

Builds with CONFIG_VIDEO_HEXIUM_GEMINI=m show no new warnings,
and our static analyzer no longer warns about this code.

Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
Changes in v2:
  -  Add i2c_del_adapter in hexium_attach()
  -  Change 'return -1' to 'return -ENOMEM' in saa7146_vv_init

 drivers/media/common/saa7146/saa7146_fops.c | 2 +-
 drivers/media/pci/saa7146/hexium_gemini.c   | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/media/common/saa7146/saa7146_fops.c b/drivers/media/common/saa7146/saa7146_fops.c
index baf5772c52a9..be3215977714 100644
--- a/drivers/media/common/saa7146/saa7146_fops.c
+++ b/drivers/media/common/saa7146/saa7146_fops.c
@@ -521,7 +521,7 @@ int saa7146_vv_init(struct saa7146_dev* dev, struct saa7146_ext_vv *ext_vv)
 		ERR("out of memory. aborting.\n");
 		kfree(vv);
 		v4l2_ctrl_handler_free(hdl);
-		return -1;
+		return -ENOMEM;
 	}
 
 	saa7146_video_uops.init(dev,vv);
diff --git a/drivers/media/pci/saa7146/hexium_gemini.c b/drivers/media/pci/saa7146/hexium_gemini.c
index 2214c74bbbf1..3947701cd6c7 100644
--- a/drivers/media/pci/saa7146/hexium_gemini.c
+++ b/drivers/media/pci/saa7146/hexium_gemini.c
@@ -284,7 +284,12 @@ static int hexium_attach(struct saa7146_dev *dev, struct saa7146_pci_extension_d
 	hexium_set_input(hexium, 0);
 	hexium->cur_input = 0;
 
-	saa7146_vv_init(dev, &vv_data);
+	ret = saa7146_vv_init(dev, &vv_data);
+	if (ret) {
+		i2c_del_adapter(&hexium->i2c_adapter);
+		kfree(hexium);
+		return ret;
+	}
 
 	vv_data.vid_ops.vidioc_enum_input = vidioc_enum_input;
 	vv_data.vid_ops.vidioc_g_input = vidioc_g_input;
-- 
2.25.1

