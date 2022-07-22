Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4BF57DF11
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbiGVJox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 05:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiGVJo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:44:28 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E97BB8C5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:38:50 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31e63e48e49so35224497b3.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EdBwhDB1kTfOuaZ44XnXqAFiApYJfH6lT/hr3SDnJ/w=;
        b=gPVLoOuKJt62FkkLy8/2yUn70N9cMwMg0NqDjsY+Frsa95mUBpYG68nMSa0FlEBDLd
         iXKK/rDCH1qzi2geeyk73a+raqj9Q36BvBNH5xp9fCWSLHVCibioJcnlTZYIVxMxzXqq
         IeqUfW1fM+/ypF6f2quRJdn2sMscnROePSbn/Fy0lzhzJP/D2nE0ElTYzDXvx8W71FHg
         qCLcQ+YcJODw5bXSHcaC8KO0Yb8EsrlZpxc89qJizbABdwf05Qd39DbF6ASL7fb34Dxb
         n85N1RtO5VzPNQE/OrW1DFOTJPNg0KS8BiKXbnmtiM65ENnrtSb4791mDMmlMYgRYXMP
         0jXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EdBwhDB1kTfOuaZ44XnXqAFiApYJfH6lT/hr3SDnJ/w=;
        b=oYeW67a46D0pHcMMhLs2OuvKkq4PponEFp7PFog5rSdExKGzCD5aRALSoDRSAypyxn
         JVIVXHLFgXbeP7RqiiHFAA9onGtnwzBHvUpKUHuqs0fSxL3r58T5ufEb5Pb4YNPvLu1A
         DCZO54PFDo6lAYc8m96/GozlSVjf1aadAT8cxqmK9eMS15BqNpNoSX6QUAOlnCjTAYPc
         5h8HC4s2oqcnOQqN85yynpwJHEmeE2iLJ85CrurKLuu3iYNwXQz+oHFdqoY3jHfvsHLY
         rd7L7hEHcs9shko2amzm7YedbgbmGvOaqpYZg8SqCCG/8H0AcIwOzFDhV0WZ1L5114fj
         Nqug==
X-Gm-Message-State: AJIora9BM8xzmdkISKfbqCIVfz/iA1jm6raTA6YtumhxMSnAP5qaPOBj
        hY7JDDNaC2uZe6/l/P4byt2YTlP6I64afEMj7NDmNTZ+bDahwAl/bcJyUHIQSjB4rsmOTeq7b7q
        Fe7fJBq/vbASs6t79CXwjmKK5dsXLgE6F4Lv4DrkkJ5QmxywiHo3z1mZkBeDxC5VU9Qo=
X-Google-Smtp-Source: AGRyM1v/0YsN7N1ZDNPpQQjFr5qD9ZaFHhp2KlBQW9DYS5Wzckg6JL2WrqE3KHHwbiqK6mFr34QSFCzL7g==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a25:71d7:0:b0:670:403b:a74f with SMTP id
 m206-20020a2571d7000000b00670403ba74fmr2198395ybc.239.1658482729838; Fri, 22
 Jul 2022 02:38:49 -0700 (PDT)
Date:   Fri, 22 Jul 2022 09:38:21 +0000
In-Reply-To: <20220722093823.4158756-1-nhuck@google.com>
Message-Id: <20220722093823.4158756-2-nhuck@google.com>
Mime-Version: 1.0
References: <20220722093823.4158756-1-nhuck@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH 1/3] dm-bufio: Add flags for dm_bufio_client_create
From:   Nathan Huckleberry <nhuck@google.com>
To:     linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nathan Huckleberry <nhuck@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a flags argument to dm_bufio_client_create and update all the
callers.  This is in preparation to add the DM_BUFIO_GET_CANT_SLEEP
flag.

Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 drivers/md/dm-bufio.c                         | 3 ++-
 drivers/md/dm-ebs-target.c                    | 3 ++-
 drivers/md/dm-integrity.c                     | 2 +-
 drivers/md/dm-snap-persistent.c               | 2 +-
 drivers/md/dm-verity-fec.c                    | 4 ++--
 drivers/md/dm-verity-target.c                 | 2 +-
 drivers/md/persistent-data/dm-block-manager.c | 3 ++-
 include/linux/dm-bufio.h                      | 3 ++-
 8 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index 5ffa1dcf84cf..ad5603eb12e3 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -1717,7 +1717,8 @@ static unsigned long dm_bufio_shrink_count(struct shrinker *shrink, struct shrin
 struct dm_bufio_client *dm_bufio_client_create(struct block_device *bdev, unsigned block_size,
 					       unsigned reserved_buffers, unsigned aux_size,
 					       void (*alloc_callback)(struct dm_buffer *),
-					       void (*write_callback)(struct dm_buffer *))
+					       void (*write_callback)(struct dm_buffer *),
+					       unsigned int flags)
 {
 	int r;
 	struct dm_bufio_client *c;
diff --git a/drivers/md/dm-ebs-target.c b/drivers/md/dm-ebs-target.c
index 0221fa63f888..c90f9b9b1f02 100644
--- a/drivers/md/dm-ebs-target.c
+++ b/drivers/md/dm-ebs-target.c
@@ -312,7 +312,8 @@ static int ebs_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 		goto bad;
 	}
 
