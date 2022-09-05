Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1A35AD6B9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238983AbiIEPjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238391AbiIEPjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:39:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E146422EE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 08:38:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6819561331
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 15:38:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E30C4314B;
        Mon,  5 Sep 2022 15:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662392336;
        bh=BLZGHzBh5oYUyLXC7SF+E4GBdswvlK4T1kxFL5aA+CE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=a8o6eMNWU3T1UHA1gu6f+bZ3Ryw5DsQc/qecNv3j4hVyvWtWwtt3Z800BAefUyT7d
         KnQLoiWSrOvVMR9XYN5t2aWmJGIzHB/KjmrFdlnrPQTIaLkuhMZtRtYc4YTsrsfsiy
         YFGcKmeU4S6kUmq2orrZVbneD6ilVTgWuZVcIjJ76leNX0OKUDsKrmpHmaAhCAUH+N
         aLVi/i0zF6Xhei4lg5OElfbzwYXb7PKoq+krdVZdCUxnnJDEfsxG/96jNGYPb5jvUm
         W/rp9I9Sxt21q2BoglpyyEdUTxuJAwAuGu7rvcwp6P47qDUFzJYh/Xm9R4XEWRpwG0
         B6H2QbtuSmQvg==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, angelogioacchino.delregno@collabora.com,
        daniel.baluta@nxp.com, pierre-louis.bossart@linux.intel.com,
        Chunxu Li <chunxu.li@mediatek.com>,
        peter.ujfalusi@linux.intel.com
Cc:     sound-open-firmware@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, yc.hung@mediatek.com,
        project_global_chrome_upstream_group@mediatek.com,
        linux-mediatek@lists.infradead.org, alsa-devel@alsa-project.org,
        matthias.bgg@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <20220903032151.13664-1-chunxu.li@mediatek.com>
References: <20220903032151.13664-1-chunxu.li@mediatek.com>
Subject: Re: [PATCH] ASoC: SOF: Introduce function sof_of_machine_select
Message-Id: <166239233387.736206.8864417821862907650.b4-ty@kernel.org>
Date:   Mon, 05 Sep 2022 16:38:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Sep 2022 11:21:51 +0800, Chunxu Li wrote:
> From current design in sof_machine_check the SOF can only support
> ACPI type machine.
> 
> In sof_machine_check if there is no ACPI machine exist, the function
> will return -ENODEV directly, that's we don't expected if we do not
> base on ACPI machine.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Introduce function sof_of_machine_select
      commit: 354f6008b730a217a3e6ad982eda42e90e6f7473

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
