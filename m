Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44C55770E0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 20:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbiGPSuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 14:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiGPSuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 14:50:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E631B7AF;
        Sat, 16 Jul 2022 11:50:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77E0361169;
        Sat, 16 Jul 2022 18:50:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D98ECC34115;
        Sat, 16 Jul 2022 18:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657997407;
        bh=AwVDko6poIK4VnN6UOcOdJYDygWVFy0BvCsem1Nf3p0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Wl5tD/VakRFqH7ePzSiwknqg0VEsU8lWdVzed/fGe6vUYAKtuMUh8zRU+JXcFTHhK
         W/x2OJfNduAzRA29OJzSuBy/E0KNf9oa6PLHw/W3ZEAn+zLXQ8lvM5nt32cRi3zThp
         yCdUzaKrWkfZDTMtwDulXpmsj0PrXHBsfeSKc+PYg0faA+mfyujzyHMlgW0CAj7+mT
         qW2WuadxKOJytpsA7KaC1NFOF/L35rbbC+F6ONjJ2ibFx+5ZMEDEYaThbhIN0FRLSp
         SoWEjTt0iJJ5JgS9dHcChPbJjQIAawjIJgkyCDgQXiFKweC/l/1N0XNJ72DMd4iDHp
         vhAA0NCCckOsg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C1FD9E45227;
        Sat, 16 Jul 2022 18:50:07 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 5.19-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ce185648f24041886a7194ab8eee23f9649b8a85.camel@HansenPartnership.com>
References: <ce185648f24041886a7194ab8eee23f9649b8a85.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ce185648f24041886a7194ab8eee23f9649b8a85.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 355bf2e036c954317ddc4a9618b4f7e38ea5a970
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c5fe7a97f20c7f3070ac870144515c0fabc6b999
Message-Id: <165799740778.27449.16208851207833975445.pr-tracker-bot@kernel.org>
Date:   Sat, 16 Jul 2022 18:50:07 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 16 Jul 2022 09:10:20 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c5fe7a97f20c7f3070ac870144515c0fabc6b999

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
