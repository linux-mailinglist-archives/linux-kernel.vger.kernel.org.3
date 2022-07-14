Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED28C575063
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240210AbiGNOJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiGNOJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:09:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4D810D7;
        Thu, 14 Jul 2022 07:09:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82028B825AC;
        Thu, 14 Jul 2022 14:09:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 703EEC385A2;
        Thu, 14 Jul 2022 14:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657807740;
        bh=qwEKLtdVN/QHEyKn9oc4vrJc9CADTkrNgMeyci3U86M=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=F+gUAzvqfTTFWsKKWgBiXP330hhzq8JMw+uINf0UqrrTIaTfN89CkjY37QskA8rd3
         P3Wx3niOLerQQVoDLOv2lc3m/NwHw09boQUsT+LbHfx9Sv08MigkTtAUUBD3Fl7BVg
         KD1WIEsB0+bqeYy5PqIGhSIC+0/552XkxzSaHZEwoM5nxS1rpV1KT7pv8qjKxZhU8v
         bsQ5IwbJT0zHQyS7lG/N8K+JBZLUm9FzKJdRbaS7uFSzPiGFcCkAJ+v1fVw3PF0Y0o
         HBkBwm0+GQON8ekq4fAOLuDuOa5idbmAmLIw8Y/WVzer27ikT/c3Rju7gYWhBZa80n
         uhHDUB5Ku72qA==
From:   Mark Brown <broonie@kernel.org>
To:     sergiu.moga@microchip.com, krzysztof.kozlowski+dt@linaro.org,
        nicolas.ferre@microchip.com, robh+dt@kernel.org,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com
Cc:     UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org,
        Kavyasree.Kotagiri@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        tudor.ambarus@microchip.com, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220713132908.175026-1-sergiu.moga@microchip.com>
References: <20220713132908.175026-1-sergiu.moga@microchip.com>
Subject: Re: [PATCH v4] spi: dt-bindings: atmel,at91rm9200-spi: convert to json-schema
Message-Id: <165780773718.79948.15297148088318624775.b4-ty@kernel.org>
Date:   Thu, 14 Jul 2022 15:08:57 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2022 16:29:10 +0300, Sergiu Moga wrote:
> Convert SPI DT binding for Atmel/Microchip SoCs to json-schema.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dt-bindings: atmel,at91rm9200-spi: convert to json-schema
      commit: ecff027298de72c6b0c7144baa7a76c7b2a24451

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
