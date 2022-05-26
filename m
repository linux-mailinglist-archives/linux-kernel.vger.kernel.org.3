Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912885353DA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 21:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348738AbiEZTTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 15:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348727AbiEZTTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 15:19:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96F4DFF67;
        Thu, 26 May 2022 12:19:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 497EA6189F;
        Thu, 26 May 2022 19:19:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8ABD0C36AE3;
        Thu, 26 May 2022 19:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653592771;
        bh=KS2McsxhBLS7+hWpeP3BPcJfV6sieAyneyqr3xrIZI8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JU6KAJom5njyrHmrm5M3d45ZyE81I8/+y1ZD+XOKWjI3TGQ/K41Fpask9vMCEwuT4
         EWlg+FBnsYVYxeGIXzXq//0AnvDQTCjzjrFQsdGxpAReWxtF2Y2KWCJiQK3X8NYKFb
         oNSuXTFsS/kwejtgzOIE+SMicOgug17pxne37hrUoZzCrrMtE+puT2LXKl/dYzgjrn
         dK/1gNuvwo2CQMsUi+udFy9MHhZ5Ppso+GfcvNE+gOLvmtFfpONM7Ki8RL1Rh2O/Yy
         jBaikTIOOhOYF36Xu3OSBT43yn9w9KUnpA1g81k/BPSXLFBJlmR8w82fMQX4yR5y1k
         m3P7y6Q0+hrpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7812DF03938;
        Thu, 26 May 2022 19:19:31 +0000 (UTC)
Subject: Re: [GIT PULL] Kbuild updates for v5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNATy1o89+KwgDmJ3tDDxnF2JvhVBm702JbRe6jREWH8MYQ@mail.gmail.com>
References: <CAK7LNATy1o89+KwgDmJ3tDDxnF2JvhVBm702JbRe6jREWH8MYQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNATy1o89+KwgDmJ3tDDxnF2JvhVBm702JbRe6jREWH8MYQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-v5.19
X-PR-Tracked-Commit-Id: 5ce2176b81f77366bd02c27509b83049f0020544
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: df202b452fe6c6d6f1351bad485e2367ef1e644e
Message-Id: <165359277147.21112.16821078324624291969.pr-tracker-bot@kernel.org>
Date:   Thu, 26 May 2022 19:19:31 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 25 May 2022 23:37:23 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-v5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/df202b452fe6c6d6f1351bad485e2367ef1e644e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
