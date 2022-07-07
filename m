Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B51756A48D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235684AbiGGNzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236040AbiGGNys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:54:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98AC1A812;
        Thu,  7 Jul 2022 06:54:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8AF50B82224;
        Thu,  7 Jul 2022 13:54:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66694C341C6;
        Thu,  7 Jul 2022 13:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657202047;
        bh=bfSNl/kqtaSioIPpTfl5sDM6mMgQPB4Brm2wjepEylM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SPH64QzAwqsLdDnV122DcfIvEvPg6xn5BSGyzcOc3Yh5yuFj+R3dAE4uUJ0xyyP6v
         ylQ7sr3W2x4ZU1hfupBc0JZZCbLFlRYdG58eDvDioEvc4yPcSuJWIlRfOmKB66VQSD
         8rgB6Gli0tjmr903J8LB5t6gWX/J/F4lfS8dPo5oLGgSSPyNkXnkHlFoyLLe2ENgSD
         ACCBnhTe8oX6v21mHV+Vkz/uVbdW1Dxhs8E3iMZnvuSxlLsijX6INZpEsLa9kX87tu
         mqg2DXK3AXs2md4iuelpv4yjDEVSJ0ja+5zLhg+O5EPtfE7hyNYxAOZrWhlj0sEfqD
         Zn7W3wZFmAEpA==
From:   Mark Brown <broonie@kernel.org>
To:     paul@crapouillou.net, aidanmacdonald.0x0@gmail.com, tiwai@suse.com,
        lgirdwood@gmail.com, perex@perex.cz
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20220706211330.120198-1-aidanmacdonald.0x0@gmail.com>
References: <20220706211330.120198-1-aidanmacdonald.0x0@gmail.com>
Subject: Re: (subset) [PATCH 00/11] ASoC: cleanups and improvements for jz4740-i2s
Message-Id: <165720204509.3916612.8521005481587535129.b4-ty@kernel.org>
Date:   Thu, 07 Jul 2022 14:54:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2022 22:13:19 +0100, Aidan MacDonald wrote:
> This series is a preparatory cleanup of the jz4740-i2s driver before
> adding support for a new SoC. The last two patches lift unnecessary
> restrictions on sample rates and formats -- the existing ones appear
> to be derived from the limitations of the JZ4740's internal codec and
> don't reflect the actual capabilities of the I2S controller.
> 
> I'm unable to test the series on any JZ47xx SoCs, but I have tested
> on an X1000 (which is the SoC I'll be adding in a followup series).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/11] ASoC: jz4740-i2s: Remove Open Firmware dependency
        commit: 98356c89d44dac838dfbab02975645d828de3099
[02/11] ASoC: jz4740-i2s: Refactor DMA channel setup
        commit: 8a7691010992886290b340a1ba943067c2e70f85

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
