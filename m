Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34575B1CAA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbiIHMVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiIHMVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:21:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A441511C14D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 05:21:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82CBF61CD7
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 12:21:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93570C433C1;
        Thu,  8 Sep 2022 12:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662639678;
        bh=ta0R/1zAhxfsBz0h0xvErcAQgXEKY1W5B/bPXLt1pgk=;
        h=From:To:Cc:Subject:Date:From;
        b=MBJQ7XnRfxeevd8jB60VScgtpTJyweRjGYdhAGm8NWNd6CXfsmn4KT/DbsbPRBFtd
         t5tf3cgWAd7Etcf/vuBHxpF6SZuDRYM2HbtRY9almo5bf/ALh/sDH/TwlSnfcinWII
         HJW/INropBuYP3GXq0fwYvDWJm/h2TaVKGLsSLL2yx/KBIxVqvwTMhrJKkQ2lMDYdv
         F3ht8jmm+WK6AJs56jJZjuKJVi1bJZ6xyPmehcz2r2I43QxOALQYXGlUOjZX+hqLrm
         JKRU9BsC3fVi7ed9IN2y6LciuxinYgHsd6wRFCiSu0nSagkmzXVEg0dXd1rZcIz6IC
         MTWuO1BlG3bUg==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v6.0-rc4
Date:   Thu, 08 Sep 2022 13:21:06 +0100
Message-Id: <20220908122117.93570C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.0-rc4

for you to fetch changes up to 475043fabe8c58fb18c32c7942d8754897bd11fa:

  regulator: Fix qcom,spmi-regulator schema (2022-08-31 12:13:17 +0100)

----------------------------------------------------------------
regulator: Fixes for v6.0

One core fix here improving the error handling on enable failure, plus
smaller fixes for the pfuze100 drive and the SPMI DT bindings.

----------------------------------------------------------------
Andrew Halaney (1):
      regulator: core: Clean up on enable failure

Jean-Philippe Brucker (1):
      regulator: Fix qcom,spmi-regulator schema

Xiaolei Wang (1):
      regulator: pfuze100: Fix the global-out-of-bounds access in pfuze100_regulator_probe()

 .../devicetree/bindings/regulator/qcom,spmi-regulator.yaml       | 3 +--
 drivers/regulator/core.c                                         | 9 +++++++--
 drivers/regulator/pfuze100-regulator.c                           | 2 +-
 3 files changed, 9 insertions(+), 5 deletions(-)
