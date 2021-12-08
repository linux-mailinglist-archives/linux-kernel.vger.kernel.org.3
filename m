Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD8046C9BA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 01:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239224AbhLHBBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 20:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238948AbhLHBBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 20:01:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8456BC061746;
        Tue,  7 Dec 2021 16:57:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 493F7B81F07;
        Wed,  8 Dec 2021 00:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7ABC341CD;
        Wed,  8 Dec 2021 00:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638925049;
        bh=T6c3r/MsuZMeHAt1ZBPcbgrbe8ykTaS8eY/bKSrSpMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gIs2sq0lWuK5pCQKn5Njqx8TrbUHG1cMFB/wiG9EzNWqdsSh2M+8Fk9tL3YtSxAv2
         hSMix7rpoFACCMepj5F6spKRC/4UaJCads7LR3VWJtTQqqjTRgsoe9ud5+EAX5ojPV
         pPkyAsqAZrAheS3Rjlw/fo2qr5mTaBDXI+e0cpINtd8Y2emOuxYpODCBthqLT5IB7p
         4UdqnueBe0Rr76tptAcpbrMxuKYk82iQyMR5Q9QnBwFVFWp4hvvYoAptq4Pb1ElHNZ
         9OVfQbLxE8pG4w9y14lOeLeyaHGDbzkwtCAOc5dfeVxVDY79j2z6u1pc3zhe19gOew
         Meptg+q8po89g==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 5/8] docs: sysfs-block: document stable_writes
Date:   Tue,  7 Dec 2021 16:56:37 -0800
Message-Id: <20211208005640.102814-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211208005640.102814-1-ebiggers@kernel.org>
References: <20211208005640.102814-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

/sys/block/<disk>/queue/stable_writes is completely undocumented.
Document it.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/ABI/stable/sysfs-block | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index de3b86a3dfa55..30ce8dc587bb2 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -516,6 +516,16 @@ Description:
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

