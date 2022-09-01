Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9AA5A99B7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbiIAOHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiIAOHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:07:35 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C707140B8
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 07:07:30 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id D31BB5C01A9;
        Thu,  1 Sep 2022 10:07:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 01 Sep 2022 10:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1662041249; x=1662127649; bh=ZH
        1W9SzAvh365K3LsTeS4Fe2O1mpetLxMk2nvupx0cI=; b=ReDzDKUSFmoBHeUVs5
        oy45ls0RS0FkKtQVRQ22Y6d5x1CM4rs6/B6MDtVWrmOYi82xBdNe3m70AzcyTzTD
        aOVcIqAwZiniIXiXJ8mPz52kHTM7oARoAvGYynD5q3cJp0rGIfgZ1tL7HZarG9Xi
        vPTw1nxU3ZeXC3xrWiPX7IlBdzfa5J0PieioNGE2lInlvyZVok5mY7nsLqoHja+a
        Wt3u6RqbhrQjYPe5Xw1FbpG+OdHZVEBQz4ZBNMLF2TPkaIxdP8rRQI2I48pOzrQm
        /hvsYAN/CdaOb9QVSmutWlCieENoKNoEwbf257EpsRIN+IBGg5tkLhI+u9fW99o2
        eW5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1662041249; x=1662127649; bh=ZH1W9SzAvh365
        K3LsTeS4Fe2O1mpetLxMk2nvupx0cI=; b=RUn40TsnsjcJduv2QkpQqzCwQIvJZ
        A8qDnomtL1c6VNXXnst17TqLiCNW52UlPz+7ogsfQGSqSRJHhu/x59iWP38QXkca
        N/e91jC+VmDVePN9KUraDDRHxccBM6HOrxeBg+o/inIndkOyXTR26dotdUOXFD3c
        mR1a6Fu3We/Aw6n5KBJGdDchV5GnLGtdKKRWBY5VOQM65tJ7A5YAG3hJ04igcMYu
        JI2QzwsSZf3e/VgW1hDbFEc+uOx68PvEOFMQitRnURhbcqjvYJCC9IKl90WyuqF2
        Sy67fC1sc07WyUbFlmllVyR+OsjA0H0TGGFKIoZ3c9//0IJgo7FlOsLAg==
X-ME-Sender: <xms:oLwQY6zWV5cbVyhBknSFjfYzJ26o90uYKatJsqA_NwygcTsoGOWIMw>
    <xme:oLwQY2QLy7E8sBZFEAybNfHH4uFYuI06vAc2ABpKdndEOsDFk5q9AMQdQ1YwocdMb
    sO2vOkeka7Qnw45zqU>
X-ME-Received: <xmr:oLwQY8UJQE-FyXnilAd6t5VezOj-TlxSjXEtdOIeIM6T0d7qtRKu-gqZxuvS8iat26rieWIl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdekkedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepvdegffehledvleejvdethffgieefveevhfeigefffffgheeguedtieek
    tdeigeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:oLwQYwiTimP6_gPdve45MuKXavDLWc8aRJyOYzRKSmByUKmFu66qew>
    <xmx:oLwQY8COvZlwAuxafeK_H_o9qjFDwHz-uAfvf1EaOPWUnEfIOagDLQ>
    <xmx:oLwQYxLk3F2GFMsqu4IZXBXzLZNor1rGh2DYajlvlAF5FmjNEbex3Q>
    <xmx:obwQY_9dTEbqhKnOrk2YgR2x808l0HdqrLCuUWZIY2d0fFhBEW6dGw>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Sep 2022 10:07:27 -0400 (EDT)
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Eric Biederman <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        Tycho Andersen <tycho@tycho.pizza>,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: [PATCH] fuse: In fuse_flush only wait if someone wants the return code
Date:   Thu,  1 Sep 2022 08:06:47 -0600
Message-Id: <20220901140647.1125079-1-tycho@tycho.pizza>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <YvpRLJ79GRWYjLdf@tycho.pizza>
References: <YvpRLJ79GRWYjLdf@tycho.pizza>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

In my very light testing this resolves a hang where a thread of the
fuse server was accessing the fuse filesystem (the fuse server is
serving up), when the fuse server is killed.

