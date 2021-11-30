Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81791463BFC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244093AbhK3QnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:43:13 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:57666 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbhK3QnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:43:12 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 4J3ScR5kb2z9y5gl
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 16:39:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id x7hTaEAOyzug for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 10:39:51 -0600 (CST)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 4J3ScR3XfLz9y5gr
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:39:51 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 4J3ScR3XfLz9y5gr
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 4J3ScR3XfLz9y5gr
Received: by mail-pj1-f70.google.com with SMTP id m20-20020a17090aab1400b001ad6e2148ccso153045pjq.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m7joVp9ZGPeCi9ib/4Zk8tpyk8ZFFr30BOqRtbM2qm0=;
        b=ghKddV5vhe9R2iiR2g7/xEa0wQFHcVdeTvN6Hu6qGRai76wxmDEe5uFgPyam/6RGTL
         dG7et/pJ9pC13zR12TKcu9NHSG41t1u2tszo3S2qDGkE+Bb0nfcz/gP7+b/gfctTJ4Ry
         a3GUtaqFCs3tYwM2sJW0dm97GlIsHqi9QENqtqm/dteBH60NAyTUFM93vMvfOvSQaFDG
         BGEyPK9/yZUSs+dSD7ChhQWpirAeTTkTxAahyT1PwGWwSQCGGQ/PdEoKUVMvdensVWSJ
         EaaiDqj9KEvP2OsKXjRmPX9pjMWZnb76C0s0J3rbc0gmMgoptZstpU7quFo6XeG5/+VT
         izJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m7joVp9ZGPeCi9ib/4Zk8tpyk8ZFFr30BOqRtbM2qm0=;
        b=ZC1AGK62rH2o0C0qn5bxN5TYt85PUGAic607wRTKS2CGKnI/pziVOcQ0lBD+oB2k8P
         3n6jkQDgWO0YAIdQObVwTuPUPbw/Ugja3ECmRclAO5TLZEJcHqL+wl6k0cOQbz0g72UQ
         zFmiEpdnOzNMxM03kpjRKrERVUcvMHcmhgouqvTCIRHNl9QVWocM88l331ohHg4CtWkZ
         HGoJ9VPJH1vdc7dSn32jvY/NGjQAW1OMklwPOGkzkgawu1/UQOZfy9DyLNJkiscTgP+q
         JZRWq4MLUauNNGRkgvpMQ/PRp36an/7A6jnC8jplBNIpXFK8wWHY/OLvP9pgRRi15OE+
         xXng==
X-Gm-Message-State: AOAM533GxOSz6qACFj9+/N33CjcY1ru0BRo5F7ZnlvtZ2HTFEfrEnmd2
        HsyY4j+X3DB5D/b1A8mBaJF3OY4DoxLV/wE94aEXOs46r/JV+5Ixk9xx0ax0X/8zxTYUKgo5a5E
        xfma0FvN6LZSZLEqJHGRB0Qz2aQVB
X-Received: by 2002:a63:654:: with SMTP id 81mr222369pgg.218.1638290390608;
        Tue, 30 Nov 2021 08:39:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyawp1G79vl80DYOCucv1k9O4bRauliVE99jsaHmQOoxxj9MO6RJiMr+CN4ZQlSBX/KLZJ8FA==
X-Received: by 2002:a63:654:: with SMTP id 81mr222353pgg.218.1638290390430;
        Tue, 30 Nov 2021 08:39:50 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id e19sm15175741pgt.49.2021.11.30.08.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 08:39:49 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: vidtv: Fix a wild pointer dereference in vidtv_channel_pmt_match_sections()
Date:   Wed,  1 Dec 2021 00:39:45 +0800
Message-Id: <20211130163946.189005-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In vidtv_channel_pmt_match_sections(), vidtv_psi_pmt_stream_init() is
assigned to tail and &tail->descriptor is used in
vidtv_psi_desc_assign(). There is a dereference of &tail->descriptor
in vidtv_psi_desc_assign(), which could lead to a wild pointer
dereference onfailure of vidtv_psi_pmt_stream_init().

Fix this bug by adding a check of tail.

This bug was found by a static analyzer. The analysis employs
differential checking to identify inconsistent security operations
(e.g., checks or kfrees) between two code paths and confirms that the
inconsistent operations are not recovered in the current function or
the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

Builds with CONFIG_DVB_VIDTV=m show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: f90cf6079bf6 ("media: vidtv: add a bridge driver")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/media/test-drivers/vidtv/vidtv_channel.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/media/test-drivers/vidtv/vidtv_channel.c b/drivers/media/test-drivers/vidtv/vidtv_channel.c
index 7838e6272712..f2faa5504642 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_channel.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_channel.c
@@ -318,6 +318,10 @@ vidtv_channel_pmt_match_sections(struct vidtv_channel *channels,
 	struct vidtv_psi_table_pmt_stream *s = NULL;
 	struct vidtv_channel *cur_chnl = channels;
 	struct vidtv_psi_desc *desc = NULL;
+	struct vidtv_mux *m = container_of(&channels,
+					struct vidtv_mux,
+					channels);
+
 	u16 e_pid; /* elementary stream pid */
 	u16 curr_id;
 	u32 j;
@@ -341,6 +345,13 @@ vidtv_channel_pmt_match_sections(struct vidtv_channel *channels,
 					tail = vidtv_psi_pmt_stream_init(tail,
 									 s->type,
 									 e_pid);
+
+					if (!tail) {
+						vidtv_psi_pmt_stream_destroy(head);
+						dev_warn_ratelimited(m->dev,
+							"No enough memory for vidtv_psi_pmt_stream_init");
+						return;
+					}

 					if (!head)
 						head = tail;
-- 
2.25.1

