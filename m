Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595AE4716C2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 22:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhLKVew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 16:34:52 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:48942 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhLKVev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 16:34:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 00F5ECE09E6;
        Sat, 11 Dec 2021 21:34:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21CE8C341C3;
        Sat, 11 Dec 2021 21:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639258488;
        bh=YunQb4XDokziDarP76FC3zXnpXPE1nnGHVBoKCZ5Iik=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bmET9rNcUQKjqkcCPX1ZALmSAICUErLObalALA8shn0sARuxMVzNRnUjQKXgOItZn
         HuWKHWVBLtDOJwakae2/1GIJXF0Pb+KEvcAg3HWv8PS1sFKTcX4UPfzAUOiF/BqlIy
         8UagVvtg9mxhxdQt+mRiZxvk/fLz/ygZnpGTZjAdq6ixMIrOr6ysbg74ztcxN5s/lj
         Vrjfd8zSuRRpnaijksEmVdsVB6OrPJjFBoamwVHBYtURlNuDYAogW2wlTC2Cc3Xgio
         PZkhQUhnP63pUL6WhbvlpffTZnk5Wz4og0+6B6LnD7mBLQ4DNPfbtq5HWoIlIf1Wm2
         uFhAbsltGsvfw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id F225860A36;
        Sat, 11 Dec 2021 21:34:47 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v5.16: 3rd batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211211153649.468266-1-acme@kernel.org>
References: <20211211153649.468266-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211211153649.468266-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.16-2021-12-11
X-PR-Tracked-Commit-Id: 9937e8daab29d9e20de6b7bc56c76db7a4eeda69
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bbdff6d583be718935b613ab2a966cddaadf661f
Message-Id: <163925848793.7097.13552881636016347356.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Dec 2021 21:34:47 +0000
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
        Alexandre Truong <alexandre.truong@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 11 Dec 2021 12:36:49 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.16-2021-12-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bbdff6d583be718935b613ab2a966cddaadf661f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
