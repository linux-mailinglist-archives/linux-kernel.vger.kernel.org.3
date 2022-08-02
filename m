Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7690D5883C7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 23:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbiHBVsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 17:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbiHBVs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 17:48:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C312610E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 14:48:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76D16B82121
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 21:48:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 151ADC43470;
        Tue,  2 Aug 2022 21:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659476906;
        bh=w8af8kMWQ6K2F5BFKhbrmQeTnIMZobTADPycurTr8TI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FE2M+giE6qxLmyDXVBL15K/VOCmV4W4Rl21PHgxjA0j77vk2LPR01iAXwyK1069y6
         MvmHp36K2tQ+DtiFH6Fx1g7ZeBzpvJHRqsRUwv1FZhRd1rlue+yBjvetSnew6W4ojz
         dmSmOathOWS1d6LlctUD1RD53w/76f+ClUi1iLV4lLt5NPlUcCDl54LJX2siTrEXV7
         6dS6Hv9n9I8E12DjWn7ERBQHbcQP52mvd36Xwru5nNXFgbwGOn9zyIat4EOSxA2IyI
         0D7KzG14UHLtG03A3wFtI1yDYrupscb3TYFkBnd+C+/n2FQ6GQpbfkDxZO6/bnF0c/
         XSqnu3pJs1kSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 00BA7C43142;
        Tue,  2 Aug 2022 21:48:26 +0000 (UTC)
Subject: Re: [GIT PULL] execve updates for v5.20-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202208011036.F80AB3F@keescook>
References: <202208011036.F80AB3F@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202208011036.F80AB3F@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v5.20-rc1
X-PR-Tracked-Commit-Id: c6e8e36c6ae4b11bed5643317afb66b6c3cadba8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d7b767b5088d57ff9b5f9a0060c9ad0f9410b1c0
Message-Id: <165947690599.15647.5980474032744855888.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Aug 2022 21:48:25 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Zhang Jiaming <jiaming@nfschina.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Aug 2022 10:37:08 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v5.20-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d7b767b5088d57ff9b5f9a0060c9ad0f9410b1c0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
