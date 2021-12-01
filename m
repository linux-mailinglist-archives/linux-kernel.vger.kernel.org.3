Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4266C465581
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352578AbhLASgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:36:10 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:57638 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352511AbhLASfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:35:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DEE17CE2083;
        Wed,  1 Dec 2021 18:32:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A096C53FCD;
        Wed,  1 Dec 2021 18:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638383543;
        bh=4g5v88qsCsd2eOxSUuIi5nfN0VvYnTAxUAxeb2Tfytw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=EiKCubeadJNn/PHgCLjVjjAtpedMYyGlyEzDsIuLfsuC4bsRfNHPGYUCDM3bA2ppQ
         FF20EIagtMESiQPT4ruwPZhdu+wQmj3P15w9vYA7EFcxJzccUwoffoa++4Jsb4oA+f
         fbabmk65q/nbSY4N8QNquvyp24Vlt3eF1CbQn6uuj8kKs6ucHwyKjkLhAG3va7gvVV
         K6gAo8a2bS8TQekkeJ/jDoNN5ofos5ehd3EsZZQFqwgih0Q5JtkQQ7hvBF/+6U+1AF
         O8q1iFKf5stU7gLqsN7LhwI5G1WfAqyFEhOlasjl2p/qHUbBYlT25g3z7VPRpFcKA5
         H7EV93Ea5bBmw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, Takashi Iwai <tiwai@suse.com>,
        Colin Ian King <colin.i.king@googlemail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20211129224236.506883-1-colin.i.king@gmail.com>
References: <20211129224236.506883-1-colin.i.king@gmail.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8195: make several arrays static const
Message-Id: <163838354089.2179787.18120653222525343560.b4-ty@kernel.org>
Date:   Wed, 01 Dec 2021 18:32:20 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2021 22:42:36 +0000, Colin Ian King wrote:
> Don't populate various arrays on the stack but instead make them
> static const. Also makes the object code smaller by a few hundred
> bytes.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8195: make several arrays static const
      commit: 91745b034dca6044407b559fe28dd1cf7efccc29

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
