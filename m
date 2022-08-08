Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAD858CF0D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 22:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236240AbiHHUX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 16:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243020AbiHHUX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 16:23:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C431A3BB;
        Mon,  8 Aug 2022 13:23:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C38860BD6;
        Mon,  8 Aug 2022 20:23:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75191C433D6;
        Mon,  8 Aug 2022 20:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659990235;
        bh=EclEpHX49VYDq26eqhYIz6y6CsaMJTKwhdUyP+ZlCJw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NdI1anmNxnZ5m4gNkxeFi8NA8LUBI1dM8SDaetRD8flq/vJ52WC+faqgTl8DfGB3R
         lvTSQfw+LuIvnrmEVSR6ceFIdaOEA3y8yKGfZIyOGBeVquWmTA1a7uEh6Dr2P/I3Ey
         ko9h3WbKha+x6P4fO5CmVRGyFKS8Uc9QIkwiS9mt+kR72kjDvG33eiY3PLBmh3xVv1
         IST1Uy2pdQ4bCQ11yqfw/ORNUkpF6Bp/FxwagOD1bvI5G4gLAhzb+XzYEo2RQSmJkC
         37ZAVar4GtUuKXVHFFwmri9+CDZexWDUjaXoR1ziFk4Lm/cpRLgMovA1A4O1ZjOZ8d
         vfUkG+tLynQQQ==
Received: by pali.im (Postfix)
        id 71893F13; Mon,  8 Aug 2022 22:23:52 +0200 (CEST)
Date:   Mon, 8 Aug 2022 22:23:52 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: marvell: Update Armada 37xx platform
 bindings
Message-ID: <20220808202352.iimhb2q6yawi35y6@pali>
References: <20220713200123.22612-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220713200123.22612-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PING?

On Wednesday 13 July 2022 22:01:23 Pali Rohár wrote:
> Distinguish between Armada 3700 family, Armada 3710 SoC and Armada 3720 SoC.
> Armada 3720 DB is name of the board with Armada 3720 SoC, so correctly
> indicate SoC in example.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  .../devicetree/bindings/arm/marvell/armada-37xx.txt        | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
> index f6d6642d81c0..d2ca008de266 100644
> --- a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
> +++ b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
> @@ -4,6 +4,11 @@ Marvell Armada 37xx Platforms Device Tree Bindings
>  Boards using a SoC of the Marvell Armada 37xx family must carry the
>  following root node property:
>  
> + - compatible: must contain "marvell,armada3700"
> +
> +In addition, boards using the Marvell Armada 3710 SoC shall have the
> +following property before the previous one:
> +
>   - compatible: must contain "marvell,armada3710"
>  
>  In addition, boards using the Marvell Armada 3720 SoC shall have the
> @@ -13,7 +18,7 @@ following property before the previous one:
>  
>  Example:
>  
> -compatible = "marvell,armada-3720-db", "marvell,armada3720", "marvell,armada3710";
> +compatible = "marvell,armada-3720-db", "marvell,armada3720", "marvell,armada3700";
>  
>  
>  Power management
> -- 
> 2.20.1
> 
