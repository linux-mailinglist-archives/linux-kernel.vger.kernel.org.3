Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD299521DCA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244831AbiEJPPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345220AbiEJPPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:15:02 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CC226C4EF;
        Tue, 10 May 2022 07:49:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2F6F9CE1F33;
        Tue, 10 May 2022 14:49:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01BFFC385C9;
        Tue, 10 May 2022 14:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652194177;
        bh=Te2sD/cDnoun0AwDA9vgLsTlUYlmrjjvVc6ECCVxxpU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hIU0MLSy0U+hyR4yUULyOPI3PieQ6tkGZURG/I4Dz+y3wN7FQMcaIjyArGXSlH501
         i4OI+tJXfFqeHf+KdssFjQadGcCfVK4Hz8qRXku6q2hrQARzijqwkZOX1HxcDXriCS
         MK17vqz9geYAtwDWTZJJnhMh+lq0G2kBjoVzZJz9yt7UodOZEAjDxPl9cwSvW6JASA
         OUymGcyaf3i8CuAShTtf+yD2elx0XdAHUX6K+29C+SHNqhk7TOYyv8GdARoHhVgGNT
         Gn1WPVdEzE34Ma+a8+yt/nXgSziTHn1SMqjrDIcq3csEopB/qWro43E3uw3G7ZkI9E
         pbekd+u8gNhsA==
From:   Mark Brown <broonie@kernel.org>
To:     Xiubo.Lee@gmail.com, alsa-devel@alsa-project.org, perex@perex.cz,
        krzk+dt@kernel.org, shengjiu.wang@nxp.com, lgirdwood@gmail.com,
        nicoleotsuka@gmail.com, festevam@gmail.com,
        devicetree@vger.kernel.org, shengjiu.wang@gmail.com,
        robh+dt@kernel.org, tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1652087663-1908-1-git-send-email-shengjiu.wang@nxp.com>
References: <1652087663-1908-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH 1/2] ASoC: fsl_micfil: Add support for i.MX8MPlus
Message-Id: <165219417472.388769.13970240077661005048.b4-ty@kernel.org>
Date:   Tue, 10 May 2022 15:49:34 +0100
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

On Mon, 9 May 2022 17:14:22 +0800, Shengjiu Wang wrote:
> On i.MX8Plus there are two updates for micfil module.
> 
> One is that the output format is S32_LE, only the 24 more
> significative bits have information, the other bits are always
> zero. Add 'formats' variable in soc data to distinguish the
> format on different platform.
> Another is that the fifo depth is 32 entries.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: fsl_micfil: Add support for i.MX8MPlus
      commit: cb05dac1bc34ad701972503ca1a75b51ae4478ff
[2/2] ASoC: dt-bindings: fsl,micfil: Add compatible string for imx8mp
      commit: 7b46eb1bf9534a75ff072a01e774b79e6a17cfdd

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
