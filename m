Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55DD54CE77
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348590AbiFOQTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356200AbiFOQSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:18:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C6D49FB8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 09:17:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EC20618C8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 16:17:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F379C3411C;
        Wed, 15 Jun 2022 16:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655309821;
        bh=53U+0p94v4s6WvHvxY6pHhsNI4R1g5VVQhC66Iszj5w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aGO+TCMcVZ0UiD66zVvjx57eZS+9o6UQSGXYff6055XAebUJ02YaMa3EQftsWDOnn
         EundbMmTEV4EwnV+8mWNXPbL8EZkUtHvJOQHrBLDvCaLazuFERHzkBAAAg+X0C7u/M
         TTdNTkXb1931kp6xJ87WLQU3OnZJzubMzOIeuAoP9bNB+ccy4SMScAr66QIqTsni/x
         sElIgrP+wq8GSS6hfBJ0ZubFIn+uQ+X2SUGK7mdDSucRDCiih/k0Cr3fc6GhCYSFqD
         NavstWQq6488s3pFtp7qRWyCSE8Yc+S/oAENvijvOEpOKHfi8x1Sf5VBE50Qe/WjOV
         LK1wjo5cKtzAQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E9A9E6D482;
        Wed, 15 Jun 2022 16:17:01 +0000 (UTC)
Subject: Re: [GIT PULL] fs fix for v5.19-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220615103751.2342910-1-brauner@kernel.org>
References: <20220615103751.2342910-1-brauner@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220615103751.2342910-1-brauner@kernel.org>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.fixes.v5.19-rc3
X-PR-Tracked-Commit-Id: 168f912893407a5acb798a4a58613b5f1f98c717
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 979086f5e0066b4eff66e1eee123da228489985c
Message-Id: <165530982137.22214.10299483244538364669.pr-tracker-bot@kernel.org>
Date:   Wed, 15 Jun 2022 16:17:01 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 15 Jun 2022 12:37:52 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.fixes.v5.19-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/979086f5e0066b4eff66e1eee123da228489985c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
