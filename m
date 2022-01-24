Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8552E498657
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244340AbiAXRUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:20:10 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:38860 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241556AbiAXRUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:20:08 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 4JjGvW11dCz9vBsQ
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 17:20:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZXRdBEmTkrWY for <linux-kernel@vger.kernel.org>;
        Mon, 24 Jan 2022 11:20:07 -0600 (CST)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 4JjGvV64PLz9vBrg
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 11:20:06 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 4JjGvV64PLz9vBrg
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 4JjGvV64PLz9vBrg
Received: by mail-pl1-f199.google.com with SMTP id u14-20020a170902714e00b0014ace69caccso3689998plm.17
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 09:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h2JRhxJChDjEc19BlDKaMcq9FWna7cgcELD3wcsjdNU=;
        b=cLr2eZY/tB17jFSJpyIuavnaaKRSot65n47sX4pg2kXWeHCNNiNv0NxQP5piROKKIX
         PHvIByc4s0VikEHclosLcdrBdQMbKRcWLR0InVEWc1sOLIVpmvjxlQW3Cu7QT5/jPWsN
         kBgbUJd9UOADE4XYM/zR28Q4DDeDvgrPj76RIXiIRr2WhqVRRcy9uPTEI4cj65roLvIe
         dkv+NGn5xwg3osmJ4DJ2NLOYfH5938mUPLDa0mgkTmVp1FbtVEezVawTbdcyktJW+frE
         p4z288MAJRvsm8kUDMcO3BVXJclG9OKEal6fRwRxh8aqLBp4CtxYoyPwF6Lh+qaOnEHX
         rmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h2JRhxJChDjEc19BlDKaMcq9FWna7cgcELD3wcsjdNU=;
        b=GrV9O/j/6MhieMbXANML1aN+EyaxtgEsHCeiK9NeYtaNS+P8JVKxuazKPbdUK57i4c
         aDqu1dDTseHIyTtm75uLQT9OmSXBEBofr4ymP2X4mG6ko2VQCdwBKxvfaa/lroene+zK
         cLgDXJUxkvJOZyae+UzdDQbQmW1SnZ7sNxMkkHIMPks4GXDuwELqgKw1X+bppidK1umQ
         c/aFZKosXhqd4tMkGjMGAawEuS2Leif3qHmpCRg4jU4ljAUzwR5FOkRryViOrCP2nCie
         giRl7bX+9/yfTPV96IEwiKeAPcqExvTheJdaPLuwuwkILjKi+TXUjM1w+yT4iFet+4t9
         /o8g==
X-Gm-Message-State: AOAM533FQ2i/ttk7rBpB7OQaYfmWiJljWAh6blFM2ntcVqt88yBzrzLG
        zghfx7ioRV+dgEo6aS8MH4mLXkGlBxe4Pvoiv2bQYXfEX5ypVlQ9+PXPtYVwuDfUG1ubkmrffFr
        2+dARZYj7BxB+9IYZ4nGr+lYLFZCZ
X-Received: by 2002:a63:fe10:: with SMTP id p16mr12354431pgh.546.1643044805995;
        Mon, 24 Jan 2022 09:20:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyXGYkHlV1znfzG4/WeKqTtvwoYa0BJ9/DXjKeFSmVu0fri6iZ3upKqAPfaCzXONy8SZSnWFA==
X-Received: by 2002:a63:fe10:: with SMTP id p16mr12354417pgh.546.1643044805734;
        Mon, 24 Jan 2022 09:20:05 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.4.61.248])
        by smtp.gmail.com with ESMTPSA id u9sm17604761pfi.14.2022.01.24.09.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 09:20:05 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Benoit Parrot <bparrot@ti.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: ti-vpe: cal: Fix a NULL pointer dereference in cal_ctx_v4l2_init_formats()
Date:   Tue, 25 Jan 2022 01:20:01 +0800
Message-Id: <20220124172001.62457-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cal_ctx_v4l2_init_formats(), devm_kzalloc() is assigned to fw and there
is a dereference of it after that, which could lead to NULL pointer
dereference on failure of devm_kzalloc().

Fix this bug by adding a NULL check of ctx->active_fmt.

This bug was found by a static analyzer.

Builds with 'make allyesconfig' show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: 7168155002cf ("media: ti-vpe: cal: Move format handling to cal.c and expose helpers")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
--
The analysis employs differential checking to identify inconsistent 
security operations (e.g., checks or kfrees) between two code paths 
and confirms that the inconsistent operations are not recovered in the
current function or the callers, so they constitute bugs. 

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

 drivers/media/platform/ti-vpe/cal-video.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/ti-vpe/cal-video.c b/drivers/media/platform/ti-vpe/cal-video.c
index 7799da1cc261..3e936a2ca36c 100644
--- a/drivers/media/platform/ti-vpe/cal-video.c
+++ b/drivers/media/platform/ti-vpe/cal-video.c
@@ -823,6 +823,9 @@ static int cal_ctx_v4l2_init_formats(struct cal_ctx *ctx)
 	/* Enumerate sub device formats and enable all matching local formats */
 	ctx->active_fmt = devm_kcalloc(ctx->cal->dev, cal_num_formats,
 				       sizeof(*ctx->active_fmt), GFP_KERNEL);
+	if (!ctx->active_fmt)
+		return -ENOMEM;
+
 	ctx->num_active_fmt = 0;
 
 	for (j = 0, i = 0; ; ++j) {
-- 
2.25.1

