Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D0558A4C9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 04:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235846AbiHECkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 22:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiHECkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 22:40:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEBB1105
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 19:40:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 382E2B827DC
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 02:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B58F0C433D6;
        Fri,  5 Aug 2022 02:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659667213;
        bh=rGqPr+ZYa5Fa9SDIlx0KLNnQD/6z8SqgTSiv57flWPw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=alZHoTP15EG0WWNphvOQxyYpbaNuqohYxtoCC3sIoyi3XilpEk4fzcAkICbMNYeLC
         H2JQN7LuiHAEJ+tmvtC19V5lY8rh0Zk1iCW1OcLqr/Oix2AEwCO1gCjCjXNRxQYHKZ
         NZ0HvQQm9nwyIXRqI19+XZMHqvxf8PPresgfTo+JmVPUNJYBotFzACI09MJ+StkWk9
         wJnpe1Qd4ccKwRz+bs6VvyigqP7Vrvemt9R955A8Mbf4oRv4fzcsD7AOK7NOv3NyvD
         C5D416LljpRCKUqFCUMWhztR4TyxYWAO/2F/VKjjVkNPLB3A0VJbU/lMna/p92yOxv
         xHs6q/JjfhUgA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 99C49C43140;
        Fri,  5 Aug 2022 02:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] platform/chrome: cros_ec_proto: Update version on
 GET_NEXT_EVENT failure
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <165966721362.15379.12989245947386222213.git-patchwork-notify@kernel.org>
Date:   Fri, 05 Aug 2022 02:40:13 +0000
References: <20220802154128.21175-1-pdk@semihalf.com>
In-Reply-To: <20220802154128.21175-1-pdk@semihalf.com>
To:     Patryk Duda <pdk@semihalf.com>
Cc:     bleung@chromium.org, groeck@chromium.org, gwendal@google.com,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        upstream@semihalf.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-kernelci)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Tue,  2 Aug 2022 17:41:28 +0200 you wrote:
> Some EC based devices (e.g. Fingerpint MCU) can jump to RO part of the
> firmware (intentionally or due to device reboot). The RO part doesn't
> change during the device lifecycle, so it won't support newer version
> of EC_CMD_GET_NEXT_EVENT command.
> 
> Function cros_ec_query_all() is responsible for finding maximum
> supported MKBP event version. It's usually called when the device is
> running RW part of the firmware, so the command version can be
> potentially higher than version supported by the RO.
> 
> [...]

Here is the summary with links:
  - [v1] platform/chrome: cros_ec_proto: Update version on GET_NEXT_EVENT failure
    https://git.kernel.org/chrome-platform/c/c2b1dc63ba41

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


