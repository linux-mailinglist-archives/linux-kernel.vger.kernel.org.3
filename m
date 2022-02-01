Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E874A6235
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241149AbiBARSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241021AbiBARSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:18:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A849C061714;
        Tue,  1 Feb 2022 09:18:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5031E61265;
        Tue,  1 Feb 2022 17:18:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DBEC340F1;
        Tue,  1 Feb 2022 17:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643735911;
        bh=QCTlWYmS9EOoe3FSAuKyF+iS/GsMDs+Q+vbUb7YCgig=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Fkf5IMU3dvwqyIUm7rtcGVWFj/F+gC931f/JlE40yXNSsMPv3+LhaL5vY8eidcHL7
         7/XgoH1Romk6+3DUD0mlIH8CFvhOU4RLbuZDAqD/bqR9hMH3RLdY5OqDvn1jj6EkxJ
         DTY96Kse3fsyqNzM04kQAVKa6xXH7pBIoWuQhnunhWN8Kcz8V9OpxvuUAv/WYo/yEZ
         YoRLIvIMmIOaibIUmu2tPYiXBry9J3NAh9vA5XUzjQ9UIyfAmcZ+7A3y2LwPYuxfMi
         EkJvp+DjdbIKPrxkUCF+IwC9mrPBBO6bPV989n9OPLc4iqBGlvg1Q57oWcFzehXRk4
         bDv8OkhC+yI0w==
From:   Mark Brown <broonie@kernel.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Gross <markgross@kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
In-Reply-To: <20220121172431.6876-1-sbinding@opensource.cirrus.com>
References: <20220121172431.6876-1-sbinding@opensource.cirrus.com>
Subject: Re: (subset) [PATCH v6 0/9] Support Spi in i2c-multi-instantiate driver
Message-Id: <164373590827.2398858.14272664575079463567.b4-ty@kernel.org>
Date:   Tue, 01 Feb 2022 17:18:28 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jan 2022 17:24:22 +0000, Stefan Binding wrote:
> Add support for SPI bus in the i2c-multi-instantiate driver as
> upcoming laptops will need to multi instantiate SPI devices from
> a single device node, which has multiple SpiSerialBus entries at
> the ACPI table.
> 
> With the new SPI support, i2c-multi-instantiate becomes
> bus-multi-instantiate and is moved to the ACPI folder.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/9] spi: Make spi_alloc_device and spi_add_device public again
      commit: 941bffd7d7f5d6030a54184c5d81b0eb9116ca9a
[2/9] spi: Create helper API to lookup ACPI info for spi device
      commit: 70dd264bc07aee4f89e65138db11e908701388dd
[3/9] spi: Support selection of the index of the ACPI Spi Resource before alloc
      commit: 92640f98a78c6a3ea1ca32143144241eceb129bd
[4/9] spi: Add API to count spi acpi resources
      commit: 113962301d2d9a5c11381d9c25ddea7af71be2ff

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
