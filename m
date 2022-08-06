Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E5C58B795
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 20:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241920AbiHFSTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 14:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbiHFSTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 14:19:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB2A12096;
        Sat,  6 Aug 2022 11:19:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85A016115D;
        Sat,  6 Aug 2022 18:19:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0C55C433D6;
        Sat,  6 Aug 2022 18:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659809970;
        bh=GzeMyM3wJ1P84CG/BoU2WyvfIEHgqNHa/SH83KefuE8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=L+RiD/4fhLmqXVWDO3f84KDsr7aKpfPu9vlh6BNf7juf+wzzo/yADNtznPqg5fu7W
         kBqjrJTTHTycFEoVH+j5NWpNofSTBDcV2UwakMZx/GM3qARA/ctHrY8Il47TW7aDhj
         mmX4Q7Bxaya+WtobZYA/Ryw/CQco18bGAzchxXsrDkvcEpa4gVVUosKntsw4SIXhgo
         i5L7CWaGAly9r/K06DxGRGMSR/iRlAqzbyW7JoYRdgwJkfIMIMYDpXpL+AgXCgxwzm
         7lM3gpCRAuHbHK74usrBr+OtWnxNNMo8ZPKwtD+QLB9tVR6ORgG45v09BxZVFNBF5R
         3aKss+D3SxICQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BFD00C43140;
        Sat,  6 Aug 2022 18:19:30 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools changes for v6.0: 1st batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220804213457.500335-1-acme@kernel.org>
References: <20220804213457.500335-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220804213457.500335-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v6.0-2022-08-04
X-PR-Tracked-Commit-Id: bb8bc52e75785af94b9ba079277547d50d018a52
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 48a577dc1b09c1d35f2b8b37e7fa9a7169d50f5d
Message-Id: <165980997077.27284.581164792704578757.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Aug 2022 18:19:30 +0000
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
        Adrian Hunter <adrian.hunter@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Blake Jones <blakejones@google.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        German Gomez <german.gomez@arm.com>,
        Ian Rogers <irogers@google.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "Shawn M . Chapla" <schapla@codeweavers.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
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

The pull request you sent on Thu,  4 Aug 2022 18:34:57 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v6.0-2022-08-04

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/48a577dc1b09c1d35f2b8b37e7fa9a7169d50f5d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
