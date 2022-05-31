Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED49153988F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 23:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347946AbiEaVUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 17:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239528AbiEaVUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 17:20:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384617035C;
        Tue, 31 May 2022 14:20:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C479061348;
        Tue, 31 May 2022 21:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D3AFC3411C;
        Tue, 31 May 2022 21:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654032012;
        bh=GcfQ54dGudm7ZHirEit88epzxfWGn1nphYP+Wy62oEY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Y6kHqXkA9whpiyTh5YyQ+NHKX6etzcrVPPnxpwQRr7E41zclGyy7dr5aV1NDpfOME
         BsyLxtKY+Y3jKd++8EJF5ao9yEuQJp18/JbxTI2MqFvU0adzBg4f7an2QHIalPRMMq
         2Jx7YpSiH+76MoHQhs11oVx7gLpju2k+6P4fP5ey92GrriMPrPVrIuU4L8ST8hX6Ci
         gIOnuZ9cUOmw2KC1W+13r9S2zzRIw1KfJ6FxOEZAhdwIx5CGrcJlMCgK5a71SQFtgh
         F202sQzeSwIYEquFnMnJFd62b3IxABXBNtlv2iXtgjyU0w5Tt6CbCbPflJgMUeCjXO
         Wp/t8ZiJM+65w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D2B6F0394E;
        Tue, 31 May 2022 21:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND v1] Bluetooth: hci_qca: Return wakeup for qca_wakeup
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165403201205.25010.12372170867802214338.git-patchwork-notify@kernel.org>
Date:   Tue, 31 May 2022 21:20:12 +0000
References: <1653646543-349-1-git-send-email-quic_saluvala@quicinc.com>
In-Reply-To: <1653646543-349-1-git-send-email-quic_saluvala@quicinc.com>
To:     Sai Teja Aluvala <quic_saluvala@quicinc.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, quic_hemantg@quicinc.com,
        quic_bgodavar@quicinc.com, quic_rjliao@quicinc.com,
        quic_hbandi@quicinc.com, abhishekpandit@chromium.org,
        mcchou@chromium.org
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
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 27 May 2022 15:45:43 +0530 you wrote:
> This fixes the return value of qca_wakeup(), since
> .wakeup work inversely with original .prevent_wake.
> 
> Fixes: 4539ca67fe8ed (Bluetooth: Rename driver .prevent_wake to .wakeup)
> Signed-off-by: Sai Teja Aluvala <quic_saluvala@quicinc.com>
> ---
>  drivers/bluetooth/hci_qca.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [RESEND,v1] Bluetooth: hci_qca: Return wakeup for qca_wakeup
    https://git.kernel.org/bluetooth/bluetooth-next/c/9271cf2ecc9a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


