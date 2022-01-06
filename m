Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07B3486B1F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 21:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243812AbiAFU2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 15:28:42 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51868 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243797AbiAFU2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 15:28:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E96D361D4A;
        Thu,  6 Jan 2022 20:28:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5636AC36AE3;
        Thu,  6 Jan 2022 20:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641500912;
        bh=OsUNE+VHqPLHWF8yTSwYqfnc8VqlRB2e9tgtXMVHVBw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=EBkG92G4ZWVbeSGpD5lMWBeVEFfirktRV+ual0xf035o5SyCf2mr1PQ4ettj8TwfL
         QSzROPwdU5vEuAg8O6qJZXfi/ZQTi8vw4XBjDQbLXzXcsI7aqCSwJuYMvYv7pC6Xsg
         QPNXBJL32h8bVhcBXuiQcxbj2Z2gGcj/+aB3dRQFDukzlJLcwUegmEpavGnrNKeSGk
         XgwrYYA3FSM8XFIisOVIZSOjYmo6nIXlZZ7pH5a5MuWAovZcVRKAAjG5IfJ5NYDP4v
         b4qlACZ9ilXfYRLZr3FPFimM/W//4abLLqy8ef5TghpYjHpRMRHLY2++xo13NxoAgH
         cE+35laGEiEUw==
From:   Mark Brown <broonie@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Rob Herring <robh@kernel.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220105183234.3426649-1-robh@kernel.org>
References: <20220105183234.3426649-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: spi-mux: Add reference to spi-peripheral-props.yaml schema
Message-Id: <164150091106.2243644.5917099933375767402.b4-ty@kernel.org>
Date:   Thu, 06 Jan 2022 20:28:31 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jan 2022 12:32:33 -0600, Rob Herring wrote:
> The spi-mux serves as both a SPI peripheral and controller, so add a
> reference to spi-peripheral-props.yaml in addition to
> spi-controller.yaml. This is necessary to avoid unevaluatedProperties
> warnings once those are fully enabled.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] dt-bindings: spi-mux: Add reference to spi-peripheral-props.yaml schema
      commit: 709c81b55c6aa74a6cdad27bdc224f50962b6ad9

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
