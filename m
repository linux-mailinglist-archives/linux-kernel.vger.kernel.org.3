Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADC34EF8F7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 19:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350046AbiDARcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 13:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241765AbiDARcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 13:32:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C401AA8E2;
        Fri,  1 Apr 2022 10:30:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6B50B82594;
        Fri,  1 Apr 2022 17:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69E98C3410F;
        Fri,  1 Apr 2022 17:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648834212;
        bh=8+a6lsKNv6DWxdironHVAEwmEBHHczrlrkS5+9vgAsw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=q/V8pxjnzpRUDo87O5ArosC1RM4HraQLU+fkpCb+tcOXgIDEGMR8lZe197KzFV9yv
         BDTYA2WNYuEd453IduCiEDwSolfZdQZNU66TUwv8IOMX8qfBdvHsLiGBLm7FAL2tsj
         0X9B5VG5ZAqXgB6zFe2TlnSlL3x2xr/umnRXduCSkt9HrdstuWSAz99MIOc10i0Naf
         sxA7y5h8Ht2ktXo9/yMf3MU+5KnfQK47KO8l932OhpeZ/IgmqbcvTw9LI0Jo12Zx8s
         3y5/P377wZSTK/PKwuyUGblgrylSBKsrEIUgbXdvh//OkYbG1ahOGkThtrCUQpmo/u
         Qx2qFZKo++nXA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4834DF0384B;
        Fri,  1 Apr 2022 17:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btintel: Constify static struct regmap_bus
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <164883421229.6587.11782366458459576058.git-patchwork-notify@kernel.org>
Date:   Fri, 01 Apr 2022 17:30:12 +0000
References: <20220330223252.42136-1-rikard.falkeborn@gmail.com>
In-Reply-To: <20220330223252.42136-1-rikard.falkeborn@gmail.com>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
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
by Marcel Holtmann <marcel@holtmann.org>:

On Thu, 31 Mar 2022 00:32:52 +0200 you wrote:
> The only usage of regmap_ibt is to (after the regmap_init() macro is
> expanded), pass its address to __regmap_init(), which takes a pointer to
> const struct regmap_bus as input. Make it const to allow the compiler to
> put it in read-only memory.
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: btintel: Constify static struct regmap_bus
    https://git.kernel.org/bluetooth/bluetooth-next/c/30b0001fcdc1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


