Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE88853D930
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 04:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245670AbiFECOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 22:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243940AbiFECOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 22:14:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7124A186D1;
        Sat,  4 Jun 2022 19:14:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E33CB80AD5;
        Sun,  5 Jun 2022 02:13:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0FD8C385B8;
        Sun,  5 Jun 2022 02:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654395238;
        bh=KglVujWwKmzy7Dy6BV+PUhQGv8m7JNDXzqVCS00tV4c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eJvG4AGenIbnr8gun+j0qCfF28pSS2oKnknIMoYUzeDOFjm9ODvmnNcZr7ULBYzyV
         0Al96JEUuHSo/YZm38D5GyqQD4rTdIYPQJcDwriB7rSMaeyMLXp6zZZNF55P+boMzn
         aBXLUQR2zW0IMbK0R9wVtkxwy0i+ypn+kNwegqtRghoOlV9sdnBlQPKcV5wItGyKvS
         zb2t4Beoxgp2pE0ee+MC2zZHWRqoVYRBh0OmymVj3idBwZgCBoShOLTir5MSkWRqTn
         S8VKrXp92SwJtabUEmoeEilXJmDMMm8ADzOhJkiT1RuXBdSEj/L6Z7Kb6Bbqz1zsMJ
         7GbKCQDkr4aPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DEF12EAC081;
        Sun,  5 Jun 2022 02:13:57 +0000 (UTC)
Subject: Re: [GIT PULL] SMB3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mueybgm5M39d+y9bF53aKjsAavLGvPFc3YquQnuFTcFdg@mail.gmail.com>
References: <CAH2r5mueybgm5M39d+y9bF53aKjsAavLGvPFc3YquQnuFTcFdg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mueybgm5M39d+y9bF53aKjsAavLGvPFc3YquQnuFTcFdg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/5.19-rc-smb3-client-fixes-part2
X-PR-Tracked-Commit-Id: ee3c8019cce254f586b7fc2c5b836c275b275527
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d66016c5cd3d4c474cd24622c511dcd358645613
Message-Id: <165439523790.29822.10163586812457445371.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Jun 2022 02:13:57 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 4 Jun 2022 18:00:34 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.19-rc-smb3-client-fixes-part2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d66016c5cd3d4c474cd24622c511dcd358645613

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
