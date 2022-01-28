Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD30D49FD65
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 16:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349831AbiA1P73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 10:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349813AbiA1P7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 10:59:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B85C061747;
        Fri, 28 Jan 2022 07:59:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3DEF8B82640;
        Fri, 28 Jan 2022 15:59:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13E8C36AE3;
        Fri, 28 Jan 2022 15:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643385547;
        bh=A0ACMtz2PYMxCJh7KzbsBtaPz87LTsKG2YmEISHjPAM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=R8uP5WeF3NuoUSS/XrcCWKGFIM+G/hF5YCATW+g4NJtTdDv3zzrE3HfKBTcP1/QKr
         i+5kRC/7DEQsF4KaFHlKF/agL8siiilyP9HohmMhWWffpwhX/j8SSRexTNG8ax2L+j
         4gC3AJKLlXcOwdGc7wVgslz0hyqkO2Qmr6nBCiK3qvxNuIZITS+HUBsOr505LIZc8H
         hk2ugw/3SSXkBQTdxN6DxXwg/H69YYyeZUA/5p6M/N2ssGqtY6W8VLBHOA+w1diq+4
         7F84TpOZkbCQwhRphGs+7Tg6uBiSm5Mh9u3+fjfQRm56q6I8Sc2fVYxVXu+4HueskB
         LJ91yIE1ldk8g==
From:   Mark Brown <broonie@kernel.org>
To:     Kamal Dasu <kdasu.kdev@gmail.com>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com
In-Reply-To: <20220127185359.27322-1-kdasu.kdev@gmail.com>
References: <20220127185359.27322-1-kdasu.kdev@gmail.com>
Subject: Re: [PATCH] spi: bcm-qspi: check for valid cs before applying chip select
Message-Id: <164338554665.1711475.8978411907163622225.b4-ty@kernel.org>
Date:   Fri, 28 Jan 2022 15:59:06 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2022 13:53:59 -0500, Kamal Dasu wrote:
> Apply only valid chip select value. This change fixes case where chip
> select is set to initial value of '-1' during probe and  PM supend and
> subsequent resume can try to use the value with undefined behaviour.
> Also in case where gpio based chip select, the check in
> bcm_qspi_chip_select() shall prevent undefined behaviour on resume.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-linus

Thanks!

[1/1] spi: bcm-qspi: check for valid cs before applying chip select
      commit: 2cbd27267ffe020af1442b95ec57f59a157ba85c

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
