Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33304878FE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 15:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347811AbiAGOdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 09:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347806AbiAGOdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 09:33:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8794CC061574;
        Fri,  7 Jan 2022 06:33:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27E7561EEC;
        Fri,  7 Jan 2022 14:33:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F979C36AE0;
        Fri,  7 Jan 2022 14:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641566001;
        bh=Eph8sqgV5sdpwR5dgEulgL6dC/4txofb6JyaHjVOvEE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hxuHQUOBXSHsYmSrM2Zjp1XQt0v9f1ayP7oAtcFi+2AI8Q+NtNJRpO8lwKP2J9D/d
         dgcDEEA7QttrnJZxqUh9ERERdAolPRkMD4mx42Q02oIZJQ7G64U5hJyPe1jzR/ggC0
         P9iOCAzN9UVX7bo4FbyueOaiYNKYFdWe512SuZuL0SeMvBzSQJ/yQDcSXjfpU9ogab
         1MBuHLxVbzRnYq31zg+3FivA2Og4lDt1EFfQUZQ6+s3ee9IjM6y2843+J2kNhr4vWx
         BTWQz2xVJsj2uGcAPi8pC8pJQZ3UrxhVokiFIqIy86DceOuxZo/J+nPyqindLUb854
         snn4ueNAM8O6A==
From:   Mark Brown <broonie@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     linux-spi@vger.kernel.org, Beniamino Galvani <b.galvani@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220107075424.7774-1-linmq006@gmail.com>
References: <20220107075424.7774-1-linmq006@gmail.com>
Subject: Re: [PATCH] spi: spi-meson-spifc: Add missing pm_runtime_disable() in meson_spifc_probe
Message-Id: <164156599935.2077509.18070348001401229585.b4-ty@kernel.org>
Date:   Fri, 07 Jan 2022 14:33:19 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jan 2022 07:54:24 +0000, Miaoqian Lin wrote:
> If the probe fails, we should use pm_runtime_disable() to balance
> pm_runtime_enable().
> Add missing pm_runtime_disable() for meson_spifc_probe.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-meson-spifc: Add missing pm_runtime_disable() in meson_spifc_probe
      commit: 69c1b87516e327a60b39f96b778fe683259408bf

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
