Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63952534328
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 20:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbiEYSiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 14:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343805AbiEYShw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 14:37:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F1CB82E5;
        Wed, 25 May 2022 11:37:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB914617D9;
        Wed, 25 May 2022 18:37:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C87FC385B8;
        Wed, 25 May 2022 18:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653503855;
        bh=yjw68vrdFW3l3zBArE4VuOiW3qBA6+hJaHYq/yy95to=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eXkYziJK5LDYL2wXYmSn78/yirAlm8zk6M9N0AmPI/nSztk4p0DL1SFknZXEO4wXx
         yxgpe3hBxr9SnHZaCguLsPpHMuCeJkBTG1hEoAqKy1B7eFQRlhjSXnJtHQnkzRyfTY
         ex64CMtA39Ap/VIiBsvTAGCfOvQXHp/Rb5DE+CG58BzaoKxzo8W52PlmPCb7x5E/EI
         DBoYm+NNfANIi7ZeoitRkVsHRAUDix/hrOOhtsuP8dMCNjYlW4S9bLUHmCOidjfIcv
         FpillyJYPZkg1Wl30bj0k1JPO2A91xmOZLPiTVQbvX2pfHPqoxGc0R8EuNmpt2/H+w
         pbnZfdN0goqkA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4AB6EE8DBDA;
        Wed, 25 May 2022 18:37:35 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87wnecgsnx.fsf@meer.lwn.net>
References: <87wnecgsnx.fsf@meer.lwn.net>
X-PR-Tracked-List-Id: <linux-doc.vger.kernel.org>
X-PR-Tracked-Message-Id: <87wnecgsnx.fsf@meer.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-5.19
X-PR-Tracked-Commit-Id: b86f46d5ce3e7497930be931a9a9e57480f0baff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 88a618920e9baabc1780479e2fbb68e5551d0563
Message-Id: <165350385530.15754.14984172251166457488.pr-tracker-bot@kernel.org>
Date:   Wed, 25 May 2022 18:37:35 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 09:44:34 -0600:

> git://git.lwn.net/linux.git tags/docs-5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/88a618920e9baabc1780479e2fbb68e5551d0563

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
