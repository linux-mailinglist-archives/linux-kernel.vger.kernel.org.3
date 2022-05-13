Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556B9526B3A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384175AbiEMU2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384179AbiEMU14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:27:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A101116A;
        Fri, 13 May 2022 13:27:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 567A7B831C3;
        Fri, 13 May 2022 20:27:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C84FC34100;
        Fri, 13 May 2022 20:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652473672;
        bh=B7YkBURDF1+FnxVQEIccEngvzMw5jb+93dTOUbcW/zE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AdcAtW2Fcnr9I82BB3eSckwgiHUNb7nOjXzeVxvPYtmq4ag3K5hgaFLwztuDLuJ5J
         j82HevKqAztt4aqcRmU0CDFGWt8cB1P6j1vAiwchb8QX24R/XkAm5AUbYq+r18BhEj
         BuNQVKW2bmtMOBhN/yh/NzQQiOIWs595cz/MZ30CiZh9jIjsi2f8UjMWxZyG5mf4ZH
         QY1sUJuPEHm10lDAfjGUvJKjn3fHx550OsPzQnoXAx/uAUqaQPbCTmYhFXAtm3RmSK
         12H8bIv9wEIkVTyzik7+54SDdiPYpJNUySPECkaprw6ijYp7jZFxyqHhJlSxIIZckq
         C6LMkOy1WJrZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 08CF8F0389D;
        Fri, 13 May 2022 20:27:52 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 5.18-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <892647cabbe1e3b2134f4667c3edadd853d51602.camel@HansenPartnership.com>
References: <892647cabbe1e3b2134f4667c3edadd853d51602.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <892647cabbe1e3b2134f4667c3edadd853d51602.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 7752662071053adcdb6b6e7853834205dd60e1c0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f2dd007445b1d4c0581d0292f85fdd5b47387776
Message-Id: <165247367202.7375.5766271969428521513.pr-tracker-bot@kernel.org>
Date:   Fri, 13 May 2022 20:27:52 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 May 2022 14:58:20 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f2dd007445b1d4c0581d0292f85fdd5b47387776

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
