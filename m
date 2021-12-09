Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F52746DF9B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 01:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241635AbhLIAnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 19:43:50 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53640 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241500AbhLIAnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 19:43:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D74F6B82284;
        Thu,  9 Dec 2021 00:40:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C23C341C6;
        Thu,  9 Dec 2021 00:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639010401;
        bh=UZR5o//IotWL4AvI7WNqFdHHhYJPi8ZNZjYRMgcahzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ku8xohOzI9YJ4GJ1V9Mtu8ypiJDL6bVV30SBzNt60yAOicLutbwVcY29koDLSSspY
         p7+ddx71zagO0l63Nx/mF35AaR4NQ8r3wWel3xl70Ngc5kRw1/LRQoZjAGtECwzq2P
         GB2g5Plz8zBynkHzC2lcBKHgIX6F3miijbm3N13shuRKEevV4xN9bHIkad7jCJ09i6
         2+4PEZkj6Io9C0PfRx8LgsQm28wwPD+3U9I8Yc93xBJUrAqjOgs9ZoYVimcQm37hBS
         NNC8P/tHjGR1HHiLHwyXf5vSOAYcPxF9IfCwR08OxmeT9YnC8cDaaIEPnVxwNvrrZO
         tro1NdPzLG5Ug==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 8/8] MAINTAINERS: add entries for block layer documentation
Date:   Wed,  8 Dec 2021 16:38:33 -0800
Message-Id: <20211209003833.6396-9-ebiggers@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211209003833.6396-1-ebiggers@kernel.org>
References: <20211209003833.6396-1-ebiggers@kernel.org>
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
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
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

