Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B4358B8CE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 02:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241618AbiHGAur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 20:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbiHGAuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 20:50:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753D0FF8;
        Sat,  6 Aug 2022 17:50:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1EBAFB80B36;
        Sun,  7 Aug 2022 00:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC268C433D7;
        Sun,  7 Aug 2022 00:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659833410;
        bh=OfI0SVIwsXpPk0HooNZxVkg4KFWZxbdAQjeFC2Jm4YA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=l6J+vg2lG1EiyA2g5zEPRvfOLTmJlwIX+0E6e8HUR/+E5CAn1sW2ciJTPTwiOQwRb
         iEYQ5PWiP2txoVFoe1zeJ/B/ld2AwGNjoFyXGvMu382MLOBqeVTS6QH6YfPxjWwTCZ
         L5NsKibO73R4ZGvmaWGd9fMynkJi+bs9lgmdTfxczz/HR3MT4ZtZufDwmbh+AWxfkn
         oZx+B/BRYzVwaFj1HHFwG0AYQ7/R/ri3PqJktHzQ/aSaF0ZfOxbCQfcy5DzlzxaCI4
         wXJEcejmqHgHk79LbP6JYFtvEZEDavEN2x3zykOJDScoR4hd2iJR6Lz0SGpe7BVboZ
         ZC8IAR66w+09A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BB899C43142;
        Sun,  7 Aug 2022 00:50:10 +0000 (UTC)
Subject: Re: [GIT PULL] MIPS changes for v6.0-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220806083423.GA3635@alpha.franken.de>
References: <20220806083423.GA3635@alpha.franken.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220806083423.GA3635@alpha.franken.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_6.0
X-PR-Tracked-Commit-Id: 74de14fe05dd6b151d73cb0c73c8ec874cbdcde6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d77771c926671e0362af3fe792391be66072b242
Message-Id: <165983341076.27609.1383633366027709205.pr-tracker-bot@kernel.org>
Date:   Sun, 07 Aug 2022 00:50:10 +0000
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     torvalds@linux-foundation.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 6 Aug 2022 10:34:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_6.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d77771c926671e0362af3fe792391be66072b242

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
