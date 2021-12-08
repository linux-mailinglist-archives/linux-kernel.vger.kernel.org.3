Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C1446C9AE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 01:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238934AbhLHBBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 20:01:01 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53628 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234815AbhLHBBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 20:01:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66B78B81D80;
        Wed,  8 Dec 2021 00:57:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E735C341C3;
        Wed,  8 Dec 2021 00:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638925047;
        bh=KQADkv9+jE2sqMtcxOjCDaZTkMCKMJbcpcIbmGmt1Oc=;
        h=From:To:Cc:Subject:Date:From;
        b=LE1T4uk0tMwzvOM0v5m3yIETgBqsuuPLtL76KoY3dqBGVKw6J7QOa1e9e8UjtM7Hw
         YUimVagS4QhO2S2qy+sMOv+q8Zqrs675xOk0fVZn+YgnY38qs+V44gMdnbTY5K9u3/
         nlrNJ9yb78/Mpa+XDJCseOw1sTEKETOgTwQksOQsg7dGZYdluGFgqTnyWe3hjqe9oY
         CroKR1646vLPRQpLHhYdgQGu50Vj+F4AbLDTQ8elw7hoVlIa3WNXChxH5crCkU546+
         2Sy3V9DQrVz8FmtaArwE+ozw9M9JZKDMgriv54+Q9d6i17FAj0i9gZA7uLD0n08mOa
         fr1cXRJoh71hQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] docs: consolidate sysfs-block into Documentation/ABI/
Date:   Tue,  7 Dec 2021 16:56:32 -0800
Message-Id: <20211208005640.102814-1-ebiggers@kernel.org>
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

Changed v1 => v2:
   - Added patch which moves the documentation to the stable directory.
   - Added Reviewed-by tags.

Eric Biggers (8):
  docs: sysfs-block: move to stable directory
  docs: sysfs-block: sort alphabetically
  docs: sysfs-block: add contact for nomerges
  docs: sysfs-block: fill in missing documentation from queue-sysfs.rst
  docs: sysfs-block: document stable_writes
  docs: sysfs-block: document virt_boundary_mask
  docs: block: remove queue-sysfs.rst
  MAINTAINERS: add entries for block layer documentation

 Documentation/ABI/stable/sysfs-block  | 668 ++++++++++++++++++++++++++
 Documentation/ABI/testing/sysfs-block | 346 -------------
 Documentation/block/index.rst         |   1 -
 Documentation/block/queue-sysfs.rst   | 321 -------------
 MAINTAINERS                           |   2 +
 5 files changed, 670 insertions(+), 668 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-block
 delete mode 100644 Documentation/ABI/testing/sysfs-block
 delete mode 100644 Documentation/block/queue-sysfs.rst


base-commit: cb3b5daece093c8d921e4e8736c5d7eff1eeb98b
-- 
2.34.1

