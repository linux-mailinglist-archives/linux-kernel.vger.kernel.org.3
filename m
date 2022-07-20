Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF9F57C0B0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 01:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbiGTXM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 19:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbiGTXMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 19:12:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C373645071;
        Wed, 20 Jul 2022 16:12:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A915B8221D;
        Wed, 20 Jul 2022 23:12:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECBAC3411E;
        Wed, 20 Jul 2022 23:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658358740;
        bh=aOLwg6/EISYMyb84RQNgohTNXRsQHE5/pdLsiinq944=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=g3dcb437XYFf4PzH68vCmRlXnNdvzvZEvE/Bp7DI3beYSjS9yXZzMcVlVt7gW1Qja
         pAzR67tUFuZt0bmB+LnNEhiNyxKO8jA+jWHs8I3Wge0rsUMrHkQ2pQSURuq7Mt68Cf
         1nzG2+VTUYk7lfzP+xe9Ja88+XgqAf+PrQBFwxrRtbwL7A/hC8+TQXcwgGEvYRDvvX
         Yj7CkvaTtFxNJG4Ns/9BJ6n2T0V2Lq5w4KrydwuBbzdd9JQTRl2vDgcTYZseeJ/jqO
         qweTTsAkaq89uLLpzXyC5v2gXm/Nae9oQwVE0PcJ+JCYMu7wAttbzLthQkpUA07me9
         BbwSjOAtCTl3w==
From:   Mark Brown <broonie@kernel.org>
To:     jiaxin.yu@mediatek.com, angelogioacchino.delregno@collabora.com,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        tzungbi@google.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, julianbraha@gmail.com,
        trevor.wu@mediatek.com, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, aaronyu@google.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
In-Reply-To: <20220718162204.26238-1-jiaxin.yu@mediatek.com>
References: <20220718162204.26238-1-jiaxin.yu@mediatek.com>
Subject: Re: [PATCH v10 0/8] ASoC: mediatek: Add support for MT8186 SoC
Message-Id: <165835873701.1007579.13802197177165168890.b4-ty@kernel.org>
Date:   Thu, 21 Jul 2022 00:12:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jul 2022 00:21:56 +0800, Jiaxin Yu wrote:
> This series of patches adds support for Mediatek AFE of MT8186 Soc.
> Patches are based on broonie tree "for-next" branch.
> 
> Changes since v9:
>   - Drop the definitions that unused in mt8186-afe-common.h.
>   - Use device_get_match_data() instead of of_device_get_match_data().
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/8] dt-bindings: mediatek: mt6358: add new compatible for using mt6366
      commit: 8f57d8b149b1e46b4ffa707634fe76532ec89e83
[2/8] ASoC: mediatek: mt8186: add platform driver
      commit: 097e874ad3fc69601e2b142ff3b638893c355b41
[3/8] ASoC: mediatek: mt8186: add mt8186-mt6366 common driver
      commit: a809ded89d1d982ac05d8a3c6c943b49ff1b94fa
[4/8] dt-bindings: mediatek: mt8186: add audio afe document
      commit: 344afef6b980be569f4e9325778ca6869fed82cd
[5/8] ASoC: mediatek: mt8186: add machine driver with mt6366, da7219 and max98357
      commit: 3c6e24b65b53ce22c30492b9f239853b01d2d5b2
[6/8] dt-bindings: mediatek: mt8186: add mt8186-mt6366-da7219-max98357 document
      commit: 8a8da1e6af18f51b719a142fde92e5db56a129a0
[7/8] ASoC: mediatek: mt8186: add machine driver with mt6366, rt1019 and rt5682s
      commit: 0da16e370dd7a17b33b6fa2769ad9536389a0e12
[8/8] dt-bindings: mediatek: mt8186: add mt8186-mt6366-rt1019-rt5682s document
      commit: 1bcca73ee596e46e84782514621062c0ddf9d24f

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
