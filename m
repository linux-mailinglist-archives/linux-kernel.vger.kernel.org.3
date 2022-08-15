Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCF159284A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 05:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbiHODzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 23:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiHODza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 23:55:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FD3627A;
        Sun, 14 Aug 2022 20:55:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DB4160EF1;
        Mon, 15 Aug 2022 03:55:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA553C433C1;
        Mon, 15 Aug 2022 03:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660535728;
        bh=MgA5zDE8RPJK79rlqlC3IbBUVTth+II+UBJdAEV4GD4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mlD/Xp5XqO/1qExsLpw3QDAg2OpnC8B+q+aRc3UpeqWJblr2LJLO2T+Bfs3QnaZun
         REgqbB/pE0OdxrtDvesTKyAQ74Wp+qeYmGnGiBXrNmLTeGvxw35f94dFWthxfNCYZn
         V+w7+HC2JIRRmYwAvG2pp/sB+tde6dXzWEuokwRN4mlIpbVSIuawDvRvnVscqyvY+0
         X6XIvKu8pMf5Y1TWBkNrLW3eH88Q7UYmw/eHHbZKM5/2bnuIgdT3bItEaGLctuxJ4I
         H6nQghr29j/+H8+bSSa33RlvxZ4kkoIZBEl3g4Se5Y+s0E/UfSDQKt1n3k+uUq9Lqr
         6z0r8Lfmjnz4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8F3C7E2A04F;
        Mon, 15 Aug 2022 03:55:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] [v3] media: platform: cros-ec: Add moli to the match table
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <166053572858.30867.5596424089361079581.git-patchwork-notify@kernel.org>
Date:   Mon, 15 Aug 2022 03:55:28 +0000
References: <20220520110831.29502-1-scott_chao@wistron.corp-partner.google.com>
In-Reply-To: <20220520110831.29502-1-scott_chao@wistron.corp-partner.google.com>
To:     Scott Chao <scott_chao@wistron.corp-partner.google.com>
Cc:     hverkuil-cisco@xs4all.nl, mchehab@kernel.org, bleung@chromium.org,
        groeck@chromium.org, zhuohao@chromium.org,
        linux-media@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org
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

This patch was applied to chrome-platform/linux.git (for-next)
by Mauro Carvalho Chehab <mchehab@kernel.org>:

On Fri, 20 May 2022 19:08:31 +0800 you wrote:
> The Google Moli device uses the same approach as the Google Brask
> which enables the HDMI CEC via the cros-ec-cec driver.
> 
> Signed-off-by: Scott Chao <scott_chao@wistron.corp-partner.google.com>
> ---
>  drivers/media/cec/platform/cros-ec/cros-ec-cec.c | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - [v3] media: platform: cros-ec: Add moli to the match table
    https://git.kernel.org/chrome-platform/c/a1a9b71ebd65

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


