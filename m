Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDE1463C93
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 18:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244694AbhK3RPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 12:15:24 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:36560 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243657AbhK3RPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 12:15:20 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 4J3TKX5V8Wz9w94m
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 17:12:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Zms3DVVCGrD3 for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 11:12:00 -0600 (CST)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 4J3TKX3YkGz9w951
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 11:12:00 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 4J3TKX3YkGz9w951
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 4J3TKX3YkGz9w951
Received: by mail-pf1-f199.google.com with SMTP id u4-20020a056a00098400b004946fc3e863so13183426pfg.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 09:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V0lWGpYWyNpOYPxuRnSF3f8gDAFkgkH4nbP8crWjnQc=;
        b=mpUcODJ4kpde9Ay7Z/krQyfktHenkFWFmQDS1w2AgoRAY3OABAVNotR4Qf0OmlvfUZ
         1NyBd2+ivU57FrKLRsu4L5zm1mxOvHK2ZQFcEfdSaimtmL26gxkPGarzPQ3w2H7YmEN8
         zJmebwb793bOf0EE+JCw22LFOLO01H2DqptjFlEcW7SHfVU5PKzz72trj+0es4RvgsCj
         J748A2Ft+WA2Y8A0xtwwnKQYcy+e+rHPIHGoi6rs48IcSaNqeHutinnctETP9RNNAxt7
         8Hoisxxnj1Evfb8tr9vEcNjVKXzB2DMisXyIA/j5rR+gZGcvDvEqm9V4/3WiFE9PhO52
         7I/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V0lWGpYWyNpOYPxuRnSF3f8gDAFkgkH4nbP8crWjnQc=;
        b=y6EOYeExD/K7v/aUAOA7XrWJNfCcTx4/14YdWynDbpO5qrQu3JgKT1X77uTVv8aPid
         rVYYfN7XeXUxn3iLNyRPoG4vcwtYFGC5OiW5jjQ5Xkh7LMsm5nrpwYQzOOjiwARSZGA5
         Bs73yNq0wKp80ntHgQBNzeAhSpeuu6tIKnUulucvVfNlxS9CRiAhBS196+NFqfVqOH9U
         z6lhD6WX9s8pjdbatEkSZvtq0DPqE4rIHHuxckw22EwKkhzFvOtEZKG5bC3q2hNlJ40M
         vvuB6ewdniT5mnSDKZj4Wvqc/97vbRHYJsx2g33ekkU2hQ/Hk6bfVQY+RKxqILT72+j+
         DR0w==
X-Gm-Message-State: AOAM531XIZwowIC1L9YcWY7ZYuCKRXiPKlCtdo4Glu2MsFkbrYhq7Qch
        G5VQAme7jG7PGDl8wSEYL1/3uBhTg6CiDSOi7+nDYxhqcizgYj7lm0dUOEMFkOKdwiwb88wkLSn
        4JBBGrwK9+DPlhemh/QBheAFQMXvZ
X-Received: by 2002:a17:902:c410:b0:142:2506:cb5b with SMTP id k16-20020a170902c41000b001422506cb5bmr495035plk.36.1638292319706;
        Tue, 30 Nov 2021 09:11:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz2fXuTGnSmdHQRZFTjtJ71nlh0+Fs1qffHsWrGRYAwEWvVrGJGew4rmr+xWPQ0i+cAagA6qQ==
X-Received: by 2002:a17:902:c410:b0:142:2506:cb5b with SMTP id k16-20020a170902c41000b001422506cb5bmr494998plk.36.1638292319396;
        Tue, 30 Nov 2021 09:11:59 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id p2sm3124816pja.55.2021.11.30.09.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 09:11:59 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: libfc: Fix a NULL pointer dereference in fc_lport_ptp_setup()
Date:   Wed,  1 Dec 2021 01:10:49 +0800
Message-Id: <20211130171049.199111-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In fc_lport_ptp_setup(), fc_rport_create() is assigned to
lport->ptp_rdata and there is a dereference of in fc_lport_ptp_setup(),
which could lead to a NULL pointer dereference on failure of
fc_rport_create().

Fix this bug by adding a check of fc_rport_create().

This bug was found by a static analyzer. The analysis employs
differential checking to identify inconsistent security operations
(e.g., checks or kfrees) between two code paths and confirms that the
inconsistent operations are not recovered in the current function or
the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

Builds with CONFIG_LIBFC=m show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: 2580064b5ec6 ("scsi: libfc: Replace ->rport_create callback with function call")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/scsi/libfc/fc_lport.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/scsi/libfc/fc_lport.c b/drivers/scsi/libfc/fc_lport.c
index 19cd4a95d354..5cd716afb711 100644
--- a/drivers/scsi/libfc/fc_lport.c
+++ b/drivers/scsi/libfc/fc_lport.c
@@ -241,6 +241,13 @@ static void fc_lport_ptp_setup(struct fc_lport *lport,
 	}
 	mutex_lock(&lport->disc.disc_mutex);
 	lport->ptp_rdata = fc_rport_create(lport, remote_fid);
+	if (!lport->ptp_rdata) {
+		mutex_unlock(&lport->disc.disc_mutex);
+		printk(KERN_WARNING "libfc: Failed to allocate for the port (%6.6x)\n",
+				remote_fid);
+		return;
+	}
+
 	kref_get(&lport->ptp_rdata->kref);
 	lport->ptp_rdata->ids.port_name = remote_wwpn;
 	lport->ptp_rdata->ids.node_name = remote_wwnn;
-- 
2.25.1

