Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9954D46A0F8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358377AbhLFQSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380295AbhLFQRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 11:17:23 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACC2C0412A1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 08:06:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 078E6CE16C5
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 16:06:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A1CC341C1;
        Mon,  6 Dec 2021 16:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638806788;
        bh=zOrGEM1rf59ll4s1bJ0l4uWdTBMmiSkh1qpRQF40CTE=;
        h=From:To:Cc:Subject:Date:From;
        b=XdeMg2jqFqbPtsd/oMusZu9/MpKymZLrOgN0imNJPTnHkWrG58C09BQSol0cmdWVK
         J7FwVrMWAlOXeIivR29KNsNzPXsobhpCpWx/K6amSL65X9vXRlLirCeG9FS+pMEJnN
         gZnKznPwGk5kZscl40G0KLmQzyrcBhejP2vlxeKhcncCaVdGCxvkil6DlMuKiEfYRv
         CkDMdFAqTquZPvalx3I5Phkf8qv06TvMOl1mkgBm+AbWXglhZNqmbY2ffuhIHD3jum
         YCaH4j0AlJ5Q5bck9mJnfTvAH48e2h08nvJRSmlZsiSqs/g5rq5e8vDHUPX6/rx79x
         pSqPH11rk1H5w==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v5.16-rc4
Date:   Mon, 06 Dec 2021 16:06:11 +0000
Message-Id: <20211206160627.76A1CC341C1@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7492b724df4d33ca3d5b38b70fb4acb93e6d02bf:

  Merge series "Remove TPS80031 driver" from Dmitry Osipenko <digetx@gmail.com>: (2021-10-23 17:30:21 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.16-rc4

for you to fetch changes up to 6966df483d7b5b218aeb0e13e7e334a8fc3c1744:

  regulator: Update protection IRQ helper docs (2021-11-18 13:57:09 +0000)

----------------------------------------------------------------
regulator: Documentation fix for v5.16

A fix for bitrot in the documentation for protection interrupts that
crept in as the code was revised during review.

----------------------------------------------------------------
Matti Vaittinen (1):
      regulator: Update protection IRQ helper docs

 include/linux/regulator/driver.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)
