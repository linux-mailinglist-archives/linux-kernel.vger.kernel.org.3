Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9844EFC55
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 23:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353115AbiDAVrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 17:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353010AbiDAVrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 17:47:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1A410F6D8
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 14:45:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C73E761ACC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 21:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37D97C34110;
        Fri,  1 Apr 2022 21:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648849515;
        bh=0fUF4EqPjHV0qvYjhExxdTo+uUL/LTf2YmAFEyL4srU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QdMXlNVdmdqwNbGqxcDuYKG73r4gDsDsXhMk3t3x05UhSkRuxIoWAaKF1DUilOSvd
         1LZmMWxVf5nXsxKExQaKZWHMz9m1i8pF2XBZ8buTXc35ThAfEBYuTnsJ6z7CMYnx2Z
         gJPZ//sL+qwdSsJsoQ4siXb3eLRTjpgJWBQ5SPDV1Ic2WCu0KtSc4ePb5WUktd9Y4L
         q/lXFuHTGUQX+nQp6pbkh/cVcrF/M/f/FBjPk9KH8X5cg97ttvtaTyKDarLt1t3Ilx
         mxksxttUPwrj52oTEw5LLaSR2Mfg7fFgS4xBP2tHHiUC5CON9ctbHCVzI+SQkUAGOC
         nN7s+N/Hjm+og==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 23D5EE6BBCA;
        Fri,  1 Apr 2022 21:45:15 +0000 (UTC)
Subject: Re: [GIT PULL] XArray fixes for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YkcIKm6hb4jWf9dx@casper.infradead.org>
References: <YkcIKm6hb4jWf9dx@casper.infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YkcIKm6hb4jWf9dx@casper.infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/willy/xarray tags/xarray-5.18
X-PR-Tracked-Commit-Id: 3ed4bb77156da0bc732847c8c9df92454c1fbeea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5a3fe95d76999980a106f661bf70379818a77701
Message-Id: <164884951513.9554.8495281881599183719.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Apr 2022 21:45:15 +0000
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Apr 2022 15:11:54 +0100:

> git://git.infradead.org/users/willy/xarray tags/xarray-5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5a3fe95d76999980a106f661bf70379818a77701

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
