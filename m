Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E284946DF89
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 01:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241506AbhLIAng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 19:43:36 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:49312 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhLIAne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 19:43:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2F009CE1CB6;
        Thu,  9 Dec 2021 00:40:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 317F7C00446;
        Thu,  9 Dec 2021 00:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639010398;
        bh=Pt84C57Ykdxk1xyB0g68o/uBG/Zu9LdTIDqUUAv0eWo=;
        h=From:To:Cc:Subject:Date:From;
        b=EnYYeDmkqEjch3mmUTpK+1+j34LceVH0yiIe+yeueMHk7Z+3k8lXhlEOMRTUNkZXl
         mskXYnCtiCGHZ8k2XiOdjGcWhfQhdFK4Sh0VETUwyypj6Pd6siqclmJImscJ4CzWPV
         nP7a6ihR/vYaz03/Li6MmiBUe6cZQJAXCDYHtLKc7KxvrI5KIUUs86iR/uBeb0EyDm
         T7iRcceA04cf1V/f1mbP5Ds5s5y6F2Z3WRWgb835UK1QT0MIv6nINOCZ2A8Slyicqc
         x7Os2pgQSHXrWLIEQoGgiishYTwSSCR6iTozBBM5xtSo2jBsVdl20XsWwmj+PSXsDQ
         2Vi+GX1e+lLUA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/8] docs: consolidate sysfs-block into Documentation/ABI/
Date:   Wed,  8 Dec 2021 16:38:25 -0800
Message-Id: <20211209003833.6396-1-ebiggers@kernel.org>
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

Changed v2 => v3:
   - Improved documentation for stable_writes and virt_boundary_mask.
   - Added more Reviewed-by tags.

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

 Documentation/ABI/stable/sysfs-block  | 676 ++++++++++++++++++++++++++
 Documentation/ABI/testing/sysfs-block | 346 -------------
 Documentation/block/index.rst         |   1 -
 Documentation/block/queue-sysfs.rst   | 321 ------------
 MAINTAINERS                           |   2 +
 5 files changed, 678 insertions(+), 668 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-block
 delete mode 100644 Documentation/ABI/testing/sysfs-block
 delete mode 100644 Documentation/block/queue-sysfs.rst

base-commit: 2a7f2f5e3f0a18344b1a5d4ffa9307ffc9cbeee2
-- 
2.34.1

