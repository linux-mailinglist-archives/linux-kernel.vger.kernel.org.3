Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BC9539536
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 19:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245751AbiEaRFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 13:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346411AbiEaRFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 13:05:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCB88DDF7
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 10:05:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDE7FB815F6
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 17:05:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6811C385A9;
        Tue, 31 May 2022 17:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654016742;
        bh=BUf5DDIvZSCdDEgeyAz0R/STC5kkzGo5CDpLk20V6GU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KntG/fo3uUE35o/MThrpmpd2YiTauMJ9sTHshCfvPHJR/X/gN8cVLFDJr1JBafFdE
         up9uiDXv9A+KwiRQTs0ZGHsZS4QSRrQip5UHB1r9CVm556OyfdSfQ9ntuAWnvSd+G9
         nSQu6D2KYAD7/6nl/SUqnjwEQJ+M29UQAVawegZuj9j9T9/b7fnMAkA+0d22yhzJB6
         R55ONEVhfB+4NtnSuyZb8i8oeCZL+9eO31CN4R49pJKiS/8IXIzVyEHOrfrprrlQYC
         NCBrjJ4s4pBJL6CJL0pd6IR2IhILnQngnAgW/6bKObrELUOZ3euiLEygsY/0BC+X5+
         2S3SzH38glaGA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 94621F03944;
        Tue, 31 May 2022 17:05:42 +0000 (UTC)
Subject: Re: [GIT PULL] arch/microblaze patches for 5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <9bfbc0fb-ddd2-d65c-f9ac-2a2696581c71@monstr.eu>
References: <9bfbc0fb-ddd2-d65c-f9ac-2a2696581c71@monstr.eu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <9bfbc0fb-ddd2-d65c-f9ac-2a2696581c71@monstr.eu>
X-PR-Tracked-Remote: git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v5.19
X-PR-Tracked-Commit-Id: 78b5f52ab6f6074a6fe2f27122e2165f32d6a143
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3335d5550256210c9b213f67240221633d8f7b53
Message-Id: <165401674259.5782.2970663186207926507.pr-tracker-bot@kernel.org>
Date:   Tue, 31 May 2022 17:05:42 +0000
To:     Michal Simek <monstr@monstr.eu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 31 May 2022 09:10:19 +0200:

> git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3335d5550256210c9b213f67240221633d8f7b53

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
