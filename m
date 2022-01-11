Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF38D48B903
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 21:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244851AbiAKUyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 15:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244632AbiAKUxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:53:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6F4C03400A;
        Tue, 11 Jan 2022 12:53:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 812B5616B7;
        Tue, 11 Jan 2022 20:53:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 548BCC36AEF;
        Tue, 11 Jan 2022 20:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641934390;
        bh=jxUZ606xjHrygy5OsIYobq3FoIFdtp2RDbu5bAsla3Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=D87y6895m5UlKBGi3p/oY9+BEo+9XDdwGOoeRv8aUTIo08rN3b3aagHZdY2ekU7tE
         5QGiwhSthYtLuP9M+TokPvnzWy3kbH0jZnDr4j3CXT+3nu4OmMSnpXskOTbPJmmB3A
         yepxsOrv1i0U+9oo1TTV6Cyy6vrHySxS7rdqWS+rbBMAihGhozBmnTlT5cN3U6eLE6
         iE8daQ6tphrpjVCz3BxjBes9rO0HDzF8c5cCIzX4PO2WVirQEEWnJmvALmaJ560rpc
         F5tTy28znACMcLO/zFitB5bbybnn9E6dy2fNKf4GRKlJFsoQvQRO6bdZzyIYdTbi9w
         3xHvo9kuQMsTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43D98F6078C;
        Tue, 11 Jan 2022 20:53:10 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Update for 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Ydzlo+UmL5bbDgUZ@gondor.apana.org.au>
References: <20200803044024.GA6429@gondor.apana.org.au>
 <20201012033249.GA25179@gondor.apana.org.au>
 <20201214055515.GA14196@gondor.apana.org.au>
 <20210215024721.GA20593@gondor.apana.org.au>
 <20210426123200.kgbyk6ayey4l4lrw@gondor.apana.org.au>
 <20210628110050.GA12162@gondor.apana.org.au>
 <20210830082818.GA30921@gondor.apana.org.au>
 <20211102035201.GA23331@gondor.apana.org.au> <Ydzlo+UmL5bbDgUZ@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ydzlo+UmL5bbDgUZ@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus
X-PR-Tracked-Commit-Id: 5f21d7d283dd82865bdb0123795b3accf0d42b67
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5c947d0dbae8038ec1c8b538891f6475350542ee
Message-Id: <164193439027.11435.3994810490249594244.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Jan 2022 20:53:10 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 11 Jan 2022 13:04:19 +1100:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5c947d0dbae8038ec1c8b538891f6475350542ee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
