Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1630B4B0F95
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 15:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242572AbiBJODI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 09:03:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242575AbiBJODC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 09:03:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689539A;
        Thu, 10 Feb 2022 06:03:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0433D612CC;
        Thu, 10 Feb 2022 14:03:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 673CDC004E1;
        Thu, 10 Feb 2022 14:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644501783;
        bh=L+PpSV/TcNiz+mfnm44CEXLNSfejV2BvLcPSOPgEGHg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=heErZJ5gEuTECPxXK3+pdRe0LQ3IWwF+7AdPZ5b+6req+YnOf+g8gWdiHus1kJ+Rr
         FdZUryam4V3vKWG33gVz6Y5h5Ovwuwv5W15E4ejY2Nq5bJxFAoNTQFFPTax7zuXJA6
         hL2tdNzVFbvYU3/AOL3K6tMiNEY4RTq22Q+J1GBWYUuUb9EhNjoiNz9cf90FPPZ+ou
         3gyjJLg/srnPLH3a2jGEW7SI3XjZb35xh3TPfPgRQynwYSt4kwW+5nRZ6wD6+Aw1yN
         JyMwYAC/fz+bpMea+sZ89UKq1GQvS9cc/Bxqg2oVbJXXl3Z6IjA16LyKeJxkVEaJhD
         jfoVPfw5ObEwg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5181FE5D084;
        Thu, 10 Feb 2022 14:03:03 +0000 (UTC)
Subject: Re: [GIT PULL] MIPS fixes for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220210102939.GA9285@alpha.franken.de>
References: <20220210102939.GA9285@alpha.franken.de>
X-PR-Tracked-List-Id: <linux-mips.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220210102939.GA9285@alpha.franken.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes-5.17_3
X-PR-Tracked-Commit-Id: d9565bf40da22426d2f660cb31700b6858d1911d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e3c85076d7a6f986445b9008be7e7f83d1b0780a
Message-Id: <164450178331.30240.93820123938051512.pr-tracker-bot@kernel.org>
Date:   Thu, 10 Feb 2022 14:03:03 +0000
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     torvalds@linux-foundation.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 10 Feb 2022 11:29:39 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes-5.17_3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e3c85076d7a6f986445b9008be7e7f83d1b0780a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
