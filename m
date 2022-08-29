Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7AE5A50CF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 17:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiH2P6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 11:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiH2P6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 11:58:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5683597B21
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 08:58:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97442B81115
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 15:57:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10EFAC433D6;
        Mon, 29 Aug 2022 15:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661788677;
        bh=+II9I2VUO84fey3cODw3Ntjm3FbAKD1mEnge+7FYRdo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=i0WV2Nx8FJHxIRF0kPF9suCEsov7v9BmjxoqMxP/RrFl/HLHFi1ApRBPm2Lntr8Nr
         mSdBBYnc80tyPtYweOUsPtuVzxmy+37QzY/5dRVievd/oAj/JF9D+8b8SZNLKHLNJR
         /jYvsfS2cmme0i7z5eq+ejoR8ztN8tytfCSGZEUvObriBHLrt578Sd5VQtb0R1JMSX
         NLpRrPIuwrFks7gKS3W+nzaPowwZOuvJoZqQ3yWqoKU03/iC+MW0TURODdqD8OlUrM
         5ICEc957rKLPvVW5JRAPl2naTy0/TiBGxZDWVKS+QAUll9tnHtfpjECGAm61KzIJ8N
         cf0k2OG63mhUA==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, cgel.zte@gmail.com
Cc:     linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>,
        ckeepax@opensource.cirrus.com, cui.jinpeng2@zte.com.cn,
        perex@perex.cz, jiapeng.chong@linux.alibaba.com, tiwai@suse.com,
        tommaso.merciai@amarulasolutions.com, steve@sk2.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20220829091319.266068-1-cui.jinpeng2@zte.com.cn>
References: <20220829091319.266068-1-cui.jinpeng2@zte.com.cn>
Subject: Re: [PATCH linux-next] ASoC: codecs: max98088: remove redundant ret variable
Message-Id: <166178866796.855087.12254175359520201304.b4-ty@kernel.org>
Date:   Mon, 29 Aug 2022 16:57:47 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-65ba7
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Aug 2022 09:13:19 +0000, cgel.zte@gmail.com wrote:
> From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
> 
> Return value from devm_snd_soc_register_component() directly
> instead of taking this in another redundant variable.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: max98088: remove redundant ret variable
      commit: e0550fffd5b3d32118a335718d1e3ec93e6bc411

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