-	ec->bufio = dm_bufio_client_create(ec->dev->bdev, to_bytes(ec->u_bs), 1, 0, NULL, NULL);
+	ec->bufio = dm_bufio_client_create(ec->dev->bdev, to_bytes(ec->u_bs), 1,
+		0, NULL, NULL, 0);
 	if (IS_ERR(ec->bufio)) {
 		ti->error = "Cannot create dm bufio client";
 		r = PTR_ERR(ec->bufio);
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 3d5a0ce123c9..a508073d8414 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -4439,7 +4439,7 @@ static int dm_integrity_ctr(struct dm_target *ti, unsigned argc, char **argv)
 	}
 
 	ic->bufio = dm_bufio_client_create(ic->meta_dev ? ic->meta_dev->bdev : ic->dev->bdev,
-			1U << (SECTOR_SHIFT + ic->log2_buffer_sectors), 1, 0, NULL, NULL);
+			1U << (SECTOR_SHIFT + ic->log2_buffer_sectors), 1, 0, NULL, NULL, 0);
 	if (IS_ERR(ic->bufio)) {
 		r = PTR_ERR(ic->bufio);
 		ti->error = "Cannot initialize dm-bufio";
diff --git a/drivers/md/dm-snap-persistent.c b/drivers/md/dm-snap-persistent.c
index 3bb5cff5d6fc..aaa699749c3b 100644
--- a/drivers/md/dm-snap-persistent.c
+++ b/drivers/md/dm-snap-persistent.c
@@ -494,7 +494,7 @@ static int read_exceptions(struct pstore *ps,
 
 	client = dm_bufio_client_create(dm_snap_cow(ps->store->snap)->bdev,
 					ps->store->chunk_size << SECTOR_SHIFT,
-					1, 0, NULL, NULL);
+					1, 0, NULL, NULL, 0);
 
 	if (IS_ERR(client))
 		return PTR_ERR(client);
diff --git a/drivers/md/dm-verity-fec.c b/drivers/md/dm-verity-fec.c
index cea2b3789736..23cffce56403 100644
--- a/drivers/md/dm-verity-fec.c
+++ b/drivers/md/dm-verity-fec.c
@@ -749,7 +749,7 @@ int verity_fec_ctr(struct dm_verity *v)
 
 	f->bufio = dm_bufio_client_create(f->dev->bdev,
 					  f->io_size,
-					  1, 0, NULL, NULL);
+					  1, 0, NULL, NULL, 0);
 	if (IS_ERR(f->bufio)) {
 		ti->error = "Cannot initialize FEC bufio client";
 		return PTR_ERR(f->bufio);
@@ -765,7 +765,7 @@ int verity_fec_ctr(struct dm_verity *v)
 
 	f->data_bufio = dm_bufio_client_create(v->data_dev->bdev,
 					       1 << v->data_dev_block_bits,
-					       1, 0, NULL, NULL);
+					       1, 0, NULL, NULL, 0);
 	if (IS_ERR(f->data_bufio)) {
 		ti->error = "Cannot initialize FEC data bufio client";
 		return PTR_ERR(f->data_bufio);
diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index d6dbd47492a8..5d3fc58a3c34 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -1266,7 +1266,7 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
 
 	v->bufio = dm_bufio_client_create(v->hash_dev->bdev,
 		1 << v->hash_dev_block_bits, 1, sizeof(struct buffer_aux),
-		dm_bufio_alloc_callback, NULL);
+		dm_bufio_alloc_callback, NULL, 0);
 	if (IS_ERR(v->bufio)) {
 		ti->error = "Cannot initialize dm-bufio";
 		r = PTR_ERR(v->bufio);
diff --git a/drivers/md/persistent-data/dm-block-manager.c b/drivers/md/persistent-data/dm-block-manager.c
index 54c089a50b15..11935864f50f 100644
--- a/drivers/md/persistent-data/dm-block-manager.c
+++ b/drivers/md/persistent-data/dm-block-manager.c
@@ -391,7 +391,8 @@ struct dm_block_manager *dm_block_manager_create(struct block_device *bdev,
 	bm->bufio = dm_bufio_client_create(bdev, block_size, max_held_per_thread,
 					   sizeof(struct buffer_aux),
 					   dm_block_manager_alloc_callback,
-					   dm_block_manager_write_callback);
+					   dm_block_manager_write_callback,
+					   0);
 	if (IS_ERR(bm->bufio)) {
 		r = PTR_ERR(bm->bufio);
 		kfree(bm);
diff --git a/include/linux/dm-bufio.h b/include/linux/dm-bufio.h
index 90bd558a17f5..e21480715255 100644
--- a/include/linux/dm-bufio.h
+++ b/include/linux/dm-bufio.h
@@ -24,7 +24,8 @@ struct dm_bufio_client *
 dm_bufio_client_create(struct block_device *bdev, unsigned block_size,
 		       unsigned reserved_buffers, unsigned aux_size,
 		       void (*alloc_callback)(struct dm_buffer *),
-		       void (*write_callback)(struct dm_buffer *));
+		       void (*write_callback)(struct dm_buffer *),
+		       unsigned int flags);
 
 /*
  * Release a buffered IO cache.
-- 
2.37.1.359.gd136c6c3e2-goog

