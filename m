Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFEC5076A0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355838AbiDSRf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354486AbiDSRfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:35:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D86F393E1;
        Tue, 19 Apr 2022 10:33:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 189A561475;
        Tue, 19 Apr 2022 17:33:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C776C385A7;
        Tue, 19 Apr 2022 17:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650389591;
        bh=YbL2SoyX8ywwqAgTv4kfcPF9Jb7R3HNeB5PaW9/657E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ww9CQMj58Oe5AbT2mHuJegpImEzBiKzoc9WK0MMEvEgeORTrU2eJ46skuzBqCvQJV
         //HUjhGJmN2s7e54GzdsggtYd3ffuLfCJaVpniYiFiV4394Msne+WunmdIMIKi4NAL
         CHbYSQ9y54rMvzZOkmo/xm8FVWQPqpUa9xGiQaXkpDvBXJAR6MMoGMS0lGsiJsFo9u
         40U4Ul+7xD35YwzY/KWmJWMkjM6er5v6kA9pwtBYw7T4E/PHwrxMS0j+b/z2f5Epc9
         s/NUNr/+UX99zi6FJ4I2gxcpDTI0RqoQeQOZUwgJkj5KrJbdVixlHKlbLwDWdOnzrL
         UzZnZGpBaz03w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 62158E8DBDA;
        Tue, 19 Apr 2022 17:33:11 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v5.18-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220419152215.53772C385A5@smtp.kernel.org>
References: <20220419152215.53772C385A5@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220419152215.53772C385A5@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.18-rc3
X-PR-Tracked-Commit-Id: 8c235cc25087495c4288d94f547e9d3061004991
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b7f73403a3e922c20bb278ba3cfcc3c61930d82a
Message-Id: <165038959139.25161.856660991158682532.pr-tracker-bot@kernel.org>
Date:   Tue, 19 Apr 2022 17:33:11 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 19 Apr 2022 16:22:07 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.18-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b7f73403a3e922c20bb278ba3cfcc3c61930d82a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
