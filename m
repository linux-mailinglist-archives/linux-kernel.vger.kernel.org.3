Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D1F463CA8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 18:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244769AbhK3RWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 12:22:42 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:37018 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244170AbhK3RWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 12:22:30 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 4J3TTm4sJvz9yT9j
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 17:19:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Aarb-d5wLU8K for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 11:19:08 -0600 (CST)
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 4J3TTm2l61z9yT9X
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 11:19:08 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 4J3TTm2l61z9yT9X
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 4J3TTm2l61z9yT9X
Received: by mail-pg1-f200.google.com with SMTP id d2-20020a656202000000b00325603f7d0bso5184379pgv.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 09:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RFhArOyxQn5pjZYL9yNu46kO2Q7Wi3qiSk6NbXAyyM0=;
        b=DwwDjFZrzioL04V/Lb87rUAcaUDlq48oyaCgzLIjUaihJji3fpz48cDEumpK4d+k0i
         U7mmUS1VSfOnoUf/FsfjvPgQHf1Wmn/uGFx/FrRPWsxdk9E4fjHmD6anao8BGSEqWLbK
         iVWlof7W6Lm2vgk9XgUZ9cF+ONIBCwrMo0Fg+texL/BdJbisUHwZZW2qxzgtxOlxZ4RZ
         3/8Hm0kBtE038J15Cyh5WWhkmt9qG8RAuFbHzIX0RTY+NU2IVETtHPeMaeA9NHzHUx8v
         fObufUEFzYEVR2EowOmTT4HqF1JzSAp6QaLd5wZGv5q4vZ8z2NDW5Lr89fCYga8mAsQa
         sWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RFhArOyxQn5pjZYL9yNu46kO2Q7Wi3qiSk6NbXAyyM0=;
        b=11hoCDcgqrw+W5sRdXZGup8/9Ycinx3lsIaSMl3Ch1pVYdOunufu/ZZu3gEF2VUlUl
         ztT5rWC19X6N+UbyVCCbs81oDpm/eP1qZ8nUt6+3gq58Q5JFrImdpgRsqYe4agYrAGiP
         W+vG1/kqappNHdxgvTcx671AzPuUd4bVWZk9HJapd35lZae+zsliLXXOk28hH5R3qaYn
         AM/RV9yFRMKchcUuGkCUzKHkwruQxJgko5bjZwk3YKcRrP6KOeX/sY5+oLA6U1IFdjDC
         zJfcNwgGh+BY81lj0xqLq15izEBVRKG5uT0tb5oJRDe7xAadqhN8wQAWb0wBRpmSlwyu
         hb4A==
X-Gm-Message-State: AOAM531TEsyJ2vXdKBGQUjtkH1YOvVi7v92y9c91iEcM16JQ4At8bPna
        vVFQ0UDmKVoiwBhHTAlt2WQipGi9FXGoeAs9l9e/f9gOJkbe0BusB5YaF83rWWcSluqMY6pmCbk
        VUM+asgsVeBGoVTP0hJD4GSfPlulY
X-Received: by 2002:a63:778c:: with SMTP id s134mr366184pgc.289.1638292747705;
        Tue, 30 Nov 2021 09:19:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxg8qDxsG9c58L5rijf8FS/fNzjxeNzfkQ8Ajjp/dGFQ3NjtBZe/4EeXghkDZwhOI/PccSaOA==
X-Received: by 2002:a63:778c:: with SMTP id s134mr366160pgc.289.1638292747459;
        Tue, 30 Nov 2021 09:19:07 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id me7sm3988741pjb.9.2021.11.30.09.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 09:19:07 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matt Lupfer <mlupfer@ddn.com>,
        virtualization@lists.linux-foundation.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: virtio_scsi: Fix a NULL pointer dereference in virtscsi_rescan_hotunplug()
Date:   Wed,  1 Dec 2021 01:19:01 +0800
Message-Id: <20211130171901.202229-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In virtscsi_rescan_hotunplug(), kmalloc() is directly used in memset(),
which could lead to a NULL pointer dereference on failure of
kmalloc().

Fix this bug by adding a check of inq_result.

This bug was found by a static analyzer. The analysis employs
differential checking to identify inconsistent security operations
(e.g., checks or kfrees) between two code paths and confirms that the
inconsistent operations are not recovered in the current function or
the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

Builds with CONFIG_SCSI_VIRTIO=m show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: 5ff843721467 ("scsi: virtio_scsi: unplug LUNs when events missed")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/scsi/virtio_scsi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 28e1d98ae102..5309f2a3a4cb 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -337,7 +337,11 @@ static void virtscsi_rescan_hotunplug(struct virtio_scsi *vscsi)
 	unsigned char scsi_cmd[MAX_COMMAND_SIZE];
 	int result, inquiry_len, inq_result_len = 256;
 	char *inq_result = kmalloc(inq_result_len, GFP_KERNEL);
-
+	if (!inq_result) {
+		pr_err("%s:no enough memory for inq_result\n",
+			__func__);
+		return;
+	}
 	shost_for_each_device(sdev, shost) {
 		inquiry_len = sdev->inquiry_len ? sdev->inquiry_len : 36;
 
-- 
2.25.1

