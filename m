Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809AD4A77AE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 19:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346551AbiBBSQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 13:16:43 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44206 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237657AbiBBSQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 13:16:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFA5F618BC;
        Wed,  2 Feb 2022 18:16:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A0AC340EC;
        Wed,  2 Feb 2022 18:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643825801;
        bh=fh9fVTskiyEHoa27YSivtOQn6L49xcyj1O7qRCi8oYQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Xo4M7HFJhcA0wZ9F1A5+6kJ/pj0KuWIWeKkIeAYemG355yz5p4+EHeasL2WyB0mTX
         fcSLSOhvtkCZve191LpledYeTBDXQRYwOLlu94wQ4VIhgjc/KxB89fuUuce5dy+37u
         PieGvTcFLsm1gdaggflYBB8As+WDNBUvaU9KXXHJ5bApDqrwQ2eg+NeArb69mknP6r
         mtUmow+0M6gAUaoHH3X/BA10MHNuuPKbq8GOI+44VlOZtQzEZ2DtQi9iCY7qV3Q+BB
         Rosakpihod8RINV+IXpyepxot8Arrv8Rf+yow2MOBBxPRDwkNQbkmghuCCRrBi4Vv5
         Y7FGzZWwsXCiA==
From:   Mark Brown <broonie@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-spi@vger.kernel.org,
        Linux ACPI <linux-acpi@vger.kernel.org>
In-Reply-To: <2231987.ElGaqSPkdT@kreacher>
References: <2231987.ElGaqSPkdT@kreacher>
Subject: Re: [PATCH] spi: Replace acpi_bus_get_device()
Message-Id: <164382580003.3628373.14125155104405192519.b4-ty@kernel.org>
Date:   Wed, 02 Feb 2022 18:16:40 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Feb 2022 21:05:59 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Replace acpi_bus_get_device() that is going to be dropped with
> acpi_fetch_acpi_dev().
> 
> No intentional functional impact.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Replace acpi_bus_get_device()
      commit: 7030c428fae100c339436f5cb6f9e7c0574097ad

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
