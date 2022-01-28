Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708D54A047D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 00:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351814AbiA1XrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 18:47:17 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51890 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351804AbiA1XrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 18:47:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3900961F31
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 23:47:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C890EC340EC;
        Fri, 28 Jan 2022 23:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643413631;
        bh=KUvqDwiBSeBpmaoRMc2V9wXY1UxPYpVWgS8k5oLfBew=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JYSNUJKbXET2ON8ufNwkW6I6SiZY3kx0H5jYgsCO20xGemIUpPlJs9IdCxT9AALEp
         J/4GBo+6eCuXYEBDjbCEETWRZy/Isp1GaN04QqWDzkFconHUxIeTm5FOCVyiCYzpqy
         l/fiRCJC1Zha8Dqr8ROjI0Wmkruozy0h41lpK1S0zjApD4Du1shxa1FqIjw+PCsZvv
         mwYstMCg2KrlQi6b7lo/8/xxYwgYK5VIpgHuCAhDo1os/zJ0+qRKsaYpKZ3bkAV6zT
         10OEx3WFbXvno8b3tOnkN2CrJCsvtL5NB1qVT/UaPXkL/0XEqiKcUaCuZkQw1LxfCD
         NkIGt5qp/0aeQ==
From:   Mark Brown <broonie@kernel.org>
To:     Detlev Casanova <detlev.casanova@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
In-Reply-To: <20220124220129.158891-1-detlev.casanova@collabora.com>
References: <20220124220129.158891-1-detlev.casanova@collabora.com>
Subject: Re: [PATCH v3 0/9] regulator: rpi-panel: Support official Raspberry Pi 7 inches touchscreen
Message-Id: <164341363054.694916.12375594292083230045.b4-ty@kernel.org>
Date:   Fri, 28 Jan 2022 23:47:10 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2022 17:01:20 -0500, Detlev Casanova wrote:
> This patchset provides different fixes to the rpi-panel-attiny-regulator driver.
> 
> This is a preparation patchset for supporting the official Raspberry Pi 7
> inches touchscreen.
> 
> It has been tested with a Raspberry Pi 4 B and the official Raspberry Pi 7
> inches touchscreen.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/9] regulator: rpi-panel: Register with a unique backlight name
      commit: 7291e7d686308b4a77f43225eaf1753cb20cc692
[2/9] regulator: rpi-panel: Handle I2C errors/timing to the Atmel
      commit: 5665eee7a3800430e7dc3ef6f25722476b603186
[3/9] regulator: rpi-panel: Serialise operations.
      commit: 00440bcd211a3cac686b730447c4efa3d4c84c2a
[4/9] regulator: rpi-panel: Ensure the backlight is off during probe.
      commit: 89339a2ae7608138dbcccda8db67a87870550cbe
[5/9] regulator: rpi-panel: Convert to drive lines directly
      commit: 4866e35e48e6bd2bef1c567b05105e7fb3493ff9
[6/9] regulator: rpi-panel: Add GPIO control for panel and touch resets
      commit: 8c518eb4039102445b1b7bd6626aba0fef65b753
[7/9] regulator: rpi-panel: Remove get_brightness hook
      commit: 1d746d448f421094a71ba634399d2ee61669513f
[8/9] regulator/rpi-panel-attiny: Use the regmap cache
      commit: 5fa4e8ea649009566a1b080f836ce23d4ce0c416
[9/9] regulator/rpi-panel-attiny: Use two transactions for I2C read
      commit: e4a7e3f741f797d93d97a153b0f6a862d19a1304

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
