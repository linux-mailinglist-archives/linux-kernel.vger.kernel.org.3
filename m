Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1235E51ACEB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377084AbiEDShl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377108AbiEDShR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:37:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF00ACE0
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 11:24:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B91661AA0
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 18:24:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF906C385A5;
        Wed,  4 May 2022 18:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651688689;
        bh=89ev1D1u5hd7kOhk2ciwm5FY2lRj1JKcWOWaEZ/VWlk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sA8Rcgp+6wWn2k/2hZ/tgyxLNdzgvBTgb8ybb8uc3tkjLqpGqaA94UqLu5hfszK+I
         4NgfGJeORoJs7HnUsSPeBj+wM8NQo3XQsfIULEqcv5GTL7eSo66l/rlEpEw2Cum6Xz
         iMt3FgLWFnLM5rNHUP/Eo8/V9NVz4mBq1kB8CfgALFGBJJ3G7eJoSl/llDKMtetABq
         hBUU3gHzrQ7RLsEU0EVUuTPG8sznZGtRSuTli64qe9FXyWVOaHK54toy22bt7xG1jL
         RT+M6O5Dr7/RKy//ec4c2rampYNY9xd56aGu/Iw7oEQ672FlzL9dhTgHJiURQ5+dX8
         5qbKuMV7ebozg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BC527E8DD77;
        Wed,  4 May 2022 18:24:49 +0000 (UTC)
Subject: Re: [GIT PULL] IPMI bug fixes for 5.17 (second set)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220504115047.GC3767252@minyard.net>
References: <20220504115047.GC3767252@minyard.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220504115047.GC3767252@minyard.net>
X-PR-Tracked-Remote: https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.17-2
X-PR-Tracked-Commit-Id: 9cc3aac42566a0021e0ab7c4e9b31667ad75b1e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3118d7ab3f01e309d38b4e719370bdd5361aec6d
Message-Id: <165168868976.19526.7851757229912228701.pr-tracker-bot@kernel.org>
Date:   Wed, 04 May 2022 18:24:49 +0000
To:     Corey Minyard <minyard@acm.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 4 May 2022 06:50:47 -0500:

> https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.17-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3118d7ab3f01e309d38b4e719370bdd5361aec6d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
