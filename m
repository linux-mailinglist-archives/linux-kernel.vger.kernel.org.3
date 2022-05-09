Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367A5520422
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 20:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240030AbiEISJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 14:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240005AbiEISJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 14:09:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0546227
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 11:05:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7CA01B818E3
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 18:05:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDCAAC385B6;
        Mon,  9 May 2022 18:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652119536;
        bh=gGfUxs0/w+zjfDmY/Qhn/XynbQHVpf03rg4HBdcEACU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=kJI8qMJU76rImKVJolra9Tvt1KxAzVFxHIl/UHCy5musRzZjSz5UL7UbxOdZS3Q8a
         8n+j2BFjcUO06W1VPNlvkuCBaIBHuBUrQDRntmTJwD/djHNq+ZPGphEJWizALurXgt
         k4v0vHY++LY0yTVuHx7f0q0iibILCT9t6gKohjXOKvriVKhcUafOo8VzOwpZHJYEpD
         EOcZvDdo/g6mwQEC5cw1gPz39bzEseZh//zFukhRqL2DBvcEABQXp7Ty3zww6Ra9sZ
         IMsEoQ1IRnol84HBH64+lYcOT59YcTBDPsFVDHRJ2kQl6tbP74Fd/Oi2z1YMdTAq9I
         w9NqnqXC32CQQ==
From:   Mark Brown <broonie@kernel.org>
To:     lukma@denx.de, Liam Girdwood <lgirdwood@gmail.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20220509121055.31103-1-lukma@denx.de>
References: <20220509121055.31103-1-lukma@denx.de>
Subject: Re: [PATCH 1/2] ASoC: wm8940: add devicetree support
Message-Id: <165211953463.1181242.11641287577145582350.b4-ty@kernel.org>
Date:   Mon, 09 May 2022 19:05:34 +0100
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

On Mon, 9 May 2022 14:10:55 +0200, Lukasz Majewski wrote:
> This adds devicetree support to the wm8940 codec driver.
> With a DT-based kernel, there is no board-specific setting
> to select the driver so allow it to be manually chosen.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: wm8940: add devicetree support
      commit: 3a3610aaa9dce8ef1257bb42ac7f0fe2b5809a54

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
