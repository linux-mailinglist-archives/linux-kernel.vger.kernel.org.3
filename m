Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF094F7BCC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbiDGJkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiDGJkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:40:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8D0642A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:38:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9275E61864
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 09:38:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2EA1C385A0;
        Thu,  7 Apr 2022 09:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649324283;
        bh=YcV0evLf+R2U300KOktMd4Hf1IaExnGql5B24JONj8c=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dmVt+wmB5GFyh77APZAqJOfAJ6ZzPTtEdXt8zZTVefYGipNY3fWLpxmdKf/0u28wl
         w1YBGnyMrCMjPG0Ox1DdIjzI+RXTsN3FmxdNW0MzfDFp+UOEH2URcerY0ovnAAgbLK
         FArBG1ajD+mk2LNzAcQmKFxtrTOajj1k9EjB+RWDwTpJr74liiuhn3JvOjiD7I8ihn
         sfBbh7vvRGGXAIWtNxSA2jBMBrxj/C6kbSo77v06wWo4/0OAAOR6d33NcVvnPL6BSG
         lURiY4eTMWNrfeutrB9e2OvHJZpj/KDYupQ9fmUtvTptkUACvg4CQbB8d7V2Ichb9Q
         8g7Pc2U6wZ5Sw==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, perex@perex.cz, nizhen@uniontech.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220310065354.14493-1-nizhen@uniontech.com>
References: <20220310065354.14493-1-nizhen@uniontech.com>
Subject: Re: [PATCH] ASoC: Intel: boards: Use temporary variable for struct device
Message-Id: <164932428242.3844153.12708508204017781920.b4-ty@kernel.org>
Date:   Thu, 07 Apr 2022 10:38:02 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2022 14:53:54 +0800, Zhen Ni wrote:
> Use temporary variable for struct device to make code neater.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: boards: Use temporary variable for struct device
      commit: 8b3520f7f6f6b54bb6b6e50b88f707a6b8113887

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
