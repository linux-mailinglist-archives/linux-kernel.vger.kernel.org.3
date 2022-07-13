Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB14857390A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236573AbiGMOmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236316AbiGMOmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:42:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CF4255AF;
        Wed, 13 Jul 2022 07:42:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23D5361DFD;
        Wed, 13 Jul 2022 14:42:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10143C34114;
        Wed, 13 Jul 2022 14:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657723319;
        bh=EesIxIgOr7jZcR+5H8sF24f8wwa1pocLRdaJoenkPss=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=NK7ewaG/00mmoes0KUDNTLxjh0PMWg7p/eR8Y+SxDUu2V89fiYh8uLMk4z9H43Ecu
         9BxNWN155jIYxo+gKHgk8LJ/C+lzkcPQTiDKqucjYPAq6sYtPoQjzENmlwnpC1d7f9
         QZUYt3KMMdqcl6ShC8jLBRX16GgLuP2FN22oB3+IUUsM9Vfx2HvVih3V3R5tOkBR1M
         Aj3QQ3KcR/EQPEYQ0MTS+xd83hR/QSdZEujaCMsFeA+7I4n/GPds0r6XLUC6s/lrso
         PxRgzDiXnFf9uqdRTi2i6AHWP459+b8aRmPBvqCv6sbbFI9RcEtATWhRadRUsx0FnO
         r0cilnVR79zYg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, nandhini.srikandan@intel.com,
        robh+dt@kernel.org, fancer.lancer@gmail.com,
        linux-spi@vger.kernel.org
Cc:     mahesh.r.vaidya@intel.com, kris.pan@intel.com,
        furong.zhou@intel.com, kenchappa.demakkanavar@intel.com,
        rashmi.a@intel.com, devicetree@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, mgross@linux.intel.com
In-Reply-To: <20220713042223.1458-1-nandhini.srikandan@intel.com>
References: <20220713042223.1458-1-nandhini.srikandan@intel.com>
Subject: Re: [PATCH v6 0/4] Add support for Intel Thunder Bay SPI controller
Message-Id: <165772331678.125140.17555799988893027082.b4-ty@kernel.org>
Date:   Wed, 13 Jul 2022 15:41:56 +0100
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

On Wed, 13 Jul 2022 12:22:19 +0800, nandhini.srikandan@intel.com wrote:
> From: Nandhini Srikandan <nandhini.srikandan@intel.com>
> 
> 
> This patch enables support for DW SPI on Intel Thunder Bay.
> This patch set also enables master mode for latest Designware SPI versions.
> 
> Patch 1: Fixed dw_spi_ip_is macro with the missing underscore.
> Patch 2: DW SPI DT bindings for Intel Thunder Bay SoC.
> Patch 3: Adds master mode support for Designware SPI controller.
> Patch 4: Adds support for Designware SPI on Intel Thunder Bay SoC.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] spi: dw: Fix IP-core versions macro
      commit: 5d76b7509cb223e94ff73a672273e58f1957ac68
[2/4] dt-bindings: spi: Add bindings for Intel Thunder Bay SOC
      commit: 0d085723c637fd6929b8926a2963de1c2307cfa1
[3/4] spi: dw: Add support for master mode selection for DWC SSI controller
      commit: 51e41dc2f2bc7e7c8d5b8202a23eae3ee6056131
[4/4] spi: dw: Add support for Intel Thunder Bay SPI controller
      commit: dc4e6d9fbf9a39f7df71e8c262282aa1915452d8

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