The practical problem is that the fuse server file descriptor was
being closed after the file descriptor into the fuse filesystem so
that the fuse filesystem operations were being blocked for instead of
being aborted.  Simply skipping the unnecessary wait resolves this
issue.

This is just a proof of concept and someone should look to see if the
fuse max_background limit could cause a problem with this approach.

Additionally testing PF_EXITING is a very crude way to tell if someone
wants the return code from the vfs flush operation.  As such in the
long run it probably makes sense to get some direct vfs support for
knowing if flush needs to block until all of the flushing is complete
and a status/return code can be returned.

Unless I have missed something this is a generic optimization that can
apply to many network filesystems.

Al, vfs folks? (igrab/iput sorted so as not to be distractions).

Perhaps a .flush_async method without a return code and a
filp_close_async function without a return code to take advantage of
this in the general sense.

Waiting potentially indefinitely for user space in do_exit seems like a
bad idea.  Especially when all that the wait is for is to get a return
code that will never be examined.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
[tycho: small fixups for releasing fuse file + nocred flag]
Signed-off-by: Tycho Andersen <tycho@tycho.pizza>
Reported-by: Tycho Andersen <tycho@tycho.pizza>
Tested-by: "Serge E. Hallyn" <serge@hallyn.com>
---
 fs/fuse/file.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 05caa2b9272e..da45fb2dd740 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -464,6 +464,67 @@ static void fuse_sync_writes(struct inode *inode)
 	fuse_release_nowrite(inode);
 }
 
+struct fuse_flush_args {
+	struct fuse_args args;
+	struct fuse_flush_in inarg;
+	struct inode *inode;
+	struct fuse_file *ff;
+};
+
+static void fuse_flush_end(struct fuse_mount *fm, struct fuse_args *args, int err)
+{
+	struct fuse_flush_args *fa = container_of(args, typeof(*fa), args);
+
+	if (err == -ENOSYS) {
+		fm->fc->no_flush = 1;
+		err = 0;
+	}
+
+	/*
+	 * In memory i_blocks is not maintained by fuse, if writeback cache is
+	 * enabled, i_blocks from cached attr may not be accurate.
+	 */
+	if (!err && fm->fc->writeback_cache)
+		fuse_invalidate_attr_mask(fa->inode, STATX_BLOCKS);
+
+
+	iput(fa->inode);
+	fuse_file_put(fa->ff, false, false);
+	kfree(fa);
+}
+
+static int fuse_flush_async(struct file *file, fl_owner_t id)
+{
+	struct inode *inode = file_inode(file);
+	struct fuse_mount *fm = get_fuse_mount(inode);
+	struct fuse_file *ff = file->private_data;
+	struct fuse_flush_args *fa;
+	int err;
+
+	fa = kzalloc(sizeof(*fa), GFP_KERNEL);
+	if (!fa)
+		return -ENOMEM;
+
+	fa->inarg.fh = ff->fh;
+	fa->inarg.lock_owner = fuse_lock_owner_id(fm->fc, id);
+	fa->args.opcode = FUSE_FLUSH;
+	fa->args.nodeid = get_node_id(inode);
+	fa->args.in_numargs = 1;
+	fa->args.in_args[0].size = sizeof(fa->inarg);
+	fa->args.in_args[0].value = &fa->inarg;
+	fa->args.force = true;
+	fa->args.nocreds = true;
+	fa->args.end = fuse_flush_end;
+	fa->inode = igrab(inode);
+	fa->ff = fuse_file_get(ff);
+
+	err = fuse_simple_background(fm, &fa->args, GFP_KERNEL);
+	if (err)
+		fuse_flush_end(fm, &fa->args, err);
+
+	return err;
+}
+
 static int fuse_flush(struct file *file, fl_owner_t id)
 {
 	struct inode *inode = file_inode(file);
@@ -495,6 +556,9 @@ static int fuse_flush(struct file *file, fl_owner_t id)
 	if (fm->fc->no_flush)
 		goto inval_attr_out;
 
+	if (current->flags & PF_EXITING)
+		return fuse_flush_async(file, id);
+
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.fh = ff->fh;
 	inarg.lock_owner = fuse_lock_owner_id(fm->fc, id);

base-commit: 3d7cb6b04c3f3115719235cc6866b10326de34cd
-- 
2.34.1

