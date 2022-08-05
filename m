Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3B958A473
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 03:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240470AbiHEB23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 21:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240039AbiHEB2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 21:28:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85051BE95;
        Thu,  4 Aug 2022 18:28:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67D3361985;
        Fri,  5 Aug 2022 01:28:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6124C433B5;
        Fri,  5 Aug 2022 01:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659662901;
        bh=AeMmp+nbQUbcHM6PLxapsSad5C9svj3hzsD5edaFZ/c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Lj4WO1hyciAoMSpT2tt1X1WMJKkZYrkSjImMBsd+Qz1XRiw6w7DvI0CxUn2J8Wls8
         6VFR6Khv/eCWGZp37QwxDeJTHbqCaKBcFzCl192D2nAHR2hMRT1X4aPc0FBs2rAtU0
         QGHX3gMsKj824OqRkz3GMnh7Iii2wpLs2TbJOnR1t3CjKTL3uPDo3RK0WqLwipp1Ow
         dud2DHqUqtbvUt9QZEOxF1avxHtNUOKfwv4z4U/82ERfsExgvvad4xMUM1VECMbQ2H
         4n06BjQKOsw4CSfyquRp7XHhK4widH9yaQVXODzjgRfHxKXqOTf/sMLiC3RD8bqzEn
         LiYSmkkhpBceA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B6791C43140;
        Fri,  5 Aug 2022 01:28:21 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree updates for v6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220802224904.GA796923-robh@kernel.org>
References: <20220802224904.GA796923-robh@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220802224904.GA796923-robh@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.0
X-PR-Tracked-Commit-Id: 7e7a24c3c6c98abc4425abd1dbf2a71b42dfafcf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: da8d07af4b3e2e407c5dd13f08b64580931fd1a6
Message-Id: <165966290174.8823.14048839297036734986.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Aug 2022 01:28:21 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 2 Aug 2022 16:49:04 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/da8d07af4b3e2e407c5dd13f08b64580931fd1a6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
