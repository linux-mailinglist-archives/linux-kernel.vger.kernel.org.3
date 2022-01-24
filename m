Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D474985AB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244075AbiAXREW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:04:22 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:55534 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243962AbiAXREU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:04:20 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 4JjGYG6q15z9vY6r
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 17:04:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id H7FHHO1vlg44 for <linux-kernel@vger.kernel.org>;
        Mon, 24 Jan 2022 11:04:18 -0600 (CST)
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 4JjGYG4mpVz9vY6m
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 11:04:18 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 4JjGYG4mpVz9vY6m
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 4JjGYG4mpVz9vY6m
Received: by mail-pg1-f199.google.com with SMTP id s5-20020a635245000000b0034ea48b7094so4575376pgl.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 09:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FazSFMA+aZ9XoPqirxdQTRfh3CfesxK/5V0htIJuY88=;
        b=PaWfKa1kKN2Zof2lfwbFJNDiHyqysB22EEnId9NaRlB/MV9/MtE+ezuNu9UyLZhJue
         /iaiiqYVttjLceS5I7CQtz6z7dNPpfkFqKof/GWZnMhOpgb74L06Dusu+lfOAu3gW8td
         /uXwRlFQ8hJkujrg8/1fsE2avXJgPCPlI5lDS7G4zjVeDfq14gTJ9wHtBGkypE/WYFvq
         184zXbzKNFXzvicSjZcP1kqeIhoF6v+6ERwi3Mmrcd5drW+aLqXR1xEFLAEgaKVfScg9
         cFo2jjjbpD5FID1+JIfNzvntGnp8PZEK06wM9ImCb7BXCdza/KjBTZ4t8SIipDmVNmn5
         /J+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FazSFMA+aZ9XoPqirxdQTRfh3CfesxK/5V0htIJuY88=;
        b=BWWHvBslIvdbCXKT6z5onbOeTKkI2SWdqHnvDD4pr2hVcAqC4Zaf54kwrlGFn8/qpu
         DIvRXkKms/Sp5sO5wxEzxC14wO+cB9Zch0yUjeHZx1Sh/hr8r8O9nUczOm3HSCIWdSS9
         JDw1V7NbfcFTYaBUXxLOeGnMngIlh6TLvyMcd9b9hmYNotZni179rPXFFM6iU03BCkLa
         4bEACHaRpyrMdQCCa71+IeC+TlBJo2zI0o59TwNOkSTFNad8mc2aK31LDvZhuAeMP1TZ
         BwcAYDg9KA7LmOJ+MWDkpif/UDaaRkx8Dz0qhlSi47qZUKjybrcIb3+zBbdl5LUj9v44
         MvUQ==
X-Gm-Message-State: AOAM531a8kci4b+Zi5g6U9wOUhGf0urg1vMUye91lhQ5HUcy5b+c2OaL
        Q/97ZoJVI4VVbnNWUEIK3r8QgP50YtTdNrzcVD/zDjz6EOUWyKMuMc0ZQ0nddOreqbmSLGfmbRk
        vu/WxjreI3izMxr8Swx/pKNH+WI6x
X-Received: by 2002:a17:90a:77c8:: with SMTP id e8mr2786747pjs.111.1643043857703;
        Mon, 24 Jan 2022 09:04:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy7YNZc6mTIEdSdNIs3FzgPra3yoffvTnmNwSImjoKYeOXmKfcLsHqlEVt2QCw16aOAEFawTA==
X-Received: by 2002:a17:90a:77c8:: with SMTP id e8mr2786724pjs.111.1643043857463;
        Mon, 24 Jan 2022 09:04:17 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.4.61.248])
        by smtp.gmail.com with ESMTPSA id 25sm20665228pje.22.2022.01.24.09.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 09:04:17 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Douglas Schilling Landgraf <dougsland@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: bttv: Fix a NULL pointer dereference in bttv_s_fbuf()
Date:   Tue, 25 Jan 2022 01:04:09 +0800
Message-Id: <20220124170411.58169-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In bttv_s_fbuf(), the return value of videobuf_sg_alloc() is assigned
to variable new and there is a dereference of it after that. the return
value of videobuf_sg_alloc() could be NULL on failure of allocation,
which could lead to a NULL pointer dereference.

Fix this bug by adding a NULL check of new.

This bug was found by a static analyzer.

Builds with 'make allyesconfig' show no new warnings,
and our static analyzer no longer warns about this code

Fixes: 402aa76aa5e5 ("V4L/DVB (6911): Converted bttv to use video_ioctl2")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
The analysis employs differential checking to identify inconsistent 
security operations (e.g., checks or kfrees) between two code paths 
and confirms that the inconsistent operations are not recovered in the
current function or the callers, so they constitute bugs. 

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

 drivers/media/pci/bt8xx/bttv-driver.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/pci/bt8xx/bttv-driver.c b/drivers/media/pci/bt8xx/bttv-driver.c
index 5aa46593ddc6..c0664cffb881 100644
--- a/drivers/media/pci/bt8xx/bttv-driver.c
+++ b/drivers/media/pci/bt8xx/bttv-driver.c
@@ -2627,6 +2627,8 @@ static int bttv_s_fbuf(struct file *file, void *f,
 			struct bttv_buffer *new;
 
 			new = videobuf_sg_alloc(sizeof(*new));
+			if (!new)
+				return -ENOMEM;
 			new->crop = btv->crop[!!fh->do_crop].rect;
 			bttv_overlay_risc(btv, &fh->ov, fh->ovfmt, new);
 			retval = bttv_switch_overlay(btv, fh, new);
-- 
2.25.1

