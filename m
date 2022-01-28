Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 321CD49FE5F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350299AbiA1Qux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:50:53 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45142 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350285AbiA1Quv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:50:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC190B803F5;
        Fri, 28 Jan 2022 16:50:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 784C3C340E7;
        Fri, 28 Jan 2022 16:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643388649;
        bh=smEkud7X9ftSoEuVSWS02b91dG/kVYHJjeJXXQIQpXA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Drk1QpTphiURlgVVx1LtZiOFbYB11ZZVor8/vWz2dshLmzR8WjudJg25G9Dmw1T4o
         bFqtKH7WXm/kZF/4mSufyVfxwdtxlvBiVgNg13IpsP+9bQvAESqjUzYmUpGccJAn07
         AjT4ZTP1znL6v3WG1WivTw3YP1gUiJyR1Jv2y6H9jRVz8ruBhJZsEvpRh/dEARjww/
         wxpaiDOHzRNGei/N5pHmwFWt8R5G0Rv1hmd9fyIKkji6AdXp72Gr5hnggB0uTb6uTg
         JJwq7gjTW8BJFzk18YzE0hUZR2sPDU2M0wGv6gG5nKC5fH/pbKBsEktEdCtATXySgu
         1nCU0V7/+TsqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 610F1F60799;
        Fri, 28 Jan 2022 16:50:49 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph fixes for 5.17-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220128160805.15166-1-idryomov@gmail.com>
References: <20220128160805.15166-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220128160805.15166-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-5.17-rc2
X-PR-Tracked-Commit-Id: 4584a768f22b7669cdebabc911543621ac661341
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8157f4707360a17027538fa43b1b89b534c65eb9
Message-Id: <164338864938.23534.17568067929652887219.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Jan 2022 16:50:49 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Jan 2022 17:08:05 +0100:

> https://github.com/ceph/ceph-client.git tags/ceph-for-5.17-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8157f4707360a17027538fa43b1b89b534c65eb9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
