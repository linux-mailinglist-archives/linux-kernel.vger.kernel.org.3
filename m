Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2334CBEEC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 14:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbiCCNeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 08:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiCCNd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:33:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4048850063;
        Thu,  3 Mar 2022 05:33:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95C8561A07;
        Thu,  3 Mar 2022 13:33:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EAC9C004E1;
        Thu,  3 Mar 2022 13:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646314391;
        bh=p2C7b5c/cUQV9McqiJLePU5w1eCpvl0FqwxxR66KW3c=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Hfiz7SzlXv23kTOu2VKGxKVgiYhP4fTT7098Cx4jimhp/UBzWjBSlsmpA4PwCP0BI
         ZDn+4+G8eE+Iiin/G+HGlKI6JW89ENHtP3szsQLgOSJpIUUy5K/pMmyikLSpu5n+uo
         FmBzmcY/4fnqIXvljAWbFHPO9duZuh4Eu92asbi6E0Ok1Q2k1rV1FNfj3DydPqGydM
         LzbDei8LBdviYQKbIAqDRRTnXwVO0YP7vKSG0beUdQgR9lz7BV30dEfxK9bfzRBjRR
         4BOUrXs9w/KhHeeD6RZ4xWEsRaFwbg8sAZhSs3AY+RxNozi4NlZ9Im31Fupzl18zwG
         Hb8uFwEI84NCg==
From:   Mark Brown <broonie@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org, perex@perex.cz,
        devicetree@vger.kernel.org, trevor.wu@mediatek.com,
        tzungbi@google.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        matthias.bgg@gmail.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20220302013533.29068-1-jiaxin.yu@mediatek.com>
References: <20220302013533.29068-1-jiaxin.yu@mediatek.com>
Subject: Re: [v2] ASoC: bt-sco: fix bt-sco-pcm-wb dai widget don't connect to the endpoint
Message-Id: <164631438805.1870788.7887428309950116158.b4-ty@kernel.org>
Date:   Thu, 03 Mar 2022 13:33:08 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2022 09:35:33 +0800, Jiaxin Yu wrote:
> This patch fix the second dai driver's dai widget can't connect to the
> endpoint. Because "bt-sco-pcm" and "bt-sco-pcm-wb" dai driver have the
> same stream_name, so it will cause they have the same widget name.
> Therefor it will just create only one route when do snd_soc_dapm_add_route
> that only find the widget through the widget name.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: bt-sco: fix bt-sco-pcm-wb dai widget don't connect to the endpoint
      commit: 8f2b025abc31bc15d38657d1286d7470bbbd5efa

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
