Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FFC4A841C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 13:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350659AbiBCMw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 07:52:27 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46664 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350644AbiBCMwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 07:52:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34F9060AF2
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 12:52:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF20BC340E4;
        Thu,  3 Feb 2022 12:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643892739;
        bh=79cATYyU3SWqa7eJXOIKQE4CIfytpAFrSkXsfOHDABI=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=nmMCMzr8ECxWr0XdyZ6SogfrQ27o5IJpehXo87v8F1BuriPoBQtqZpTwVOxkoBkLo
         bolQnQaISyEF+5xPmyamHpXWkSHtFl40bAW0wYczPjTPmbb9odU4znHPBO2XKri1S3
         pDQmZtIFx0F2D5c0BEKxLEbVpE9njCNxroHv8kpSxjHtV5XZhD3kb62aKuUF8HDeUv
         eGzXbFuK1gaI8HCZsFxaCHYxy2zASz4mVtaWWnkcHvnPdKcI19wv+Ft95H46IDh+4n
         MH8GtQJoXMACuGKHtWBzKQR4mfgGKIGw23oEBe/KlTbNsI+NVXIzURtdQxpBk9PlSS
         wh80K9KfUj0Dg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Prasad Kumpatla <quic_pkumpatl@quicinc.com>
In-Reply-To: <20220119142953.1804-1-quic_pkumpatl@quicinc.com>
References: <20220119142953.1804-1-quic_pkumpatl@quicinc.com>
Subject: Re: [PATCH v2] regmap-irq: Use regmap_irq_update_bits instead of regmap_write
Message-Id: <164389273850.1027572.18316786842189679898.b4-ty@kernel.org>
Date:   Thu, 03 Feb 2022 12:52:18 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2022 19:59:53 +0530, Prasad Kumpatla wrote:
> With the existing logic by using regmap_write() all the bits in
> the register are being updated which is not expected. To update only the
> interrupt raised bit and not tocuhing other bits, replace regmap_write()
> with regmap_irq_update_bits().
> 
> This patch is to fix the issue observed in MBHC button press/release events.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-linus

Thanks!

[1/1] regmap-irq: Use regmap_irq_update_bits instead of regmap_write
      commit: 8419f8e559a78a3d1050dd8132ef04727e8881c1

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
