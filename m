Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77088524F98
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355120AbiELONF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355123AbiELOM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:12:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F6763BDD
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:12:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0731B82860
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 14:12:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E693DC34117;
        Thu, 12 May 2022 14:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652364774;
        bh=lG75f7u0FOqEgFZ07a5DYCoxWItDAZ8O3d88rmBiq6E=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=b5kJwuzD1lOZhBAXIcqO8oOT9HXbyUpXcSwfFc89H4yP4l4hnclrC3gTybPcExclI
         t0KnaO48RSag9HkYSggtIEsjXjtCbVdZdPYevcRYqzWDhSPY0PlXrulVYce1rXw1o8
         zZ1mBU00sjYdFFsVcRU29zxC32jTiYXCjWcNXfkGMGybHod6e3l3nluSOWKqEl8Nch
         5M3YaGLOo5rbQIs0SHEswg73X7v0FQ2+OOSe53BNSZxHLFYhpAwZ3J9KVdqXT9ptrI
         q4fsKRWlFaJa+nBuSqF+h+m9KOiygo2iZ3a+Q38a8akrjAR7wjbkYh234QjiIRqiTH
         QBxQOD2IrYgug==
From:   Mark Brown <broonie@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        linux-arm-kernel@lists.infradead.org, jiasheng@iscas.ac.cn,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>, linux-imx@nxp.com,
        linmq006@gmail.com, shawnguo@kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>
In-Reply-To: <20220511133725.39039-1-linmq006@gmail.com>
References: <20220511133725.39039-1-linmq006@gmail.com>
Subject: Re: [PATCH] ASoC: mxs-saif: Fix refcount leak in mxs_saif_probe
Message-Id: <165236477165.1016627.13757710006354879246.b4-ty@kernel.org>
Date:   Thu, 12 May 2022 15:12:51 +0100
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

On Wed, 11 May 2022 17:37:22 +0400, Miaoqian Lin wrote:
> of_parse_phandle() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when done.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mxs-saif: Fix refcount leak in mxs_saif_probe
      commit: 2be84f73785fa9ed6443e3c5b158730266f1c2ee

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
