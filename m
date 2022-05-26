Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB7953491F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 04:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbiEZC70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 22:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237445AbiEZC7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 22:59:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E09BCE9E;
        Wed, 25 May 2022 19:59:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF28AB81EC3;
        Thu, 26 May 2022 02:59:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80389C385B8;
        Thu, 26 May 2022 02:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653533957;
        bh=VJabWyAI7ssWfGvUOMDtsGx8kN+ReQPetUHWFWvaVuc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FWS03qWeRCSXcLyIHdIhNwz6UD9S5SNAI3Gmxqz8dt+JhqoZaTqugQOWDyQw+ES93
         OQYCoU3zda5yLq41AFikYQcIQJpwiX+pWVoNaLCKEjml7xHpLzg5waoopMnI3pPUZR
         Clbqp4Fk5Eu4wZtfDGIZElOxmXMrI3Q2sAob0y1wXNxDsUvj0pLe/ifCSgkdmL/riC
         iApF2zkuHrl7Lev31JFaFtPCqMBYSaq1vgr265EFfWDmPCwzheBXle+q6Bihopvs5Z
         5Di6uRy0V0bNAaif12eW1zm/2Rh9bie40zQqo0mOAuMTe1YfQ6s0rXdjbSbaq2S1e6
         6iEHLfPW1LB7Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6EA69E8DBDA;
        Thu, 26 May 2022 02:59:17 +0000 (UTC)
Subject: Re: [GIT PULL] first round of SCSI updates for the 5.18+ merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <bd25414c73fae85529568c6f5b88bfdad6df7b97.camel@HansenPartnership.com>
References: <bd25414c73fae85529568c6f5b88bfdad6df7b97.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <bd25414c73fae85529568c6f5b88bfdad6df7b97.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc
X-PR-Tracked-Commit-Id: 325d5c5fb216674296f3902a8902b942da3adc5b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fbe86daca0ba878b04fa241b85e26e54d17d4229
Message-Id: <165353395744.29187.3005143147293528642.pr-tracker-bot@kernel.org>
Date:   Thu, 26 May 2022 02:59:17 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 24 May 2022 22:38:34 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fbe86daca0ba878b04fa241b85e26e54d17d4229

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
