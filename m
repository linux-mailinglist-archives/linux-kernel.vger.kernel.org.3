Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81C34E360F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 02:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbiCVBlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 21:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbiCVBlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 21:41:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0224F165B4;
        Mon, 21 Mar 2022 18:39:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E4CD615F8;
        Tue, 22 Mar 2022 01:39:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4A42C36AE5;
        Tue, 22 Mar 2022 01:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647913189;
        bh=knokuBBRUmom8/6Y0gPAHPzXAtRD36I778GZXHEe18A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tTXO62Ir/U//TV21TWA4Y0QIbCVIE2JywQONezYc9c/z3wEV+ww37c5ZEOnurJ70X
         cFryI6n3lxjZJ/gk/Jrhrq2B1kMLB1vYv256nK+UmkoFoytk/su2s0KsRxjxa8pa/M
         3k3d/cJUl65aKi/L+NcTXbFkGJS7hADh++fZ457CiXS8JVygE27jYcrcMHnIKk9BAk
         94/PRBbIrDvS9uO4ojfTj/g1XU9HpTNYY6nN5gbQTihv9XJed7pHydIFVQfZahWAa+
         PImTf+JjYZndqIF67woph5Nz2KlVjNowq7ocbQ06gcwweMY4PpkwatxE0YW4fZ4d35
         PNdADrrTls3sQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CECDAE7BB0B;
        Tue, 22 Mar 2022 01:39:49 +0000 (UTC)
Subject: Re: [GIT PULL] SPI updates for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220321123625.BA8CDC340F2@smtp.kernel.org>
References: <20220321123625.BA8CDC340F2@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220321123625.BA8CDC340F2@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.18
X-PR-Tracked-Commit-Id: 89b35e3f28514087d3f1e28e8f5634fbfd07c554
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad9c6ee642a61adae93dfa35582b5af16dc5173a
Message-Id: <164791318984.2267.17556409524025409104.pr-tracker-bot@kernel.org>
Date:   Tue, 22 Mar 2022 01:39:49 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 12:36:04 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad9c6ee642a61adae93dfa35582b5af16dc5173a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
