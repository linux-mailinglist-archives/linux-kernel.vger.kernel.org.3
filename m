Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B928B586006
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 18:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236980AbiGaQzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 12:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237341AbiGaQzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 12:55:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C6063F2;
        Sun, 31 Jul 2022 09:55:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5513F60F18;
        Sun, 31 Jul 2022 16:55:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3A05C433D7;
        Sun, 31 Jul 2022 16:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659286546;
        bh=l6FdVPWe1L2Gm6gHVQVu1QZEsFqxuNEDBhFpXRHsxdc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=I5ExtBhKmu4k1H/nTKe1CfnCygiMygmXo/CJA0pKX4l3h+WEQ1MOI9+ZZpzmn/PD4
         yZubHvweGOyqRajY6WGFs01khnPVvCI5QtAm0XBgwNRkhTTax/qR4KrSIslikeqN2V
         s0HY5njdE8GB6Vy09sQOQRCuMarcetuhJGiidMoGRGcLDz4clSe0uUkGkT2ghdXnnr
         GPsd54gP4MXJaGHHM7Lhbi+uY6RCdv7LK1FdUDQtu8ksv1oyFoLne28/TTRv1C8TF8
         C0Phrf4FOBHUYWQ1oP6kMc/KhNT9uXlMZ8PjvUjNdxP7h/ptN5gptEaYWd0NToQzzn
         QGCullkkbhmYQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2534C43140;
        Sun, 31 Jul 2022 16:55:46 +0000 (UTC)
Subject: Re: [GIT PULL] clk fixes for v5.19-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220731161733.2786191-1-sboyd@kernel.org>
References: <20220731161733.2786191-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-clk.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220731161733.2786191-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: 8dc592c41f38735306d1f1dc0b183601379c6d94
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 334c0ef6429f261c7f53dc035632435ffbc0c60d
Message-Id: <165928654666.8632.9198524769281032820.pr-tracker-bot@kernel.org>
Date:   Sun, 31 Jul 2022 16:55:46 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 31 Jul 2022 09:17:32 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/334c0ef6429f261c7f53dc035632435ffbc0c60d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
