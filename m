Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8919498528
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241189AbiAXQrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:47:13 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:50364 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243424AbiAXQrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:47:11 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 4JjG9W0bTyz9vjCF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 16:47:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kxoXPmLz9dK2 for <linux-kernel@vger.kernel.org>;
        Mon, 24 Jan 2022 10:47:10 -0600 (CST)
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 4JjG9V5bz2z9vjCS
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 10:47:10 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 4JjG9V5bz2z9vjCS
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 4JjG9V5bz2z9vjCS
Received: by mail-pj1-f72.google.com with SMTP id ay18-20020a17090b031200b001b53c85761aso7412005pjb.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 08:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i98tmVoJeC0eQ+zcA+l102zpTFZNjsWcE56+L4IvPRA=;
        b=fmEmp2AnDhlqnBVhNNKp9HUrLlvl1EbxSJADCJj75bll08ktE0omUjKSWchdDP4xEh
         NN2ik9BpXLqOliky5cWJYNkbQ+MdJmOS/xplHosHCbNynThNZ9NMguspHPm7fakUOZjD
         bNw9idxBOnFpRxGVJKi3ItlCd7FioMDaWjBR8srPVEgywtJhclcx9bn/aspHKqyX+lTG
         KLyjvWqpeqieQoMzJJOZxNEyXNOru0nADVQlQbWb7PARam/+GswW/YKpmMihSWfPlmk1
         NiRa8Vnaqqh+7ZG0sNwA/oiv0sTdycNkVNqGAlqjp87Zp5ovqcnuurw4/OnJi8vrkGY4
         4/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i98tmVoJeC0eQ+zcA+l102zpTFZNjsWcE56+L4IvPRA=;
        b=45XUsfrFh531ZbIBKZV9akNVX2t+UjIe2ZrJ5IOeZMnVJ2VQHOnCQTAV3B9dUFVPmK
         cZ4aryzB2ulU92xthnXTEMyUcAFdzbBz61UoB97t00s9L1eA9IdlwBVeKbqTnLKTkvNJ
         IUDboXMQ7H3UOGWUjDmhXo3Bt8t4q8RvTfS9egsD6SO2Q0U1Ft8Yh9oZ1iFB93LXCgPG
         SCmIdynXbbykKzhMwLYfI+yqfevKQA2CWBztEfIJi3PmJ+FCIQhC5amMQzuD15H7m3PA
         EgmjdzoCGbpAUqLhsJAyh99/ETSj9OhvPVgy2K8/OQfaHdPaAqLxMn+CQkcngTotygUU
         lt4w==
X-Gm-Message-State: AOAM532o3H1LQWqmo3hsAh4hgL/dhgJBLt1hqLKxgRohVM6my3O1xeKc
        5L0m4nGNwpu8pVwWxOEdhN8dri9nlwME9orya59f78xa+UdZn1pi8MNTH9rV+lKcf2/pmBQJwJ+
        DDjPIrwofJu5t6HB1kT/nrRphS/j6
X-Received: by 2002:a63:f1a:: with SMTP id e26mr12360923pgl.590.1643042829967;
        Mon, 24 Jan 2022 08:47:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwVq1C+Exiwxl9jXMBaOLgynVMpFUBZOce4a/NW+k1SaZHArswlEPpljjEMZV5gHQIkBg5/dA==
X-Received: by 2002:a63:f1a:: with SMTP id e26mr12360906pgl.590.1643042829728;
        Mon, 24 Jan 2022 08:47:09 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.4.61.248])
        by smtp.gmail.com with ESMTPSA id y8sm12833578pgs.31.2022.01.24.08.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 08:47:09 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Coly Li <colyli@suse.de>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bcache: Fix a NULL or wild pointer dereference in btree_gc_rewrite_node()
Date:   Tue, 25 Jan 2022 00:47:01 +0800
Message-Id: <20220124164701.53525-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In btree_gc_rewrite_node(), btree_node_alloc_replacement() is assigned to
n and return error code or NULL on failure. n is passed to
bch_btree_node_write_sync() and there is a dereference of it in
bch_btree_node_write_sync() without checks, which may lead to wild
pointer dereference or NULL pointer dereference depending on n.

Fix this bug by adding IS_ERR_OR_NULL check of n.

This bug was found by a static analyzer.

Builds with 'make allyesconfig' show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: ("bcache: Rework btree cache reserve handling")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
The analysis employs differential checking to identify inconsistent 
security operations (e.g., checks or kfrees) between two code paths 
and confirms that the inconsistent operations are not recovered in the
current function or the callers, so they constitute bugs. 

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

 drivers/md/bcache/btree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 88c573eeb598..06d42292e86c 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -1504,6 +1504,8 @@ static int btree_gc_rewrite_node(struct btree *b, struct btree_op *op,
 		return 0;
 
 	n = btree_node_alloc_replacement(replace, NULL);
+	if (IS_ERR_OR_NULL(n))
+		return 0;
 
 	/* recheck reserve after allocating replacement node */
 	if (btree_check_reserve(b, NULL)) {
-- 
2.25.1

