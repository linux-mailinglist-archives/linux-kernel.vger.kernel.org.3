Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B75463D6B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 19:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245329AbhK3SPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 13:15:18 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:48454 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245315AbhK3SPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 13:15:17 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 4J3Vfj5Ty7z9vvMn
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 18:11:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jttlaACgkQU0 for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 12:11:57 -0600 (CST)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 4J3Vfj3V12z9vvMZ
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 12:11:57 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 4J3Vfj3V12z9vvMZ
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 4J3Vfj3V12z9vvMZ
Received: by mail-pj1-f69.google.com with SMTP id r23-20020a17090a941700b001a74be6cf80so7206022pjo.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2o54CAxD5XyQaMV38YJxUljOZZT2lsArgctVLanjbrQ=;
        b=cI50VIOUTb4Ii3alTD42k0DVOICzUhB1ZBN9AzYNUZWn1K8An9p2TOwu6MJC40MsNi
         GyB2AL4K2AoC42rZiJkhgUlA0jRqW+arEpdDt0R2XhwUklGPNnY0vIzzA17Sg5ckA60C
         nRWiCt1wHq6usJ7/+fdXJKmrB7bcEZjAdyJFs30DBmnnOEYEl8ydvZCE1U7X1UjrBqOL
         jD/uiALGN694Cib/dZ5uOrAF15Gwno9THtuHOCJoYXz6xq9eXrIi2G2Ayyyc53xyztUE
         G4qqGGUa8+2RD4wmvDo6BzEJRDrUJnvS2ZPWQerWlIxyk/VXmsJ5LffH0NFzXq4Tf3QV
         Unrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2o54CAxD5XyQaMV38YJxUljOZZT2lsArgctVLanjbrQ=;
        b=xHmvqVpJwRfdymhP0disy0lMEMw7VsmKajwi+WChT7w3AqjObEiAOMK9nUGj6pgr4o
         21eyGJl3hqC8uCDBLs1xyW7tWgJeSbkKEtArDZ5DGG/TS2BusfhAq1vyB4BFsBx+3LwA
         2KA5Yc28AEpCDu74h4sid6OaeGAs0pmNwDTmQoKYhCFHzH+mgwllO3QE3u321bt8pftE
         kcY80kFx/lfzbjwkw2lUH+pKQn4UsZHecr7fMmJhgRcYT7uc/ObgWazr5uE0ii5vMFz3
         2GMI7WMw3G1Z/jSo+eoWOpUfBvfcxryOeP3gnfbgchDKXyelYPHDtOgz7LVijRmHMAHq
         8dTQ==
X-Gm-Message-State: AOAM533IKRydJ90ghtdisI0etb17MUvzGzIQ/UtICriGPZ1fAmRO8udF
        8gb4Ik9QRfyhqTBfUxTGmolWoKwAZTBnoB+zSf6QEPivO9t024K9R0NnC0SfkNjiJOUGt0+1j7p
        iWLpLG8T3c/X16Hjd76rG6rhTGXJx
X-Received: by 2002:a17:90a:74c2:: with SMTP id p2mr677987pjl.184.1638295916606;
        Tue, 30 Nov 2021 10:11:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxTzjNJlDHlzKO48s3UZ2eyNMNJWf7467tI1qIvFaEzmpDISsTb7ifjy4n2BO8SG4D0VOWb2g==
X-Received: by 2002:a17:90a:74c2:: with SMTP id p2mr677948pjl.184.1638295916342;
        Tue, 30 Nov 2021 10:11:56 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id nv12sm3551679pjb.49.2021.11.30.10.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 10:11:55 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Dominik Brodowski <linux@dominikbrodowski.net>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] pcmcia: rsrc_nonstatic: Fix a NULL pointer dereference in nonstatic_find_mem_region()
Date:   Wed,  1 Dec 2021 02:11:40 +0800
Message-Id: <20211130181142.220254-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In nonstatic_find_mem_region(), pcmcia_make_resource() is assigned to
res and used in pci_bus_alloc_resource(). There a dereference of res
in pci_bus_alloc_resource(), which could lead to a NULL pointer
dereference on failure of pcmcia_make_resource().

Fix this bug by adding a check of res.

This bug was found by a static analyzer. The analysis employs
differential checking to identify inconsistent security operations
(e.g., checks or kfrees) between two code paths and confirms that the
inconsistent operations are not recovered in the current function or
the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

Builds with CONFIG_PCCARD_NONSTATIC=y show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: 49b1153adfe1 ("pcmcia: move all pcmcia_resource_ops providers into one module")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/pcmcia/rsrc_nonstatic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pcmcia/rsrc_nonstatic.c b/drivers/pcmcia/rsrc_nonstatic.c
index 4f5e1a46ebe4..43ae6bd84499 100644
--- a/drivers/pcmcia/rsrc_nonstatic.c
+++ b/drivers/pcmcia/rsrc_nonstatic.c
@@ -812,6 +812,9 @@ static struct resource *nonstatic_find_mem_region(u_long base, u_long num,
 	unsigned long min, max;
 	int ret, i, j;
 
+	if (!res)
+		return NULL;
+
 	low = low || !(s->features & SS_CAP_PAGE_REGS);
 
 	data.mask = align - 1;
-- 
2.25.1

