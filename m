Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451F446C9C3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 01:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242840AbhLHBBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 20:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239086AbhLHBBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 20:01:04 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0031C061746;
        Tue,  7 Dec 2021 16:57:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id ED8DCCE1F42;
        Wed,  8 Dec 2021 00:57:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE118C341C5;
        Wed,  8 Dec 2021 00:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638925050;
        bh=doXw0FYXEv55XwbYN1486+6hyhzPsD7PUsHDWpGZ1no=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ESTxpbjv8+14Eiq3kOAgxzpInZ3e1a0+97xQRcb3YLLeUwa+XCczhp0Wq+ytPr0fm
         E4TOErkwSQOjByTuyBSuJkOQkozjHMpgR5UkG0I16hjyL8p1eSW/7yhzrTa0GQ48BO
         cx4hX1/OVH1xHmg0RBneFVrltGyVegc95ODPD3pyjVIKNYvrXTlq3eBT8Xy18mmZ/h
         p25mtqd3Gq9CaHTC7jjZepRzo2pGv8tLGXvnByXDLIKiZciGegUq7sRCGd2CfD9aca
         KJDLSBdZj6N+NwtmHDakm3X+I3VTHWFSfPHKbHNvz7XHbDXf7TTkFpzgmVfLj1CXD8
         HGNg9GYhvuy+g==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 8/8] MAINTAINERS: add entries for block layer documentation
Date:   Tue,  7 Dec 2021 16:56:40 -0800
Message-Id: <20211208005640.102814-9-ebiggers@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211208005640.102814-1-ebiggers@kernel.org>
References: <20211208005640.102814-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Include Documentation/block/ and Documentation/ABI/stable/sysfs-block in
the "BLOCK LAYER" maintainers file entry.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 360e9aa0205d6..19db69dda15af 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3380,6 +3380,8 @@ M:	Jens Axboe <axboe@kernel.dk>
 L:	linux-block@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
+F:	Documentation/ABI/stable/sysfs-block
+F:	Documentation/block/
 F:	block/
 F:	drivers/block/
 F:	include/linux/blk*
-- 
2.34.1

