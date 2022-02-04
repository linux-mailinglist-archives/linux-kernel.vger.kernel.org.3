Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADDA4A9E77
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 18:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377268AbiBDR63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 12:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377266AbiBDR61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:58:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562CFC061714;
        Fri,  4 Feb 2022 09:58:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D2F4B8387E;
        Fri,  4 Feb 2022 17:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E46FBC340F2;
        Fri,  4 Feb 2022 17:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643997504;
        bh=HUZCm3jTJk41ScG/NjahE75dhaV2tXUyzE3upfBjpwM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SUvx0PS/Xa0n3eFlQ4YRjcF4dmQY1qt5Pw8ZsI11w76D7LYACbigaffuXqTPlH1hH
         2sEj+v8qB44rebH7FSWjVsF1TBGUFozmDYcqocYkmFoANlOxSpn1CETTShnGiXMq/G
         spIUtXoE2lRd9+KhLA74I61bBvodDhsOetZqzkDvR4i30aeF5rexNLeKqWts+JtZHw
         GFyNdRkYVVxWxsokQI68RGStn9T8uqMMQfsraxpWDdAVZPr2hgD2CYn43+zuG8dVlS
         W73s7zYGeJCgShbNosVJnt7l/t4JyZWCgrWKq0kXcMjy8saApvKQ2je9ABG6oeFZRG
         MITQB3mmPh+fA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C3448E5D08C;
        Fri,  4 Feb 2022 17:58:24 +0000 (UTC)
Subject: Re: [GIT PULL] cifs/smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5muqducHGxPtueahyFbqZZkUr1=04JrTuLEzejj_pKjEJQ@mail.gmail.com>
References: <CAH2r5muqducHGxPtueahyFbqZZkUr1=04JrTuLEzejj_pKjEJQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5muqducHGxPtueahyFbqZZkUr1=04JrTuLEzejj_pKjEJQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/5.17-rc3-smb3-client-fixes
X-PR-Tracked-Commit-Id: d3b331fb51f326d5b5326010bf2b5841bb86cdc6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 633a8e8986eac2c9e32c76ccb9cfe0e5a898b314
Message-Id: <164399750479.18890.2839224296725639418.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Feb 2022 17:58:24 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 4 Feb 2022 00:08:12 -0600:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.17-rc3-smb3-client-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/633a8e8986eac2c9e32c76ccb9cfe0e5a898b314

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
