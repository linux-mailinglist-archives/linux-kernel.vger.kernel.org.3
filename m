Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B6A486B19
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 21:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243796AbiAFU20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 15:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243787AbiAFU2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 15:28:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57170C061212
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 12:28:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 207ADB823F5
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 20:28:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19B8C36AE5;
        Thu,  6 Jan 2022 20:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641500899;
        bh=WJ2sfcxn6GVvDjVhkMuBqAzdc3GwgvrPGmKcfFu60ec=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=K0B2TiIiP/OB5JpWTBCGOLDpev+HYLQW3HR3vjJ/2pGG53/TaYk6exXM6T+eC4waY
         LFxUtOajGRr09bpzsDMVd5Qc96WRBKtIwqEFN3FbmYLs/3PPd+dgOclOkSrrP94uck
         VgDPzDToBHma7GfPRq9f70p+oneyV0plwFq/U6KEeeF4xw3HAVt47VAJ9jM1s/4uLG
         nL5rhGF4jICnLDgHqoJbX+5wvo+bV9uU+Xpp5UHJiqS2r6PU+EJtIXFSpIH5owaJov
         7KRjcn9+EoZFPcLgTT67d3zIQ9KljRzNCveEel6n/l4SnfQrCD2GLRNNhX6FQgAK/l
         51DNYDa/ZVEzg==
From:   Mark Brown <broonie@kernel.org>
To:     Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        alsa-devel@alsa-project.org
Cc:     Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
        Alexander.Deucher@amd.com, Sunil-kumar.Dommati@amd.com,
        V sujith kumar Reddy <vsujithkumar.reddy@amd.com>,
        Vijendar.Mukunda@amd.com
In-Reply-To: <20220106150525.396170-1-AjitKumar.Pandey@amd.com>
References: <20220106150525.396170-1-AjitKumar.Pandey@amd.com>
Subject: Re: [PATCH] ASoC: amd: acp: acp-mach: Change default RT1019 amp dev id
Message-Id: <164150089750.2243486.8547152917333843393.b4-ty@kernel.org>
Date:   Thu, 06 Jan 2022 20:28:17 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jan 2022 20:35:21 +0530, Ajit Kumar Pandey wrote:
> RT1019 components was initially registered with i2c1 and i2c2 but
> now changed to i2c0 and i2c1 in most of our AMD platforms. Change
> default rt1019 components to 10EC1019:00 and 10EC1019:01 which is
> aligned with most of AMD machines.
> 
> Any exception to rt1019 device ids in near future board design can
> be handled using dmi based quirk for that machine.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: acp-mach: Change default RT1019 amp dev id
      commit: 7112550890d7e415188a3351ec0a140be60f6deb

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
