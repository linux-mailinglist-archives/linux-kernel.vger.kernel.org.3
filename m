Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6382246DF9F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 01:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241580AbhLIAn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 19:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241365AbhLIAne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 19:43:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4720CC061746;
        Wed,  8 Dec 2021 16:40:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03283B82284;
        Thu,  9 Dec 2021 00:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641C9C341C7;
        Thu,  9 Dec 2021 00:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639010399;
        bh=JSsIsPMDLa6QoQk3ochxR7oNxZfnhw6OWqS5mt7MjrY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jDWMVgPqDEyn2MUW0Awss8wH2IEx8ENZJdHBysL4AqbHNx3KzB0OslhiVEvTT0KSd
         8C70ajc9AbJgzGONqb02BQFwDx3KvxodPX7i8h7AEgCke3Zg7oHpTFbDQX2YxyJAHr
         n8K3yqCnGrRvR31c3dxyxNneTQzxZxJbOC/uNVu0seqaE+xb+S9vBEISy7U9EfWyFb
         gPZmIAccDI2XUeTWl0vSC/CBCrMxucgswBThJjVLEorrhw69UrujvYgCfgEXbdjcSx
         TPxNvk1VXaBMyFWdzH7bb/v14ctEUe6W0rPRtTtnkqSNxbkNxRcDnB0ge2/HeFtExN
         0T4me1orcc1XQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 3/8] docs: sysfs-block: add contact for nomerges
Date:   Wed,  8 Dec 2021 16:38:28 -0800
Message-Id: <20211209003833.6396-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211209003833.6396-1-ebiggers@kernel.org>
References: <20211209003833.6396-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The nomerges file was missing a "Contact" entry.  Use linux-block.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/ABI/stable/sysfs-block | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 9febd53a5ebe8..c70fce6b76c17 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -242,7 +242,7 @@ Description:
 
 What:		/sys/block/<disk>/queue/nomerges
 Date:		January 2010
-Contact:
+Contact:	linux-block@vger.kernel.org
 Description:
 		Standard I/O elevator operations include attempts to
 		merge contiguous I/Os. For known random I/O loads these
-- 
2.34.1

