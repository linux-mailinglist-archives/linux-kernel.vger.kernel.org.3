Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0488057BEC3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 21:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbiGTTnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 15:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiGTTnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 15:43:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24BF5508E;
        Wed, 20 Jul 2022 12:43:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C4CF61B98;
        Wed, 20 Jul 2022 19:43:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93CCFC3411E;
        Wed, 20 Jul 2022 19:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658346186;
        bh=PnFEDzlN7mX92Wmglf1wrhAi7PN1WR65H5TpqJw7YAA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=PbvTSz0zl6XDNeT/6lXsvFkeYyD8SNq/0/k6ZBeHAMhsCh4g+tm+DclKVN+6Saiby
         z0P3Gl09jkwjmCfKjgaaiJEuwW+r71c1KdEqRXL+u/Hv++ow5l8e7oMBv9iiOGU3ey
         bwJbDKcfM3+GzH0Vr0hSGoapVlNCc3OSj5ogDvO8QbdXh6bQOLeU3jEeciMxALZGhJ
         Lm+6aHjMascnccl4ZNo64oHTp5E603S/pZyaqZNfDyU/FkL0P/ojJtkjx3viqi5Vgt
         fqFyMXa0+QukVxWFilfLX0vwnBhvSeBEKIg53tCJ5pIWkNQOLH88rMKDyg0Ghxc39c
         f9j58/PQxa1Rw==
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org, nicolas.ferre@microchip.com,
        Ryan.Wanner@microchip.com, alexandre.belloni@bootlin.com,
        krzysztof.kozlowski+dt@linaro.org, claudiu.beznea@microchip.com,
        lgirdwood@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20220715162922.660859-1-Ryan.Wanner@microchip.com>
References: <20220715162922.660859-1-Ryan.Wanner@microchip.com>
Subject: Re: [PATCH v3 0/2] ASoC: dt-bindings: atmel-classd: Convert to
Message-Id: <165834618426.685508.3523782122255231487.b4-ty@kernel.org>
Date:   Wed, 20 Jul 2022 20:43:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 09:29:20 -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> This patch series converts atmel-classd and atmel-pdmic device tree
> bindings to json-schema.
> 
> v1 -> v2:
> - Fix commit formatting.
> - Fix titles in yaml file.
> - Removed trivial descriptions.
> - Correct formatting errors.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: atmel-classd: Convert to json-schema
      commit: a3b19e0c9cdd0ece48f34f68f922764f26435f73
[2/2] ASoC: dt-bindings: atmel-classd: PDMIC convert to json-schema
      commit: ca0e30b19dbe5f23cf0abe047259a9e9495624c6

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
