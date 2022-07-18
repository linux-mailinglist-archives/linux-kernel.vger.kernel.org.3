Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF20578523
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbiGROQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbiGROQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:16:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161105FA2;
        Mon, 18 Jul 2022 07:16:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A157A60A6D;
        Mon, 18 Jul 2022 14:16:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8970EC341CF;
        Mon, 18 Jul 2022 14:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658153770;
        bh=anQAhzj0hNoAoDauWAq911k+RDOaRL0GEvj3qKhtGY4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=b/Pa9E/Jr2Gd3SQoqBG6Msxj+sN6828QlFO2lDwMzyRfpchng/INs/htM6GMgPNlh
         ioa2jELQfHiLejSc6ItPg4PBxCmjwQkFZ0jZ5NpMBYuri7Ycq5+W2Wnu24j3i9ur3g
         VTQ8uX8d10lEj4z3UgYzameKLbiJ7sL1kXAMbFiEHE0jyOBNhn3EmByg3YU7cMaUkW
         Gc7bbAu6EkWuhx5zc8yZuVKUxt/ZiBDRyNuSzbcKb+Vpi0CPFu2w+GxJTTwbZpG8hz
         odgbVtlB5vKG0lSvvFvcR4Eo8oYXc2M728bi3te0Ga6RbEx/BDEhIGXuh58le5ywFY
         RMocPiTrjUK2Q==
From:   Mark Brown <broonie@kernel.org>
To:     claudiu.beznea@microchip.com, tudor.ambarus@microchip.com,
        alexandre.belloni@bootlin.com, nicolas.ferre@microchip.com
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20220718071052.1707858-1-claudiu.beznea@microchip.com>
References: <20220718071052.1707858-1-claudiu.beznea@microchip.com>
Subject: Re: [PATCH] spi: atmel: remove #ifdef CONFIG_{PM, SLEEP}
Message-Id: <165815376828.235243.1985340166357749822.b4-ty@kernel.org>
Date:   Mon, 18 Jul 2022 15:16:08 +0100
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

On Mon, 18 Jul 2022 10:10:52 +0300, Claudiu Beznea wrote:
> Remove #ifdef CONFIG_PM, #ifdef CONFIG_PM_SLEEP and use
> SYSTEM_SLEEP_PM_OPS() and RUNTIME_PM_OPS() macros instead which allows
> getting also rid of __maybe_unused in the code.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: atmel: remove #ifdef CONFIG_{PM, SLEEP}
      commit: a3fd35be0eda760610a63e179ad860189b890f0b

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
