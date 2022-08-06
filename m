Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1007758B88A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 00:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbiHFWIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 18:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241852AbiHFWIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 18:08:39 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC5210FDD
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 15:08:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 93E59CE01BA
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 22:08:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DED4DC433D6;
        Sat,  6 Aug 2022 22:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659823714;
        bh=nHw83sQdZQ6G7dhReEL62mbCqyWazTW4ITBeXm+A0x0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=i4d/oF4IJ6QI3BeKHNz4xoM48ttviI1RpXrMQDjpDNk6QvXDNDConMTKYXF9A7HDc
         MK/0GPfk/GSFgEpSrBXNU7Wv95zcpbGj0VM7veBj4bGmY3iA0F+aAZAldDs3seiUQU
         9chPKMFeNsYC52SG8C2wCVNfPQLGuPOP8wj6GEp0Z3UWefJ2R5IiofOTuSHxMU/3++
         I9RUgBm7r7SNauABaJByQs/PU+Y6GA86wtCZfSeOdJ583lmQrJ331C7PgFkiETjEUc
         au/10RdQ3z8dr92IMSvUOGoZ7UAXyXZXg4JQ7PD/KH4R2aWWwwpHmIO/2bxVWeN15j
         pBySaF874I73A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0369C43142;
        Sat,  6 Aug 2022 22:08:34 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2 fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220805201248.123846-1-agruenba@redhat.com>
References: <20220805201248.123846-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220805201248.123846-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.19-rc4-fixes
X-PR-Tracked-Commit-Id: 446279168e030fd0ed68e2bba336bef8bb3da352
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c42b729ef6bfc72fed56f81f589a39298b9d12c8
Message-Id: <165982371484.16627.9098253173243829418.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Aug 2022 22:08:34 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  5 Aug 2022 22:12:48 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.19-rc4-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c42b729ef6bfc72fed56f81f589a39298b9d12c8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
