Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCD3592844
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 05:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240343AbiHODpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 23:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240181AbiHODo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 23:44:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A1113F23
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 20:44:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA277B80D04
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 03:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7BE0BC43470;
        Mon, 15 Aug 2022 03:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660535094;
        bh=r/x3vZ3Q7kN3eSNpeyQVl4c+2bbKKii9y8fY1wImfUw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=NlcekeVBt29OCuEshgw/AxbBWR9b9HScfll6DfK5hJy/grj/8I3HxSmqHofn6CnAN
         fyq7NiFRGy70YZP63Kgsyja7MWfw0Ss919lK1+xSMPynL/cGKoKueKlOvXIArg2QpV
         EamRsQdCJv/X4WaDrckNheQYLkT0YT1BBkM+xaMvCNrcQuqRHXFfkyNTtimgyaqv0O
         HKaToMml4hjt1ncS/vFyYPB65bwj6kifSw9h39KFQM4NyOrGnjWSTwxn7pUVvXSWZ9
         S3un7RflPH+SxcczLl9nM/IlyNk61YWQLrZPdlIXQSqbrrb8+kq+wcAM0yU0vCr0rQ
         g1QoeO2K1rQHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5FB77E2A04C;
        Mon, 15 Aug 2022 03:44:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] chrome-platform changes for v5.20
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <166053509438.30867.8572544538142335376.git-patchwork-notify@kernel.org>
Date:   Mon, 15 Aug 2022 03:44:54 +0000
References: <Yun1yFEsqpF59Tdy@google.com>
In-Reply-To: <Yun1yFEsqpF59Tdy@google.com>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     torvalds@linux-foundation.org, pmalani@chromium.org,
        bleung@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This pull request was applied to chrome-platform/linux.git (for-kernelci)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Wed, 3 Aug 2022 04:12:56 +0000 you wrote:
> Linus,
> 
> Please pull chrome-platform updates for v5.20.
> 
> Thanks,
> TzungBi
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] chrome-platform changes for v5.20
    https://git.kernel.org/chrome-platform/c/5bb3bf24b0aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


