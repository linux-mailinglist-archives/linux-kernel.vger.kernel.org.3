Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FE8591488
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 19:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239486AbiHLQ7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 12:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239559AbiHLQ7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 12:59:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC1DB0B37
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 09:59:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A76861638
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 16:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0D11C4347C;
        Fri, 12 Aug 2022 16:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660323576;
        bh=bu/qKn1ajo3Yvaa4ti2xtnTzrmq8LgTcz4if1cYeQko=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lTzVoe6RNo+wPERqzRHsNPYaJh4ww/OIvRvsCZdP/5riuruYXvBziyYg6I9MFIGAp
         VRad0lLmVXzC80mH/AFokubt6f6IvsLkGJvtLeFf6EFCGWfXp8AoGkSrpj5NkjamDN
         UNxF9hcxF0Y6GuHXJK0JjWgWu0YfaopSZGxxt5+V0IfJqbjsZyoio1JeMYTVUyldeh
         hbFZEIhDzcIXGVk8iTue2dAFXxwWNiLCQoSdXmf9TSCbPz4Kjl5Quy3Ieir+1/KxHh
         c4IKLcMQdX/4xW9x/QzjLraNiTwA0QK+ygytt26+UGqu6LF7twFNpbDhQ6XBiLg2O4
         pKnlE4P5fw1XA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9DBAAC43141;
        Fri, 12 Aug 2022 16:59:36 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.0-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87edxlvlkk.wl-tiwai@suse.de>
References: <87edxlvlkk.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87edxlvlkk.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-6.0-rc1
X-PR-Tracked-Commit-Id: 636aa8807b5780b76609b40cd3d3e1b5a225471c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a9350597aff50bbd0f4b80ccf49d2e02d1111f5
Message-Id: <166032357664.14629.9813361828565389213.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Aug 2022 16:59:36 +0000
To:     Takashi Iwai <tiwai@suse.de>
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

The pull request you sent on Fri, 12 Aug 2022 11:48:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-6.0-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a9350597aff50bbd0f4b80ccf49d2e02d1111f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
