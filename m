Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DE35260E2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 13:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379862AbiEMLVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 07:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379863AbiEMLVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 07:21:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD714F477;
        Fri, 13 May 2022 04:21:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D11A161D7B;
        Fri, 13 May 2022 11:21:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3DBA8C36AE2;
        Fri, 13 May 2022 11:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652440899;
        bh=PVTCAHuDpC7TKyqJJ6yfKKs+p30+5tiQZTFIZV159oQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TnM8HoUNbVYxdTfg0b+rnan7vn3FmRPLuc3+jS73RubnADXWLI9nzvgXXO1VyRZyM
         kjGMeB8BfAvNS62ZVPFyVv8ktAfKLD8Kb69viEBnHaxS6odD40foB5mmxlbyMBeliU
         x2k6BMb9QHixVfqPWE5XTLfshNLNrPje+QV17xuKs5QBw9+jDWQhTd18Hnlo+aPJ1X
         zPZsZxfLHvgjeg7n4fCt8PBaL5oUSPSJDggPQP1JyDjbti1uHS96RNhHDs/AzwcuZ/
         X8ZgPc9NnyMcciYpYCdpZScmmerBVJRVghnAlFf1Tqc4YvypKGw00wrs+StI7kzhkF
         2QhHh764cbZrw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1E0F3E8DBDA;
        Fri, 13 May 2022 11:21:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btbcm: Add entry for BCM4373A0 UART Bluetooth
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165244089911.8477.8063070079009637517.git-patchwork-notify@kernel.org>
Date:   Fri, 13 May 2022 11:21:39 +0000
References: <20220505195010.31329-1-tharvey@gateworks.com>
In-Reply-To: <20220505195010.31329-1-tharvey@gateworks.com>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Marcel Holtmann <marcel@holtmann.org>:

On Thu,  5 May 2022 12:50:10 -0700 you wrote:
> This patch adds the device ID for the BCM4373A0 module, found e.g. in
> the Infineon (Cypress) CYW4373E chip. The required firmware file is
> named 'BCM4373A0.hcd'.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  drivers/bluetooth/btbcm.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - Bluetooth: btbcm: Add entry for BCM4373A0 UART Bluetooth
    https://git.kernel.org/bluetooth/bluetooth-next/c/0d37ddfc50d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


