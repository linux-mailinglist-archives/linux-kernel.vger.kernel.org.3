Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BE6520179
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238469AbiEIPtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238400AbiEIPts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:49:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E000625FE
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 08:45:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A8CBB816DA
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 15:45:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B1AC385B1;
        Mon,  9 May 2022 15:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652111142;
        bh=oQ1ml70LJT9el9PON/9R0g3f3UYsMYuYJEQBReN2NJk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ihzsCnFsMew8Zj98kEHx7dWpMilARnYHeUqvNasxqsg1MJFC400RZj/wU3X2Czhmr
         wKwiU4flOJ3YgCO3/d5B/i+1qkDa6RSO0IznNeilX8gDn+zwkRFf1hlGoaOvpAONsl
         34wAX3hus9nMOhj2OV6P4nX+G/Xt0dEaJxgSouDoFv+shqKBJw4Sbl6nm/B1I6/t53
         /AIirOEMR5RYoYBnlSmaSlYtOedkm7nKAfuaGFsH2YSsmrGoBRimxhDz2EJxyI//AD
         BHRU01krpiUsjyGpY/I/XuoP2Yk6Y+ZgocwstIOw8vfGx2ujxHpDQ+ePYYC7Gwj/q9
         rWP1Kk27k6ACg==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, cgel.zte@gmail.com
Cc:     chi.minghao@zte.com.cn, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, zealci@zte.com.cn
In-Reply-To: <20220505022102.54650-1-chi.minghao@zte.com.cn>
References: <20220505022102.54650-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] ASoC: pcm186x: simplify the return expression of pcm186x_power_off()
Message-Id: <165211114145.774487.8579724629086117424.b4-ty@kernel.org>
Date:   Mon, 09 May 2022 16:45:41 +0100
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

On Thu, 5 May 2022 02:21:02 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Simplify the return expression.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: pcm186x: simplify the return expression of pcm186x_power_off()
      commit: 5cb3bdd6bdcda6293aafe2a5adaaa44d011fbdf2

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
