Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5E7533201
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 21:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241371AbiEXTxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 15:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241343AbiEXTxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 15:53:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DDD5996A;
        Tue, 24 May 2022 12:53:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5333EB81BA0;
        Tue, 24 May 2022 19:53:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A428C34100;
        Tue, 24 May 2022 19:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653421999;
        bh=2bq/6pM1eiRfVNpsd/AZB9LdInGFonZIe5nFXJpMv/A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IZv0l+FPc42Qp/SeBzHk3ERPGYjjziiAyC0OMffpUBbaXQhXyfCoLDN3Z6RiNniHI
         ODdLoOMzTTJh/0NB/Rg0RRzY/uf38SopyjO1UIHTbM/CyEcf3rSd6Lf3xoBjM+4vm5
         xstqFstgMKnjhFsF2AQT0X2lIM2TBYfcvLRvmGjAbN+QD8K/TKKpLYIKz+dqn7uulZ
         ZOjDw90EkWBLSAUQ6WNQgMI2yzOdMZVSEnRPXSSoUPPcqTl7eQPnrdXnOzWJD0NCKR
         uTy6GcNfPjbXlJXGlTrpF0XTjl8Xxw3C3WaDZshadncV2hZ4ry4MM7BOSKOA64eyeE
         wM9U7uPGrKCgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 043C6F03938;
        Tue, 24 May 2022 19:53:19 +0000 (UTC)
Subject: Re: [GIT PULL] kernel hardening updates for v5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202205231146.E8C6085@keescook>
References: <202205231146.E8C6085@keescook>
X-PR-Tracked-List-Id: <linux-hardening.vger.kernel.org>
X-PR-Tracked-Message-Id: <202205231146.E8C6085@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/kernel-hardening-v5.19-rc1
X-PR-Tracked-Commit-Id: ed5edd5a70b9525085403f193786395179ea303d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0bf13a84362e750a90008af259b098d7c0e0755b
Message-Id: <165342199901.18932.10398964285564438364.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 19:53:19 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alexander Popov <alex.popov@linux.com>,
        Bill Wendling <morbo@google.com>,
        David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Yuanzheng Song <songyuanzheng@huawei.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 12:10:02 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/kernel-hardening-v5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0bf13a84362e750a90008af259b098d7c0e0755b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
