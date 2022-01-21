Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2322A496189
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381259AbiAUOs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:48:59 -0500
Received: from ms.lwn.net ([45.79.88.28]:51172 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350999AbiAUOs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:48:59 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9E899739;
        Fri, 21 Jan 2022 14:48:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9E899739
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1642776538; bh=9csn3Zs6jFAFfMGQWC4LX824xwK7SBMTPxIqKSWpvWc=;
        h=From:To:Cc:Subject:Date:From;
        b=EJK+Lq8ceKzmQGESjnXxLbCmPqR2b8qI3rjfNEaDUDuqAuzu+PFA2ZQDvJ7kROmM+
         XeFo60JFZZS23ZcXJ7GICqyLpc1kpY8BHsN1UY6gze4Q6MgwqPSil4jASXD9zvDuwV
         GQOHK02A7V2U/piVu9blTRAoXRzT6KovFkiUR+2wCsqPy5VJXcGMEvtPvSKNBPTKih
         rPpEYmh4gRPfDeLLD3YLXXNKv2uIJ4fUseZzWGjE6TSF85ZxAu20F0mzTfCsHKqZVo
         FKoMEl2NNAQkwLSizj03ZMa8EHq6MYo32p05/gAeVXHHodM+Ysaqa/2cT50HPwwdmb
         Z4dS6ABwXZMhA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [GIT PULL] Documentation fixes
Date:   Fri, 21 Jan 2022 07:49:24 -0700
Message-ID: <87bl05400b.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 87d6576ddf8ac25f36597bc93ca17f6628289c16:

  scripts: sphinx-pre-install: Fix ctex support on Debian (2022-01-07 09:33:13 -0700)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-5.17-2

for you to fetch changes up to b0ac702f3329cdc8a06dcaac73183d4b5a2b942d:

  Documentation: fix firewire.rst ABI file path error (2022-01-20 17:01:32 -0700)

----------------------------------------------------------------
Three small documentation fixes.

----------------------------------------------------------------
Huichun Feng (1):
      docs: ftrace: fix ambiguous sentence

Randy Dunlap (1):
      Documentation: fix firewire.rst ABI file path error

Wang Cheng (1):
      docs: staging/tee.rst: fix two typos found while reading

 Documentation/driver-api/firewire.rst | 4 ++--
 Documentation/staging/tee.rst         | 4 ++--
 Documentation/trace/ftrace.rst        | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)
