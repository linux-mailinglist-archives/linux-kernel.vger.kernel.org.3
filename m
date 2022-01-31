Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7AF4A4BD0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380286AbiAaQWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:22:35 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60168 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380326AbiAaQVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:21:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84E85B82B87;
        Mon, 31 Jan 2022 16:21:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F09C3C340E8;
        Mon, 31 Jan 2022 16:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643646112;
        bh=wWknve0ByAYjqmk6E5o/sBBge05VPLlg/q+HLA7HEyw=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=WIxZmBdtMPBjVI7zaY7SZQ/1uT0//avx0VlJLMkApB+U/24XyGmneqaI1pCLO7MtQ
         2Is1s0eoFCgmWANU/kzI3Ec6S/8WH0muvrM5LNo9iVIcedBpYdKycrsgke5g+poyK5
         SyHvtpHRD6UuuU0UJXkhNxe3HfzNhoTQUpSL+Pan1Bjr+h7O/27iK+o3tSCCxELGuk
         gOzdSqTV9iuXED9SxTgsDN/TmCFnwz98WP2769dxVHOWgEG13M7u91htHopwS/YK+L
         UCah7mIgvGmX/34E9dyWDECzn0VEMtvLwxJP5y44kD1uteoKTANxmHh3kojWJdM0dK
         XlZekBHSFJ61w==
Message-ID: <751a60e7-1ebd-78a7-7c58-e8cfecb23d8c@kernel.org>
Date:   Mon, 31 Jan 2022 10:21:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] arm64: dts: agilex: align pl330 node name with
 dtschema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220129175535.299035-1-krzysztof.kozlowski@canonical.com>
 <20220129175535.299035-2-krzysztof.kozlowski@canonical.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20220129175535.299035-2-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/29/22 11:55, Krzysztof Kozlowski wrote:
> Fixes dtbs_check warnings like:
> 
>    pdma@ffda0000: $nodename:0: 'pdma@ffda0000' does not match '^dma-controller(@.*)?$'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>   arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
> index 63dd4e69c962..1f4618c1062e 100644
> --- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
> @@ -337,7 +337,7 @@ ocram: sram@ffe00000 {
>   			reg = <0xffe00000 0x40000>;
>   		};
>   
> -		pdma: pdma@ffda0000 {
> +		pdma: dma-controller@ffda0000 {
>   			compatible = "arm,pl330", "arm,primecell";
>   			reg = <0xffda0000 0x1000>;
>   			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>,

Both patches applied!

Thanks,
Dinh
