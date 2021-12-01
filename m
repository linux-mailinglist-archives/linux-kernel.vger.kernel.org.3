Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C05464A1B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 09:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242123AbhLAIua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 03:50:30 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44290 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbhLAIu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 03:50:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1590FB81E07;
        Wed,  1 Dec 2021 08:47:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99002C53FD1;
        Wed,  1 Dec 2021 08:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638348424;
        bh=k64TpFPHQz2yd1TCCk6k+LzSXvrajv8dqn+wLoGvTS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NlZMurtx0Y4OT+D1/6FflbJLLrpSswsZW2Ek1nbb8Qi0WKVvhrL2ZvWjB1WEHirSp
         LlNMwB3C3oUP6vV3OuntYV3jXJjREWaJbo4h7u90Tl35Uqi8ii1WnLJCcleai1PPum
         zQxYb24pPU59bEY3tV6d5fTB1sKyZZpNWS8m3hRk9OL9tGpJCEMuglD0LXiaUwv4xp
         BzSvE0A2kdEg6CsiQEwi66aF215dh2pgUakRQXVhYtGrMYgM87XMpyfa8OpH1IaYNN
         kTIgSCgKxQkO0+0+QUMqWO4JswzGbMxnY4ke5CP5fSBtJ04yFey+/QJY+H8CYi/XHN
         Wv4cE+qdZRc/A==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] docs: sysfs-block: document stable_writes
Date:   Wed,  1 Dec 2021 00:45:21 -0800
Message-Id: <20211201084524.25660-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211201084524.25660-1-ebiggers@kernel.org>
References: <20211201084524.25660-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

/sys/block/<disk>/queue/stable_writes is completely undocumented.
Document it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/ABI/testing/sysfs-block | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/testing/sysfs-block
index 94711edc6529d..5d8b187e1ec54 100644
--- a/Documentation/ABI/testing/sysfs-block
+++ b/Documentation/ABI/testing/sysfs-block
@@ -515,6 +515,16 @@ Description:
 		scheduler module, if it isn't already present in the system.
 
 
+What:		/sys/block/<disk>/queue/stable_writes
+Date:		September 2020
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RW] If the device requires that memory must not be modified
+		while it is being written out to disk, this file will contain
+		'1'.  Otherwise it will contain '0'.  This file is writable for
+		testing purposes.
+
+
 What:		/sys/block/<disk>/queue/throttle_sample_time
 Date:		March 2017
 Contact:	linux-block@vger.kernel.org
-- 
2.34.1

