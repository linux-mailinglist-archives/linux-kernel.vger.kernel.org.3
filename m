Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE56059284D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 05:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbiHODzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 23:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiHODza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 23:55:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF80062CF
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 20:55:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69C9A6101B
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 03:55:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4DC2C43470;
        Mon, 15 Aug 2022 03:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660535728;
        bh=Vx25ahkT7ReKmBbFzek0zpHkCrN+s7kbUGG8w9rRCiY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kEq77R36zbKSA2qL6r186mf8eU0oanZrICw6YYbO3rN5umL2VCmTI2PCNyNTVbiuH
         AyyGvhB41jqCI20lL0C8EGBuHY0MVzbgT+0PHSWhZCSo6JpwNnsSMK4+obQg4CPtJs
         36WSSe7GiXadaEuTfZCc8c5k4VY9F+zJdd3U0ad+TfuCHe8DxQOfHbkbWf2Msm9600
         6HFqvYmG2HfT0GlCcKMs6Jut9TxyupCFpyhytPOViOUmddgYDHDAhDkEykEBIFjMw4
         shwKeddiMrPJC6bqd5+SzjfNYJGrUIspUAVrTt7I8jRhltc77tRPGxXafvYU7I3UYM
         Vpo5edvJrVngw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 98C8FE2A04D;
        Mon, 15 Aug 2022 03:55:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] chrome-platform changes for v5.20
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <166053572862.30867.2875149894587725461.git-patchwork-notify@kernel.org>
Date:   Mon, 15 Aug 2022 03:55:28 +0000
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

This pull request was applied to chrome-platform/linux.git (for-next)
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


