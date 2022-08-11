Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60F2590535
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 18:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237094AbiHKQ5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 12:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236756AbiHKQ4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 12:56:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30797D86D9;
        Thu, 11 Aug 2022 09:29:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91094B821AD;
        Thu, 11 Aug 2022 16:28:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4594AC433C1;
        Thu, 11 Aug 2022 16:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660235337;
        bh=3+ho3jN/CyJOCje1s1LNU0zm5QUTd8ipkfPq+/Q0vgs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uuD7CSDCyZ0KzpuYUQIqVqnqgUhGMjIdTeX0syj2elNormVH8lZj8Jd2vKIPglM1m
         9uigaBEic1/toShAdfypI88StXkbkGaL7jm8UcLM1ji/cSNN4r/TIPYWd7UTpeID0i
         KHtF6d/T8M+urPRPLKeNsymYwa3khsmIfgY2bRZmKQ4M7T2fEOqEE++uUlhsMIRpx7
         QI3rTB6E9Fd1Shj+b3uVp8NHf18YZKLZvt3OF6Lsp7rarYxqgVZZ/POAhz0MSf/HaL
         uq+PW10p7Vw9rWUHhXoUKFEqwWwrLhadNSI2DBbeyqWOuPrm4b/vgHAbHguvn/cvX6
         71I/arFz3XACw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 34703C43142;
        Thu, 11 Aug 2022 16:28:57 +0000 (UTC)
Subject: Re: [git pull] Input updates for v5.20-rc0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YvQvwNqu5sxr36Th@google.com>
References: <YvQvwNqu5sxr36Th@google.com>
X-PR-Tracked-List-Id: <linux-input.vger.kernel.org>
X-PR-Tracked-Message-Id: <YvQvwNqu5sxr36Th@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v5.20-rc0
X-PR-Tracked-Commit-Id: 8bb5e7f4dcd9b9ef22a3ea25c9066a8a968f12dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2ae08b36c06ea8df73a79f6b80ff7964e006e9e3
Message-Id: <166023533719.23214.12182678886174197132.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Aug 2022 16:28:57 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 10 Aug 2022 15:22:56 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v5.20-rc0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2ae08b36c06ea8df73a79f6b80ff7964e006e9e3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
