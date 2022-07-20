Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8005657BB4D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 18:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240419AbiGTQUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 12:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239565AbiGTQUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 12:20:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A09B63DE;
        Wed, 20 Jul 2022 09:20:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D96FB8210A;
        Wed, 20 Jul 2022 16:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E291C3411E;
        Wed, 20 Jul 2022 16:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658334017;
        bh=1Y1MG790Tx9DD4NtMB3EsvXdcl+aT5LsCSJdpHsZXPY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=dNRHbKr3QIVKyGCBwEHxJHIpNhGiDwH8MeKfzQKEvX+7q3XbDv2+2cgAehSdW9fyQ
         cBVBhh4r6+/87Ae/5vKA4TsoLYt2NxqwCsbMbdFmWpi4LJAnFbozBy4LZr3XIhxQA5
         jwqWXmT8EWLOLq9nH+RyAmV66lP2Bilr//tqFF6EReWQ6k3EDz2lncAO4A2ycReW2W
         cssxRS4H3zI6E8YyYLZdTX/iL3dDiRraDKs7WX5T81czLwHNZ6rFuuRKNu0KjgCOCZ
         AfoRUfjhybjBd1D3MjHm8InLcnR4oBwt2I681AeMyzaGFfX3a0rJupwolkYeKOC7Ve
         2lfkfhqNxxH3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35E49E451B3;
        Wed, 20 Jul 2022 16:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: Add default wakeup callback for HCI UART driver
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165833401721.6265.3730661801299527644.git-patchwork-notify@kernel.org>
Date:   Wed, 20 Jul 2022 16:20:17 +0000
References: <20220704183320.1.Ib7423c21f71003643a5bbe954ed0538ee532b29c@changeid>
In-Reply-To: <20220704183320.1.Ib7423c21f71003643a5bbe954ed0538ee532b29c@changeid>
To:     Ying Hsu <yinghsu@chromium.org>
Cc:     marcel@holtmann.org, chromeos-bluetooth-upstreaming@chromium.org,
        alainm@chromium.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  4 Jul 2022 18:33:24 +0800 you wrote:
> Bluetooth HCI devices indicate if they are able to wakeup in the wakeup
> callback since 'commit 4539ca67fe8e ("Bluetooth: Rename driver
> .prevent_wake to .wakeup")'. This patch adds a default wakeup callback
> for Bluetooth HCI UAR devices. It assumes Bluetooth HCI UART devices are
> wakeable for backward compatibility. For those who need a customized
> behavior, one can override it before calling hci_uart_register_device().
> 
> [...]

Here is the summary with links:
  - Bluetooth: Add default wakeup callback for HCI UART driver
    https://git.kernel.org/bluetooth/bluetooth-next/c/db52f939ccf8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


