Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A77758B8CB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 02:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiHGAu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 20:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbiHGAuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 20:50:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B5FA0;
        Sat,  6 Aug 2022 17:50:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4297360CEE;
        Sun,  7 Aug 2022 00:50:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10598C433B5;
        Sun,  7 Aug 2022 00:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659833411;
        bh=86gdex+fUoDkvlLaQDim3x6WVXmrAW4Eob2xLKUi4ww=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=M7ovEBU11VvCyilmAwqqRDuYGTyWd7EpvXliLSK56F4jb/w2xdjGUOxyRHKdA6RnR
         0yx884gvVmr0uHmonFnlDCQjBJcEPKh6NOMJkwQd9pRE1kh685qBkZ01A1J6481Zxz
         dlzaeN77bwAvWU+uJ4b9AcWYGvN2q60Qkq21sJBV+fiK9pkwuqKVAR9sZUyZfKtE/k
         o7Y6rfqcAeqAo1WhIxHC/SLDrU4RHpTvmGD+5AjoL7ycnCIPBeCeywd41Ts02YjAJP
         xSQDYfBno3azKhVUNCLlNTZlSjDZkg5DNERy9kqyKzJLsTbixw3JA+p703e4mLLbaq
         MVAZvWgZkXvJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F18F2C43140;
        Sun,  7 Aug 2022 00:50:10 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 5.20 merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yu4uUqpvcXGfGpy8@tuxmaker.boeblingen.de.ibm.com>
References: <Yu4uUqpvcXGfGpy8@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yu4uUqpvcXGfGpy8@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.iov_iter
X-PR-Tracked-Commit-Id: 953503751a426413ea8aee2299ae3ee971b70d9b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 24cb958695724ffb4488ef4f65892c0767bcd2f2
Message-Id: <165983341098.27609.12940403492622309959.pr-tracker-bot@kernel.org>
Date:   Sun, 07 Aug 2022 00:50:10 +0000
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 6 Aug 2022 11:03:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.iov_iter

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/24cb958695724ffb4488ef4f65892c0767bcd2f2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
