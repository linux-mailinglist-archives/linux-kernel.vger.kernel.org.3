Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7559E496B7D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 10:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbiAVJkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 04:40:16 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52114 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234015AbiAVJkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 04:40:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17EDAB81B5B;
        Sat, 22 Jan 2022 09:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CFF29C340EB;
        Sat, 22 Jan 2022 09:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642844409;
        bh=ycU31NGXa5G+6fm/+givyqW9MAcXK3tU0KMy/d4hp9E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jGBq8XmZIxWDHU1jPNgad3G59Lnpc/Apxvx+d3YGCdUHnMMkbXZZdLLrVcTq2As8v
         Zo0RzwuTvrXAmktXqpRIEsrU4JsV3ZpJBPXJhdLZ48nRaW5xe6krLNl1m06pOa19HF
         fideX6vCsyjz/SojntH2IzDwc2703m5M2blPmyE4tNtpalHcAQDjvLIxtGPcmlF1yr
         lbvq6j/CeW2QM2T+Lun+IxnLL2A4WNko0D+3Ow18F50jLA5d99RjS23Xv4yNbR9+Cl
         KO7FXmtgwtz4vaU3zygU320ufXFre9ZZESycdN9li1sA2LVzsw/hY2M3DlDPhbzxMX
         1sRDS7tmVio+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A67B1F60798;
        Sat, 22 Jan 2022 09:40:09 +0000 (UTC)
Subject: Re: [GIT PULL] final round of SCSI updates for the 5.16+ merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <21f7e329c2ff2f5ce6a41ff08bda968e7dc10633.camel@HansenPartnership.com>
References: <21f7e329c2ff2f5ce6a41ff08bda968e7dc10633.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <21f7e329c2ff2f5ce6a41ff08bda968e7dc10633.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc
X-PR-Tracked-Commit-Id: 2576e153cd982d540b212e989458edc42ad1b390
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 369af20a2c3f738c8610d75b010ee5dc5d3c207f
Message-Id: <164284440966.7666.17995808009223044790.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Jan 2022 09:40:09 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Jan 2022 23:04:22 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/369af20a2c3f738c8610d75b010ee5dc5d3c207f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
