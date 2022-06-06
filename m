Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F23353E01F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 05:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352322AbiFFDd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 23:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbiFFDdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 23:33:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5434B37A39;
        Sun,  5 Jun 2022 20:33:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B269460EDC;
        Mon,  6 Jun 2022 03:33:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07FCBC36AFE;
        Mon,  6 Jun 2022 03:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654486430;
        bh=GvbnNdDO95Viv4J08oBd15X/hC/cew08t9KpoUk6BoM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=q0E3wy1n1jEU0ZITn0noAJw5W16quomE4u+H5T2nj+WCyMpxDRu7XnKzpN26wCR61
         MnmEq2m9czldbZte/wDySuCe6JaEva7mT2ZOlQff4mae2rs3k6+JEY/KpC+FVNwnOi
         VZnU6aqhEwLbKW1JiCXksE4dLALpzk055saaImz2LHAhCTXFwdCUtv5dUbQyd2XXo2
         O4qzcRofc760Q1wjdNxim3EipfH16Z4I0p/3SSCoIp5ZhOuGIX6Ul4JtEaNzy9BNew
         fF9zWS20pUM2bDMqyGlsQ5CpwM5abPloa+eFxyGT9BGT1AOYZOyhUdrnkrZ1KytrYU
         IZZqzlvC9G1ow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DFECBE737F4;
        Mon,  6 Jun 2022 03:33:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 0/2] Input: cros-ec-keyb: Better matrixless support
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <165448642991.20111.2194828010616443866.git-patchwork-notify@kernel.org>
Date:   Mon, 06 Jun 2022 03:33:49 +0000
References: <20220516183452.942008-1-swboyd@chromium.org>
In-Reply-To: <20220516183452.942008-1-swboyd@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, chrome-platform@lists.linux.dev,
        krzk+dt@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        bleung@chromium.org, groeck@chromium.org, dianders@chromium.org,
        hsinyi@chromium.org, joebar@chromium.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to chrome-platform/linux.git (for-next)
by Dmitry Torokhov <dmitry.torokhov@gmail.com>:

On Mon, 16 May 2022 11:34:50 -0700 you wrote:
> This is a followup to my previous patch[1] that skips keyboard registration
> when the matrix properties aren't present. This adds a compatible string
> for this scenario so we can ease existing DTBs over to the new design.
> 
> Changes from v4 (https://lore.kernel.org/r/20220503204212.3907925-1-swboyd@chromium.org):
>  * Make switches compatible fail probe if no switches present
>  * Add description to compatible list
> 
> [...]

Here is the summary with links:
  - [v5,1/2] dt-bindings: google,cros-ec-keyb: Introduce switches only compatible
    https://git.kernel.org/chrome-platform/c/52dc6d3bea3b
  - [v5,2/2] Input: cros-ec-keyb - skip keyboard registration w/o cros-ec-keyb compatible
    https://git.kernel.org/chrome-platform/c/ca1eadbfcd36

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


