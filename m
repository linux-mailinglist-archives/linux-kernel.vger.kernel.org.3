Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7F1475164
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 04:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239589AbhLODfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 22:35:46 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:32976 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236356AbhLODfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 22:35:45 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 4JDLVn24q2z9vYVd
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 03:35:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7McqHQ6jtvGc for <linux-kernel@vger.kernel.org>;
        Tue, 14 Dec 2021 21:35:45 -0600 (CST)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 4JDLVn0GWWz9vYVl
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 21:35:44 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 4JDLVn0GWWz9vYVl
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 4JDLVn0GWWz9vYVl
Received: by mail-pj1-f69.google.com with SMTP id o21-20020a17090a9f9500b001b105598e71so109557pjp.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 19:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vDyUbaxuYkfxzYa4iPnu8TJLkb4HX292tDIieRYCOfk=;
        b=XewPLirKRxPHk4whWqb+HaKFC82BJREBaskmOgZBTb+tnQoMqBDKzfavA7pfQfHSW9
         Cnopnm012L9hKposuoqf/ziC+2XnlQCgrO01qkbKmL0nu4bbzhH5FHwL8j3xNM6k0Y4L
         9PSEI6MwZtZ8L55WEx4Abr7aUuGW/ySIP+Ixs9sLmTB0Uf5TxJRN6+OxmPNOf5ijlvlq
         ElXJ0hBrenb8eKWnRZ7AOaGnvMaCSUM6MJ2zZ2T+cCWT6H/XaH0dep5WYt6RnwA6rCN7
         iFC2Zof6uKf0EAYYCKsRx6tTYQFBzBgVT7xMvao6iu3JXYHshyJHCH+WE8mIUBH8qJIB
         q/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vDyUbaxuYkfxzYa4iPnu8TJLkb4HX292tDIieRYCOfk=;
        b=r2HTwrceG3R3LP26CvtWNAK0kTYujlpTs2M82pId3IJ43wK2MjOuinxQohgSGLbid/
         nmb22yBs+aWHf//qUjXsXdox3ebJN5wBhsG23CuTgSd83OWzWz1HFj5OZU2l8bigF0UG
         x3Im4eVAEC+lw9mHJn92Jq/k4oEX4x3aRIXRxOQPMbgQoEfcfR/wgVABW7yrDFZ+PriO
         z/4UuksnDvGJ56BiORGi4t2quauap7VGyFt3gj92XZ6peMO55E1XN4U5/OTU3qIr6ecv
         VM2seL3QZRr4vLgpHI+PvETltup5YTQpxqy6AtkJKzOHTHyoJ49RjAyPP+Im9roV9l3q
         MA3w==
X-Gm-Message-State: AOAM53048ARdHuURi5q1iILvJj4LF3IkxWmg0phDuSYdDv2aTHYs0uQg
        mi/flz78/Dazd+gUeQmbcXu+/Bu9ajPWpfIjzkDmzwRcbx5DIHzWKIznJ53AlWHwLl0yP0J8pPP
        wfuEgp9/nckLtGOwZF89bRU45EPnA
X-Received: by 2002:a65:4889:: with SMTP id n9mr6300362pgs.303.1639539343353;
        Tue, 14 Dec 2021 19:35:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwuxQHgEkh5S9opzXkPm/4oyyaBbohUhOVVfMAyOnb213uAvq9wDfP7swp8VGy9xCEw1vo0oQ==
X-Received: by 2002:a65:4889:: with SMTP id n9mr6300335pgs.303.1639539343129;
        Tue, 14 Dec 2021 19:35:43 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.4.93.244])
        by smtp.gmail.com with ESMTPSA id p12sm532401pfo.125.2021.12.14.19.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 19:35:42 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Neil Armstrong <narmstrong@baylibre.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Maxime Jourdan <mjourdan@baylibre.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] media: meson: vdec: Fix a NULL pointer dereference in amvdec_add_ts()
Date:   Wed, 15 Dec 2021 11:35:35 +0800
Message-Id: <20211215033535.40422-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211214144613.35fec82a@coco.lan>
References: <20211214144613.35fec82a@coco.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In amvdec_add_ts(), there is a dereference of kzalloc(), which could lead
to a NULL pointer dereference on failure of kzalloc().

Fix this bug by adding a NULL check of new_ts.

This bug was found by a static analyzer[1].

