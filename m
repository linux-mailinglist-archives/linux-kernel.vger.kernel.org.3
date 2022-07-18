Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E5757840A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbiGRNnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiGRNnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:43:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC270205EB
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:43:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CA6C61635
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 13:43:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678A2C341C0;
        Mon, 18 Jul 2022 13:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658151823;
        bh=7tFBGqUCkSt48dOZXzzfz1gzARNR5pWpaicXyiZifAg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ZpQlyzBX+qw7XQHIlBSp/jjGa9M1Rd7hoGLTAZAEHVNR6vkW7pre56b/B3TkdfqPG
         YFZuBdAZpYt4TJxpaldPAiAy7NbT7zla/5ts/XDnQOhgg4TaDLYe7dHrm5Fm5uX6IE
         XKREkjDZdbDHAfuaLGK+x5xAtV9IQ1gETwlZLGcXy0s7aLgPLkJxYxJXWXaD8QqaL6
         6oSRXj3cT07k7fWaIbxmSfVeW09vQeANSI8lg8rM6ShSnJXiC7J4ziezzuA4bUgAQi
         AJVYjMSGknCWP0qUkTosPTx1oUEBwupxjk5PKPjZWdn1bdMX2J9Y61tZOvMKw0hjoB
         oRB29qgPRd2Zg==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, angelogioacchino.delregno@collabora.com,
        chunxu.li@mediatek.com
Cc:     tzungbi@google.com, matthias.bgg@gmail.com,
        linux-mediatek@lists.infradead.org, alsa-devel@alsa-project.org,
        trevor.wu@mediatek.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20220715085903.7796-1-chunxu.li@mediatek.com>
References: <20220715085903.7796-1-chunxu.li@mediatek.com>
Subject: Re: [PATCH v2] ASoC: mediatek: mt8195: extract SOF common code
Message-Id: <165815182112.53643.17525611218975401104.b4-ty@kernel.org>
Date:   Mon, 18 Jul 2022 14:43:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 16:59:03 +0800, Chunxu Li wrote:
> The functions related to SOF can be reused in different machine drivers,
> such as mt8195 or mt8186, so extract the common code to avoid duplication.
> 
> Set mtk_soc_card_data which include machine private data and SOF private
> data as card drvdata, then the difference between machine private can be
> ignored such as mt8195_mt6359_priv or mt8186_mt6366_priv, at the same
> time the SOF related code can be reused in different machine drivers.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8195: extract SOF common code
      commit: 0caf1120c58395108344d5df4e09359b67e95094

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
