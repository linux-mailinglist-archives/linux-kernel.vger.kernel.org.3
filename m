Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE8E514EA2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377455AbiD2PFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiD2PFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:05:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47187CD338;
        Fri, 29 Apr 2022 08:02:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 029FAB82B31;
        Fri, 29 Apr 2022 15:02:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1B1C385A7;
        Fri, 29 Apr 2022 15:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651244533;
        bh=Q9J8nfFbLcH6u/qm4eHj84G34KDbxXld+7fzihyYfPc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SFfCAJ/UJgPZA4oKecLcRClW9Fno8hmmkOuJIQMxdyyKOV9qPnwDc4fbFS10xuLxv
         XtTPLfkk5ePWl35qAHXSY5+VW4l5vn3a7AgM7jAleqtkxNyVWZeSh96eXXW23MB7OF
         Kr7nUnMC/GTNn/b75wVf0J/i4Ikr5paHMZTu2fHNTbb1riEk2lJo+i2a5OLu4aJ9NZ
         39VzDKDjiVYV4Gvm/c31qka5PbHJcxgdsuhArOPTClpVrGq2XJrabP62XZKiuQ3qDR
         X/cplXnllK7b3WHU4Gno1RX6I7IcmdhCTKImvOKNSBNrqSQPoCtAp1u/K9xds+RUWY
         glyyXxana3kQw==
From:   Mark Brown <broonie@kernel.org>
To:     matthias.bgg@gmail.com, tiwai@suse.com, robh+dt@kernel.org,
        yc.hung@mediatek.com
Cc:     trevor.wu@mediatek.com, daniel.baluta@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        allen-kh.cheng@mediatek.com, alsa-devel@alsa-project.org,
        cezary.rojewski@intel.com
In-Reply-To: <20220106064847.15588-1-yc.hung@mediatek.com>
References: <20220106064847.15588-1-yc.hung@mediatek.com>
Subject: Re: [PATCH v4] dt-bindings: dsp: mediatek: add mt8195 dsp document
Message-Id: <165124453080.141488.6009641744846773699.b4-ty@kernel.org>
Date:   Fri, 29 Apr 2022 16:02:10 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jan 2022 14:48:48 +0800, YC Hung wrote:
> From: "YC Hung" <yc.hung@mediatek.com>
> 
> This patch adds mt8195 dsp document. The dsp is used for Sound Open
> Firmware driver node. It includes registers,  clocks, memory regions,
> and mailbox for dsp.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] dt-bindings: dsp: mediatek: add mt8195 dsp document
      commit: 66727cdb250ec5d3f42558e33ace5c7d0fbd9477

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
