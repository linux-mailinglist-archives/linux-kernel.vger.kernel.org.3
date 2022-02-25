Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6F04C4B75
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243325AbiBYQzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241873AbiBYQzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:55:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA94E1D9B4D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 08:55:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8861861CEA
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 16:55:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678CAC340E7;
        Fri, 25 Feb 2022 16:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645808117;
        bh=J7xPnwpV/EL7PO4VknzFRtwLyYRXdvMHKSloPxQ3AxY=;
        h=From:To:Cc:Subject:Date:From;
        b=AIxyXux2Bhrsjs/kGOepbXbOd1iT07wlbe5s/d59SWP5ED2ljuU69VRCUDt02MOb4
         AJ+21IuejkkvI7Cba8qoSlL+vAmaeDzbnBS2USEDMXlNpxFovGMNvvEZrmlo//v0+w
         fX/0yGIhLMUFdIyjsFBcdtrRg4NVLMnvqXmRUP5+BCYnw8OpSdO0gv7GanPz9FTNIC
         N+Cxz/ehTO4DRf3ILyoCRXM8CWe8VYTBe1VtdO/5SM1QQXAV/8lAaoxLld4S1rpudl
         UD8KxRinb9KYCGu3OwKFcLkU0NjiWWxTKL5cV16MNHhSHyQK7xY6Tb+m7q+SdzKHS3
         0c4vET58MIcVg==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap fixes for v5.17-rc5
Date:   Fri, 25 Feb 2022 16:55:04 +0000
Message-Id: <20220225165516.678CAC340E7@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b56a7cbf40c895cbe8b67ce5649a26b7a7bc48be:

  regmap: debugfs: Fix indentation (2022-01-07 19:16:23 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v5.17-rc5

for you to fetch changes up to d04ad245d67a3991dfea5e108e4c452c2ab39bac:

  regmap-irq: Update interrupt clear register for proper reset (2022-02-17 15:33:15 +0000)

----------------------------------------------------------------
regmap: Fix for v5.17

A fix for interrupt controllers which require the explicit
acknowledgement of interrupts using a different register to the one
where interrupts are reported.  Urgent for the few devices this affects.

----------------------------------------------------------------
Prasad Kumpatla (1):
      regmap-irq: Update interrupt clear register for proper reset

 drivers/base/regmap/regmap-irq.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)
