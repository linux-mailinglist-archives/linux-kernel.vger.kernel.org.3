Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91277481EE0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 18:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237236AbhL3RzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 12:55:14 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52912 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237146AbhL3RzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 12:55:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A0546173D;
        Thu, 30 Dec 2021 17:55:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83E30C36AE9;
        Thu, 30 Dec 2021 17:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640886912;
        bh=40C0mjquxthFKfYAe6IKTrPEJG1KRvBZkHtr8bHNwmI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Pd1tRNrhnDac1giRTodsFXrwMkG63U1a2fwG+JdbNL8REz1PhtVvkGwJklDsZgRYx
         hr90t0GrgymW1ZylPsfbLXi3cFMcC4DZWFGWwQriyESFG3Y6pR7H1AUCSvd7Xb7JKp
         VOX0fUquFRn7RcKtZNNmV1KXmsugE1BX970lAqKImxNxKKFd+LIVtQ4rb7aoTnp6tG
         VXkGKKZ58St7KWx7j8ur4JQWDZkkcp1uUi5hhYEve7ZGE3tNRt8BXek2LPo79Dr7OO
         1RjoWnDUGbg0hNecdJGug4hPVIKbU/pHFPhgKxz6PovEa0QpzZaoVrejRnWBBftm9L
         va03YpvD/rOtg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 732B3C395DE;
        Thu, 30 Dec 2021 17:55:12 +0000 (UTC)
Subject: Re: [GIT PULL] USB fixes for 5.16-final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yc3jxXB0JoKOrxb9@kroah.com>
References: <Yc3jxXB0JoKOrxb9@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yc3jxXB0JoKOrxb9@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.16
X-PR-Tracked-Commit-Id: 3f345e907a8e7c56fdebf7231cd67afc85d02aaa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2d40060bb51fb3b571b57aa9d823ab7fe55b4280
Message-Id: <164088691246.28006.2638978274095196930.pr-tracker-bot@kernel.org>
Date:   Thu, 30 Dec 2021 17:55:12 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 30 Dec 2021 17:52:21 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2d40060bb51fb3b571b57aa9d823ab7fe55b4280

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
