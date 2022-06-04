Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF1253D88D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 22:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241509AbiFDU4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 16:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241300AbiFDU4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 16:56:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADF02CDD3;
        Sat,  4 Jun 2022 13:56:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C42FAB803F6;
        Sat,  4 Jun 2022 20:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74FD0C385B8;
        Sat,  4 Jun 2022 20:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654376162;
        bh=fzxIdKNBxQYv1bsgYycgDgcXBAeAmjY5gDNOANoX1A4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gT4jQr6qY4XFMQcCen+bkhyfqxIZADqw9xXServfU5ZLKHOxmaiGov4yw7x9RR2Yg
         /btL+Z6YhM4X4Kxjdp1ZTKvEUOTlshXyyfGVSkj2usNF4eXZzX3bnRn7CXgzj0hGp4
         9ud/ghE9mfJdTsMjBR3NWZ5jiuLI+oKvXXEadpr82hUVNeOfscoIdB0Uu7OLzOrqKq
         UePYMEpOdtGXDEGlLa+nCTiuSQNh9Mdear4jdt6yGEfP7G51ddmFaXT/BLDear4Tsx
         u19UPIZ3FUU6+mGwqpYNMxP5FUhZJP5l2KdaxpnxunwwPj1gYQ1nTya1XMP3zOwfDk
         1DJQPlMALA+8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 62E8FEAC081;
        Sat,  4 Jun 2022 20:56:02 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools changes for v5.19: 3rd batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220603223136.554028-1-acme@kernel.org>
References: <20220603223136.554028-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220603223136.554028-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.19-2022-06-04
X-PR-Tracked-Commit-Id: 1bcca2b1bd67f3c0e5c3a88ed16c6389f01a5b31
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 45b2e5ad6837dfe4de6b9028c575bd57c132774c
Message-Id: <165437616240.25005.16223561163619319343.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Jun 2022 20:56:02 +0000
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
        Fangrui Song <maskray@google.com>,
        German Gomez <german.gomez@arm.com>,
        Ian Rogers <irogers@google.com>,
        Kevin Nomura <nomurak@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        Sebastian Ullrich <sebasti@nullri.ch>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat,  4 Jun 2022 00:31:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.19-2022-06-04

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/45b2e5ad6837dfe4de6b9028c575bd57c132774c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
