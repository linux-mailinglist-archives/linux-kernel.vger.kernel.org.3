Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0E947E9AF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 00:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241150AbhLWXqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 18:46:12 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:50210 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhLWXqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 18:46:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A558061FBA
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 23:46:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5754C36AE5;
        Thu, 23 Dec 2021 23:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640303169;
        bh=mBt988pV4kWE/KH2zKVeh/zXjm3TAeqjnonncY9U4qA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EX1FlIiF3tWqZ6eChU35r/WN5cLAwedmI2iQLZsiTp7GWk+CVaprP0g9zeLpP7hti
         Ry1/Pf3ROptuAYndD5B0YIegzdy+xo3jiPdts/aqB93lWXJaIuDoTp0pAx41UYYqoG
         QR3GJ61KyxYaZsXKbJWZuHnCP5S3+6BwsSw/6e3qpA50Say1Zg/S7I6MU1MlBR9G59
         dNQRuiHEKvKK6XyVtUw8h3b+4bEhY4eEuwai5LGLFflHC6Nt2hmHG2//BTEkT9OYPf
         VYh4YSOoD9NFHEmxw+HMydS+uZYiISnnAgDlhw59Q8fDUZ7a8a8XVhsC2CPV8qGXRR
         RTV7mU0wgC1vA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE28AEAC06C;
        Thu, 23 Dec 2021 23:46:09 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.16-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9ty=B0ZvuwiQExR2-RoCZo18DZYrKMzTfK8-00psKncw9w@mail.gmail.com>
References: <CAPM=9ty=B0ZvuwiQExR2-RoCZo18DZYrKMzTfK8-00psKncw9w@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9ty=B0ZvuwiQExR2-RoCZo18DZYrKMzTfK8-00psKncw9w@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-12-24
X-PR-Tracked-Commit-Id: dbfba788c7ef839849e013264fef551e4d119d0b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 95b40115a97bda99485267ca2b3b7566f965b5b4
Message-Id: <164030316965.13743.3716169270809623738.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Dec 2021 23:46:09 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Dec 2021 08:14:51 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-12-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/95b40115a97bda99485267ca2b3b7566f965b5b4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
