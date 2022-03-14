Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E10F4D8857
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 16:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242650AbiCNPlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 11:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242638AbiCNPlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 11:41:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285E53207E;
        Mon, 14 Mar 2022 08:40:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 634E9612D2;
        Mon, 14 Mar 2022 15:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BEC30C340EE;
        Mon, 14 Mar 2022 15:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647272410;
        bh=e8u2C/xf0zwy6DUOtm2RukdO7bBhOpXS0qkJvO8EKdo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BpANEOQkxbgWDy81heDZQ5kTJMnhBmFzhIAXWWcQThQyk5B7AWg+DZNW7uoxpMPTY
         U7DOyJW4bPLRSFtWPX7DJVjAMjczwkqrjBQ02y1l8LIbAAVwUYTBCdK63F5sqCfQLf
         6oPupByUSh4bhvqbq9Aj8KTLvUMEyWRsI+1s8qZ8sWAjqWTuijVyhWM34B3pxIUNn6
         99KUIK3XBke6lMj5wyDmZ1W9GN7w1PVG+iKtiC4zSjOHLtWsB/aWOsAORrBcp/9s6x
         Z22FQHBO2aCSCY8FjKCUe0QmU2R8/WEYZq7/8+Fjw9uONXumpkvJgLjfYaSvMGAitW
         bPgsd+rzS1+oQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9D733E6D3DE;
        Mon, 14 Mar 2022 15:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_uart: add missing NULL check in h5_enqueue
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <164727241064.27748.11693637138240755601.git-patchwork-notify@kernel.org>
Date:   Mon, 14 Mar 2022 15:40:10 +0000
References: <20220313174936.1299-1-paskripkin@gmail.com>
In-Reply-To: <20220313174936.1299-1-paskripkin@gmail.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        hildawu@realtek.com, apusaka@chromium.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+b9bd12fbed3485a3e51f@syzkaller.appspotmail.com
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

On Sun, 13 Mar 2022 20:49:36 +0300 you wrote:
> Syzbot hit general protection fault in __pm_runtime_resume(). The problem
> was in missing NULL check.
> 
> hu->serdev can be NULL and we should not blindly pass &serdev->dev
> somewhere, since it will cause GPF.
> 
> Reported-by: syzbot+b9bd12fbed3485a3e51f@syzkaller.appspotmail.com
> Fixes: d9dd833cf6d2 ("Bluetooth: hci_h5: Add runtime suspend")
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_uart: add missing NULL check in h5_enqueue
    https://git.kernel.org/bluetooth/bluetooth-next/c/928df045e94e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


