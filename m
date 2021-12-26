Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D1747F4EB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 03:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhLZCYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 21:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhLZCYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 21:24:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6945AC061401;
        Sat, 25 Dec 2021 18:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=qnMX8qfGbegNg14xNs1sPIKfUUN56fIYJid23oyCc+s=; b=KmRrgkwz2yJzSOdw1nzYfpWo2S
        iqSROS3f/uusw9vG+35BKYk+8WvKYU6JPUfWT0kOwvTIh/gKPsITmKM/gd8WXsnqYYWtsjDxztUzv
        HvHtZZr80NiuVUlJxSW+AgBYDI3pzqqi1BLKTclh5hTMlSzrUakObrm0rBC8HJsrgdPvBM4rZ9URg
        Eu/tEBFqSFLPee3xkvcBt9sjxANZo/NSQwV9L5PLuRwfVTyIPr9QFECJTRqyJ+u3rS8oj8fgFJDI0
        Z8eHgeu6y/OhPQCIy/FmR3fTQ2XJs0jVz3Xg/Y2KkaXZXXDX6SrstBaa2C5uajs4r9IaCpp2J1OcY
        6I/Hxpdg==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n1JCm-00FE8M-4f; Sun, 26 Dec 2021 02:24:12 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org
Subject: [PATCH] md: fix spelling of "its"
Date:   Sat, 25 Dec 2021 18:24:11 -0800
Message-Id: <20211226022411.22437-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the possessive "its" instead of the contraction "it's"
in printed messages.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Song Liu <song@kernel.org>
Cc: linux-raid@vger.kernel.org
---
 drivers/md/md-cluster.c |    2 +-
 drivers/md/md.c         |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20211224.orig/drivers/md/md.c
+++ linux-next-20211224/drivers/md/md.c
@@ -8402,7 +8402,7 @@ int md_setup_cluster(struct mddev *mddev
 	spin_lock(&pers_lock);
 	/* ensure module won't be unloaded */
 	if (!md_cluster_ops || !try_module_get(md_cluster_mod)) {
-		pr_warn("can't find md-cluster module or get it's reference.\n");
+		pr_warn("can't find md-cluster module or get its reference.\n");
 		spin_unlock(&pers_lock);
 		return -ENOENT;
 	}
--- linux-next-20211224.orig/drivers/md/md-cluster.c
+++ linux-next-20211224/drivers/md/md-cluster.c
@@ -574,7 +574,7 @@ static int process_recvd_msg(struct mdde
 	int ret = 0;
 
 	if (WARN(mddev->cluster_info->slot_number - 1 == le32_to_cpu(msg->slot),
-		"node %d received it's own msg\n", le32_to_cpu(msg->slot)))
+		"node %d received its own msg\n", le32_to_cpu(msg->slot)))
 		return -1;
 	switch (le32_to_cpu(msg->type)) {
 	case METADATA_UPDATED:
