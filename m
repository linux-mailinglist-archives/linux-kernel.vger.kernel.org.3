Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73EF74D3CBD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238572AbiCIWRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238516AbiCIWRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:17:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AC0104A74
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:16:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32F36B823FF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 22:16:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D41ACC340E8;
        Wed,  9 Mar 2022 22:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646864169;
        bh=7Gm//2LqEtD2IWBmeRggFUAph0WB0PzEA/sMIW4XQkE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=q+M6UJDlatx/uHcTQ3L+r8cBCIaxNDgpMJ9qiQYRMYpHjvPtdeo56FgxlFpimWj0b
         ZWSStf8VrFzttj7wqynESadR1stiC0pbEFGTwJmecddPYoNkjcPUf9Zd+cIEAycp0c
         qvDBowY8aSUPtItSBw/dlIicvOIrxxwyby+MkvxtBB2lf7c1faNAO0YpY6ni/37Km2
         44fTb23gaEC8yloIEvGa1dzBCpsrI8TigBNAVS0mXUok7yUIIYsKV9dZM36ldvU3oG
         1kKTPlMKftI7rRdP6zMiAjbnZK9RfJUz3JwHhTqoy3PJOnLV+/kVjLDEOa60k9/uOZ
         q3dZpl0ggRtXg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BB0E0E73C2D;
        Wed,  9 Mar 2022 22:16:09 +0000 (UTC)
Subject: Re: [GIT PULL] HID fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2203091139210.24795@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2203091139210.24795@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2203091139210.24795@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: fe23b6bbeac40de957724b90a88d46fb336e29a9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 37c333a5dea519973e8b6588ef7845b18ee1cb46
Message-Id: <164686416975.25297.17580113805057094644.pr-tracker-bot@kernel.org>
Date:   Wed, 09 Mar 2022 22:16:09 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 9 Mar 2022 11:42:10 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/37c333a5dea519973e8b6588ef7845b18ee1cb46

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
