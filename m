Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE3D4F0600
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 22:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349940AbiDBUDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 16:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350192AbiDBUCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 16:02:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797BEFD17;
        Sat,  2 Apr 2022 13:01:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22A96B80B66;
        Sat,  2 Apr 2022 20:00:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF052C34111;
        Sat,  2 Apr 2022 20:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648929657;
        bh=EhcFGnLPGaRO4VDZmQNQRZOQhCQe9B9NKZgU475x4MI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=F4U8hkXAANNSab180b/ZOauUExd5kotyEzE6wSjXx3vJxy4mgeT5IcGdXK/poVqYg
         Eqa9Iwn5h0msVSyOO9fbKWNSm3VfF6O3+cgw3NTywhH0b9Qd1vrXDaL6nCkV0IY0B6
         ESo14nu8SNfAzXiAN2SiTLpu/x4n+tGN9lD7eh0T2iDMX82+oPOvEDmNpOD/8uhCmm
         mtNmSTOqOoLIQ2CJIrxXVBkZjLQmfB3/y6YnoDQbYgchQbvwyS72w23Uqpnyjumjzg
         hwwK9cFqULKN4IoHlEnswN7RT9h8UI6hY1wHlfIlnklFyjWXDAGFCdBCfaOwj6iXRk
         3797ZmCQBh0yg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BBA29E6BBCA;
        Sat,  2 Apr 2022 20:00:57 +0000 (UTC)
Subject: Re: [GIT PULL] Kbuild fixes for v5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNASN9Q40P6dUGSidT5=y0FA4pd+U93L17r8sH0j3VPum4A@mail.gmail.com>
References: <CAK7LNASN9Q40P6dUGSidT5=y0FA4pd+U93L17r8sH0j3VPum4A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNASN9Q40P6dUGSidT5=y0FA4pd+U93L17r8sH0j3VPum4A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v5.18
X-PR-Tracked-Commit-Id: bf5c0c2231bcab677e5cdfb7f73e6c79f6d8c2d4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d897b680418db98f01a0bff038f1b03770a33722
Message-Id: <164892965776.29522.8021146833842117164.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Apr 2022 20:00:57 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 3 Apr 2022 03:28:19 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d897b680418db98f01a0bff038f1b03770a33722

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
