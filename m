Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91443523C7D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 20:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346257AbiEKScB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 14:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346251AbiEKSb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 14:31:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354B53BF88
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 11:31:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBF53B82529
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 18:31:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9515DC340EE;
        Wed, 11 May 2022 18:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652293915;
        bh=kCCerywDBBA4IoO0PQrQlUEkZgZN+MEjD0xdMDToPjE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Qcn39IAKfSZ3kVwQqk2Qd7kGZxgL7autk6gImQe2p1Z1BA0+NUzAfqXPQgXEj3iZP
         4hxPiwtWPyhqlq6ntnITR9+UDo0ZMWte7t/bAxiyMPMHgdkkqjhSoJVVGMSq+/l7+n
         3SBYaQvurQbkuz3xETTtxhMBZPAxp5Y+7rb/qTTwFAsHG74d3iGbFCZtQ8FucEDXmd
         77J6QUilwyUZbbkD5Upw4pO8R5YntXB3txq86VCccaUXL6/l2tWMCr/enlFbuGOvjJ
         GFXOe5MVgzocjUnCIeEvjUVGEAKcXxkEuPQED2Du/PD/39a3ZbUulGlNuLu6OmCMTn
         AlOZGeTdq13PA==
From:   Mark Brown <broonie@kernel.org>
To:     Xiubo.Lee@gmail.com, festevam@gmail.com, perex@perex.cz,
        shengjiu.wang@gmail.com, shengjiu.wang@nxp.com,
        alsa-devel@alsa-project.org, tiwai@suse.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1651925654-32060-1-git-send-email-shengjiu.wang@nxp.com>
References: <1651925654-32060-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH 1/2] ASoc: fsl_micfil: explicitly clear software reset bit
Message-Id: <165229391332.338959.11028062899331313513.b4-ty@kernel.org>
Date:   Wed, 11 May 2022 19:31:53 +0100
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

On Sat, 7 May 2022 20:14:13 +0800, Shengjiu Wang wrote:
> SRES is self-cleared bit, but REG_MICFIL_CTRL1 is defined as
> non volatile register, it still remain in regmap cache after set,
> then every update of REG_MICFIL_CTRL1, software reset happens.
> to avoid this, clear it explicitly.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoc: fsl_micfil: explicitly clear software reset bit
      commit: 292709b9cf3ba470af94b62c9bb60284cc581b79
[2/2] ASoc: fsl_micfil: explicitly clear CHnF flags
      commit: b776c4a4618ec1b5219d494c423dc142f23c4e8f

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
