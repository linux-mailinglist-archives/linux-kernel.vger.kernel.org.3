Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B161A5469FA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 17:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349435AbiFJP7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 11:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349352AbiFJP7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 11:59:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F102B1EBEFD;
        Fri, 10 Jun 2022 08:59:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C1BF62002;
        Fri, 10 Jun 2022 15:59:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EECDC34114;
        Fri, 10 Jun 2022 15:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654876742;
        bh=jI2yfO2X8nFkVbq8tQhcl36qrbDRJRICzwMQDeEzgPk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=G/B4l5oDGx1fnGfoKuzs+vRiVvkTDQsN9Tp8t41q+oERC+RR8xKngn6fhhHjTVfPI
         bl+zpu9j4uYI0kGrelgJqcHyZPwxhnaVv1eg6qCfWPi3+SXfvRBfjrK7Fjs2qmzncA
         fjLq1niNhv4fb7vatwdilEJPbkMXK4GpJR8Zg+LVVFileoaDknA1YNcbL41D5YzWCc
         JkY2nSAYTffDHFDTfF5hfAzQXwnSC1l+aH360ZoXjxWHPFGdZWV5RFqVYtmWyLTcuJ
         yeWx2KuPqS0YEG4mI1Fkimz7zEERnp3hYqh0Zg3DnlSYmjOnGjsiqW+2P6Sr9dlB4P
         h3LjosEv57Hew==
From:   Mark Brown <broonie@kernel.org>
To:     tudor.ambarus@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20220609084246.1795419-1-claudiu.beznea@microchip.com>
References: <20220609084246.1795419-1-claudiu.beznea@microchip.com>
Subject: Re: [PATCH 0/3] spi: atmel-quadspi: add runtime pm support
Message-Id: <165487674116.1756526.16695078743655371627.b4-ty@kernel.org>
Date:   Fri, 10 Jun 2022 16:59:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jun 2022 11:42:43 +0300, Claudiu Beznea wrote:
> The following series adds runtime PM support for atmel-quadspi driver.
> clk_disable()/clk_enable() is called on proper
> runtime_suspend()/runtime_resume() ops. Along with it 2 minor cleanups
> were added (patches 2/3, 3/3).
> 
> Thank you,
> Claudiu Beznea
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: atmel-quadspi: add runtime pm support
      commit: c349fad389c5916facead610d454250f67cfb20b
[2/3] spi: atmel-quadspi: use pm_ptr()
      commit: f11ec1cc46e38f0feac3721a03c21fa99167e329
[3/3] spi: atmel-quadspi: align condition to parenthesis
      commit: af7c2d4145b57c15d25a092cfb5a91708c72b541

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
