Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D27C5421D4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiFHFAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 01:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbiFHE7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 00:59:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E31A277FB9;
        Tue,  7 Jun 2022 18:30:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3F1F6194B;
        Wed,  8 Jun 2022 01:30:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D367C34114;
        Wed,  8 Jun 2022 01:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654651804;
        bh=Hb+BN4EbTI7oHbNdiClO0nwi6BMjuaLDtiOn5aXUWjI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kAO87fxpwyta+zT4FPAxocJDpJxU4nfDtVC/aBPVT8FpAiVXPI03yEejFGiyhJLsk
         LGqTMrJfThn3mDY9r1g1FASo4bQPA7+UB2aOnnVe1XYUhCmIg56iqs0r+CxS6EDlFD
         yHEYzLjeXBjoaCH9lLy1H+B96Sxm3gwc44pbkO4uB1mUybT7hir0flhuYHSXosEncf
         zC+wsws6e7QQt2OJWpbzTvDI3agiUu3S5HRu1Y3ipsPIOC6C1f8nOzVkIHSqsD/0Bz
         CRQO7vdh4hGhlGs1+jRRznk264lGEHoYpdZbi/mPBzoaUrTo9/jmcgcqEXgr7MG5Wc
         QH6plDPXo90WQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3ED58E737EF;
        Wed,  8 Jun 2022 01:30:04 +0000 (UTC)
Subject: Re: [git pull] Input updates for v5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yp/AGMpXXnx9lW6j@google.com>
References: <Yp/AGMpXXnx9lW6j@google.com>
X-PR-Tracked-List-Id: <linux-input.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yp/AGMpXXnx9lW6j@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v5.19-rc1
X-PR-Tracked-Commit-Id: 6ab2e51898cd4343bbdf8587af8ce8fbabddbcb5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9886142c7a2226439c1e3f7d9b69f9c7094c3ef6
Message-Id: <165465180419.26354.5340851139035739936.pr-tracker-bot@kernel.org>
Date:   Wed, 08 Jun 2022 01:30:04 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 7 Jun 2022 14:16:08 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9886142c7a2226439c1e3f7d9b69f9c7094c3ef6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
