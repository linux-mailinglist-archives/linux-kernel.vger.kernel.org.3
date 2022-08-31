Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE9B5A895B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 01:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbiHaXKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 19:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiHaXKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 19:10:24 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830D162A8A;
        Wed, 31 Aug 2022 16:10:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1646DCE23BC;
        Wed, 31 Aug 2022 23:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74F0AC433B5;
        Wed, 31 Aug 2022 23:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661987416;
        bh=9yzqYWQSSPYBUv51fZxscF1h4YaLJd1bhTqD33vncvg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=AMhCa83IyPT4SIazgmZF8spUCKEw3KytoEycaQpSmtrJp21twvIhHLfzI54kvWqKf
         d+bk7SLeg4oaoAsgJxB1rPx714Z1/Kg5wxsb8PJLwPpMa/2pRLNbzKcvf4a/2YTkGS
         VA9hzQUc/EEbcvNiPMfB6aGMMTbBGEyXEa1Jw8m0NYU9UBoZm4kAaiNaFico4fS/LW
         WDxg804k7tecVK/zxWLsqilkCv/KbTjTXQ/zxb4v1RwsnHbnFq+OD681fOmtekdLav
         VSKHW/EnUgsa2BxD07nKIM9Ei5qcw61eS3QxfMuD7c0BwM0UDqMblfC6kvtDrxIB4m
         NEQUgfMyS4DNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4F06AE924DC;
        Wed, 31 Aug 2022 23:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] Bluetooth: btusb: Add Realtek RTL8852C support ID
 0x13D3:0x3592
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166198741631.19908.12220351710969580519.git-patchwork-notify@kernel.org>
Date:   Wed, 31 Aug 2022 23:10:16 +0000
References: <20220829114507.1024-1-max.chou@realtek.com>
In-Reply-To: <20220829114507.1024-1-max.chou@realtek.com>
To:     Max Chou <max.chou@realtek.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex_lu@realsil.com.cn, hildawu@realtek.com, karenhsu@realtek.com,
        kidman@realtek.com
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

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 29 Aug 2022 19:45:07 +0800 you wrote:
> From: Max Chou <max.chou@realtek.com>
> 
> Add the support ID(0x13D3, 0x3592) to usb_device_id table for
> Realtek RTL8852C.
> 
> The device info from /sys/kernel/debug/usb/devices as below.
> 
> [...]

Here is the summary with links:
  - [1/1] Bluetooth: btusb: Add Realtek RTL8852C support ID 0x13D3:0x3592
    https://git.kernel.org/bluetooth/bluetooth-next/c/c4ba5800217b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


