Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F99504885
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 18:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbiDQRBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 13:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbiDQRBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 13:01:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3D01903A;
        Sun, 17 Apr 2022 09:59:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48AD1B80D30;
        Sun, 17 Apr 2022 16:59:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0FBB2C385A4;
        Sun, 17 Apr 2022 16:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650214740;
        bh=P6ASqz0CNPpNP1c/VGzhMBEoj8JIZ6HAz3kqOzB8p+o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kUR4rfdi6tSpntNZsg5+u3PzZATLGU2BEvBjqJItW+Z1GuvWbLduqc0yvva8B4shf
         woHVaIyU01RHKKq+oAHdF1D1ddksnAv8xrfMRqfGoFRaCLrvP9laTPSa52UJP+EYr0
         nhF4ApngmfsrIKWft+C0Zy79/AVAm6SKsx9o6WPKHqB8onHJ7GPY8/WHhxAA+A7AFp
         dtPBXGDoygeAY6z7AL3MToacg3N3NfDEWpI/dz1Kf+Goi22e7zdyFqBjZ/AHQe3Atv
         Vb/bnQEBxcreK3Eh8LZX9SOm/kc7ZeJTak1RPbZ5djqptkR9kb5mTLOtRmUuxBbRvK
         56caUtE6//JgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EA11FE85D15;
        Sun, 17 Apr 2022 16:58:59 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 5.18-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220417162936.zqxxjmfpdut34qjb@earth.universe>
References: <20220417162936.zqxxjmfpdut34qjb@earth.universe>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220417162936.zqxxjmfpdut34qjb@earth.universe>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.18-rc
X-PR-Tracked-Commit-Id: 581045ed5cfa42ed7f5364d6ccbcb6fcc077ffcf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9a921a6ff7a616863b981220d0a2e0d1de2d050b
Message-Id: <165021473995.4330.3612361325979901539.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Apr 2022 16:58:59 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 17 Apr 2022 18:29:36 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.18-rc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9a921a6ff7a616863b981220d0a2e0d1de2d050b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
