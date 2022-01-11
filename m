Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C224848B901
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 21:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbiAKUyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 15:54:16 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43406 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244590AbiAKUxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:53:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 682D8B81D50;
        Tue, 11 Jan 2022 20:53:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39833C36B03;
        Tue, 11 Jan 2022 20:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641934388;
        bh=YRjKWNl+VzQWa8Hv3wTzIaOB8mXASYhZrFJ4rjMQ9/I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GMQHS0K7rQSikD4jAR2L4FYUWKt4rRJHK7aat/KDckLNEcHOOwfHqdyPDdgK7X7bS
         Aago6jj7E0EluFOcDe8iCytYXwwSNyK0cPZEnMV0IPDWlze2A3J+GDvQRp9MaVS6SL
         J1nJ3sB2Va4JT/dTl2DteSLXwxzPRPuYpzqVvNfH/POFXhIBtejaDWUV7GErrrWIxv
         qqJSAZFVjTZjB0YilHgKBoAI9Ix36D2/eShNB/SOm5if14M3ptiewkyWd5ApsY//fp
         m0rtm5ZYbB7MSIYYAA5Y+axTltc+Omoehf5evhjSB+CVLX0EM8ewy+a0d5Tz36Dni1
         pZ9j6nxlWmaTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 265E0F6078A;
        Tue, 11 Jan 2022 20:53:08 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220110094812.4rtl2ltyaow7hgla@earth.universe>
References: <20220110094812.4rtl2ltyaow7hgla@earth.universe>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220110094812.4rtl2ltyaow7hgla@earth.universe>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.17
X-PR-Tracked-Commit-Id: 25fd330370ac40653671f323acc7fb6db27ef6fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 039053c11965a33250e75009e37dab8e7580fa4e
Message-Id: <164193438814.11435.10197426396100717909.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Jan 2022 20:53:08 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 10:48:12 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/039053c11965a33250e75009e37dab8e7580fa4e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
