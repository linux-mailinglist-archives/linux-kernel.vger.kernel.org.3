Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95D1498639
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241456AbiAXRQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:16:33 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:59176 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiAXRQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:16:32 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 4JjGqN02fzz9vKYF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 17:16:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2EKooWZw42rL for <linux-kernel@vger.kernel.org>;
        Mon, 24 Jan 2022 11:16:31 -0600 (CST)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 4JjGqM4ynQz9vKYH
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 11:16:31 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 4JjGqM4ynQz9vKYH
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 4JjGqM4ynQz9vKYH
Received: by mail-pj1-f70.google.com with SMTP id ay18-20020a17090b031200b001b53c85761aso7460306pjb.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 09:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZbD4Cm/3Vffm0HL+lKO3+0FIUSFq/dKHU9Ud+lQuNnU=;
        b=OVepBF7n9FOnQOfzWCH4yWVhHf3qOf5lFf3MkeinE6ALECdgZjTHJEuVYZqgTtJkmo
         XXQVbOjRSbe6YkPVR7qrrSPlVSOnXihzD2ioDcd/8JZWKSzivdB6AoGmKAAsqeIhZbtO
         u/ffPsiXgak4owPYTtk5IDkUln+lhYru919YU14PeqL4sA8cNjuHxFjf35T2+/N2i3su
         iUHGOW8TCzcotiKL7kVcRmRBr0Kue1DOhe25iEBdRh2J7lCxSpKKgvWS/g6jXUDhlrfg
         +eMwdBbQZYKg6z1RlsVltqUnInSdq170jk1/RzdB8MtvmcOpxXIgRiovCyaO535rQ7Qg
         LK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZbD4Cm/3Vffm0HL+lKO3+0FIUSFq/dKHU9Ud+lQuNnU=;
        b=2OcgNnLmuWv1FaFxEkwN600bj3fEcUGv+wUvhVWDd8z+DSGti/JYzYVVIvX6Cj2AtA
         e2ktYNpip8KQyNrQmzam4eSvy74e8IZEk6fXqH3HMlqAEs1r9bKMQ27ja+ZX81tn32YE
         OtYOMIww8xTsHQcBGRIfZke3G/HMfMO+D4RTKdzs/sWW5y9WpStGYRU0brFxiYiVUNeU
         0CQ0+ywwZYnBreIxFmrpAEoAtrQrrLg0x7d3NHdSpe48RKxjS+Qqs7sWILDuBGqo136a
         3O/UBmOXp9jfIRNzHLIQcfXgT4uj4BmaxFon7Y3/bS3iXktCtY4qUG9ESdrzEPWLQD4l
         MIQA==
X-Gm-Message-State: AOAM532ag7seQGBe9xQ6QAczFNJKOUA0RF/J3Rq4Lsdu0WWG6V0munCn
        h3l0maqCkJ2UiwbOPyG1Sb2MuCBZv6Xn6/SZ9dtj+HMh5B683lNxriPr3+fC2cYjqmg7hdTXjut
        5z5i8PXBSJdR+rgNF4ZDp3AciL2JT
X-Received: by 2002:a17:902:8498:b0:14a:1b37:9f2b with SMTP id c24-20020a170902849800b0014a1b379f2bmr15862257plo.85.1643044590807;
        Mon, 24 Jan 2022 09:16:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxmzkfmTgOVWbH61bb5d63j3WPu+JGnTE+TZUZcNzLSobKKUqFKCwRRttlfynOChBm0zoLXhg==
X-Received: by 2002:a17:902:8498:b0:14a:1b37:9f2b with SMTP id c24-20020a170902849800b0014a1b379f2bmr15862240plo.85.1643044590590;
        Mon, 24 Jan 2022 09:16:30 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.4.61.248])
        by smtp.gmail.com with ESMTPSA id l4sm1013112pfu.90.2022.01.24.09.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 09:16:30 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: pci: cx23855-video.c: Fix a NULL pointer dereference in cx23885_video_register()
Date:   Tue, 25 Jan 2022 01:16:18 +0800
Message-Id: <20220124171620.61466-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cx23885_video_register(), the return value of cx23885_vdev_init() is
assigned to dev->video_dev and there is a dereference of it after that.
the return value of cx23885_vdev_init() could be NULL on failure of
allocation, which could lead to a NULL pointer dereference.

the same as dev->vbi_dev.

Fix this bug by adding a NULL check of dev->video_dev and dev->vbi_dev.

This bug was found by a static analyzer.

Builds with 'make allyesconfig' show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: 453afdd9ce33 ("[media] cx23885: convert to vb2")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
The analysis employs differential checking to identify inconsistent 
security operations (e.g., checks or kfrees) between two code paths 
and confirms that the inconsistent operations are not recovered in the
current function or the callers, so they constitute bugs. 

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

 drivers/media/pci/cx23885/cx23885-video.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/media/pci/cx23885/cx23885-video.c b/drivers/media/pci/cx23885/cx23885-video.c
index a380e0920a21..1b95109eff8c 100644
--- a/drivers/media/pci/cx23885/cx23885-video.c
+++ b/drivers/media/pci/cx23885/cx23885-video.c
@@ -1353,6 +1353,11 @@ int cx23885_video_register(struct cx23885_dev *dev)
 	/* register Video device */
 	dev->video_dev = cx23885_vdev_init(dev, dev->pci,
 		&cx23885_video_template, "video");
+	if (!dev->video_dev) {
+		err = -ENOMEM;
+		goto fail_unreg;
+	}
+
 	dev->video_dev->queue = &dev->vb2_vidq;
 	dev->video_dev->device_caps = V4L2_CAP_READWRITE | V4L2_CAP_STREAMING |
 				      V4L2_CAP_AUDIO | V4L2_CAP_VIDEO_CAPTURE;
@@ -1381,6 +1386,11 @@ int cx23885_video_register(struct cx23885_dev *dev)
 	/* register VBI device */
 	dev->vbi_dev = cx23885_vdev_init(dev, dev->pci,
 		&cx23885_vbi_template, "vbi");
+	if (!dev->vbi_dev) {
+		err = -ENOMEM;
+		goto fail_unreg;
+	}
+
 	dev->vbi_dev->queue = &dev->vb2_vbiq;
 	dev->vbi_dev->device_caps = V4L2_CAP_READWRITE | V4L2_CAP_STREAMING |
 				    V4L2_CAP_AUDIO | V4L2_CAP_VBI_CAPTURE;
-- 
2.25.1

