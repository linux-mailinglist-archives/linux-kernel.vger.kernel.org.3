Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28584D1EDD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347403AbiCHRYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349308AbiCHRW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:22:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD4855754
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 09:21:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 960D260B77
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 17:20:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA83DC340EF;
        Tue,  8 Mar 2022 17:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646760058;
        bh=wSgfdJeBnQuD5Tw0f9riM3mLX4grfj+Fq6bUvc86P64=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=OCeTIOQh9qpUvmWZfWOIAHCl07UBaqndWDIed2WZLKCEj6mM+IAu2/OlhJ/IH590C
         LpcWjyKkTwoDt7u2nBbe4ZeBMRTANTgGV3HkoH+vLArzFNOfSs+rNX8Qz0Numr2JkT
         b/LWAdoFLatB4+ZAoUxXHipZX1Y5Lo69Xx6xu/ebiAwlUu6JGnRABEBqF5epD0APUm
         8txfRgGU+zsu+02WBuxVu8dxvE3QozWxKbKaXI6nWMDN8gepdgRtDcbqk9dsE//RC4
         5eEtaNCoEjamqaakfjzWwRcbp3LiqKstoY++yeAfDkS64QrlH2MnLi/AA4FBnQglrp
         TK9zbhdiwpTBg==
From:   Mark Brown <broonie@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     alsa-devel@alsa-project.org, trevor.wu@mediatek.com,
        Tzung-Bi Shih <tzungbi@kernel.org>, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        perex@perex.cz, Project_Global_Chrome_Upstream_Group@mediatek.com,
        tzungbi@google.com, linux-mediatek@lists.infradead.org
In-Reply-To: <20220307033056.11463-1-jiaxin.yu@mediatek.com>
References: <20220307033056.11463-1-jiaxin.yu@mediatek.com>
Subject: Re: [v2] ASoC: mediatek: mt8183: support wb bt audio
Message-Id: <164676005561.54315.8574406268011125156.b4-ty@kernel.org>
Date:   Tue, 08 Mar 2022 17:20:55 +0000
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

On Mon, 7 Mar 2022 11:30:56 +0800, Jiaxin Yu wrote:
> Use "bt-sco-pcm-wb" codec dai driver for wb bt audio.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8183: support wb bt audio
      commit: 5ea14bf62ef4501c13f56fce75f6752cf643748f

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