Builds with CONFIG_VIDEO_MESON_VDEC=m show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: 876f123b8956 ("media: meson: vdec: bring up to compliance")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---

[1] The analysis employs differential checking to identify inconsistent
security operations (e.g., checks or kfrees) between two code paths and
confirms that the inconsistent operations are not recovered in the 
current function or the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

Changes in v3:
  -  Change the description of patch
  -  Turn the return type from 'void' to 'int'
  -  Check the return value in the caller 'esparser_queue()'

Changes in v2:
  -  Delete dev_err() message

 drivers/staging/media/meson/vdec/esparser.c     | 7 ++++++-
 drivers/staging/media/meson/vdec/vdec_helpers.c | 8 ++++++--
 drivers/staging/media/meson/vdec/vdec_helpers.h | 4 ++--
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/media/meson/vdec/esparser.c b/drivers/staging/media/meson/vdec/esparser.c
index db7022707ff8..095100a50da8 100644
--- a/drivers/staging/media/meson/vdec/esparser.c
+++ b/drivers/staging/media/meson/vdec/esparser.c
@@ -328,7 +328,12 @@ esparser_queue(struct amvdec_session *sess, struct vb2_v4l2_buffer *vbuf)
 
 	offset = esparser_get_offset(sess);
 
-	amvdec_add_ts(sess, vb->timestamp, vbuf->timecode, offset, vbuf->flags);
+	ret = amvdec_add_ts(sess, vb->timestamp, vbuf->timecode, offset, vbuf->flags);
+	if (!ret) {
+		v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
+		return ret;
+	}
+
 	dev_dbg(core->dev, "esparser: ts = %llu pld_size = %u offset = %08X flags = %08X\n",
 		vb->timestamp, payload_size, offset, vbuf->flags);
 
diff --git a/drivers/staging/media/meson/vdec/vdec_helpers.c b/drivers/staging/media/meson/vdec/vdec_helpers.c
index b9125c295d1d..06fd66539797 100644
--- a/drivers/staging/media/meson/vdec/vdec_helpers.c
+++ b/drivers/staging/media/meson/vdec/vdec_helpers.c
@@ -227,13 +227,16 @@ int amvdec_set_canvases(struct amvdec_session *sess,
 }
 EXPORT_SYMBOL_GPL(amvdec_set_canvases);
 
-void amvdec_add_ts(struct amvdec_session *sess, u64 ts,
-		   struct v4l2_timecode tc, u32 offset, u32 vbuf_flags)
+int amvdec_add_ts(struct amvdec_session *sess, u64 ts,
+		  struct v4l2_timecode tc, u32 offset, u32 vbuf_flags)
 {
 	struct amvdec_timestamp *new_ts;
 	unsigned long flags;
 
 	new_ts = kzalloc(sizeof(*new_ts), GFP_KERNEL);
+	if (!new_ts)
+		return -ENOMEM;
+
 	new_ts->ts = ts;
 	new_ts->tc = tc;
 	new_ts->offset = offset;
@@ -242,6 +245,7 @@ void amvdec_add_ts(struct amvdec_session *sess, u64 ts,
 	spin_lock_irqsave(&sess->ts_spinlock, flags);
 	list_add_tail(&new_ts->list, &sess->timestamps);
 	spin_unlock_irqrestore(&sess->ts_spinlock, flags);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(amvdec_add_ts);
 
diff --git a/drivers/staging/media/meson/vdec/vdec_helpers.h b/drivers/staging/media/meson/vdec/vdec_helpers.h
index 88137d15aa3a..4bf3e61d081b 100644
--- a/drivers/staging/media/meson/vdec/vdec_helpers.h
+++ b/drivers/staging/media/meson/vdec/vdec_helpers.h
@@ -56,8 +56,8 @@ void amvdec_dst_buf_done_offset(struct amvdec_session *sess,
  * @offset: offset in the VIFIFO where the associated packet was written
  * @flags: the vb2_v4l2_buffer flags
  */
-void amvdec_add_ts(struct amvdec_session *sess, u64 ts,
-		   struct v4l2_timecode tc, u32 offset, u32 flags);
+int amvdec_add_ts(struct amvdec_session *sess, u64 ts,
+		  struct v4l2_timecode tc, u32 offset, u32 flags);
 void amvdec_remove_ts(struct amvdec_session *sess, u64 ts);
 
 /**
-- 
2.25.1

