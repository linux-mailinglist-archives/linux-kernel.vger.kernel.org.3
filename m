Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B00E4D1EF9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349193AbiCHRZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349365AbiCHRXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:23:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A3355BD6;
        Tue,  8 Mar 2022 09:21:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD214610AB;
        Tue,  8 Mar 2022 17:21:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495B4C340F4;
        Tue,  8 Mar 2022 17:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646760077;
        bh=r0phUWwXuodlZB9g376p0WnbRKfdUHRWw2XOE/O6cE8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=mNdns1GKRgyX9nw4gEM7EBaXTiHkW0e9F9nrn4BQ33AO3t7Ze/yUrAFKy3ii0uYdu
         tIsOi5nASBmnmjMNhzPWx9YLgxqSWD6V3Sk2rq7vcxpgVs4wLIXG1P/A3Oexp28/b+
         fR76HmJs9PZVv10MZA0TTUm228WWE+jnK/xQX3JDjGEz0n7x7MlKQboT3KrtuUMs2o
         j4UsyGBDZTqiS8TtEVG0QBXgctLu4UAGaJiqeLCYgKPpANHOUE/beFeTHatFHiQfuf
         AmZYZPZ6pH1WA776ASoVFQs/GElnyl0mlj/HiYwZW63f8TaaD7Cwp+Q3wUzlfErscn
         Nwdiyt8rGCvAg==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, nicolas.ferre@microchip.com, perex@perex.cz,
        lars@metafoo.de, tiwai@suse.com
In-Reply-To: <20220307122202.2251639-1-codrin.ciubotariu@microchip.com>
References: <20220307122202.2251639-1-codrin.ciubotariu@microchip.com>
Subject: Re: (subset) [PATCH v3 0/6] Add driver for SAMA7G5's PDMC
Message-Id: <164676007501.54315.7100142758313239597.b4-ty@kernel.org>
Date:   Tue, 08 Mar 2022 17:21:15 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Mar 2022 14:21:56 +0200, Codrin Ciubotariu wrote:
> This patch series adds support for Pulse Density Microphone Controller
> (PDMC), present on Microchip's SAMA7G5.
> The PDMC interfaces up to 4 digital microphones having Pulse Density
> Modulated (PDM) outputs. It generates a single clock line and samples 1 or
> 2 data lines. The signal path includes an audio grade programmable
> decimation filter and outputs 24-bit audio words.
> The source of each channel can be independently defined as PDMC_DS0 or
> PDMC_DS1, sampled at the rising or falling edge of PDMC_CLK.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] ASoC: dmaengine: do not use a NULL prepare_slave_config() callback
      commit: 9a1e13440a4f2e7566fd4c5eae6a53e6400e08a4
[2/6] ASoC: dt-bindings: Document Microchip's PDMC
      commit: 015044e9610c8523794ea6cb55d5388bc00ba96a
[3/6] ASoC: atmel: mchp-pdmc: add PDMC driver
      commit: 50291652af5269813baa6024eb0e81b5f0bbb451

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
