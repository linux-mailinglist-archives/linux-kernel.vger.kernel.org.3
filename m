Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F398C48B67F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 20:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350328AbiAKTIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 14:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243166AbiAKTIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:08:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D70C06173F;
        Tue, 11 Jan 2022 11:08:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C492B81D0D;
        Tue, 11 Jan 2022 19:08:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26E3C36AE3;
        Tue, 11 Jan 2022 19:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641928112;
        bh=dy0dLXK/jHyplFwGggXfIGmjaaHPWjJoW2Ch06lbWYo=;
        h=Date:From:To:Cc:Subject:From;
        b=twg7MIxF76JoxIXiMuGHZ3gwJ+FKFAN85pmsEsrcFZssN8URCI0dLZIVUxqvU1KMS
         6099w54d7SSc2+PRtfeO3Zdjkmh3fzCPW4/BVlCUNFlD9XrXbZ+WbwwxGNqGjT4YVp
         9KPmtxxmlk6qxyP0To1wH6SRYcPxnYugQ4hg/MD1F6Iwk7Utz9tgLJv198QYEoCkTW
         J+DJUshJ1EFFG8Cxs2Lludt4AabfyC2O2LfnWG5OBCVnTE9dMOnz8qyvZtCiMcYsbz
         JVpwyilVcX8uLH9v6Vb+aE03wPfTBHbYvJwiotyPm7ceqt1rqM/wZZMi31sPAl1U2h
         SQ9xYf0UKN1Uw==
Date:   Tue, 11 Jan 2022 13:14:56 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [GIT PULL] fallthrough fixes for Clang for 5.17-rc1
Message-ID: <20220111191456.GA11976@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 136057256686de39cc3a07c2e39ef6bc43003ff6:

  Linux 5.16-rc2 (2021-11-21 13:47:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/fallthrough-fixes-clang-5.17-rc1

for you to fetch changes up to ceec16f8fd660c7827e72aec74021f1acc1f7240:

  fbdev: sh7760fb: document fallthrough cases (2021-11-22 18:43:20 -0600)

----------------------------------------------------------------
fallthrough fixes for Clang for 5.17-rc1

Hi Linus,

Please, pull the following patches that fix some fall-through warnings
when building with Clang and -Wimplicit-fallthrough.

Thanks!
--
Gustavo

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      MIPS: mm: tlbex: Fix fall-through warning for Clang

Randy Dunlap (1):
      fbdev: sh7760fb: document fallthrough cases

 arch/mips/mm/tlbex.c           | 1 +
 drivers/video/fbdev/sh7760fb.c | 2 ++
 2 files changed, 3 insertions(+)
