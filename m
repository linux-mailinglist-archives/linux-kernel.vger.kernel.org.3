Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C7858F266
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 20:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbiHJSd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 14:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbiHJSdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 14:33:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28628C007;
        Wed, 10 Aug 2022 11:33:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 418BB61387;
        Wed, 10 Aug 2022 18:33:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F59FC43470;
        Wed, 10 Aug 2022 18:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660156418;
        bh=3LQE8e+xAar+8oMfHFeV0FMZ51q6xZjbB19S3+NkmmY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Plc/e3kdu7lz38G7TpNpj9ZsfYGHrBLDWyGw8HixJ85/1gvkazb/mCd/Ccqf9W6om
         HL6fIaXrg7OxvcL7zL2aL4wGr34LVs4xJymooCMF4DJhDNAq7XEoWVMN7ovynkukbc
         CUsuDC3LMCORJwxuaZRNjYv5CL+XJEaOjt5g8eEfBlF2gN+cLvkz5KoyR8JzW/UYAW
         igVdZNqlZ3OjVDcP6Q8La3BgwIlUtRg2jhB8x+bRCvJ0vQw8S10w+R0tcaiCwJT7As
         7wW+2E7bV7n8NPdov36oc9yN2fImQU/TEH0Ee3zSy99lDH5suCpeYiUL4QhVhrVDLP
         syxninomwIlcQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8867EC43141;
        Wed, 10 Aug 2022 18:33:38 +0000 (UTC)
Subject: Re: [GIT PULL] Kbuild updates for v5.20-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNATwE1L4oS6R=7gHfiE6+9Dksvtvu-BGE07N6=JHVQ5hKQ@mail.gmail.com>
References: <CAK7LNATwE1L4oS6R=7gHfiE6+9Dksvtvu-BGE07N6=JHVQ5hKQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNATwE1L4oS6R=7gHfiE6+9Dksvtvu-BGE07N6=JHVQ5hKQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-v5.20
X-PR-Tracked-Commit-Id: 672fb6740cbfde34f4d367ffa3c939b608a927e1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0af5cb349a2c97fbabb3cede96efcde9d54b7940
Message-Id: <166015641855.32353.7374106395383229409.pr-tracker-bot@kernel.org>
Date:   Wed, 10 Aug 2022 18:33:38 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 10 Aug 2022 02:06:51 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-v5.20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0af5cb349a2c97fbabb3cede96efcde9d54b7940

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
