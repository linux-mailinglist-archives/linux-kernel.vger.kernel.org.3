Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5008463B7C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238554AbhK3QTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:19:40 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:33886 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238219AbhK3QTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:19:16 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 4J3S4h37Ngz9vJyM
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 16:15:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FdJec1YvtDz2 for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 10:15:48 -0600 (CST)
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 4J3S4h14Zhz9vJyb
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:15:48 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 4J3S4h14Zhz9vJyb
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 4J3S4h14Zhz9vJyb
Received: by mail-pf1-f198.google.com with SMTP id 184-20020a6217c1000000b0049f9aad0040so13064148pfx.21
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uFn5ORD7GPFnKVCFznG5/9Dnj8eBZ7xsNflHNLM00yg=;
        b=h53udyu5K80mQyOeP0LgjWnnj4oNXGi2uBsCpaYw7NOv3mhLRWGafR5oKELxE9gIxK
         l8NJolTqsIUeJBrZE9rQ/sH473Tm3+VSMwKQH9wgWnpNZIJM0IMqCCtb2cQO3G+iVr2K
         ZZosFnKN0jfdIW2UJQf/4WetPiPXuZf1BpOUQpKwkuinejDODuvC53ofyn3Mh/G5Z8Hy
         gjEDRlke1lvKZ8VtckfcG+10CynY+NieihMMLyD/+OTumAz8fowZDte1EAnSr1bG2TxI
         q8W8tgLOIIwFZyLs1V29syZhYply7430Q0GTd0CBM5/yeGwQajHSnTITvKirG6+286Y1
         ZuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uFn5ORD7GPFnKVCFznG5/9Dnj8eBZ7xsNflHNLM00yg=;
        b=YOQn+Yqqg4EL5+WSQkN1CBvVAwG7Lb7kzFjlplrXoEeHmfdLzu4PfCgWuJ+ryxoCc+
         AUyclk41Uqr/91TqE3g5qgHwSMKy4szUbBIUaWv9BKWBV42osb3IW46yGQAGDQKRFl2q
         ouyZ2NLbwaxfCGugGKkgJft1SftzyV8YMvvrzmw0ejfSlSeYamdgl5lXXTNiiky46GYl
         30jRMF/+0TMakR2ScKMNbo+ZXCJUSkAAoEjdc8QAMmJXw45aQ1/xKN8Dd8HctLQpFQhX
         OUIk58Pp1djdUTz82/1vCHBQRXlvbBJ9oDnsmnygzFQWIVKtiwdA9csryoG3AuGq7z2J
         JiGg==
X-Gm-Message-State: AOAM532SDKR1F8jGMfzwED9M2rZu0BEXaBSgbZtEMDrAENAqr4EnkScd
        taukeO36nuRntl0GOHWfLS/vSEdi/I1sDEETBgh035UHw8z8LujX4q3dAY7V9ij2BsN3FhiGYOO
        ZtuE+YAQ5RiJGNH7nz8kTV/3rb5g7
X-Received: by 2002:a17:902:e0d4:b0:142:8897:94e2 with SMTP id e20-20020a170902e0d400b00142889794e2mr387773pla.58.1638288947234;
        Tue, 30 Nov 2021 08:15:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzMwqXXL5I73GWZCOEcLPx+/s2yZVb5dwcy1yXSqJejeaYlG2OBuTssmfPoBHz/7NBvk5Gi/w==
X-Received: by 2002:a17:902:e0d4:b0:142:8897:94e2 with SMTP id e20-20020a170902e0d400b00142889794e2mr387729pla.58.1638288946958;
        Tue, 30 Nov 2021 08:15:46 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id il7sm3338232pjb.54.2021.11.30.08.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 08:15:46 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: saa7146: hexium_gemini: Fix a NULL pointer dereference in hexium_attach()
Date:   Wed,  1 Dec 2021 00:15:38 +0800
Message-Id: <20211130161538.182313-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
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
 drivers/media/pci/saa7146/hexium_gemini.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/pci/saa7146/hexium_gemini.c b/drivers/media/pci/saa7146/hexium_gemini.c
index 2214c74bbbf1..549b1ddc59b5 100644
--- a/drivers/media/pci/saa7146/hexium_gemini.c
+++ b/drivers/media/pci/saa7146/hexium_gemini.c
@@ -284,7 +284,11 @@ static int hexium_attach(struct saa7146_dev *dev, struct saa7146_pci_extension_d
 	hexium_set_input(hexium, 0);
 	hexium->cur_input = 0;
 
-	saa7146_vv_init(dev, &vv_data);
+	ret = saa7146_vv_init(dev, &vv_data);
+	if (ret) {
+		kfree(hexium);
+		return ret;
+	}
 
 	vv_data.vid_ops.vidioc_enum_input = vidioc_enum_input;
 	vv_data.vid_ops.vidioc_g_input = vidioc_g_input;
-- 
2.25.1

