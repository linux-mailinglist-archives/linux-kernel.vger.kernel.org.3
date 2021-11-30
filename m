Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64997463B60
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhK3QQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:16:01 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:43624 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238277AbhK3QPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:15:51 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 4J3S0v4zngz9vJs2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 16:12:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6XoeNBqW2WjJ for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 10:12:31 -0600 (CST)
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 4J3S0v2vmGz9vJrl
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:12:31 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 4J3S0v2vmGz9vJrl
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 4J3S0v2vmGz9vJrl
Received: by mail-pg1-f199.google.com with SMTP id r15-20020a63ec4f000000b002e582189837so10526317pgj.20
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+InRof0/uIdyh184kbNfYTG/vjRoi2ITuATxWqrIaCg=;
        b=QQFpZIXv7DEivrF4SMIk84Xm86N1CjjIpvc3cSlX1cmd9Sy8GbGFq63zL0k5PKJa7i
         bIy7HFYuOq4jGsE4d4RTL4AxAt94zHyzsAjCw35b/P0HQ3vEJmrPcyPSxJRpH7d86KRS
         cu71acBcYj4CJebZkc2z1XlMBRaARx9RlgIlaA14r23AloLlHYesN/0Hdr7EAaieLnBr
         6GfBi4W0uurDwOAhtRKeMvYzmsyocF5Nn923hEE5t5ldSiT38+pR0WEDDTBdDUSSAs43
         s4J9TuzlbvUd7iuwKIOVUeuLVEdepQQyQJKJjvUjghseEyj0mXcL9z6BaHLeGZS3MIf6
         31OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+InRof0/uIdyh184kbNfYTG/vjRoi2ITuATxWqrIaCg=;
        b=2qullMyEYPXs+S4cUU1lNhwNmDEnslBaPOlwy9n+MCPdr5FuwNOSciC5KAjyI0JLPz
         RiwR1KOOC632FTyOBJ71Pyt/FIefpzQWOup6TuB2BGoxVoU+QsQEO4OphE8LvSJ8P6bc
         B1+YeDeU12souVSqn8jKF6EuqUEDOhLC1l4bAH2Ly/jCtklkjw9g+QIEdpy8TBSW6899
         HV1hbfCEdjd3thQ0bP0TkP/fM7/TniG962xSoNsTXfbbzKuJDFjYdIPj0cSvi1NsxwQF
         2u6yISaLho2MCCl4Q+K9xhPijMKK5GB9lDfsEysbz9vcSUEV4nwQ4tLuqyEB0lVmx6ty
         H5sQ==
X-Gm-Message-State: AOAM5314Nw33UqiLVxRGvV8TATIBFkr9ed8K8aAp0P6iFkMpb205ZpMo
        Sztm74RAk02VCpX4Iroen0oeLeoP3wsj5XK3olWiosOeQxwQEey65o4thk9alwr3e5RtipdQk4P
        +aMGezGme3UrgsmgK+JHB0kAUcWmB
X-Received: by 2002:a05:6a00:24d2:b0:49f:bbce:7bc1 with SMTP id d18-20020a056a0024d200b0049fbbce7bc1mr155711pfv.37.1638288750633;
        Tue, 30 Nov 2021 08:12:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz+GKwKQHK7uXFjfxjVBqjeb+jOkdeK3mPEahrfjDgFy1kG8HcnLoSHVfN3RaX0GqrIAbyeRQ==
X-Received: by 2002:a05:6a00:24d2:b0:49f:bbce:7bc1 with SMTP id d18-20020a056a0024d200b0049fbbce7bc1mr155680pfv.37.1638288750395;
        Tue, 30 Nov 2021 08:12:30 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id lx15sm3380968pjb.44.2021.11.30.08.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 08:12:30 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Neil Armstrong <narmstrong@baylibre.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Maxime Jourdan <mjourdan@baylibre.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: meson: vdec: Fix a NULL pointer dereference in amvdec_add_ts()
Date:   Wed,  1 Dec 2021 00:12:23 +0800
Message-Id: <20211130161224.181519-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In amvdec_add_ts(), there is a dereference of kzalloc(), which could lead
to a NULL pointer dereference on failure of kzalloc().

I fix this bug by adding a NULL check of new_ts.

This bug was found by a static analyzer. The analysis employs
differential checking to identify inconsistent security operations
(e.g., checks or kfrees) between two code paths and confirms that the
inconsistent operations are not recovered in the current function or
the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

Builds with CONFIG_VIDEO_MESON_VDEC=m show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: 876f123b8956 ("media: meson: vdec: bring up to compliance")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/staging/media/meson/vdec/vdec_helpers.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/staging/media/meson/vdec/vdec_helpers.c b/drivers/staging/media/meson/vdec/vdec_helpers.c
index b9125c295d1d..41297c2f8f9a 100644
--- a/drivers/staging/media/meson/vdec/vdec_helpers.c
+++ b/drivers/staging/media/meson/vdec/vdec_helpers.c
@@ -234,6 +234,11 @@ void amvdec_add_ts(struct amvdec_session *sess, u64 ts,
 	unsigned long flags;
 
 	new_ts = kzalloc(sizeof(*new_ts), GFP_KERNEL);
+	if (!new_ts) {
+		dev_err(sess->core->dev_dec,
+			"No enough memory in %s\n", __func__);
+		return;
+	}
 	new_ts->ts = ts;
 	new_ts->tc = tc;
 	new_ts->offset = offset;
-- 
2.25.1

