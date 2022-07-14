Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EE2575060
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240196AbiGNOJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240221AbiGNOI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:08:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487812727;
        Thu, 14 Jul 2022 07:08:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FD446210F;
        Thu, 14 Jul 2022 14:08:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2F8C34114;
        Thu, 14 Jul 2022 14:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657807737;
        bh=fCew/Myxuz1aqXtjVjtX6krnEo5yDwCjjBTFanDafVs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MWVv0ipZkZtXAcBMoZTxFAF+HO0NNKdW33ZcXoMqwp85ElkyiqZn3vtPD/V5TWK+S
         MvRSCNfxuIaj5J9Au2JonSgVPHp3t+qgpIY7wDld0Rsul48TYBmwV0/Swz4p4fOQkE
         wyf0iqv05Xf4AJz7HRs+TyyqDOQsI3dGzIDQkiWp9Bt/BcgZNrGKjDJheqCvi86LcL
         HcyCaAyZclHVJDomw8lchUgEdFNKEICu0XxdrEojDhjDttveMP43W0a8JJOe0EtU9o
         /gsPWBvxmvCLn7ROBK9jjuwISErJwE2hc+b5nyz4Ds6OW7tR++6BKxwujfPibGLnRY
         0pVCECr+tMgOw==
From:   Mark Brown <broonie@kernel.org>
To:     sergiu.moga@microchip.com, krzysztof.kozlowski+dt@linaro.org,
        nicolas.ferre@microchip.com, robh+dt@kernel.org,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com
Cc:     UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org,
        Kavyasree.Kotagiri@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        tudor.ambarus@microchip.com, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220712162554.148741-1-sergiu.moga@microchip.com>
References: <20220712162554.148741-1-sergiu.moga@microchip.com>
Subject: Re: [PATCH v3] spi: dt-bindings: atmel,at91rm9200-spi: convert to json-schema
Message-Id: <165780773409.79948.17721256972957772200.b4-ty@kernel.org>
Date:   Thu, 14 Jul 2022 15:08:54 +0100
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

On Tue, 12 Jul 2022 19:25:55 +0300, Sergiu Moga wrote:
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
