Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D6C533383
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 00:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242676AbiEXW2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 18:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242615AbiEXW1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 18:27:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917CA4D9F0
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 15:27:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A5F4B81B89
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 22:27:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D50DC34118;
        Tue, 24 May 2022 22:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653431267;
        bh=ez2Mn9nBsklTLdjMmmYlPXMJ7EyXKjpr2r6P2al3wj4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bDpJKtyfylBWcl/ChcUis/Q8XHqsBkksJa8QhEPi03AMMLFO2Cuw1+EjA14lg6Dzx
         5kmMVkmc2/83Z0arSWWuDY2X4gASjT3uc8OK/Mbsj2X20grFMdPMUDRpN9JzDVUb0+
         4Q9MqtQq8WZ/KcUV+1yxJNi5tfAHp7F4EYlsHEML8v4H7O1b+E2rUM503nnUEUSLP6
         fLbUiHO2k0vurIzJOqUNhvr0DkpceYRJR4i0cn4L31oce6Jzr3r6ctktwQJ7g1/av2
         WNP12rgfHD3s8Sq+Rct+8rhT8TfLZR0+d3SZZSaSr39/f6YEn4Ak6YDo4cA5OBymt2
         Q5rrFPBBpBwnA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3AC85E8DD61;
        Tue, 24 May 2022 22:27:47 +0000 (UTC)
Subject: Re: [GIT PULL] regulator updates for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220523131230.B844CC385A9@smtp.kernel.org>
References: <20220523131230.B844CC385A9@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220523131230.B844CC385A9@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.19
X-PR-Tracked-Commit-Id: a5b8e4a5ceec0ab6453176bc7f5eceafa78bf8a9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b18d07ba3ae75fcb7a191fafe4e2954f07271be
Message-Id: <165343126723.3997.6343294147814223549.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 22:27:47 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 14:12:19 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b18d07ba3ae75fcb7a191fafe4e2954f07271be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
