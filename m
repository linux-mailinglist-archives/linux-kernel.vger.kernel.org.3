Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C9E53EC56
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241644AbiFFQNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 12:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241595AbiFFQNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:13:36 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E8A1248D3;
        Mon,  6 Jun 2022 09:13:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0E8B8CE1C04;
        Mon,  6 Jun 2022 16:13:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130A0C34115;
        Mon,  6 Jun 2022 16:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654532012;
        bh=KzlsCY5EneODGrRzogwzoUlBLdPUtIfNZ9l+NxOzLQc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=NlF6jaNtP+Vg7t9azUkk8f/rm25iImW2yfh9pKiK4/70IPqxibkL2erZQhw2UYOcP
         vt/NRoRxJvq47TG1PtQzNL0E4Q4B8QEnaImnKmyr4h6r7P/4PEehpe53vEuMnpR/kk
         jkR9PzOm6yeXoLIGKjhB/9pyTzs5ofg6CgoYfEiJtbu5C6/iLakxm7s9ZOdW3qab1e
         A+cOpvre8Zcvd6kE2ACj/DLCNNGTYMK7hkA9j80002gk/YcMY6svCH+UHC4Mocjg2O
         ziDdANo+53zRL/IjcxRwLKFF9xcRI8yMxoCq4/BqfJO6zLglQAhJgpVv8H4d+JIJY1
         f1GhV/Dht7z5Q==
From:   Mark Brown <broonie@kernel.org>
To:     conor.dooley@microchip.com, agross@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bjorn.andersson@linaro.org,
        robh@kernel.org
Cc:     krzysztof.kozlowski@linaro.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220526014141.2872567-1-robh@kernel.org>
References: <20220526014141.2872567-1-robh@kernel.org>
Subject: Re: [PATCH] spi: dt-bindings: Fix unevaluatedProperties warnings in examples
Message-Id: <165453200977.2010189.2397395940075983324.b4-ty@kernel.org>
Date:   Mon, 06 Jun 2022 17:13:29 +0100
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

On Wed, 25 May 2022 20:41:41 -0500, Rob Herring wrote:
> The 'unevaluatedProperties' schema checks is not fully working and doesn't
> catch some cases where there's a $ref to another schema. A fix is pending,
> but results in new warnings in examples.
> 
> 'spi-max-frequency' is supposed to be a per SPI peripheral device property,
> not a SPI controller property, so drop it.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dt-bindings: Fix unevaluatedProperties warnings in examples
      commit: 6aa27071e4354c351d98e345fc888b70f335f185

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
