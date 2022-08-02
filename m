Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A4D5881E9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 20:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbiHBSeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 14:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237524AbiHBSeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 14:34:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB4B13F19;
        Tue,  2 Aug 2022 11:34:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AF13612E9;
        Tue,  2 Aug 2022 18:34:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D89F2C433D6;
        Tue,  2 Aug 2022 18:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659465248;
        bh=GBtM0DehaPq1tJtLXq1OKEu7O8SXdKoqI0E26yme45U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Rw2fHt75wEDfYXAD+SeZDm0ZPiE3jfj0C1YQKUBMViCp41vayXDoGJYlJCkref90/
         0844ixLz4DtNqohQrBh6PE+PZceyjkCSjqgqC2TNiXIuDkbVIylfuLXkneXaSjvSaC
         zzJ5Wp3ivaH7ZOStfWsBR7GDsVY72qC/nw4mr3/3qmByCRbiRrxOyDXcY/TFqFOBBw
         6Ic6++PKlOQaWOYj87ydbpjtZikSKuuvP5yHT4ffe2PZ4iAYZjws9a6JHFAtvojcbb
         ZzRqc6e+BdhbM6lmhDemjcqn41YBzfUutJtEd/R4GssREvSHe3p8mUYGYqBaOvJUlq
         N5Yub0OwoSfbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C8019C43140;
        Tue,  2 Aug 2022 18:34:08 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon updates for v5.20
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220730022529.497941-1-linux@roeck-us.net>
References: <20220730022529.497941-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-hwmon.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220730022529.497941-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.20
X-PR-Tracked-Commit-Id: cdbe34da01e32024e56fff5c6854a263a012d7ff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 64ae88ff48cb5b3cc7b7aea97241a3e940085bf7
Message-Id: <165946524881.2519.15892404700380969906.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Aug 2022 18:34:08 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Jul 2022 19:25:29 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/64ae88ff48cb5b3cc7b7aea97241a3e940085bf7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
