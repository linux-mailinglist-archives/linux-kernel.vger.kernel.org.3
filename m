Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2759F53D356
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 23:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349506AbiFCVt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 17:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349605AbiFCVtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 17:49:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9E3580E1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 14:49:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4CBC61B46
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 21:49:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24D44C341CC;
        Fri,  3 Jun 2022 21:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654292965;
        bh=GPnkEcm1JeUS8lbB+jIA3iBOOjGFs0gbuJyzslx0PNs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Y8gDA3Qlg6/I+DQVSrGZuc8Jr5qFV5DojbyE4uEhrnoElgWLQY9C2+grrwJQk1dJY
         mXzEapTwCmhoS5CYLuzW3W/tXttrJ52sLFhrKBYLPureAFJ4EEbkKhGmUk8i9+qnPJ
         Dk3+EJl3kg6v9P2MuJc/MQIeBq85lYE99ZZmgXrWmmu1WcDE6aMpppdVRP8nE6fRGZ
         axI+9qwjQBKckiQ88Ajf9xbPp0UVKEWPOeCqydikBusT65pHKjWO2+gnQ/VBH+XJd0
         rC7rdj9GsX41folKRDLJO/ydcnHSi66WIUWsLESHWHXOsnQ35uVrSdBubr/ASnLaxc
         3NxtYYLu1ypFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 10FC9F03950;
        Fri,  3 Jun 2022 21:49:25 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YppGB+DX5lGjlBEq@arm.com>
References: <YppGB+DX5lGjlBEq@arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YppGB+DX5lGjlBEq@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 78c09c0f4df89fabdcfb3e5e53d3196cf67f64ef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 21873bd66b6e6040d95d0a33525ea6933bdc6c71
Message-Id: <165429296506.7657.10828254611888019092.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jun 2022 21:49:25 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ard Biesheuvel <ardb@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Jun 2022 18:33:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/21873bd66b6e6040d95d0a33525ea6933bdc6c71

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
