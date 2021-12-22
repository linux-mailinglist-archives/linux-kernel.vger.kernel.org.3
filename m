Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E2F47D763
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 20:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345050AbhLVTCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 14:02:39 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50394 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345002AbhLVTCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 14:02:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42152B81E08;
        Wed, 22 Dec 2021 19:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F16F6C36AE8;
        Wed, 22 Dec 2021 19:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640199754;
        bh=5LMLGKVnXzb+fj+benAhxzo/CmUXZ09/1C28ds+lRUs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=m1RadMQTnyUwr0z/bVrx9igkqkigxYyM4L5eeVsUU5x5I4F0AAqK8i53qV8qP1+VZ
         S19FsMGxl0iQarXAVKGn/DCXYjxfj2OLp4UpRhbNLUF74t95ctwqEADpXzHojLm6yp
         yp3/ttusBDRYDIKIhinMqGT3EBcYktDNs+gCQLV/lOfKbUtyYn0QhtGW/bbU8rwvn4
         mrseNX+AnKHDLbHlLaM0asUuSc4UWCHmXT6hFj7I4kmqvgWGIP+DWEZI5fnWGAmGD4
         7Y34ne8MGyqm9ys6oCphJiBM8ZURB0PE4XTH9nsSdXSA+yFSRjPKnuglA/Swel8Dwj
         bv7ZjoaEZlLlA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D599FFE95A3;
        Wed, 22 Dec 2021 19:02:33 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Fixes for 5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YcKz4wHYTe3qlW7L@gondor.apana.org.au>
References: <20200803044024.GA6429@gondor.apana.org.au>
 <20200830223304.GA16882@gondor.apana.org.au>
 <20201026011159.GA2428@gondor.apana.org.au>
 <20201227113221.GA28744@gondor.apana.org.au>
 <20210108035450.GA6191@gondor.apana.org.au>
 <20210708030913.GA32097@gondor.apana.org.au>
 <20210817013601.GA14148@gondor.apana.org.au>
 <20210929023843.GA28594@gondor.apana.org.au>
 <20211029041408.GA3192@gondor.apana.org.au>
 <20211112104815.GA14105@gondor.apana.org.au> <YcKz4wHYTe3qlW7L@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YcKz4wHYTe3qlW7L@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus
X-PR-Tracked-Commit-Id: 27750a315aba7e6675bb1c3dfd4481c4f6888af1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e19e226345196649e83d49c6997e806a8ecdafe6
Message-Id: <164019975382.26306.11184236689785559312.pr-tracker-bot@kernel.org>
Date:   Wed, 22 Dec 2021 19:02:33 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 22 Dec 2021 16:13:07 +1100:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e19e226345196649e83d49c6997e806a8ecdafe6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
