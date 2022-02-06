Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAFE4AB14D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 19:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346675AbiBFSik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 13:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346610AbiBFSii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 13:38:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FD1C0401C3;
        Sun,  6 Feb 2022 10:38:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 801F4B80CF1;
        Sun,  6 Feb 2022 18:38:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A97FC340E9;
        Sun,  6 Feb 2022 18:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644172715;
        bh=7FEeWQsmF4eM1/ZeBEypA5mNtZ0WwaA05qOggnRJY4I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=t+R4ENPGh8QubVUyyes5RRaUmF4YNQTiCFUeldfUm/NCyU3mvY0QMu9LCuQxUumhH
         fP/kERqu47LdftUS8KEI/CabveqpE5kfP4fieI3m4XQ6zTwpa/K9MLY0G80wYaHnjw
         3fu9tmSzfdHZ4otxS6cBP/DcYNo5JH2nko/BjUHWPVjK2cDKkF8jHBDqiU9ObFn2ZO
         dLs7NKrxe+ffGGRXpz9klDDRZ0VuGiz4QY6YGtXVuxqBpkM+4zj8v7U3QRYg0HMMsf
         mNMyNyNoIGSFOGtSdQ+Ps3+yLtpsx7PlYGKmaN0367Ox7bNmZAgZtgZ98Zx/DtysB1
         xuyW4tRfqEIzg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E86C6E6BBD2;
        Sun,  6 Feb 2022 18:38:34 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v5.17: 1st batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220206141927.14216-1-acme@kernel.org>
References: <20220206141927.14216-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220206141927.14216-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.17-2022-02-06
X-PR-Tracked-Commit-Id: fceb62124d8fe1f6fb4b64e8f11c095dca8e7ea7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 18118a4298fd7b0d686ef61be6f2622a77f51b96
Message-Id: <164417271493.9246.3475345199392500331.pr-tracker-bot@kernel.org>
Date:   Sun, 06 Feb 2022 18:38:34 +0000
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
        Ameer Hamza <amhamza.mgc@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Changbin Du <changbin.du@gmail.com>,
        German Gomez <german.gomez@arm.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Masanari Iida <standby24x7@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        Rob Herring <robh@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun,  6 Feb 2022 11:19:27 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.17-2022-02-06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/18118a4298fd7b0d686ef61be6f2622a77f51b96

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
