Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8416A4878FC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 15:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347802AbiAGOdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 09:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347798AbiAGOdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 09:33:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478FDC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 06:33:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6F6E61F18
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 14:33:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9AB5C36AE0;
        Fri,  7 Jan 2022 14:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641565996;
        bh=KpbqoRlgmphIlm84h+uqsaJzyJ5t4kS27HZK3LhwIWY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=AA3f0pr0VJtAtJeF5s+CSuzz4G34KQPqzo/kaOuB4gTNqgLuzLb/sEdo8mBFiuPNb
         TlDULYV7Ye202yP2PBI4A0B7iRQ9Ne3wQWhll9z1/EdAVB+T5jKBlC6E2EF0hqW1ZY
         ny06A/x5UuPBycKW38Juql0d6TbtN0D/xrUxM54to2IPJFbA8LKhUKuOhyIoYsDI3s
         /t7ey6/hGzTfae395qc9yQ7KfUxXI4yVMYF3w93bK6weE3TzE4usYiRYux/wbjQaOK
         NN0ZBDC/kKHmoW9au9GmgtXNXDV8UQe7kcPE5plZUR6C7SLaWp1n2RuXUX/nGpLCeY
         G6tOj0BZ+b0hg==
From:   Mark Brown <broonie@kernel.org>
To:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Watson Chow <watson.chow@avnet.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
In-Reply-To: <20220106224350.16957-1-laurent.pinchart+renesas@ideasonboard.com>
References: <20220106224350.16957-1-laurent.pinchart+renesas@ideasonboard.com>
Subject: Re: [PATCH v2 0/2] regulator: Add driver for Maxim MAX20086-MAX20089
Message-Id: <164156599462.2077470.16513079176958565691.b4-ty@kernel.org>
Date:   Fri, 07 Jan 2022 14:33:14 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jan 2022 00:43:48 +0200, Laurent Pinchart wrote:
> From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Hello,
> 
> This small series adds a new driver (along with DT bindings) for the
> Maxim MAX20086-MAX20089 camera power protectors.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] dt-bindings: regulators: Add bindings for Maxim MAX20086-MAX20089
      commit: 764aaa4e031a9acd26babc622cabe652f57bbb04
[2/2] regulator: Add MAX20086-MAX20089 driver
      commit: bfff546aae50ae68ed395bf0e0848188d27b0ba3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
