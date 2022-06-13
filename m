Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D2A549D5C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348078AbiFMTUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351257AbiFMTTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:19:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F8C53711;
        Mon, 13 Jun 2022 10:24:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58F3260C7C;
        Mon, 13 Jun 2022 17:24:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE14C34114;
        Mon, 13 Jun 2022 17:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655141069;
        bh=Ytg1O0ZnWN5OTWz6shxsOZCb9jEbZHGc71Fqqpj9HYQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=VOZ9whWtDqTEXBLPpw8fAFY9Z/rPqKNVKU0ybnGewq4UL9zWOJLSxkUfE7LmrQ0uI
         7MpviS+7JyCy7DVqy/pc5UfFJrfp+Y6QEknhDSo+NxofDb2ZyIlmxf1PJehTlUcqP3
         7loQ9SucdK6itgT+7Q96NhEwONdaArUDSLdCSROwjTd/vMuPl8+mSvW1+DybJ2Jjxv
         BP4G8R44bEEaBhQPCGHjWUBvo9iYNVZ1AF+C95A44K7Q69QM7CcQloeHg5rA+l+ZcU
         Lgqw+mt08B+6wXOWpabL5sG+3qL06ms68AMJXUp6vhT55bc97wYJbL33kmCyX7Kwt+
         2feBQiG5DG0hQ==
From:   Mark Brown <broonie@kernel.org>
To:     jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        ashishsingha@nvidia.com, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, thierry.reding@gmail.com,
        kyarlagadda@nvidia.com
Cc:     skomatineni@nvidia.com, devicetree@vger.kernel.org,
        ldewangan@nvidia.com, linux-kernel@vger.kernel.org
In-Reply-To: <20220513080828.22079-1-kyarlagadda@nvidia.com>
References: <20220513080828.22079-1-kyarlagadda@nvidia.com>
Subject: Re: [Patch V2 0/3] spi: tegra quad: Add Tegra Grace features
Message-Id: <165514106736.671611.17346483728237955492.b4-ty@kernel.org>
Date:   Mon, 13 Jun 2022 18:24:27 +0100
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

On Fri, 13 May 2022 13:38:25 +0530, Krishna Yarlagadda wrote:
> Add multiple chip select lines supported on Tegra 241
> 
> Changes in v2:
> Split Wait polling changes to be handled later
> Change chip name to convention followed (Grace to 241)
> Add tegra qspi peripherals yaml file
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: tegra210-quad: Multi-cs support
      commit: b76134178168b5104851b3c72d9b1092b7414ff9
[2/3] spi: dt-bindings: split peripheral prods
      commit: e23917822d3cb1f5270ab0d327da713cda72f8f2
[3/3] spi: dt-bindings: Add compatible for Tegra241 QSPI
      commit: 4f37809f4cdf0cdb8d4431e779f56d1f0dec3fb5

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
