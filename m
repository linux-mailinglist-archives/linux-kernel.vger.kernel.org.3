Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68DD52FFEF
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 02:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347856AbiEVAWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 20:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347815AbiEVAWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 20:22:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006003FBC5;
        Sat, 21 May 2022 17:22:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 819C660EE8;
        Sun, 22 May 2022 00:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4231C385A5;
        Sun, 22 May 2022 00:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653178951;
        bh=uksIx+9OT377IDsqIceomLhankvWe+BJo6pkgd1joDI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IkFCD9NWxpmbJQXU8HNo1IsaunZeUaz+r+khnt2hVfckqrftJOd9TMN/iKKsltxFF
         fwiYmLldmcQ9qeNnUfa5Fp+KUMxKEbFVxIkC/EiTs68rIypfNTvyc9b43IojhRIm8j
         IlaYbXyYmzPZd2gtTGzgzMLcf9cD42FwUIk3YSOcMszs2lXvKquvkXxtP5Js07WlGi
         5E15mdkMSLIhcOy7eOx+Vo6re++MEolksx0KKHjjSvtc1RhFigo0OyntqvFN48TSod
         ujZug13726d2gr41ijwYHquGSOXtOuC1V13goHCn5wS4lMZkh/Ov/vSuYyAqFrcyoM
         4UFxgQ2OTCpkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BD414F0393B;
        Sun, 22 May 2022 00:22:31 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v5.18: 6th batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220521212722.964514-1-acme@kernel.org>
References: <20220521212722.964514-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220521212722.964514-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.18-2022-05-21
X-PR-Tracked-Commit-Id: 51d0bf99b8342be82369aa63eff343bf5df586dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eaea45fc0e7b6ae439526b4a41d91230c8517336
Message-Id: <165317895177.14812.3617530872504754503.pr-tracker-bot@kernel.org>
Date:   Sun, 22 May 2022 00:22:31 +0000
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
        Ammy Yi <ammy.yi@intel.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        Avi Kivity <avi@scylladb.com>,
        Chengdong Li <chengdongli@tencent.com>,
        Disha Goel <disgoel@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@gmail.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 May 2022 18:27:22 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.18-2022-05-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eaea45fc0e7b6ae439526b4a41d91230c8517336

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
