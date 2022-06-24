Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376B255A350
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 23:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiFXVI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 17:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiFXVIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 17:08:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AA318B10;
        Fri, 24 Jun 2022 14:08:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17054B82C3C;
        Fri, 24 Jun 2022 21:08:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D37D3C341CC;
        Fri, 24 Jun 2022 21:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656104886;
        bh=I2dK0Yt8oNR3HmRIFWZxIjtkOm61BaWJ3zZArEKvZ+Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WcZU0i/6Ipk6tp7VNaPQMxwlstmqtTQx9KgA0cc9/gt58zpParFBtgD6YAjTm1ID2
         h3l1pAMGoGiofGhA2PaPYDwm8U9mWkgET1DOqMTS16CdOunTG/E7tRPxQrjWn/tFMg
         dJnPc2Spiyi3zZ76UVqZJSaDKaW912I/DNUtbq+co8+7ze3vQ+8XZ95aHcYFcyqL3I
         o1pQ9EgdRoR+fokZFl3hlvVVWQ14tnSRBdhd7OcpT3OcGkSh5Wz95NYi+KLv7Ndn+M
         g5MihHdXtHtVYsSRr3Lrw5UUNI206nAt2wgE9bjRc+1GI6/ztFodVW8S5+CX8CWJGJ
         /6DBup80Sb1oA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B950EE8DBCB;
        Fri, 24 Jun 2022 21:08:06 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v5.19-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220624165421.384A3C34114@smtp.kernel.org>
References: <20220624165421.384A3C34114@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220624165421.384A3C34114@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.19-rc3
X-PR-Tracked-Commit-Id: 419bc8f681a0dc63588cee693b6d45e7caa6006c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4039974f3b39abcdc1b7662489157914fd6613bf
Message-Id: <165610488675.13803.14180638139159980140.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Jun 2022 21:08:06 +0000
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

The pull request you sent on Fri, 24 Jun 2022 17:54:07 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.19-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4039974f3b39abcdc1b7662489157914fd6613bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
