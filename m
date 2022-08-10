Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9D558EB55
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 13:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbiHJLct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 07:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiHJLcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 07:32:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC6D75FFB;
        Wed, 10 Aug 2022 04:32:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15B40611FA;
        Wed, 10 Aug 2022 11:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB0FC433D7;
        Wed, 10 Aug 2022 11:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660131139;
        bh=NkcJyERgdIfhg4FFRFHacZj2nr13SGeMr4Bp2YOafuY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sJot657ZGnx73hIykDoU0y5vR+HN2FlwGhJKqUgKv2ZKYqs2KeD1zqtMCIUMdLZxc
         ZbsVgtgjmI9eKPiZ6kSwrgseW0TZoatADvoT0eqb3fRf/HswgSrdwUN5988GLFtLpw
         Q3dPupRicyECL1m5qhAhUwLBg+q13c8ra/HYV0MM6xBSrFs7uHWsuCp7r/2/+Kte10
         a32UmFANFxr65ghbDPwhkPvnPmRYwdkglZVx5RG0PAEIA7FvC6paR0UARs5SMDyi3r
         5oAz6rHnPWA433OE2i9+gAqvNsz1CbrOB4gGb5qBokcLEuCqAMX+b7hWhGHZkVZI4h
         tHHWMD8DS2e0Q==
Date:   Wed, 10 Aug 2022 12:32:12 +0100
From:   Lee Jones <lee@kernel.org>
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>, iommu@lists.linux.dev,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v5 06/20] dt-bindings: power: mediatek: Add bindings for
 MediaTek SCPSYS
Message-ID: <YvOXPOidrbySvFwZ@google.com>
References: <20220804021553.14867-1-tinghan.shen@mediatek.com>
 <20220804021553.14867-7-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220804021553.14867-7-tinghan.shen@mediatek.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Aug 2022, Tinghan Shen wrote:

> The System Control Processor System (SCPSYS) has several power
> management related tasks in the system. Add the bindings for it.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/mfd/mediatek,mt8195-scpsys.yaml  | 67 +++++++++++++++++++
>  .../power/mediatek,power-controller.yaml      |  2 +-

Sebastian,

Any issues with me applying this?

>  2 files changed, 68 insertions(+), 1 deletion(-)
>  create mode 100644
>  Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml

-- 
Lee Jones [李琼斯]
