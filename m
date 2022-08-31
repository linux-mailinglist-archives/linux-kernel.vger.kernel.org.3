Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A6C5A7E00
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbiHaMw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiHaMwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:52:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FBE2D1D2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:52:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A9AF61A27
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 12:52:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333E1C433C1;
        Wed, 31 Aug 2022 12:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661950373;
        bh=DyeODZ+gC0WuqPypGEZqeNPo3/H5VBEkRk78HqWNBbc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=tS37nHwKrpgZlmSwgPfLXMSXc8KLzYFsqw+PhEjNt0e2w3YH4RgR+wIgOngkK87CG
         5JmLeXUHkBLmRBLx3JSf6F9RG5qEnRlKObLNnPRW5JH5UJAerzAGtOAfK6vCyta4BB
         0PAJTU81Vfnud1G65ol5o/j0GNR0ta/usYz0XB7gsYrNK5r0xN/AHnaT5l3e3xWVuB
         5Sl3opk0OtAQFZw2HxiTAd5PUbwJzEdKJf+2K0zBHGOl+jwtcMYEIet5Z1BYmg7TH6
         KeNce0NR4tiiEL8MR7R0SoXk2Pv7m3gHcyLcjG+xCMnElGdgaO5In27yNIgDokrEyF
         YsaGiLk5V78yQ==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
Cc:     yung-chuan.liao@linux.intel.com, lgirdwood@gmail.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        peter.ujfalusi@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org
In-Reply-To: <20220822101502.17644-1-laurentiu.mihalcea@nxp.com>
References: <20220822101502.17644-1-laurentiu.mihalcea@nxp.com>
Subject: Re: [PATCH 0/2] ASoC: SOF: compress: Add support for timestamp on capture
Message-Id: <166195037191.99184.7695234970678699743.b4-ty@kernel.org>
Date:   Wed, 31 Aug 2022 13:52:51 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-0c1df
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Aug 2022 13:15:00 +0300, Laurentiu Mihalcea wrote:
> The purpose of this patch series is to add support for
> timestamping on capture direction using the compress
> API.
> 
> This is simply done by splitting sof_compr_copy into 2
> functions: sof_compr_copy_playback and sof_compr_copy_capture.
> Each of these functions handles one of the possible directions:
> capture or playback and is called in sof_compr_copy based on
> the stream's direction.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: SOF: compress: Move sof_compr_copy functionality
      commit: 272ff8828f35658aace17e3227624fbbd68a6bcf
[2/2] ASoC: SOF: compress: Add copy function for capture case
      commit: 1a01e19278022cd2f7daa7a065ed47c5022dbad9

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
