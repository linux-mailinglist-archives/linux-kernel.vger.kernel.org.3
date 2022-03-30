Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8234EB81D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 04:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241865AbiC3CCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 22:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241923AbiC3CCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 22:02:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121D085647
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 19:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C89961383
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 02:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FE00C36AE2;
        Wed, 30 Mar 2022 02:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648605622;
        bh=sQZ0ONnMGryliTE9XUQrNyXfRxGF5DqxxqG5vDt88+8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XApP6sh7GqWGDNvAjLBys0tG5DeIyHyGs4lPi0F+gD0o2viFJWeSm0yqsfeBy691j
         DteknciBvNDd+zznTeGO1fs3FeJbZC+7MEHy4OW37KOPPyTNno1wYaveSVYC5n91nL
         IFQqy/BOsUzkjD7SJLv4Rc+I7vv4uPmjtyU8f+E8LaRrGMpJotLp+TjkerNEMwtN06
         iuNFUbe8PwlL7uhRaI+GmcuUhrU1+khVFxzy+oUzE2zoYWzZgVUhFCur2/s0TSCRMK
         8m4GrLROPSM0IoZHjBBH8O5cSwNqpvKJL8OsHMXrD4feVbSsyqvTALk4zE07TqpWEf
         3/dTS+bcYNkgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0FC58EAC09B;
        Wed, 30 Mar 2022 02:00:22 +0000 (UTC)
Subject: Re: [GIT PULL] jfs updates for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <4af677c0-e9ca-fd27-8c20-66b6b4ba6c11@oracle.com>
References: <4af677c0-e9ca-fd27-8c20-66b6b4ba6c11@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <4af677c0-e9ca-fd27-8c20-66b6b4ba6c11@oracle.com>
X-PR-Tracked-Remote: git@github.com:kleikamp/linux-shaggy.git tags/jfs-5.18
X-PR-Tracked-Commit-Id: a53046291020ec41e09181396c1e829287b48d47
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1ec48f95519bd3e920536118e8ddd30e28cde4ab
Message-Id: <164860562206.9387.9455020322184914414.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Mar 2022 02:00:22 +0000
To:     Dave Kleikamp <dave.kleikamp@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 29 Mar 2022 09:39:30 -0500:

> git@github.com:kleikamp/linux-shaggy.git tags/jfs-5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1ec48f95519bd3e920536118e8ddd30e28cde4ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
