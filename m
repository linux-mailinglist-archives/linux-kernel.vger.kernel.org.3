Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6C9489F34
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240183AbiAJS2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:28:02 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43644 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241513AbiAJS1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:27:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B08A6B8174B;
        Mon, 10 Jan 2022 18:27:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 857FBC36AE3;
        Mon, 10 Jan 2022 18:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641839273;
        bh=MRAtAKsifPv7LtwI5VAsM5XI73L03Lnuv4F8W3ubOYo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=U7dYB14BzDmi/UU7P3kmRXXWHajxTqY4bCWdAbyZedtD6Wk6so9SaEOS2I7ETHH4i
         nEdkIpqCWRgLf+xp3Og8hgPZILbv88r2iixgQ3iv6gR6r+HZPaedP+ki7FgDNDLgaL
         e5OuL0ZA2DtMhGVMtux9429pY733dS0+iKwLi1/DQpSDHoirijzKWLQnAZ2jmvWwLm
         3XiI6X5Of/Nb3+v8aiUE8Te+4pHOoDAWBaInBIt/SLsTT3YB6NKoufDTSzUqPVP0fH
         7TfDs+r070gO3oArYpcuULUAQ8/eSRuUXDFysbpfNp7qY/Ts6ucmcJGGU8g7uVNymf
         EEEDTnsduEfSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 74FEAF6078B;
        Mon, 10 Jan 2022 18:27:53 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 5.17 merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YdvNGdx2O4u3hFwn@osiris>
References: <YdvNGdx2O4u3hFwn@osiris>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <YdvNGdx2O4u3hFwn@osiris>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.17-1
X-PR-Tracked-Commit-Id: 0704a8586f75663cf30a283bbeeca09eb4e60a07
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f0d43b3a3809f280806825df2454fd83f71874c4
Message-Id: <164183927347.9673.13323844448508638691.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Jan 2022 18:27:53 +0000
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Andy Polyakov <appro@openssl.org>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 07:07:21 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.17-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f0d43b3a3809f280806825df2454fd83f71874c4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
