Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25DA4C38E4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 23:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235643AbiBXWlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235618AbiBXWlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:41:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8C720A961;
        Thu, 24 Feb 2022 14:41:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEAB961B5A;
        Thu, 24 Feb 2022 22:41:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71E5FC340EF;
        Thu, 24 Feb 2022 22:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645742480;
        bh=6bHoV+lUxtRfl3apjlzEPflf4+DoMaFgFMJBftrb0aM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Qxv1L9oFseVqYlkFcFdKqLoFb7SgGOtg7wrvdTKw+vHxmdrXk/BSZfl4Bn/zb+uag
         gE24XnqCnlOFQruBYTcAx3fGEMCOFwXQBWlYj2qcRJiKilY510MAWEBSy/xfW6Csbs
         RgLDoZ3dvjIB8tai/s4sd3zjuEdsMhlZES6oIXGmAuyR+RVuWp6ei98spU8jxMm5Jp
         H+18QdCqqH/31iPY+mFbuGS/hWkrKVf3nFp99f5RWAIF7BxOi/O/NppHKjbk+9zQ4f
         Y2gzQ/1ckAMD/krHTQSVkZliilQcps90ZgCXIWLtCayQJu+iijPpqznPKH14FiZsMH
         sWfyrt6OQBeWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5DA02E6D3DE;
        Thu, 24 Feb 2022 22:41:20 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v5.17: 3rd batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220224184122.510643-1-acme@kernel.org>
References: <20220224184122.510643-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220224184122.510643-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.17-2022-02-24
X-PR-Tracked-Commit-Id: 13e741b834538a225512912608f0182079fc64e2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ee022567bf9e2e0b3cd92461a2f4986ecc99673
Message-Id: <164574248037.13100.2233624727906017520.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Feb 2022 22:41:20 +0000
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
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
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

The pull request you sent on Thu, 24 Feb 2022 15:41:22 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.17-2022-02-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ee022567bf9e2e0b3cd92461a2f4986ecc99673

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
