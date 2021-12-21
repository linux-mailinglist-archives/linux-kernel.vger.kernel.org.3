Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB34547C51E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240450AbhLURjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbhLURjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:39:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C169C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 09:39:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6BECB817D6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 17:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FEEEC36AE9;
        Tue, 21 Dec 2021 17:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640108388;
        bh=A7aGEyolWlrfaYondm7uktaXGE/MJXwksfsRNu2ubBw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ODU0pirOMlt3QCxgxEjfAEnm3f7mW+SGkYiUSl7+seVYRzlKv7OI7NnrQ+YYIVizm
         am23XA3XjKxTlq2Y2GSQUPflNiUfoWY8GbvESk1t9aEtBfY3e/qvHqF1Htp6BYtC+3
         RO9AAPOeDGvN6LTx51bipACGBYS/1BNKqtdjwlFqZyUGN0XH478g4v73BhKtflAXWC
         lhqvnnXY6+zECJFnUIXdNtGJS2oAqgeQ5qjVMPc5jQ8xrgn+KkxUbMzkLXV9gHl6YI
         WSa3YPx9Yfe2yGVFfkhjSPLcXLvceH5sHRxKUBGOWBvHZYO2HmEKkSFqJhiCe1BTvG
         gVEfyofnhAF4w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4D77B609CC;
        Tue, 21 Dec 2021 17:39:48 +0000 (UTC)
Subject: Re: [GIT PULL] HID fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2112211532410.16505@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2112211532410.16505@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2112211532410.16505@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: 13251ce1dd9bb525da2becb9b26fdfb94ca58659
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1c3e979bf3e225e5b4b810b24712b16254d608b6
Message-Id: <164010838824.5823.16667886971940272334.pr-tracker-bot@kernel.org>
Date:   Tue, 21 Dec 2021 17:39:48 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 21 Dec 2021 15:40:27 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1c3e979bf3e225e5b4b810b24712b16254d608b6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
