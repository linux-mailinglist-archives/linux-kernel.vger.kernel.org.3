Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3B84B139A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 17:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244890AbiBJQxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 11:53:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244928AbiBJQxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:53:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32900EE;
        Thu, 10 Feb 2022 08:53:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3EC960FE9;
        Thu, 10 Feb 2022 16:53:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BABFC004E1;
        Thu, 10 Feb 2022 16:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644512004;
        bh=BZyLbJ9ADs0skIHo/vUVdDN8sNI9dXVY4OIa4uvY8wk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=XVDZ+DhZfMKklUPIiLNQonAD0F1FggOyZX50CfYWFcRQMoTTD5R2Hgx/mnr3+t0rq
         9enu3Z1DrfoYjW3CuB6ehj00pAjqrO0o9g+mVQGDAZXju3JXfrUmjkkFYJOsF5kjTs
         jrIGqYdQRiDPwemY73BkCtCEwkjUr5Jud6NWBvIPJnYO48dNWmosojO3FdCx4MUgnt
         1TP/OksYZdjSRpfcP4kx8vBRKcLQTlcOaYmtFJSR+luRzUlMknvNhP3d1nfHiDeqf0
         DqAmWYkVc8MgtrZxzQQ6BfgzMuoPB/vGjIsJNLnWeFG0iSNov2TjCXVvWqkyt+1ifD
         TqgOB+0EAxLrQ==
From:   Mark Brown <broonie@kernel.org>
To:     Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     shawnguo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@canonical.com, lgirdwood@gmail.com,
        s.hauer@pengutronix.de, michael@amarulasolutions.com,
        festevam@gmail.com
In-Reply-To: <20220210134049.32576-1-ariel.dalessandro@collabora.com>
References: <20220210134049.32576-1-ariel.dalessandro@collabora.com>
Subject: Re: (subset) [PATCH v2 1/2] ASoC: bindings: fsl-asoc-card: Add compatible for tlv320aic31xx codec
Message-Id: <164451200128.2625306.11285883153390351914.b4-ty@kernel.org>
Date:   Thu, 10 Feb 2022 16:53:21 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2022 10:40:48 -0300, Ariel D'Alessandro wrote:
> Commit 8c9b9cfb7724 ("ASoC: fsl-asoc-card: Support
> fsl,imx-audio-tlv320aic31xx codec")' added support for tlv320aic31xx
> codec to fsl-asoc-card, but missed the related device-tree compatible
> string documentation. Fix this.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: bindings: fsl-asoc-card: Add compatible for tlv320aic31xx codec
      commit: 23c2f1392f2f3a1c7a82c5d18f02d1a055ad6f16

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
