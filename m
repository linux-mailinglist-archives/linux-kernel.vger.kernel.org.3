Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CB6547B83
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 20:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbiFLSk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 14:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbiFLSku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 14:40:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2605759969;
        Sun, 12 Jun 2022 11:40:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8E87B80D03;
        Sun, 12 Jun 2022 18:40:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A67EC34115;
        Sun, 12 Jun 2022 18:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655059246;
        bh=+6WFW3Npj4ctuN/nDgdVIAVE1iKAVuuIgGpK1R++zHo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oTvpuYGLFaIajr+TC8pD8Pt5J4TDMK+AH68A9xL8D+qY1W57B2UkRP6CfVYAQd7x1
         X0QuizcOT/faDJMfCV1We0qr7Rbbzmx+FBUKo6I3HvkY3BkVtEdc5ZiXPEog0z6mrN
         o0yvTvfSg5JR0KAwHJgxFfhJavfqItNFz780kakC9VTlzmGqCdrV8bjK6TqDYW3wGF
         NO30nKT7mELr+6s2T9m/tSyJ0jikBZazbv8Xk+usXEiC1SU8N9IQftEynPaa6Wn5T3
         8xAWFrwmV9iAkliuft1w5x1jLEVEtI/pLZvRpeQpbfZqav8kr3ih5RgD6vsmNuFdEU
         VGprQHzZKnrEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7786AE737ED;
        Sun, 12 Jun 2022 18:40:46 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5msLEuGjB+JQBHF34AG+hx4szrzYsT1A=mj7Rmn7Y_r5FQ@mail.gmail.com>
References: <CAH2r5msLEuGjB+JQBHF34AG+hx4szrzYsT1A=mj7Rmn7Y_r5FQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5msLEuGjB+JQBHF34AG+hx4szrzYsT1A=mj7Rmn7Y_r5FQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/5.19-rc1-smb3-client-fixes
X-PR-Tracked-Commit-Id: 4c14d7043fede258957d7b01da0cad2d9fe3a205
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2275c6babfa53278c90b7915441c61392dd687cc
Message-Id: <165505924648.24195.8158480621712933168.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Jun 2022 18:40:46 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 11 Jun 2022 11:38:45 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.19-rc1-smb3-client-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2275c6babfa53278c90b7915441c61392dd687cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
