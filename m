Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1D95319BA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242838AbiEWRyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 13:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241280AbiEWRaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 13:30:01 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B95393CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 10:26:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 14A22CE16D6
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 17:25:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7D2C34116;
        Mon, 23 May 2022 17:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653326756;
        bh=dh+fAnKS8WI2flC692OoPZ+G9PyKzBI6qdryJjOK4yQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SNB/lAD3U3bfcbSAR6YCwn69/9c7U6PhIVPDgyDiIAomqxgdDZGAYA56IR3NfTHAp
         yV/d4aKVwc/vf6shLn0B4YQNS34p4LRUoNosg7+m38wgYO2RIxHBkc1e6KUUui6Xlx
         eXCwXGyaAZrC8pu9HCIJnzId3g+TG+blUKS2akJCBWwG9OsfW5U6Vc8QLJZnr50ymh
         UKNFnOwuPsv3oivbZ53kX6e+Emhih1XL5sKKjTi9zuyXX7mB6yiuzzQddjKQ5vKpSq
         NsRN9J7/WUPxrZDY4jqXgg5+XtqsPC31S6DiTTNvacHFJWujiH9yQk+d5zDwEewg8b
         BmGPTe+Yg7SNw==
From:   Mark Brown <broonie@kernel.org>
To:     festevam@gmail.com, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, nicoleotsuka@gmail.com, perex@perex.cz,
        shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, tiwai@suse.com,
        shengjiu.wang@nxp.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1653284661-18964-1-git-send-email-shengjiu.wang@nxp.com>
References: <1653284661-18964-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Fix FSL_SAI_xDR/xFR definition
Message-Id: <165332675410.2124944.12107532437710717569.b4-ty@kernel.org>
Date:   Mon, 23 May 2022 18:25:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 May 2022 13:44:21 +0800, Shengjiu Wang wrote:
> There are multiple xDR and xFR registers, the index is
> from 0 to 7. FSL_SAI_xDR and FSL_SAI_xFR is abandoned,
> replace them with FSL_SAI_xDR0 and FSL_SAI_xFR0.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_sai: Fix FSL_SAI_xDR/xFR definition
      commit: e4dd748dc87cf431af7b3954963be0d9f6150217

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
