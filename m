Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C842F4D47D2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 14:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242340AbiCJNPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 08:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242325AbiCJNPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 08:15:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D8E7DA9D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 05:14:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03367B8261A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 13:13:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D642C340EB;
        Thu, 10 Mar 2022 13:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646918037;
        bh=QDNquidF6BeD/URlJSXbDXcfjvClofQSBuYPeZ+AuDc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=reG3wPZ4rvbFfjAtFgKD8h/dhEUhG8YfKCpvzgTJGkrTo65UYiw5NJxBmswqHzu29
         m2IudxMyKuJW58+9AMrjSz82xeCQII1ZV0Vpp3i2LY6RNYTgC0IyuCugt7B8qMQb3H
         9zeHtfVKBIvkaUhixpz5GSVcMuBbqVOR8ekRZxTbVgSp6o4vPAJ3Ic+W4mWqtm2259
         Cao57n20ZR5wpOR+HCahzxKiIJAuOqXRtZ30CM3icTWp2VwXiQxkTL2t3PC+psoipo
         mO04ato1boi6qtkbunj2r0dim1dBC9SDLAXmRUyi0AfqbOuEU+4CEZm0I1x+gR0MY+
         4LJkOhppkNzeQ==
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>, tiwai@suse.com,
        alsa-devel@alsa-project.org, nicoleotsuka@gmail.com,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        festevam@gmail.com, Xiubo.Lee@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1646879863-27711-1-git-send-email-shengjiu.wang@nxp.com>
References: <1646879863-27711-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: Disable TX clock when stop
Message-Id: <164691803517.2018412.16511906603132824768.b4-ty@kernel.org>
Date:   Thu, 10 Mar 2022 13:13:55 +0000
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

On Thu, 10 Mar 2022 10:37:43 +0800, Shengjiu Wang wrote:
> The TX clock source may be changed in next case, need to
> disable it when stop, otherwise the TX may not work after
> changing the clock source, error log is:
> 
> aplay: pcm_write:2058: write error: Input/output error
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_spdif: Disable TX clock when stop
      commit: 6ddf611219ba8f7c8fa0d26b39710a641e7d37a5

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
