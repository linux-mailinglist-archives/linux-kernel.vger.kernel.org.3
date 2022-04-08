Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFCC4F9B02
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 18:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiDHQvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 12:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbiDHQvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 12:51:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FC4127BE1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 09:49:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C620B6211D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 16:49:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32A46C385AA;
        Fri,  8 Apr 2022 16:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649436554;
        bh=7xExulffrxewtutCFupsz/wc7uzLipKSH+Y1wJYAaPU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jGeghzmyOEuk+wpcQodoKGefuHiwJTbkiTW8138Vf6fnbRBgBgTGae6FqaJqiR5ky
         2linUNZ1PYuIKgWerF86Fm9Z2Ac9bL5uSw+kguVehce0HMy7HhpHm4cfjwUYP53tj9
         8RACwK2PR6RRCCh7Ij7tuUv+9z08r1tN0DcbK6YV2ZWOxbj4qzhTt/UxtgiGb1R5ES
         9uGZ4I8QQk2CBK8BhtBS1VTjn47huxmAW/BNWAAtW9wu1ps+Vxe42MMdDjMkLLMpRM
         2GI+qDcZN5IMHpIQzWh2Nb1SUM9L+dnXga5htJKnqAef+UOHIWpHAH5t8hdwY+ag5M
         8/nO33MIam9PQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 183D6E8DCCE;
        Fri,  8 Apr 2022 16:49:14 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220408145656.4A774C385A1@smtp.kernel.org>
References: <20220408145656.4A774C385A1@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220408145656.4A774C385A1@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.18-rc1
X-PR-Tracked-Commit-Id: 908b768f9a8ffca2ef69f3145e23a6a259f99ac3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 98849765a58b56479dbb105565a24417752eff25
Message-Id: <164943655409.24432.16864249162143377254.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Apr 2022 16:49:14 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 08 Apr 2022 15:56:49 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/98849765a58b56479dbb105565a24417752eff25

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
