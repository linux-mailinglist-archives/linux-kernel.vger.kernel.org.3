Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD4A4C4B71
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243311AbiBYQ4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241376AbiBYQ4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:56:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB531D9B5D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 08:55:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE9B1B8329F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 16:55:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E91C340E7;
        Fri, 25 Feb 2022 16:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645808138;
        bh=SThHsGFG4/uZ0Ee/cYQXDqKMN7r9bVhj/3XHQpO/k8g=;
        h=From:To:Cc:Subject:Date:From;
        b=iJrDD+3qJgIqeqa2SBvG+49rrDwZ3/cuhrDB0cY9ouUzMZMmFypN76sfvgpfrxCt5
         uuEHEh+3+flwb4A0nsR18Cj/bQ47eisSXv6B7Qg35i2CDe2ArH9wshIvmamEfULhKU
         WEWdXxsId9g7b8Y17uh6FIdTUbhZZlCNjsDkuk0ylqWHQNGgyIkh/WvL0A3BfSMa2X
         8LoQXSARcUUH2xT6E+QyYEMNRCK9u3uHI7HzIloQff0E8H2jlxVblgzTuAbWnUE7fm
         LliZ+6J70/7BPZ/5Gz9tjQAJQBk+YIkTEvOGQTi8AJjJ1MXHPYtZ88MGO8e07UIKY9
         eNva8IZfc2N+w==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v5.17-rc5
Date:   Fri, 25 Feb 2022 16:55:23 +0000
Message-Id: <20220225165537.E9E91C340E7@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 4e2a354e3775870ca823f1fb29bbbffbe11059a6:

  regulator: core: fix false positive in regulator_late_cleanup() (2022-02-08 13:37:48 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.17-rc5

for you to fetch changes up to 9c7cf33c53ce833b58de9e5c192b4736dbd09cb1:

  regulator: da9121: Remove surplus DA9141 parameters (2022-02-22 11:56:29 +0000)

----------------------------------------------------------------
regulator: Fixes for v5.17

A series of fixes for the da9121 driver.

----------------------------------------------------------------
Adam Ward (3):
      regulator: da9121: Fix DA914x current values
      regulator: da9121: Fix DA914x voltage value
      regulator: da9121: Remove surplus DA9141 parameters

 drivers/regulator/da9121-regulator.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)
