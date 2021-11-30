Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6E1463CA0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 18:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243794AbhK3RUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 12:20:05 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:45072 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241963AbhK3RT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 12:19:57 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 4J3TQr4Nzgz9wNLP
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 17:16:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id t80ZFG7Q9M8B for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 11:16:36 -0600 (CST)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 4J3TQr2HFMz9wNLM
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 11:16:36 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 4J3TQr2HFMz9wNLM
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 4J3TQr2HFMz9wNLM
Received: by mail-pj1-f69.google.com with SMTP id b11-20020a17090acc0b00b001a9179dc89fso11853121pju.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 09:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bk5/kAWjAvs+b0GCY85GoUSUo7I89iE76DMJNhOPG2s=;
        b=Dg8klp2i9BjmR1og+IfFIkoDF2VNFRN2wTwC/n3G4tv46hJyrQMMXN2/52x4Bqb3aL
         QohG9MrWU5qJuWtFX+C2dkjGkQFdDxG2CXQZ7EGkD+fZLFOrc7MI5FZ/z2KnDKm2cUPm
         ccPJM7+bytFKbkvK/958x0laxpYKBj0LljYpI0e6+c3cdrM4s9lNXA+bBIlyY1ufGpqo
         BOWAuHumPPkBb+TZsP7Of3eK7OciJIVYE2h0Wit9Bk4gC2N/6vzfJYZmPGdDrTEjEYXz
         pO33iwO7b+B55fqfn5H+0w4+t48uwqOMQPtMlo9YHnLIRADyR1HMM2NDbS9JHeQiY9tY
         lRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bk5/kAWjAvs+b0GCY85GoUSUo7I89iE76DMJNhOPG2s=;
        b=VPvlzdo6/xy26sM/LjY1UXDTKW+SmULBqhZQPY/XToPiqTbrRSS3NC9V8XC70akdKw
         Tne5T5fe2NyNvetGGBZCFODEF0G+7p+abvTNUvFCMBQGc8xnsFSoCZtgPvnVVCnlL+0a
         XsrrHBjJ11AWaHXmdC60tpI5h6GK4FcU9jFSVuWC41LH0JEj2J8+DBxrZYvKvan5sIDV
         P5Dj6vnB/da1yqlatrtEmxLlHJxHXKD3Y+YMYwJG+HyHnS7pjrJ6s7Egkpy1lDAxQ73V
         AVqcLwNLlDCNpHI0LyzMazD6jBAu2hFryDKlucXMuLWKvDRc34bjB/QRaFqd7OOTief+
         cwbw==
X-Gm-Message-State: AOAM5325HWGM4uKaG6mzuli1PQpMd4Sirg4rGFeEDFS9G3lXbajDOa8e
        u1MiQhBFjNb2voFYVOT5wRwzFRqiSr3O21mIVOpKEFvLphcjbxekNmnKZQbMbpKylimhv5kz55Q
        ucTxCtEJ3oT6GOWSn8JzjsrGL8S6C
X-Received: by 2002:aa7:8883:0:b0:49f:f87a:95de with SMTP id z3-20020aa78883000000b0049ff87a95demr148445pfe.53.1638292595625;
        Tue, 30 Nov 2021 09:16:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwZMePXStjKn4yE+PZSSZX2FKyH2zVOjdwrYOT+9/biQshIsNDwuK8FNg6ZQHWGVAGvvdh7pQ==
X-Received: by 2002:aa7:8883:0:b0:49f:f87a:95de with SMTP id z3-20020aa78883000000b0049ff87a95demr148416pfe.53.1638292595371;
        Tue, 30 Nov 2021 09:16:35 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id q13sm22247570pfk.22.2021.11.30.09.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 09:16:35 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        John Garry <john.garry@huawei.com>,
        Jason Yan <yanaijie@huawei.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Luo Jiaxing <luojiaxing@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        James Bottomley <James.Bottomley@SteelEye.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: libsas: Fix a NULL pointer dereference in sas_ex_discover_expander()
Date:   Wed,  1 Dec 2021 01:16:26 +0800
Message-Id: <20211130171629.201026-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sas_ex_discover_expander(), sas_port_alloc() is assigned to phy->port
and used in sas_port_add(). sas_port_add() further passes phy->port to
list_empty(), and there is a dereference of it in list_empty(), which
could lead to a NULL pointer dereference on failure of
sas_port_alloc().

This patch imitates the same error-handling logic in
sas_ex_discover_end_dev().

Fix this bug by adding checks for phy->port and sas_port_add().

This bug was found by a static analyzer. The analysis employs
differential checking to identify inconsistent security operations
(e.g., checks or kfrees) between two code paths and confirms that the
inconsistent operations are not recovered in the current function or
the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

Builds with CONFIG_SCSI_SAS_LIBSAS=m show no new warnings,
and our static analyzer no longer warns about this code.

Fixes:  2908d778ab3e ("[SCSI] aic94xx: new driver")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/scsi/libsas/sas_expander.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index c2150a818423..7530b1773d6b 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -957,9 +957,16 @@ static struct domain_device *sas_ex_discover_expander(
 		return NULL;
 
 	phy->port = sas_port_alloc(&parent->rphy->dev, phy_id);
-	/* FIXME: better error handling */
-	BUG_ON(sas_port_add(phy->port) != 0);
+	if (unlikely(!phy->port)) {
+		sas_put_device(child);
+		return NULL;
+	}
 
+	if (sas_port_add(phy->port) != 0) {
+		sas_port_free(phy->port);
+		sas_put_device(child);
+		return NULL;
+	}
 
 	switch (phy->attached_dev_type) {
 	case SAS_EDGE_EXPANDER_DEVICE:
-- 
2.25.1

