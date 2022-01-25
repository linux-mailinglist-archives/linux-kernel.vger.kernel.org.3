Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F90649B1A1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351783AbiAYKYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242354AbiAYKU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:20:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884EAC061756
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:20:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4430DB8174B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 10:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE9CC340E0;
        Tue, 25 Jan 2022 10:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643106026;
        bh=WQ5zDLwVwwS1ynSOHJWo3a8DI0uSQmuqRVk4pP95Oi8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=iZy2JXEYkKApBCD2hhPXk8EjIaamFY3tj58S67dzym4UmfRLu+joXr3GGhpaeC4iw
         JbI1QsZRmsQ7C7VONB7YREoh+knaPAZOzuOmC8utuTgCf8bWZNlaZloWk7PVZ6yN8e
         wlT0Bk4j4t5PHsZWQWx+rofNHNf/x8pX+kAnJPYvhsuDRL5k4SdtXCOr3hpFLwalli
         3CsdXQHy7GfFaoghuW0y4KSwa/7tOSRPcXf+x1yXXgnFkioHfsO7FbK1SZvoEY7O4a
         5TNME0d6YOUm/gNUN1Jhik90TzSeXdngj7XxjM87dYZ7DkjtAj16DTAqRd9DjtzC2S
         TK4B1Fw+gsFNw==
From:   Mark Brown <broonie@kernel.org>
To:     krzysztof.kozlowski@canonical.com, cgel.zte@gmail.com
Cc:     Minghao Chi <chi.minghao@zte.com.cn>, s.nawrocki@samsung.com,
        tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        perex@perex.cz, alsa-devel@alsa-project.org,
        Zeal Robot <zealci@zte.com.cn>
In-Reply-To: <20220117110357.863990-1-chi.minghao@zte.com.cn>
References: <20220117110357.863990-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] sound/soc/samsung: remove unneeded ret variable
Message-Id: <164310602383.74844.16089601402972484181.b4-ty@kernel.org>
Date:   Tue, 25 Jan 2022 10:20:23 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jan 2022 11:03:57 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Return value from io_remap_pfn_range() directly instead
> of taking this in another redundant variable.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] sound/soc/samsung: remove unneeded ret variable
      commit: de531908ca4251918f3aff4b21440a8f7b96b0b7

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
