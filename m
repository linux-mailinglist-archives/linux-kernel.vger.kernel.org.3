Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AB04F98BC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237243AbiDHO7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 10:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234894AbiDHO7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:59:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC07E116B58
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 07:56:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 617FC61DAD
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 14:56:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A774C385A1;
        Fri,  8 Apr 2022 14:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649429816;
        bh=4dtkFE7DVojKCW9V0wSKn9hPjn6qHArtBjFqFArK9l4=;
        h=From:To:Cc:Subject:Date:From;
        b=jpHR26KhCRtslnq+IT3+Qj2wU1XWTwBNQyJw+WUwvL92uwp8nD0wpUDvtoZljSYp9
         XbYaBt/vO2NicYOUfIxBQjCfBLfCmE1KP+6HGlDyKDGlYXjQK/xvVgc+GWseVh9vtm
         uzeaPa1XRymTZ/E0Q0qzMivlcSi96Xm8SCzng7onk3iaIDEJLKK3el3Jr4v9OWAcD9
         1om7ax+xDxP4Mlb6PEJbuTorOgfy6L2ZCcw/XYUfPW9RqNKYUld0KlQnF6cCbh5VIH
         g9e1yaevgoTCHCcCJLu06GPFeB+WkL2a56XVdUiZ5VXc2aqJF+6R1b8XNxHhSPTsOF
         zlYEtkwT12VIQ==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v5.18-rc1
Date:   Fri, 08 Apr 2022 15:56:49 +0100
Message-Id: <20220408145656.4A774C385A1@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.18-rc1

for you to fetch changes up to 908b768f9a8ffca2ef69f3145e23a6a259f99ac3:

  MAINTAINERS: Fix reviewer info for a few ROHM ICs (2022-04-08 12:09:45 +0100)

----------------------------------------------------------------
regulator: Fixes for v5.18

A few small driver specific fixes for v5.18, plus an update to the
MAINTAINERS file.

----------------------------------------------------------------
Axel Lin (2):
      regulator: rtq2134: Fix missing active_discharge_on setting
      regulator: atc260x: Fix missing active_discharge_on setting

Jonathan Bakker (1):
      regulator: wm8994: Add an off-on delay for WM8994 variant

Matti Vaittinen (1):
      MAINTAINERS: Fix reviewer info for a few ROHM ICs

 MAINTAINERS                           | 12 +++++-----
 drivers/regulator/atc260x-regulator.c |  1 +
 drivers/regulator/rtq2134-regulator.c |  1 +
 drivers/regulator/wm8994-regulator.c  | 42 ++++++++++++++++++++++++++++++++---
 4 files changed, 46 insertions(+), 10 deletions(-)
