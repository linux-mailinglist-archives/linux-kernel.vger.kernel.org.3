Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A682D4B36C7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 18:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237674AbiBLRRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 12:17:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237658AbiBLRRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 12:17:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5DA240A4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 09:17:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B18FBB807EC
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 17:17:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 630D4C340E7;
        Sat, 12 Feb 2022 17:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644686232;
        bh=Q9HYMbaFf8kSz/K+ffpJf+Uw7xognbxdMdaU5VtCFao=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ew2FUVeHj/wPq9xEmBsj62HfQpEAamxfNZOegiIdGaOV+FT4wnYZ/YACnpl5KvvIZ
         YMkuSnCOoWCQoTcdI7nqw0sXImgV81Y4fGKlqJ/jqFROK86GfTSF8uAgEfgs1/x1Vm
         /X1E90Vwvsq5DPsYu/kFS40EzEnlg4Irbj8+Dh0tYnUViSGscyuRfhQjiG8Z6t25R+
         mhuRIKefoK/l+WoVDhG6kltpjcZrO8r8SIZL/5xFoA7o/8CmoZJuaBlyPVfCasvMyP
         V41GxGW1RgT2C+yJj7Ip0PWVRQrB9y8zcc3cs1JI3a2t5ejj/yKxHfBYN2gLOkavvN
         Ni4OeG+9Dy0ow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 51CBBE5CF96;
        Sat, 12 Feb 2022 17:17:12 +0000 (UTC)
Subject: Re: [GIT PULL] seccomp fixes for v5.17-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202202111856.4A98232C9D@keescook>
References: <202202111856.4A98232C9D@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202202111856.4A98232C9D@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.17-rc4
X-PR-Tracked-Commit-Id: eed09ad261822a7bdc441ed192c6f444375e5527
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eef8cffcaba8f1498ec32f55c859b883315232ad
Message-Id: <164468623232.20961.2205651909621199445.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Feb 2022 17:17:12 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Robert =?utf-8?B?xZp3acSZY2tp?= <robert@swiecki.net>,
        Will Drewry <wad@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Feb 2022 19:02:38 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.17-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eef8cffcaba8f1498ec32f55c859b883315232ad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
