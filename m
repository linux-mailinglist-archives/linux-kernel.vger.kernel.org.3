Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383A853D4FE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 05:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350376AbiFDDGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 23:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344612AbiFDDGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 23:06:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94902ED4D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 20:06:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8522A60C51
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 03:06:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4BC0C385A9;
        Sat,  4 Jun 2022 03:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654311972;
        bh=/ynU2EhIqld0c3bXsMLt0ieQkhCHnIKWtOI2lXLMFv0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Vayy4Hm0tOQnAB4G4PKTVHXFgULJCu5G28bm9g7GsY0pjDiK40Uc8Haf4oLpntXzn
         Sj3mLNSpA6zEK4hc1Zp+i/phPobnCVneZoewLeJRvm76sOE3a9JbcWbMT53cAaczwX
         LOObr5DWSq9V2bBLcXNgsobVLxPPQ9aEM6q/c5VNA7XgOWn8ny/9T5VxoPNjearNdz
         1AmFRkJE8rgTiU878nGSqKtbSVBXDKhUrIWEegZpHL2NwZx2ennngeX3zepsDBrXhd
         a6OVVGYxx143WI5FovBLEeKQoSqMw69hui3H7iJGA7A2A9MlSeI6Lwqk4JSQhQni99
         HwvdvQQiJfreg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D166EF5F173;
        Sat,  4 Jun 2022 03:06:12 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v5.19-rc0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220603112824.A58BFC385B8@smtp.kernel.org>
References: <20220603112824.A58BFC385B8@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220603112824.A58BFC385B8@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.19-rc0
X-PR-Tracked-Commit-Id: 28cbc2d4c54c09a427b18a1604740efb6b2cc2d6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 77d4d3609cd2dd613b6f4c3162616a944d3aeb0b
Message-Id: <165431197285.21905.2040653899708631223.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Jun 2022 03:06:12 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 03 Jun 2022 13:28:08 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.19-rc0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/77d4d3609cd2dd613b6f4c3162616a944d3aeb0b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
