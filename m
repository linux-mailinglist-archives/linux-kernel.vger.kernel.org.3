Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6F150B422
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446098AbiDVJdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446097AbiDVJdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:33:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6304A4EF6C;
        Fri, 22 Apr 2022 02:30:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F24AD61D91;
        Fri, 22 Apr 2022 09:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E50EC385B4;
        Fri, 22 Apr 2022 09:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650619812;
        bh=iqKSRvVkoi982rk3Gb1felFKUcOqQmDF0b/98Xf+V9c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=JsnzA0wfk3sZdMbJRxTyVtaBLRoTPSeHB6oKhEUKYPFimKaVs8C00g5/7PB3DX3Qu
         bk+JOKloWMaLTtAEYuWcToDXVFd23UUzDfQ/qacmA9PEgaz9JZGAMtIGSOuAO9MrGd
         RytxFOT5Q/xTuHpZtIACSGYAHMY9b+ypJsMEHV6+q5TLHhqFLqgg06PMCKvb3MuiNo
         0LTJZ/b2SLK9dz1gFjGeG/pHxMS+qXdMdax1K+5ppU3NfVRDqZIVPjmIN50OdX4e3S
         kej2EjjiV0O/43ygq7Xrub/8rIJ/q1WYAlxFcHQDPTANFxdDFq3xTnqoI2I821kImD
         85i6x0R4dnjhg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 49BF2E8DBDA;
        Fri, 22 Apr 2022 09:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btrtl: Add support for RTL8852C
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165061981229.24106.8736132394177084138.git-patchwork-notify@kernel.org>
Date:   Fri, 22 Apr 2022 09:30:12 +0000
References: <20220411091957.838-1-max.chou@realtek.com>
In-Reply-To: <20220411091957.838-1-max.chou@realtek.com>
To:     Max Chou <max.chou@realtek.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex_lu@realsil.com.cn, hildawu@realtek.com, karenhsu@realtek.com,
        kidman@realtek.com, hsinyu_chang@realtek.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Marcel Holtmann <marcel@holtmann.org>:

On Mon, 11 Apr 2022 17:19:57 +0800 you wrote:
> From: Max Chou <max.chou@realtek.com>
> 
> Add the support for RTL8852C BT controller on USB interface.
> The necessary firmware file will be submitted to linux-firmware.
> 
> Signed-off-by: Max Chou <max.chou@realtek.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: btrtl: Add support for RTL8852C
    https://git.kernel.org/bluetooth/bluetooth-next/c/9ee4dddbad1e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


