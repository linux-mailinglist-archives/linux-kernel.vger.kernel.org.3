Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C34A46C9BC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 01:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239304AbhLHBBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 20:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238972AbhLHBBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 20:01:03 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0076C061574;
        Tue,  7 Dec 2021 16:57:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2BA3CCE1F59;
        Wed,  8 Dec 2021 00:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2869DC341CB;
        Wed,  8 Dec 2021 00:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638925048;
        bh=GFrSBsqaPnbevknnfrehYOVxZM1KY9cMbSCnL8jEkEI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JGznqfYoZbVvxb189PSrecMxHHbNSxPojUOWsRGvDsdShQ+PxTplxa5XLGPqy3a/q
         JapPa2LeuGgNVVPIUVmdHTZmr1M6C9EvKFVYRloKaxqGEoQcvlwhs+6UkT5fJakgiw
         bvxAchZZt8gCpQAoIZPgQJuc9cJNZ15S+YUOwyFRtnjLTSoapue+G/N6PmEUPBNFyw
         TgYwG6BmUdMbSLkp+u3vTIL9UEf4CEzvEmODxsjaMfcS1RR3QKDcoKW6oQkm7udnW4
         PKoSXw2Vlso5mKknViwpyiPBb35L142jkc/3ah1uCY4oRvyir/RIVidKCMF/c3JvDS
         1QtjBjQcZm/0Q==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 3/8] docs: sysfs-block: add contact for nomerges
Date:   Tue,  7 Dec 2021 16:56:35 -0800
Message-Id: <20211208005640.102814-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211208005640.102814-1-ebiggers@kernel.org>
References: <20211208005640.102814-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The nomerges file was missing a "Contact" entry.  Use linux-block.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
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

