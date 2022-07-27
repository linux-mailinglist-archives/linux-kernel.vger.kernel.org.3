Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CB9583408
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 22:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbiG0UWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 16:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiG0UWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 16:22:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A9F5F9AF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 13:22:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1131E61AAD
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 20:22:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B224EC433C1;
        Wed, 27 Jul 2022 20:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658953319;
        bh=oD9V7VnPE00dz4yqUuVgqIQpVscpbOrU9NDfS7TeMag=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Hy87mm+OftQ8pTPkrMDnGEAp7fJZ3T7ICtQs3ZOKepiXumIUL0pd/COsz2+l/K/lU
         ZlLSw9nUR4potEC9J3baapNtpsPMh5KIXjNV31YkStKsmDwyT3/sPjzeacLOjdWLXm
         jOIHQcGLFu95zepELiAr1Fobg/CItHVDxv4l94vrlmRL0NepvsNW/ZRErwLpoTHN4v
         HRjTSCHi2ErRQlHH/hgXSNsZHXXx09LWf6DI2PN0kJW1tb4UCbXe3iB9//mixKPDA8
         Ignk1QoTrTP6muB7eak/PXTPQMNqzMNBVLsJ+vlufbxHgsaN8Dcxf2VYch2c7UDMCf
         7fSf1MmpcjvuQ==
From:   Mark Brown <broonie@kernel.org>
To:     angelogioacchino.delregno@collabora.com,
        Jiaxin Yu <jiaxin.yu@mediatek.com>, dan.carpenter@oracle.com
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-arm-kernel@lists.infradead.org, aaronyu@google.com,
        linux-mediatek@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220726154220.28141-1-jiaxin.yu@mediatek.com>
References: <20220726154220.28141-1-jiaxin.yu@mediatek.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8186: remove unnecessary judgments
Message-Id: <165895331742.3760230.5472631801057984251.b4-ty@kernel.org>
Date:   Wed, 27 Jul 2022 21:21:57 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-d1cc2
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2022 23:42:20 +0800, Jiaxin Yu wrote:
> The afe_priv->dai_priv[] is allocated when platform driver probe(), if it
> failed, the ASoC platform driver probe() will return fail first.
> Therefore, this is excessive judgment, and the condition will never be
> established.
> 
> Bug report: https://www.spinics.net/lists/alsa-devel/msg145609.html
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8186: remove unnecessary judgments
      commit: d7bffbe9cbd3c96fe51a8482127cabf6fa1fd9b2

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
