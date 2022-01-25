Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECBC049B17F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347470AbiAYKW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242871AbiAYKUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:20:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FACC061749
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:20:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC0FBB81750
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 10:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9C5C340E5;
        Tue, 25 Jan 2022 10:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643106011;
        bh=KCr0hL6o11BQkhCkzi4kW14K7GAZ8bdJwciwDLwogb4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=bvxHPRtBAFNrfh9M+B/7esFKzaXJND94MVRoXn8pj1jIxugHrXnEHxwfPrJL7MGjF
         RYudPY+/sMx/78Vs/XkivOPSz/mtN1p2Z/tP2I63FXoCqhAyECbIBBMKbwoGh+CBul
         FeSyuO8g+m6hy1cnuwc/l1n6A1sKhKgE0HqhRdET3t8VJ0aX2cr3We86Cr8dFQDWhL
         nnT/icmNIJiswW54AJsD5uTnd7Zpr33m4Y450fS1UVshhaQ7ZDgDgoG9KV0ri35seF
         G3P8Bla+p0QoJv5Qqi5jrCMOASZ2RUqN3D9bOOA52S9tnJQbyTuSoJSkJbcq5wtGIt
         6fC05s9aU9QWQ==
From:   Mark Brown <broonie@kernel.org>
To:     cgel.zte@gmail.com
Cc:     tiwai@suse.com, chi.minghao@zte.com.cn,
        patches@opensource.cirrus.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, Zeal Robot <zealci@zte.com.cn>
In-Reply-To: <20220110012833.643994-1-chi.minghao@zte.com.cn>
References: <20220110012833.643994-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] sound/soc/codecs: remove redundant ret variable
Message-Id: <164310600828.74844.1045403214437339843.b4-ty@kernel.org>
Date:   Tue, 25 Jan 2022 10:20:08 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2022 01:28:33 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Return value from devm_snd_soc_register_component() directly instead
> of taking this in another redundant variable.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] sound/soc/codecs: remove redundant ret variable
      commit: 4ec19deec7ffae843c3445ac7d2cfcc78c56c145

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
