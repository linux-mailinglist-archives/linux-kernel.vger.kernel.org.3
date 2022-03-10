Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A414D45BD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 12:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241624AbiCJLgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 06:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234690AbiCJLgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 06:36:09 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9110BF8BBD
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 03:35:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0E936CE2334
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 11:35:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB15C340E8;
        Thu, 10 Mar 2022 11:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646912105;
        bh=Kzo5oQox5Nnel/38kZiqDln1P20PREc101+795Z1V7c=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qFauxTg1BU2FdfoSiVOiocSCMlFeo9MhYRkQ2oTbBtEVRfevq0tJyK9krLjZVYmJt
         bzjREotceLzp785GLQ83/HildcEa4Rj190aiEOcQpgrWAhmsVIaHMP26RnYxfaFKGt
         4xupO7YzOiLibrRAzbP1LTUPzicZoPtkX6rojHn7WKHhyEOrVnacFOW8yaxGGnAUI8
         6pcBNd22XaM7nSTZHrAuqzksrhWLndv+jAKHrIWvdUW5m+/vCSwJcwXizn9ELmtU0c
         L1icLh0bl1DK+86gmDsiwEWh7tjNh/wE4gluBpahLtB3/GbkjYxJ6m7zmubpBsBL9B
         sozGB3lQkl7zQ==
From:   Mark Brown <broonie@kernel.org>
To:     Simon Trimmer <simont@opensource.cirrus.com>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220309130017.2816-1-simont@opensource.cirrus.com>
References: <20220309130017.2816-1-simont@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: wm_adsp: Compressed stream DSP memory structs should be __packed
Message-Id: <164691210413.13776.14038216361749418209.b4-ty@kernel.org>
Date:   Thu, 10 Mar 2022 11:35:04 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2022 13:00:17 +0000, Simon Trimmer wrote:
> The compressed stream code has a bunch of structs that are used to
> represent DSP memory but have not been marked __packed. This isn't
> safe, they could get padded on a 64-bit build.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/1] ASoC: wm_adsp: Compressed stream DSP memory structs should be __packed
      commit: 353bb6a5f2ac495f289b7c7a528c7d134c9a8ec4

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
