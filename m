Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FB74F7BDA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243883AbiDGJlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243888AbiDGJkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:40:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B5E1B60AF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:38:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6ACA661BA3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 09:38:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD2FC385A0;
        Thu,  7 Apr 2022 09:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649324310;
        bh=adF1/u6h/yegMPzzisg329Q0g2d5Lbh7VljvdQ1YYYQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hCB1/fkwTCH2unz21ih2gLjBEiMAF1KdSZ4WhRN7qciOvwFUNath4zjir7qUW39SQ
         rZ9ydITNmrSTo9uy0qz2Jb0SC09klswxG74knIkPS6dqMfiL9z7+E/Dxv2P+sLv1eu
         DlVweSMnx5z8PlQBgwaL4lIqzWA9sKGFRGWqp//PgpyYBzq/wrUiUArljpVmc3wwca
         BlT9CRatUmEZS5l2DobvxXsbqMGTrAqkTXmoUDKkF8uV2AQ9PNcdAp7IsiAkb3LVzy
         QpRvkBkGgUJap8Hzke30OEjz0QLJX1gVYBxplxXdMMwsRzfPGhOqAwp5WdiRRM519l
         AnDKbSNXc0IGw==
From:   Mark Brown <broonie@kernel.org>
To:     steve@sk2.org, lgirdwood@gmail.com
Cc:     patches@opensource.cirrus.com, wsa@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220405122411.2096387-1-steve@sk2.org>
References: <20220405122411.2096387-1-steve@sk2.org>
Subject: Re: [PATCH v2] ASoC: wm*: use simple i2c probe function
Message-Id: <164932430929.3844153.715158855370193185.b4-ty@kernel.org>
Date:   Thu, 07 Apr 2022 10:38:29 +0100
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

On Tue, 5 Apr 2022 14:24:11 +0200, Stephen Kitt wrote:
> The i2c probe functions here don't use the id information provided in
> their second argument, so the single-parameter i2c probe function
> ("probe_new") can be used instead.
> 
> wm8731.c is excluded and will be submitted separately.
> 
> This avoids scanning the identifier tables during probes.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm*: use simple i2c probe function
      commit: 97b0b6e3fb8a390205f3266b1fba3e195b9edf30

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
