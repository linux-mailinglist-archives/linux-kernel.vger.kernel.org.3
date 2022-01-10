Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F96B4899F0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbiAJN3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:29:13 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:44738 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbiAJN3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:29:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F00A3CE1278
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 13:29:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88261C36AE5;
        Mon, 10 Jan 2022 13:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641821348;
        bh=dk01OBJA16xn8Pf34KQ7PjQVgOSREGXIjg+38v5Hvak=;
        h=From:To:Cc:Subject:Date:From;
        b=flgglsRtWfpVXH8Xg/1gJFUi8iqtOOya0kNtkOR5atjcHRB4PomozzxA5mSQ4LHUT
         8GnEXsLv0hOqiYH/WHWx2hLJKncgngGLbsY8MsW9jnRx5SWDDOFDufcjsebtrqisAJ
         8w30nqMgsYkckz65qN2lvpiLbzyHJI4+O6A79jD8LliZSVtOijIfUd0padjw6tSzxH
         /rjIN9/r7YTq+eM/tpV/bDfoRmYxZSAY390jZpjLMjdwixBz1U/0ReSL9K5ml5LscD
         YfO/wKFyIjuUwJIVdhyv3zygHzuM4GHyNAfEKHpJ2asfmGeIZVGSV/+/tdg6DBzvjr
         o8DHhNHt3DQVw==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap updates for v5.17
Date:   Mon, 10 Jan 2022 13:28:57 +0000
Message-Id: <20220110132907.88261C36AE5@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.17

for you to fetch changes up to b56a7cbf40c895cbe8b67ce5649a26b7a7bc48be:

  regmap: debugfs: Fix indentation (2022-01-07 19:16:23 +0000)

----------------------------------------------------------------
regmap: Updates for v5.17

A very quiet release for regmap:

 - Allow a custom _update_bits() operation for devices with no bus.
 - Fix an issue with creation of the debugfs directory when attaching a
   device to an existing no device regmap.
 - A trivial formatting fix.

----------------------------------------------------------------
Ansuel Smith (1):
      regmap: allow to define reg_update_bits for no bus configuration

Fabio Estevam (1):
      regmap: Call regmap_debugfs_exit() prior to _init()

Mark Brown (1):
      regmap: debugfs: Fix indentation

 drivers/base/regmap/regmap-debugfs.c | 2 +-
 drivers/base/regmap/regmap.c         | 2 ++
 include/linux/regmap.h               | 7 +++++++
 3 files changed, 10 insertions(+), 1 deletion(-)
