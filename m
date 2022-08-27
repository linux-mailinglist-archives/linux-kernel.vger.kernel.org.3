Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DB45A3A6B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 01:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiH0XH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 19:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiH0XHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 19:07:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A4D29817
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 16:07:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A384F60ED4
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 23:07:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18246C433D6;
        Sat, 27 Aug 2022 23:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661641643;
        bh=mvwtv0FEWGf6ATagIKJswwAtwI9gWccoZkOb0RV3LV0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LKvR/eqF8nhyiLiomaz+ylTlEvd8FnehBaYFzmhgGE326UFFEv0rb1rYiYYPQ5Ab1
         Kj3L5+sA6yNiKTo1vsCNAY5CrjAJiVq5NLpn5anEhuxBcFvZboT1+Q8lY3DJVmzbGH
         AmQ2OLW8fJs0z2Ey9FTS4X51ckrDqbLTvNODiw1HmeMtUdMZ79tYKehZPO5QVjvcn0
         GsfT3LuJA3wbdARNXQto8qj6Ao5NeB0cgPLxh/Yuq8Oq15+qDnJcHELgHCVBB8UeYa
         +vg53mqNGjtm9rAQ4blNR3lcom2MxKf82V96qREggaM6ac+VSIPLhDLCVie82Ucla3
         lsFh+ooCfl3Ww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F3747C04E59;
        Sat, 27 Aug 2022 23:07:22 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.0-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220827083044.5631-1-jgross@suse.com>
References: <20220827083044.5631-1-jgross@suse.com>
X-PR-Tracked-List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
X-PR-Tracked-Message-Id: <20220827083044.5631-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.0-rc3-tag
X-PR-Tracked-Commit-Id: c5deb27895e017a0267de0a20d140ad5fcc55a54
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 05519f2480a3e71053b892d4ea864e641949a77f
Message-Id: <166164164299.8591.10674223294345540484.pr-tracker-bot@kernel.org>
Date:   Sat, 27 Aug 2022 23:07:22 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, sstabellini@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 27 Aug 2022 10:30:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.0-rc3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/05519f2480a3e71053b892d4ea864e641949a77f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
