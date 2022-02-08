Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA944AE1C9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 20:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385745AbiBHTAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 14:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385714AbiBHTAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:00:34 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88003C0613CB;
        Tue,  8 Feb 2022 11:00:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8E056CE1C13;
        Tue,  8 Feb 2022 19:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB42C004E1;
        Tue,  8 Feb 2022 19:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644346828;
        bh=IEWyJRIAgqOmLk5O/Hy+y+7lLdSHvgPjohDMouOy7Lo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Po6NiauVK+KqdBgDxAOWFHuthyvLZltYbBs8zrkXk8Lm1oNPzmBBr8kJN20CCzleA
         TW+Z4PbFeOPorUdE/zXlrY4V89W2wYHUf4/6jRlrJ2icq3qzgsj8O9aKF37236DWKm
         di/l4sZy+n9DUf0OE2HpJ4l7FB4foOlhpTPbaL4+4zjD94H2FCB6RWcDxLGW9oWEB7
         QTNkdIKpBnDtID+qF/5+QhOMCzTBG1s5oqD5e1itrMla1UD3OlEUKlt6GcluUYF37j
         2v2/VX/erSOa+cDRIXWqrLRZ8XRfh+NYhS8MJdIEDLwKO/g7dFVs9yGy1BsV6/ceff
         Fet+DiSUbfVYQ==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Leilk Liu <leilk.liu@mediatek.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org
In-Reply-To: <20220125012330.13449-1-leilk.liu@mediatek.com>
References: <20220125012330.13449-1-leilk.liu@mediatek.com>
Subject: Re: [PATCH V4 0/3] Add compatible for Mediatek MT8186
Message-Id: <164434682616.1135514.9519927762573253322.b4-ty@kernel.org>
Date:   Tue, 08 Feb 2022 19:00:26 +0000
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

On Tue, 25 Jan 2022 09:23:27 +0800, Leilk Liu wrote:
> Subject: [PATCH V4 0/3] Add compatible for Mediatek MT8186
> 
> V4:
> 1. add "dt-bindings: spi: Convert spi-slave-mt27xx to json-schema" to
> this series again.
> 
> v3:
> 1. Fix Rob review comment in v2.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] dt-bindings: spi: Convert spi-slave-mt27xx to json-schema
      commit: 60edd652005fe2931565f658f23f86d094f4c1f0
[2/3] dt-bindings: spi: Convert spi-mt65xx to json-schema
      commit: 08727dd751234bc878be64e60ea6f0d8ea0d54c0
[3/3] dt-bindings: spi: Add compatible for Mediatek MT8186
      commit: ccbc5d0a92c5f1d42d1a1635b53f1987821e9cdd

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
