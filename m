Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFFBE4767DB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 03:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbhLPCV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 21:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbhLPCVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 21:21:25 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4CBC061574;
        Wed, 15 Dec 2021 18:21:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C62D1CE1FD2;
        Thu, 16 Dec 2021 02:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E83FC36AE1;
        Thu, 16 Dec 2021 02:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639621282;
        bh=De1MrH3eP1ytxROVw6moLHf969b21GpHp9ByMYABKSI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MUDfEyeYXedtPQZrd2Exfczu0ZFYL9AgssxE/0zw+dbRG1tR3gWlGND0YsdGqhcan
         UcWHxYDRN13oaOnj9cbF8NAjLlmz3WgP6EckyLbumR41aRQGKj1Bi6hCPEcrYcGC0y
         HstW1EnQeHTeS30nxCLAjWsAlS2OrLIpAE3X7BBA95xCTj1StpKTf8dQw7/ArpIXnr
         U94dQiVmvpVOFOQPzn1lAGDSkDhSp2elbZmwnw47/DlF2u54VpI0o9TKvzTb9xzR9r
         1/arHeRInG8RvgNBmBgNXeZaVQ8RpG3Rh05V0f3ryMl/QWIQw0DrQVIc0srb2zJSjb
         lVvHB0Rm57i9w==
From:   Mark Brown <broonie@kernel.org>
To:     Wolfram Sang <wsa@the-dreams.de>, Stephen Boyd <sboyd@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Len Brown <lenb@kernel.org>, Kate Hsuan <hpa@redhat.com>,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-clk@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, platform-driver-x86@vger.kernel.org
In-Reply-To: <20211203102857.44539-1-hdegoede@redhat.com>
References: <20211203102857.44539-1-hdegoede@redhat.com>
Subject: Re: (subset) [PATCH v7 00/14] Add support for X86/ACPI camera sensor/PMIC setup with clk and regulator platform data
Message-Id: <163962127796.2075461.6086847444730016805.b4-ty@kernel.org>
Date:   Thu, 16 Dec 2021 02:21:17 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Dec 2021 11:28:43 +0100, Hans de Goede wrote:
> Here is v7 of my patch-set adding support for camera sensor connected to a
> TPS68470 PMIC on x86/ACPI devices.
> 
> Changes in v7:
> - Drop "platform/x86: int3472: Enable I2c daisy chain" this workaround is
>   no longer necessary (the regulator code now takes care of this)
> - Fix using PTR_ERR(data->clk) instead of PTR_ERR(rdev) to log an error
>   code in "regulator: Introduce tps68470-regulator driver"
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[05/14] regulator: Introduce tps68470-regulator driver
        commit: 0fc31d8f1a8ad17224f6423e3ed6234507375d48

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
