Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94816464A13
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 09:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242111AbhLAIu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 03:50:27 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44270 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235121AbhLAIu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 03:50:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE2E6B81E02;
        Wed,  1 Dec 2021 08:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449CAC53FAD;
        Wed,  1 Dec 2021 08:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638348423;
        bh=012ehVDpupcqXVqvrieCmsqiN89TORbVNPw8GTtmOUg=;
        h=From:To:Cc:Subject:Date:From;
        b=HNwAJEacGoLAMaUxqo6cyRPoUQNzGRnnFX6MOVnpmYk8nsFRWmqWrLq24KJEeHcc6
         moucMp4onNGqRIPpMkwLvGqNyF/lcRfo93B/F++fWvc8KD8V0TZdbHH1dopJOarhSU
         GgpueKSOj9b0BHFHiniZLYr5/JJvumOqMRLjXNztEo4Z7EIqvJA3lBz/R12oEzVi2+
         i1ufZ4KsMeqEK8lNPrpR5wiNubnPNyt0iiDQVVWsOt0GKjCLTVa9k0waF0EfKtfGUY
         hEXmWXxwuOZSL/r1L2nIwGuzmOVWTVboBNfJ6RGIeODVIPhGswqsGCxjONkmAhW7E6
         e/b6kwJq8Pe8A==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] docs: consolidate sysfs-block into Documentation/ABI/
Date:   Wed,  1 Dec 2021 00:45:17 -0800
Message-Id: <20211201084524.25660-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series consolidates the documentation for /sys/block/<disk>/queue/
into Documentation/ABI/, where it is supposed to go (as per Greg KH:
https://lore.kernel.org/r/YaXXpEAwVGTLjp1e@kroah.com).

This series also updates MAINTAINERS to associate the block
documentation with the block layer.

This series applies to linux-block/for-next.

Eric Biggers (7):
  docs: sysfs-block: sort alphabetically
  docs: sysfs-block: add contact for nomerges
  docs: sysfs-block: fill in missing documentation from queue-sysfs.rst
  docs: sysfs-block: document stable_writes
  docs: sysfs-block: document virt_boundary_mask
  docs: block: remove queue-sysfs.rst
  MAINTAINERS: add entries for block layer documentation

 Documentation/ABI/testing/sysfs-block | 766 ++++++++++++++++++--------
 Documentation/block/index.rst         |   1 -
 Documentation/block/queue-sysfs.rst   | 321 -----------
 MAINTAINERS                           |   2 +
 4 files changed, 545 insertions(+), 545 deletions(-)
 delete mode 100644 Documentation/block/queue-sysfs.rst


base-commit: c2626d30f312afc341158e07bf088f5a23b4eeeb
-- 
2.34.1

