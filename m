Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818CB4D8858
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 16:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237229AbiCNPl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 11:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242645AbiCNPlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 11:41:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D51D329AF;
        Mon, 14 Mar 2022 08:40:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B605612CA;
        Mon, 14 Mar 2022 15:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AFEECC340F4;
        Mon, 14 Mar 2022 15:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647272410;
        bh=CWfY9aH7G49sphi7axzvOYcuJSs0H1VbcddjWWFXPQ8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=HFIWVg/bBdPGm4BcIRjqfS4pLq2cSmY4ZTGr6iDwICFK7aGfZ7DHstP+aB2/IxxMF
         SqQhIaINHow9SLOcpyUhUedhV7uPqM9U2je/lvc7h/zbLbZ6GJmTPhLq3bBtZgSPFM
         VuMRZzU5xFSK03JaSF+dOO2pVOE09j5wxb2Kjnui04pZwFGVZ2KHn5hIxSi/oCnlsL
         ArwrRo7dVz6WCB377uSyyDbeuAR/2xYZmatb+Lo0EfWzguvE4eCp6y0sVOqjndd7qs
         7XTEH4N/L2QQT41DTwV3x7WGCPsbhqVgUyS7plVoy4ZbFwkljAFKFtiddFwKBm+f5L
         uCghzJEGyNcAg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 93794E73C67;
        Mon, 14 Mar 2022 15:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btrtl: Add support for RTL8852B
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <164727241060.27748.9937813712879972198.git-patchwork-notify@kernel.org>
Date:   Mon, 14 Mar 2022 15:40:10 +0000
References: <20220314065422.1446-1-max.chou@realtek.com>
In-Reply-To: <20220314065422.1446-1-max.chou@realtek.com>
To:     Max Chou <max.chou@realtek.com>
Cc:     marcel@holtmann.org, alex_lu@realsil.com.cn,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        hildawu@realtek.com, karenhsu@realtek.com, kidman@realtek.com
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Mon, 14 Mar 2022 14:54:22 +0800 you wrote:
> From: Max Chou <max.chou@realtek.com>
> 
> Add the support for RTL8852B BT controller on USB interface.
> The necessary firmware file will be submitted to linux-firmware.
> 
> Signed-off-by: Max Chou <max.chou@realtek.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: btrtl: Add support for RTL8852B
    https://git.kernel.org/bluetooth/bluetooth-next/c/263a90f4f1a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


