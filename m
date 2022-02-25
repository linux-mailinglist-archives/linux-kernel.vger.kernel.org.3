Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184594C4C80
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243816AbiBYRgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243832AbiBYRgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:36:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290B01DF853;
        Fri, 25 Feb 2022 09:36:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6DBCB832CB;
        Fri, 25 Feb 2022 17:36:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06304C340E7;
        Fri, 25 Feb 2022 17:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645810568;
        bh=QPiQ0/Y3PgpODkPwCxa8qFsECGEgnhU38/p/hdBcPNs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=d3j+jLgkWmnUiY2e7rDCPZH5HeVPykaBRziJwuA/tAYyUvC0wk2XsslZDFX1aPUkQ
         mEfvfV/imwvCB6G20ZmD9OskZ2ZQJBC2l7EYJRtQpPKDDS9yLZytKZktWiL0I8zqY8
         RK4brKxEJfUhlD6UeRG51cUBlvljYK2+szZhGtMES7/9zeMCHVZV/p+KxSxFMSzFOV
         ebrsbzfApyrmgCjV821thZFxopup27Eskm5Q8EBdj77DRX3PwEpXrdNKw4vEhMJR1K
         krY7NFweAE5uwisyTvwTFDPoTGpYtMjPIJZA3H9VaT5MiUL22ao9LinC1Wrgj0iESy
         B/fNJpe9UllGQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Li-hao Kuo <lhjeff911@gmail.com>,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, lh.kuo@sunplus.com
In-Reply-To: <097bbc8b703b17e8fb3e3f6f6d2f97fe668bd5c5.1645770648.git.lhjeff911@gmail.com>
References: <097bbc8b703b17e8fb3e3f6f6d2f97fe668bd5c5.1645770648.git.lhjeff911@gmail.com>
Subject: Re: [PATCH] spi: dt-bindings: remove unused required property
Message-Id: <164581056673.2562676.17852885347289085467.b4-ty@kernel.org>
Date:   Fri, 25 Feb 2022 17:36:06 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Feb 2022 14:31:53 +0800, Li-hao Kuo wrote:
> fix issue
> /builds/robherring/linux-dt/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.example.dt.yaml:
> spi@9C002D80: 'clocks-names' is a required property
> From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
> delete unused required(clock-name)
> 
> Fixes: 3b8ab4da34 ("spi: Fix test error for sp7021")
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dt-bindings: remove unused required property
      commit: 83854c231262d2ad43c4fb32414ba25304f925d8

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
