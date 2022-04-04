Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7504F1DB3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345629AbiDDVke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379493AbiDDRQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:16:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED9F13F77
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 10:14:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B55F60AE7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 17:14:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ECDF9C34111;
        Mon,  4 Apr 2022 17:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649092462;
        bh=wrP0SyB7Pn2vzcNCKaCbDRANKEUMVJ6hSr1sVkXhkzw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=oPiUrM31gA4mkDsI+K2461RktHKfZBFcMziZ6I9qu/A6NE2QCq78hZWRUBb5Fg4fw
         b6FM7VfLwhUA9vS07pT9w3VHHZ18g1yR6E/rB/0GEBJcSJmL4GWTnGQZVwUy57XXev
         M7oNh8UxblMu2rCP2ypozxmVrfU34ywyUHOEFVt4OpLmZNO7FlDflZYm3CovGZpYea
         9clHL5D3+SWyX0xVT7aGd7aomuv6ELlFGArE2gylAxtAJBwUrzh0aMYcXFpnStqT3J
         vWaBtjkt1e7Pe4NoR3jEwx+XdQ1YOsdjE3rUSP1u0LnvQlp21QjDU8ON+nryHCdHLB
         vZuiNmjQJ8L4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D182CE85D53;
        Mon,  4 Apr 2022 17:14:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] chrome-platform changes for v5.18
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <164909246185.14329.16960316742222597465.git-patchwork-notify@kernel.org>
Date:   Mon, 04 Apr 2022 17:14:21 +0000
References: <YkekVRh9Ixdfa5qL@google.com>
In-Reply-To: <YkekVRh9Ixdfa5qL@google.com>
To:     Benson Leung <bleung@google.com>
Cc:     torvalds@linux-foundation.org, pmalani@chromium.org,
        bleung@chromium.org, bleung@kernel.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        tzungbi@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Fri, 1 Apr 2022 18:18:13 -0700 you wrote:
> Hi Linus,
> 
> Here's chrome-platform's changes for v5.18-rc1.
> 
> Of note, the last two commits of this PR had to be reworded (actually just
> the second to last one) since it hit linux-next for a minor commit message
> fixup. Content wise, the two are the same as they are on linux-next right now.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] chrome-platform changes for v5.18
    https://git.kernel.org/chrome-platform/c/02d4f8a3e05b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


