Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFE148DE1A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 20:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbiAMTXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 14:23:15 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33182 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbiAMTXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 14:23:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC534B82347
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 19:23:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84FE3C36AEF;
        Thu, 13 Jan 2022 19:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642101792;
        bh=hLPuL95OV1dnfOjmj+JSSTV8UddDJFQStsMcKmur0+U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Kp/e9AiAjMrnUf4CjN+eZQKDZQoqEgjEl/l1DfcaNGN5Z855lpFkM9rsg6vlhnO4D
         PgEW0EiVEUgjvI8rLln+BPhuzhPKIXvjsGnQ2l5F8zzzZ7pTfPT0Ignc1EJ/rUyS/f
         zJRsxZayYeXLBzchTfaTB6Dv3o/Z2f2kqg5JhsWUm/xs58YBN4Nr58Bepvh0K19zdt
         rz19WHOA3n4/8FFXp6TRrJn0nCZz0YcHPEOemcUBu8cnKIlPTUu41AkW7BT7Et/AQo
         VSsufE6UplwsGvEZKowyTxjLJrXuPiiGS+FzxxfjyBebD5OVPL/Xwb0zT2YGl+ZKnv
         /OgFe6adaYoqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D100F60794;
        Thu, 13 Jan 2022 19:23:12 +0000 (UTC)
Subject: Re: [GIT PULL] Mailbox changes for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CABb+yY3o9pOY1EbedNRM_++MxM8TNFrB3EbrZ+07h_p3O4i1LA@mail.gmail.com>
References: <CABb+yY3o9pOY1EbedNRM_++MxM8TNFrB3EbrZ+07h_p3O4i1LA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CABb+yY3o9pOY1EbedNRM_++MxM8TNFrB3EbrZ+07h_p3O4i1LA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v5.17
X-PR-Tracked-Commit-Id: 869b6ca39c08c5b10eeb29d4b3c4bc433bf8ba5e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fb3b0673b7d5b477ed104949450cd511337ba3c6
Message-Id: <164210179242.5840.17018685949925089577.pr-tracker-bot@kernel.org>
Date:   Thu, 13 Jan 2022 19:23:12 +0000
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 12 Jan 2022 20:28:54 -0600:

> git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fb3b0673b7d5b477ed104949450cd511337ba3c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
