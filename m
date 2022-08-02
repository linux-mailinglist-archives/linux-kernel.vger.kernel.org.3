Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC32588445
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 00:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237144AbiHBW3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 18:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236422AbiHBW30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 18:29:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8E154CBE
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 15:29:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5CA9B81FDE
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 22:29:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9CC63C433D6;
        Tue,  2 Aug 2022 22:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659479363;
        bh=luJc296e6xh942XsPLfsEB4QpgWG3WUxcEAN5C7UMQs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fglrW0iv/DcmGr9tA6DRRASSm44aT8+yTh/LPNW9gjIVQhVJB5+ePW9I4QdltplLe
         zx/oHfNh6jYRpT8OCMn0jfR7Np/GcYQeg5j3FS2CYBtNJquKzRBZpy42kRHim2m9cp
         okWm1/FWsLQe+hrc0ZtATmYj2qWiIOiHE+xBDvoR28Bc4rQ0kb3ilsnk6XCd1OYgQT
         3MTtczkPvOVsIuqvRqXYImPVn/xtVTX1iBGzuhK36K67z0hyAyWiIWnbTF9zGeRO4v
         EjMTCw3II6GWQGs2zlIkHa1dvy+gGB+SfaUzv99R59UuADum4LP/L5qlRSIWzek8s1
         cXgMV5JSlLQ9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8B06FC43140;
        Tue,  2 Aug 2022 22:29:23 +0000 (UTC)
Subject: Re: [GIT PULL] Audit patches for v6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhTzrgsDuSgQSAJyJ=E9q5VsLqvms8n83WS3oMnFJtxf7w@mail.gmail.com>
References: <CAHC9VhTzrgsDuSgQSAJyJ=E9q5VsLqvms8n83WS3oMnFJtxf7w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhTzrgsDuSgQSAJyJ=E9q5VsLqvms8n83WS3oMnFJtxf7w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20220801
X-PR-Tracked-Commit-Id: 546093206ba16623c18e344630dbfdd71a4327e0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f42e1e3e40da02924e29987c5b721c0932d9b380
Message-Id: <165947936356.5634.17684890078409606517.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Aug 2022 22:29:23 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Aug 2022 15:52:12 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20220801

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f42e1e3e40da02924e29987c5b721c0932d9b380

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
