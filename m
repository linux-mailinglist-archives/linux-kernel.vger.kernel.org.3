Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F811464A28
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 09:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348092AbhLAIuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 03:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242137AbhLAIu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 03:50:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87640C061574;
        Wed,  1 Dec 2021 00:47:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F54BB81E06;
        Wed,  1 Dec 2021 08:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B18DC53FD5;
        Wed,  1 Dec 2021 08:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638348425;
        bh=pNt0any1T6xbnR14aF7tVaNY7DrIst49Ve3IWl95gYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JCc4Lv5B7C8lwzB7VQjxKGBA2riHA1T5Kv6AFbRYiSW0oky5XKVtFT8l/gtbPo2Tj
         19g94+bc+iHTB5fXB5gPPorcrmaFM/HXKOF1PvnvL8NQh8c9NC1rFsF680Lqua/aDz
         e4fA8u+h5uaMsnyeBMIdVKSGKm/Xlj4Rxqtt5PM6UDEoT3xybnAWY1ugaQmts4bSov
         goV7VDnWFD5DH5F/rVqWqUBWfUFLOn3ATUKP8kB9XZFPE5yvun220BNuB6QEiEHmv2
         8eHephIef1bITCKVIp2sS6f+uUmhhp9U85jPWv2J+b2y1TZlB9miUUl4E7kavBC0Dq
         QBAGo+aZxBDPQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] MAINTAINERS: add entries for block layer documentation
Date:   Wed,  1 Dec 2021 00:45:24 -0800
Message-Id: <20211201084524.25660-8-ebiggers@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211201084524.25660-1-ebiggers@kernel.org>
References: <20211201084524.25660-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Include Documentation/block/ and Documentation/ABI/testing/sysfs-block
in the "BLOCK LAYER" maintainers file entry.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 360e9aa0205d6..9f66238ccb991 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3380,6 +3380,8 @@ M:	Jens Axboe <axboe@kernel.dk>
 L:	linux-block@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
+F:	Documentation/ABI/testing/sysfs-block
+F:	Documentation/block/
 F:	block/
 F:	drivers/block/
 F:	include/linux/blk*
-- 
2.34.1

