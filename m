Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B6352EA9A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 13:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiETLSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 07:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbiETLSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 07:18:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4ADB14AA74
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:18:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E39661DAB
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 11:18:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D978C385A9;
        Fri, 20 May 2022 11:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653045517;
        bh=K/HrRMv6djwUaET7IYhl0udvj25T3d8ReiyZWFxaTSs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WGRk3hmfSkiDeLWCnz04H8B+sSLqBguOtwl2KpvZ8sObiAf4zRt6NchEBkzwIxltu
         0ClkpwW/38zpvxVUGzZZO+Q2ZfsRXedvVEJ+74UvyDYlrD1swomyIt7DAfoh0n9pgX
         bU2oqJoRBmBJ4TxVjtNewW6hM0fCiaot0xp4diFf0s4KIZeFiHS0C9Vbubj6wyVeyl
         W2rTDoXDNAwIrUewLeMwdRx5vTuF+vNIf3XhSlrrl9mvO+tIz0uum5FkAfbppvRFlW
         XQJjJ3YOA5bVtWC3Uadk8JrvebbeUblJ5wtgOoR+almQA7Nkl4l5vWiKD9WZg4hxJM
         /PRkoLwcYpDcA==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, tiwai@suse.com, quic_srivasam@quicinc.com,
        quic_potturu@quicinc.com, lgirdwood@gmail.com,
        yuehaibing@huawei.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20220516120909.36356-1-yuehaibing@huawei.com>
References: <20220516120909.36356-1-yuehaibing@huawei.com>
Subject: Re: [PATCH -next] ASoC: codecs: lpass: Fix passing zero to 'PTR_ERR'
Message-Id: <165304551581.45439.10887051635570767512.b4-ty@kernel.org>
Date:   Fri, 20 May 2022 12:18:35 +0100
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

On Mon, 16 May 2022 20:09:09 +0800, YueHaibing wrote:
> sound/soc/codecs/lpass-macro-common.c:28 lpass_macro_pds_init() warn: passing zero to 'PTR_ERR'
> sound/soc/codecs/lpass-macro-common.c:38 lpass_macro_pds_init() warn: passing zero to 'PTR_ERR'
> sound/soc/codecs/lpass-macro-common.c:54 lpass_macro_pds_init() warn: passing zero to 'ERR_PTR'
> 
> dev_pm_domain_attach_by_name() may return NULL, set 'ret' as
> -ENODATA to fix this warning.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: lpass: Fix passing zero to 'PTR_ERR'
      commit: 81e7b165c45e94188ae8f1134b57f27d1f35452f

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
