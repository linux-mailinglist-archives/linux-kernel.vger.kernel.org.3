Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26264591D4D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 02:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240105AbiHNAj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 20:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiHNAjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 20:39:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB04326FC;
        Sat, 13 Aug 2022 17:39:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACC0960EDD;
        Sun, 14 Aug 2022 00:39:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19EB5C433C1;
        Sun, 14 Aug 2022 00:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660437593;
        bh=rvXP7oDYc1+ovgxAK/pvIX0vh9GosOb1yjekZAJzPsY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YLiYOwQmPwAcqJ3u9vxyDKjAnwS9K8uwUHTSCYStZ0AIB+koH68Tpqn+hGxdE7TXJ
         XNJcPJK/bzX8fd5tBO7zbNJjSQt4CApIvsZVJMJ/wjBjIB+kkSPvOW1Y8tTb6Cw/PT
         +WFNwXIQlEIgYikM4L64UV3rNR7RkjqeCWxNntYESd6ifMA+c0SzlWhxMTyJDDzWgP
         ou1Ny3t+8MeGH700mBYlDUxYtnnKcgdBGaosascDkKgfgyLgErpdR6v5djzrcFlNo1
         ypww2mU38tdIvqAiwXAdeosKw++0HbElEVSGCyM2LZ/FCsF28evLlKvBKHSlC0Pz+l
         Feye20GaGTVQg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05F3DC43142;
        Sun, 14 Aug 2022 00:39:53 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5msY4JmT5aZ_zAC9bMozQ=R4iTaa5SPF5JWpR73OcbUDZA@mail.gmail.com>
References: <CAH2r5msY4JmT5aZ_zAC9bMozQ=R4iTaa5SPF5JWpR73OcbUDZA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5msY4JmT5aZ_zAC9bMozQ=R4iTaa5SPF5JWpR73OcbUDZA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/5.20-rc-smb3-client-fixes-part2
X-PR-Tracked-Commit-Id: 7eb59a98701d3113671b513593bb489cc76f58d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 332019e23a51db1aa46fec695a9a763445fbe09f
Message-Id: <166043759301.507.8035859024810241051.pr-tracker-bot@kernel.org>
Date:   Sun, 14 Aug 2022 00:39:53 +0000
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

The pull request you sent on Sat, 13 Aug 2022 16:44:58 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.20-rc-smb3-client-fixes-part2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/332019e23a51db1aa46fec695a9a763445fbe09f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
