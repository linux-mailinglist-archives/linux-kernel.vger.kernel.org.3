Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4947750CC64
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 18:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbiDWQnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 12:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236452AbiDWQmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 12:42:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806113CA5B;
        Sat, 23 Apr 2022 09:39:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 195B1B80CEE;
        Sat, 23 Apr 2022 16:39:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8885C385A5;
        Sat, 23 Apr 2022 16:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650731974;
        bh=UPG7CofSXFfKWK0ddl4zCS+NnflrUTaJGnwJWu5sThM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=b01RdLach0P3csMy4cfwzbA7JIr4kCDQDm2BuhBsIegGI9YUhelPrNi1KTuQEmE9M
         MoemXGTl0m0o+UdAWuQIofhFh2aEk12GLU1+1h0jN8j3MfZ4o7P9ePHVN9slXKTxU8
         fcl2VWu8rrXstuWeqMr+PHm0SGk2F0CvNyAA0VFactcNtbPyl1ETp+sxAsiUPNTj8Z
         aYgUCRs0y5jDX9fWSsEaUdNX1Z6AjLrJxECT+jML5sB7EUJ8XPRC8EFokBkOvI4zEi
         9hz8DgctOI+LMOH32IC+7ln+K5e2ENkLDUm0gmUCyFI7D75xMeG/BlnhpPsvkqyMEz
         tvKMIohaeB15A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3706E8DBD4;
        Sat, 23 Apr 2022 16:39:34 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v5.18: 3rd batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220423010046.453630-1-acme@kernel.org>
References: <20220423010046.453630-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220423010046.453630-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.18-2022-04-22
X-PR-Tracked-Commit-Id: 5bb017d4b97a0f135f43ef77091b7edcce4dcee6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 45ab9400e73f34103e73c18a73280c9aa1650e98
Message-Id: <165073197472.16562.6185530869806202112.pr-tracker-bot@kernel.org>
Date:   Sat, 23 Apr 2022 16:39:34 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        German Gomez <german.gomez@arm.com>,
        Guilherme Amadio <amadio@gentoo.org>,
        Leo Yan <leo.yan@linaro.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Apr 2022 22:00:46 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.18-2022-04-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/45ab9400e73f34103e73c18a73280c9aa1650e98

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
