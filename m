Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48200464A22
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 09:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348085AbhLAIue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 03:50:34 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:50204 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242092AbhLAIu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 03:50:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E5F55CE1D7B;
        Wed,  1 Dec 2021 08:47:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2E1C53FCE;
        Wed,  1 Dec 2021 08:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638348424;
        bh=3iBw67rqk1Y6LQm3pI9pZmwa16mD4BXKLqFJxIv5or0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V5SvjrbuTiswPPIsEpYa6OV1yffixzbXVGQCX09S+ZDAqaq0eJJH8Szs4JYA+l3Md
         u9wyape6Sov7MRhrX9IN6Mid5o3VkohFapdCjf214EYv2oZosVVZzoqLcKHErTH0dN
         hIWbiQ8x3TvnSecXHFvZerhpZtbPPh84VLUQZmqlVEVFL5TBkjIx4B0ggsdn4y2CeQ
         StCJyCrEo+Hhwde+uhVZSGHZGyTMZsHxvMAecfb0ZQ2axVYZAOJeTGjSpn9n7nPUbZ
         do91ND9gzd7OHUcK03YrpORQll9Qam5psDknHVvQ4jbXxciuhB994c8sB3/0lea4az
         6blH8LdTzW3MQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] docs: sysfs-block: add contact for nomerges
Date:   Wed,  1 Dec 2021 00:45:19 -0800
Message-Id: <20211201084524.25660-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211201084524.25660-1-ebiggers@kernel.org>
References: <20211201084524.25660-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The nomerges file was missing a "Contact" entry.  Use linux-block.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/ABI/testing/sysfs-block | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/testing/sysfs-block
index 9febd53a5ebe8..c70fce6b76c17 100644
--- a/Documentation/ABI/testing/sysfs-block
+++ b/Documentation/ABI/testing/sysfs-block
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

