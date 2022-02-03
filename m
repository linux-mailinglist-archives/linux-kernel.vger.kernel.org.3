Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B794A878C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 16:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351828AbiBCPUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 10:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351833AbiBCPUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 10:20:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199C0C061714;
        Thu,  3 Feb 2022 07:20:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCA00B83499;
        Thu,  3 Feb 2022 15:20:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A055C340E8;
        Thu,  3 Feb 2022 15:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643901606;
        bh=d9xYYyjLcGQd3A9YZy9CgKwfJbm+OOZvRGbjp9uQSIk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=YR+G+fU8LE89RIGtzpJpoT9Qv1F2CsztnKjcWy8gmsMLkcbqi48iacJ0sPIFRSX14
         JyW1bGZ8O9qG8allHIoUiQodWoRTnVRgkAKwYvdnxVf9kljfo4h2VUmW2QN5sWVT3A
         OT2HOA4438ZOlWTjLaN7GTLN3okqYeMgj+QvBp9RsjsGvCqgVeRL/lLU+C/QPr+5EU
         +M5wScpOuYqH1iK6m2u6Ksc5DoGEVdto15sPDEGDWj8b7WJzhG1A6uTQoWHCNX7U7D
         zJRsrFV7uQElQPHw1qDWw277RSsGmrZO+0iRYOLz0fHRAKawvaXydE/vk/aFJwrrwL
         qcWwl5IFggvDg==
From:   Mark Brown <broonie@kernel.org>
To:     Li-hao Kuo <lhjeff911@gmail.com>, David Heidelberg <david@ixit.cz>,
        Rob Herring <robh+dt@kernel.org>
Cc:     ~okias/devicetree@lists.sr.ht, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <20220202104715.27839-1-david@ixit.cz>
References: <20220202104715.27839-1-david@ixit.cz>
Subject: Re: [PATCH] spi: dt-bindings: add mising description type to reg property
Message-Id: <164390160482.786892.2251619058820255831.b4-ty@kernel.org>
Date:   Thu, 03 Feb 2022 15:20:04 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2022 11:47:15 +0100, David Heidelberg wrote:
> Added missing description type.
> 
> Fixes warning:
> Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml: properties:reg:items: 'anyOf' conditional failed
> 
> Fixes: a708078eeb99 ("spi: Add Sunplus SP7021 schema")
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dt-bindings: add mising description type to reg property
      commit: 4e28b22225e3a8b7f1bd3e093301802a2238071a

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
