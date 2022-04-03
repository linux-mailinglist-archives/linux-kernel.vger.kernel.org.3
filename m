Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437184F0C80
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 22:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376465AbiDCUb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 16:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376453AbiDCUbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 16:31:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CB933884;
        Sun,  3 Apr 2022 13:29:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12675B80D9F;
        Sun,  3 Apr 2022 20:29:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ACD8DC340F2;
        Sun,  3 Apr 2022 20:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649017796;
        bh=0hK4HXo/3S6Y4aP5LPDRKT/TbXSlch0JfT0hI1hVRBs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ih0CsbZIcUbqZdjJAg6Ec675lDXLxoxpCewK2riM+UNQX7KzjztBUp5WENQvxKLyC
         fRgXuQuZbkl1egIsoSRHR2duO4T2LiMS2m7QytrBYZnLPZQ2kb853v3XqXlzGrJxh6
         iBfZNqM6cfHsbzMM8JR9TluDiRk1rJiJliOCWbcmXQMqVffZvdMkL3XVE+XugNN8o3
         VD6IFkaTd60gb3elAz13WRs79mezdbr8p29+AVHv/JgKpmjJq8rhTRV8u13ZaG3/9P
         LIaZu8DtTfHUEwe098rIi04wNk1DWFvqIh8l3xOHeI2RDpb1L0llc2IMXJ3JiQYYs1
         YtUg8+EwXzcCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 99250E6BBCA;
        Sun,  3 Apr 2022 20:29:56 +0000 (UTC)
Subject: Re: [GIT PULL] one more clk change for the merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220403140959.113778-1-sboyd@kernel.org>
References: <20220403140959.113778-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-clk.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220403140959.113778-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus
X-PR-Tracked-Commit-Id: 859c2c7b1d0623a6f523f970043db85ce0e5aa60
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 34a53ff911eb30629baad788fbed892f711bdd3e
Message-Id: <164901779662.22329.11478011777146283017.pr-tracker-bot@kernel.org>
Date:   Sun, 03 Apr 2022 20:29:56 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun,  3 Apr 2022 07:09:59 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/34a53ff911eb30629baad788fbed892f711bdd3e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
