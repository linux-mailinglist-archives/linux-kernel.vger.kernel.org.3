Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63644ACA45
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 21:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241733AbiBGUSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 15:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241810AbiBGUOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 15:14:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E29C0401E2;
        Mon,  7 Feb 2022 12:14:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A72361460;
        Mon,  7 Feb 2022 20:14:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86371C004E1;
        Mon,  7 Feb 2022 20:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644264884;
        bh=vKsG/uWUXHsAh6WfbSKrv7geN+bm6kyGW2sX2wduaHk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ooAddBWVEWxEcID4bcrIu3Q2BB1KeBVccs5tkcBCwmfh3+bKNdT6VXsSvLzFjryE8
         pPmSa3DvLZ0XuGKkMy1H4HnU5Yf6/F8z/N0MoIqyWY3GpicbSQ5p8gkTipuNeDK/ca
         DhbaH65DSYy4Xo6f/us4XGcah52VQEBN9HXzjL8ZyQ2WJO+8q8+VlUgKzxUe9MgloA
         HRpumgyC61snW9Blf2NI8wbPmA8j8/mKcw5t8CFhH7EE1APDURMNdC9RQWeY7lmfO9
         XpaPP2IIrF+zn4X0yKQxfdr2CuowHlAOPiIiD1qXafoJhaozJydpA40uaPBNGT4kho
         sIP7ZX7hNINlg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 76596E5D09D;
        Mon,  7 Feb 2022 20:14:44 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v5.17-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220207112605.246647-1-ulf.hansson@linaro.org>
References: <20220207112605.246647-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220207112605.246647-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.17-rc1
X-PR-Tracked-Commit-Id: bd2db32e7c3e35bd4d9b8bbff689434a50893546
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 51f7ea914d79aa44156dd63fe9e1cc75708d781d
Message-Id: <164426488448.18191.15469163597693131085.pr-tracker-bot@kernel.org>
Date:   Mon, 07 Feb 2022 20:14:44 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  7 Feb 2022 12:26:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/51f7ea914d79aa44156dd63fe9e1cc75708d781d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
