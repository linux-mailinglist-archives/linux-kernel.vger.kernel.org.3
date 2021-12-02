Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED19F466D43
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 23:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345361AbhLBWzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 17:55:20 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56660 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241825AbhLBWzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 17:55:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E88F5B823BC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 22:51:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85D26C00446;
        Thu,  2 Dec 2021 22:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638485514;
        bh=cD1WUM7nzCL5Os2ImG3RGFgXt9UMuffFvJnkapneq6I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Z8U7cvCweiLTAE0hXZtRoJ7d8epJg86KfaxDUzmHJWB4GSP/oBFNtKCJcqV31opzt
         O38YhWidY6/8URRAAeUl2/ZekHHX7kIHDi7ANhyJjZCcXDt9RGFZMIcBKqqlMxMhHB
         deJk2uBU1s/KD7iHfMAnS2HdIqx8+bnL/ndoY5YNQoTon/EeiI4cM5NWXwWpIf2uES
         OolNJ/eyZ55u7O+Nlmy4PjedidRRBo7Ecu4INzY6TfVlTDIfReszw5eAWioq9AkTlA
         YWAzldmm/cARoHVdchb4C6bvD3SCwn1yRZpI3oUyAXju7o+1lXcSW4PIMRuUl7JT/r
         DH3iFg5DkytpA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 65EF160A50;
        Thu,  2 Dec 2021 22:51:54 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.16-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyOMZFPDYCmdu2xspoNcjbrEWfqYMGSLYBioLCRCKG6wA@mail.gmail.com>
References: <CAPM=9tyOMZFPDYCmdu2xspoNcjbrEWfqYMGSLYBioLCRCKG6wA@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tyOMZFPDYCmdu2xspoNcjbrEWfqYMGSLYBioLCRCKG6wA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-12-03-1
X-PR-Tracked-Commit-Id: a687efed194bdc185fd7cb33920fe8b4e60ecb9e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5f58da2befa58edf3a70b91ed87ed9bf77f1e70e
Message-Id: <163848551435.20300.13228460979140559461.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Dec 2021 22:51:54 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Dec 2021 07:27:03 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-12-03-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5f58da2befa58edf3a70b91ed87ed9bf77f1e70e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
