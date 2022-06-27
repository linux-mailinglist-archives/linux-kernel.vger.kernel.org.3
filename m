Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F1F55CD2F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238157AbiF0R3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 13:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbiF0R3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 13:29:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36276153;
        Mon, 27 Jun 2022 10:29:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD5A0B8191E;
        Mon, 27 Jun 2022 17:29:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EC4C3411D;
        Mon, 27 Jun 2022 17:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656350984;
        bh=EYSXweih+YDOMiCxts0AhOb41Lvp/pTKopHe0Sxihec=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=vBliBvgJFr9SKv2V8PWwKzn/v1K0IurXY7g5hKj19Rf+24F4os+yYSslflWtPyxq1
         LtQgJe/lQwAXmuBVF00XZNfVukCnoaxr6qlF20Mff3QmA83jWWZf4sZOb/08MphWB8
         z75o4NFr4YX1saVbKKOeIhmuB5J0bRwsDFaZuDvs6rbbEOdob2peqHG7lYdIKKwr9s
         xxhPbqT6t/46ddgAZfhHa4itGibuJtNZJOcLgZWtxvye2WWxnPfjt+4DB1BPUH14rU
         o06NoAAaOPLPB0HQN3AXjcAX9xTc+Wb5vJXhM5z/LQCpLeh/AMROL3us+kDo4G/iEz
         H3pAceJhwS5bQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, andi@etezian.org,
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        alim.akhtar@samsung.com, aswani.reddy@samsung.com,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski@linaro.org
Cc:     chanho61.park@samsung.com
In-Reply-To: <20220627094541.95166-1-krzysztof.kozlowski@linaro.org>
References: <20220627094541.95166-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] spi: s3c64xx: constify fsd_spi_port_config
Message-Id: <165635098231.1358681.2638254582769315943.b4-ty@kernel.org>
Date:   Mon, 27 Jun 2022 18:29:42 +0100
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

On Mon, 27 Jun 2022 11:45:41 +0200, Krzysztof Kozlowski wrote:
> All struct s3c64xx_spi_port_config should be const.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: s3c64xx: constify fsd_spi_port_config
      commit: 29f235c4098471bb6a0cde44eda1d5cfc955a2bb

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
