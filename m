Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F28560200
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 16:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbiF2OGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 10:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbiF2OGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:06:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AED32A25B;
        Wed, 29 Jun 2022 07:05:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC20061EAF;
        Wed, 29 Jun 2022 14:05:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9053C341C8;
        Wed, 29 Jun 2022 14:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656511557;
        bh=1LQiXmBKTuoLLVX2WnRC35eSF4hNdTcSZ5mG47kAXVI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QgK/lOflsccYXb2DJBBYJq/7Mf7JKwqYiQmoWe1I31oqon7gn4CZzZRX7yz2bdzwb
         ezXucMoklN8+FlYHS7yTmoStl9c0pwLT0tSWEKF+/F2RuMRhmX64VcTIKw7/pr3SA3
         1ADgB/CajiR/y6sC8dAXfQ69+ShA57b62pv5wCaYcb1E+71giUjBRcC00lRLBwoLli
         O2QkbR71LCYwIdEC2Ih+b+O9NDpBl6AdpgDReTt9GQ3ZrD1BPx8SZdul65f4cuGNGQ
         HOXL6/IW/YID0a1TFb596BKRZQIfilw3s+6GnaW6EptvB8yInPJNX2YPilmilC9RXn
         yig/IWtz+Y7Kg==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, shengjiu.wang@nxp.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Cc:     shengjiu.wang@gmail.com
In-Reply-To: <1656386005-29376-1-git-send-email-shengjiu.wang@nxp.com>
References: <1656386005-29376-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v3] ASoC: dt-bindings: fsl,micfil: Convert format to json-schema
Message-Id: <165651155548.1437597.5728269652830788201.b4-ty@kernel.org>
Date:   Wed, 29 Jun 2022 15:05:55 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jun 2022 11:13:25 +0800, Shengjiu Wang wrote:
> Convert the NXP MICFIL binding to DT schema format using json-schema.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: fsl,micfil: Convert format to json-schema
      commit: 02d91fe47100a29a79fcb8798e45c22591ca852d

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
