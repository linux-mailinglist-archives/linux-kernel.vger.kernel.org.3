Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFF054AE3D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 12:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354468AbiFNKZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 06:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbiFNKZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 06:25:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F2B4757C;
        Tue, 14 Jun 2022 03:25:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DDCD9B8184C;
        Tue, 14 Jun 2022 10:25:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D11C3411B;
        Tue, 14 Jun 2022 10:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655202307;
        bh=qA9xWVn3AUOfZxfhOprMPBGdr1XvmWBCUKQPSallH0Y=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=DGbRvEExBH84aRP3LsVoe88rb3sKrQrDJjoxsjJUxG+m6/s4Zp1yT0QXwou0ZZVuK
         57N8LOHwEwXf6uz0O6ZrgPYZ4CPv1Sld/mUjt4GiUELMyBk7E/CTgnfpByvHA2w5UD
         TUgtNdMlbDKO0UxlVPSD1oqwSHrKk8JP/n5xsaTzJRowVJB6RmK4fZYVIILpyYhGcZ
         +hJ7KFui/7hcXr6XyVRtoGWsLlyJFNNN1/AVXvVH+koYyKq6TyrXaIkaw5q6Oyd68o
         KbrIQja2neTtQpk1folFoQbvO3D/ZX0abdGoU57kNE6UE4lxmo9QjNiQ8FhXsQaypE
         IWVx6FLZPRDRw==
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org, shengjiu.wang@nxp.com, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        shengjiu.wang@gmail.com, nicoleotsuka@gmail.com,
        Xiubo.Lee@gmail.com, perex@perex.cz, festevam@gmail.com,
        krzk+dt@kernel.org, lgirdwood@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1654840042-7069-1-git-send-email-shengjiu.wang@nxp.com>
References: <1654840042-7069-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: fsl,mqs: Add compatible string for i.MX93 platform
Message-Id: <165520230461.3607327.1182225062255156973.b4-ty@kernel.org>
Date:   Tue, 14 Jun 2022 11:25:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jun 2022 13:47:21 +0800, Shengjiu Wang wrote:
> Add compatible string "fsl,imx93-mqs" for i.MX93 platform
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: fsl,mqs: Add compatible string for i.MX93 platform
      commit: 81ae0635df7de58496def18b0b9333992630b9af
[2/2] ASoC: fsl_mqs: Add support for i.MX93 platform
      commit: 047c69a3a9b19f29e021c77a7e9ce79230a342ed

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
