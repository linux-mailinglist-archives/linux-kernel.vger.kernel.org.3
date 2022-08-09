Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695CF58D925
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 15:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243649AbiHINNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 09:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243508AbiHINNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 09:13:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC2719298;
        Tue,  9 Aug 2022 06:12:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4919C61128;
        Tue,  9 Aug 2022 13:12:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F97C433C1;
        Tue,  9 Aug 2022 13:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660050775;
        bh=+8zyLhfEO98yw/ytIAkP1RtkV48sQHyERjMFYT4Kk2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uQtSB8Bgyw3wQM04wsd+AILEJ/Es0V0SH1NpbLuICf7ujezJUuAvsQLxVCOmIm2+5
         +JGHXcwZsgiCQ0cIICP4OXVhFr3+7xkxSZAtrGJijkGMPxhEQh8q7CTZzKY/rJm8HP
         JhEmI2vkMHFTDjZ5Vxtl1N/8TaAPFAaA2pd7fI80blJRKQwslsl9ej0K1bFP1vWsAO
         UeDiI/qupy/6zN0qbPBu2EIgpzlut0sGxp3cyAOG2Hw8JlcyZs0S7nsmNgdlcjwnlL
         nHXUEr3ycg6w55IpYnirFxSPxh9vfy3Or28l5l7kJTBYXk8FGMIH1+lYoy8aEf2LnO
         yv5x9BhtzbQrQ==
Received: by pali.im (Postfix)
        id 9986CC1F; Tue,  9 Aug 2022 15:12:52 +0200 (CEST)
Date:   Tue, 9 Aug 2022 15:12:52 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: marvell: Update Armada 37xx platform
 bindings
Message-ID: <20220809131252.z3mbmiz4duxwlauw@pali>
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

+ Andrew, Gregory, Sebastian

please comment on this

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
