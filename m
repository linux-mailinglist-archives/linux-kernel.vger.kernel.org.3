Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF96A59331F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 18:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbiHOQZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 12:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiHOQZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:25:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730E724F2A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 09:22:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED6E0611E7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 16:22:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F04EC433C1;
        Mon, 15 Aug 2022 16:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660580577;
        bh=txviIWtgKTn8W5exAoYk95kSN70u4fkOZHI4CSdKYT8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Cg3MlLbKmC3avMOv0ogKD3gV6WtTd0JHOptirGE/1EP4DR4rU92emDbPnaE8MIBqM
         LaNLN0RRIjl6jWU3Ruvv5ptdqHalrK5y88utWRDS0cE1NQzHcDfwCVtGWxx07lWeXi
         d/BzYj3bMA6f48KwrPw4NiLqPhHGkOwSbfxX22eeoQYqublqmmFebixnQjXisP3oGP
         iW1Je/RRWEXO+fdAFUrS8CoAg+sCVPntu+1pEsz892H20anFL9K1eMMO3YmYpU4umk
         W58vjGVXX6ryhDGlAXXVYVgzSi41DwOzmzYolMKochsWadAnkT0A1EPyhVl+SLc9fB
         ZZeze+B6qVPDQ==
From:   Mark Brown <broonie@kernel.org>
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Brent Lu <brent.lu@intel.com>, xliu <xiang.liu@cirrus.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220801094034.3927841-1-sbinding@opensource.cirrus.com>
References: <20220801094034.3927841-1-sbinding@opensource.cirrus.com>
Subject: Re: [PATCH v3] ASoC: Intel: cirrus-common: Use UID to map correct amp to prefix
Message-Id: <166058057529.769843.6686706298009723312.b4-ty@kernel.org>
Date:   Mon, 15 Aug 2022 17:22:55 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fe10a
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Aug 2022 10:40:34 +0100, Stefan Binding wrote:
> Since the order of the amps in the ACPI determines the device name,
> and the ACPI order may change depending on hardware configuration,
> use UID to dynamically compute the dai links, allowing dynamic
> assignment of the name_prefix.
> 
> The UIDs for these amps in ACPI are fixed, and map to a name_prefix,
> where:
> UID 0x0 -> WL
> UID 0x1 -> WR
> UID 0x2 -> TL
> UID 0x3 -> TR
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: cirrus-common: Use UID to map correct amp to prefix
      commit: 1ca726424a12962f2c2656cc9cdd0b8668117e8f

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
