Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E005A7FF2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbiHaOS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiHaORv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:17:51 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9C598587;
        Wed, 31 Aug 2022 07:17:34 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27VEHKiN050801;
        Wed, 31 Aug 2022 09:17:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661955440;
        bh=/gJEV6tqFD7QaU/v8Di3pFGuYMqE6AnrydVvnxYfS94=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=VOgh9IzCQhQjWh2MmGiM059krkwFzEAc5bPTDf09sBsfUdLUEQnM6ss6SK/1b4obq
         d7eBBKjTkENj7cMQrgtzyk3GhKJaOyOJkIC3C113g/hUzJkz+usFN17t3AG3VI3zRM
         mCsppu2/jz369WJICt6RGHM6b0eP8WETwZNx0HVo=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27VEHKE2002207
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 31 Aug 2022 09:17:20 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 31
 Aug 2022 09:17:19 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 31 Aug 2022 09:17:20 -0500
Received: from uda0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27VEHGOZ029924;
        Wed, 31 Aug 2022 09:17:17 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Tero Kristo <kristo@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 0/2] dt-bindings: arm: ti: k3: Sort alphabetically
Date:   Wed, 31 Aug 2022 19:47:15 +0530
Message-ID: <166195533442.358015.9606670388489997924.b4-ty@ti.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220830160507.7726-1-nm@ti.com>
References: <20220830160507.7726-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth Menon,

On Tue, 30 Aug 2022 11:05:05 -0500, Nishanth Menon wrote:
> Inspired by the discussion in [1] - sort the yaml to keep things clean
> for the new SoCs and boards that are getting added in.
> 
> [1] https://lore.kernel.org/all/d7303503-70ef-7307-8cc0-1bc334c9e6af@linaro.org/
> 
> Nishanth Menon (2):
>   dt-bindings: arm: ti: k3: Sort the am654 board enums
>   dt-bindings: arm: ti: k3: Sort the SoC definitions alphabetically
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] dt-bindings: arm: ti: k3: Sort the am654 board enums
      commit: 5f120a4dc7a71187fdae0a11f6c65b7e2cf7a2d7
[2/2] dt-bindings: arm: ti: k3: Sort the SoC definitions alphabetically
      commit: b7365658294304fac75bf33d11824d3a949122a2

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
--
Vignesh

