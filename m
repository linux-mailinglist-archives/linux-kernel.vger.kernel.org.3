Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6035F513090
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbiD1KF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiD1KFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:05:06 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A2969494
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 02:50:29 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220428095027euoutp01f0dad57496213e077db058d78fb2737b~qBo_RPavM0851608516euoutp01N
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:50:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220428095027euoutp01f0dad57496213e077db058d78fb2737b~qBo_RPavM0851608516euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651139427;
        bh=QKajzPGWjpawA/433SOioj+ZbbwKlHF+LorGx65GtZg=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=AWIciYHxnOBACTjSUQubSocd+oSrGBNNTjNxC39SBb+TmaZXGeCVyOsx7HxLtnR9h
         qmovirLDrWtDrgp8GVqpAQ4HC2dzvGzfmAcZzzE1qWG65NGstjLBN0GfT/pxRUAuGq
         HHM56HmGGW9CvRrpr2kQ9hEy9thv0bSg3zYWkJpU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220428095026eucas1p2ec22349319bcf2168de65c513b05ab4b~qBo9ikf132177921779eucas1p2N;
        Thu, 28 Apr 2022 09:50:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id AE.1A.10009.2636A626; Thu, 28
        Apr 2022 10:50:26 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220428095025eucas1p26c7af662f79880082423007492e13d4a~qBo8oNkri1797917979eucas1p2k;
        Thu, 28 Apr 2022 09:50:25 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220428095025eusmtrp1a14a5627a7d495ab373e1453d917164d~qBo8nMPqR1548015480eusmtrp1J;
        Thu, 28 Apr 2022 09:50:25 +0000 (GMT)
X-AuditID: cbfec7f2-e95ff70000002719-80-626a63625b23
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 72.87.09522.1636A626; Thu, 28
        Apr 2022 10:50:25 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220428095024eusmtip246348da401bc1c6ca0d425fb55fdab81~qBo7n9WBb1651316513eusmtip2F;
        Thu, 28 Apr 2022 09:50:24 +0000 (GMT)
Message-ID: <5eeac2a0-4293-675e-9dc2-25ed8ab3fb8f@samsung.com>
Date:   Thu, 28 Apr 2022 11:50:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH 08/10] ARM: dts: exynos: use proper
 'dma-channels/requests' properties
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20220427155840.596535-9-krzysztof.kozlowski@linaro.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7djP87pJyVlJBm+281o8mLeNzWJt71EW
        i/lHzrFaHD2/m8mi78VDZou9r7eyW9z/epTRYtPja6wWl3fNYbOYcX4fk8WBpe0sFm9+v2C3
        ePcywuLpzM1sFq17j7Bb/N+zg93i8Jt2Vot3q58wWiw/tYPFQdhjzbw1jB6z7p9l89i0qpPN
        4861PWwem5fUe/RtWcXo8XmTnMfez79ZAjiiuGxSUnMyy1KL9O0SuDKOn53NUnDXqaLjzF7G
        BsZXRl2MnBwSAiYSLc8XMXcxcnEICaxglDh4cwkrhPOFUeLnrv9Qmc+MEk8f32TsYuQAa7n4
        0QykW0hgOaNE0xV3iJqPjBIbVl9hA0nwCthJTPuxiRXEZhFQldi2dCkjRFxQ4uTMJywgtqhA
        ksTcffeYQWxhgRiJx0vXgdUwC4hL3HoynwlkqIjAE1aJN5ensUAkFCVuTVvKBGKzCRhKdL3t
        AlvGKeAqcW92GxNEjbxE89bZYFdLCJzjlDjycjU7xKMuEu+PPYeyhSVeHd8CZctInJ7cwwLx
        Wb7E3xnGEOEKiWuv1zBD2NYSd879YgMpYRbQlFi/Sx8i7ChxcMNcJohOPokbbwUhLuCTmLRt
        OjNEmFeio00IolpNYtbxdXA7D164xDyBUWkWUqDMQvL8LCS/zELYu4CRZRWjeGppcW56arFh
        Xmq5XnFibnFpXrpecn7uJkZgQjz97/inHYxzX33UO8TIxMF4iFGCg1lJhPfL7owkId6UxMqq
        1KL8+KLSnNTiQ4zSHCxK4rzJmRsShQTSE0tSs1NTC1KLYLJMHJxSDUz5fTMY19Q0Lz6yM3C9
        00cfDa9/X9r//lU5K/X31D/X7x9v/67vnPRa3k836K7DxZoVV39sKZKzz2AMq2b0PsJtx7+y
        +8m/pZy7X005tPyhgnjrdJdPsxZ4cEXoyug5Xq2zmZGwy+7YmfPH1GsPPLoi7u/qI1S1+dD3
        +02avhwqMseZPt36ax78OS/4uV9g+aOlQdxlD2zsttrtFV2kfySZ50vT5j8iri+ubGBVkw94
        Wa0scTV+p7FTYmG5wMf9RVYlAsUaMV8tPJTNNKtT2ix+39jAa2037/jPXRsZlSZc3Pzn24+1
        8rXPpdjm1DzbfWFSJfu9OYUv8y4a7HiibjC9SpXne9n0uEV3j09SsnqoxFKckWioxVxUnAgA
        FCvUYfcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsVy+t/xe7qJyVlJBgdP8Fo8mLeNzWJt71EW
        i/lHzrFaHD2/m8mi78VDZou9r7eyW9z/epTRYtPja6wWl3fNYbOYcX4fk8WBpe0sFm9+v2C3
        ePcywuLpzM1sFq17j7Bb/N+zg93i8Jt2Vot3q58wWiw/tYPFQdhjzbw1jB6z7p9l89i0qpPN
        4861PWwem5fUe/RtWcXo8XmTnMfez79ZAjii9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1
        DI3NY62MTJX07WxSUnMyy1KL9O0S9DKOn53NUnDXqaLjzF7GBsZXRl2MHBwSAiYSFz+adTFy
        cQgJLGWU6OxsZOti5ASKy0icnNbACmELS/y51gUWFxJ4zyjRO1kbxOYVsJOY9mMTWA2LgKrE
        tqVLGSHighInZz5hAbFFBZIkXmx7DhYXFoiReLx0HZjNLCAucevJfCaQxSICz1glXv3cxQqR
        UJS4NW0pE8RFlxkltmw+yQ6SYBMwlOh6C3EFp4CrxL3ZbUwQDWYSXVu7oKbKSzRvnc08gVFo
        FpJDZiFZOAtJyywkLQsYWVYxiqSWFuem5xYb6hUn5haX5qXrJefnbmIEpoFtx35u3sE479VH
        vUOMTByMhxglOJiVRHi/7M5IEuJNSaysSi3Kjy8qzUktPsRoCgyNicxSosn5wESUVxJvaGZg
        amhiZmlgamlmrCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXA5L9ljvfqZ82iE8WXS2n7tjIY
        mr3Yd3n5w00SYk90zlUtO2z+QY/bVNJ52em/z5y3zUzotDMXevBKfnlnwdXf+j/uSbSYuAoq
        bZ5T8zIvqH5R0sMzrx6Jzoq3qVi399gkx/7z7l/MGqUbQvSubHPRccu6a/w8eEpmEN/C+GPN
        AZm3Hzsuu9NQ2HDsy7uz6/aZbPnyeYtPedAGrl1CB65MzGb4dpYvgOnZYafD/4oOG+vP3OV5
        2EtlJtefpYk2P3/Uz39y+FWag0ztApvlMgU7T7HLzvpyX1BzeVPQ2q28+6Zrf7pz/1377K1X
        tSWWz3v++P2Ok3UFx2/kP4lPqX19aVpR3QbWdz+DnPoN9flMtu5XYinOSDTUYi4qTgQAxG4N
        LIwDAAA=
X-CMS-MailID: 20220428095025eucas1p26c7af662f79880082423007492e13d4a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220427160347eucas1p23ce51e0fb49160d437961d98fd682c28
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220427160347eucas1p23ce51e0fb49160d437961d98fd682c28
References: <20220427155840.596535-1-krzysztof.kozlowski@linaro.org>
        <CGME20220427160347eucas1p23ce51e0fb49160d437961d98fd682c28@eucas1p2.samsung.com>
        <20220427155840.596535-9-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 27.04.2022 17:58, Krzysztof Kozlowski wrote:
> pl330 DMA controller bindings documented 'dma-channels' and
> 'dma-requests' properties (without leading hash sign), so fix the DTS to
> match the bindings.
>
> Reported-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Are those properties really needed for PL330 driver on Exynos SoCs? I've 
removed them and I still see the proper values read from registers and 
reported in the log (Exynos4210):

dma-pl330 12680000.dma-controller: Loaded driver for PL330 DMAC-141330
dma-pl330 12680000.dma-controller:       DBUFF-32x4bytes Num_Chans-8 
Num_Peri-32 Num_Events-32
dma-pl330 12690000.dma-controller: Loaded driver for PL330 DMAC-141330
dma-pl330 12690000.dma-controller:       DBUFF-32x4bytes Num_Chans-8 
Num_Peri-32 Num_Events-32
dma-pl330 12850000.dma-controller: Loaded driver for PL330 DMAC-141330
dma-pl330 12850000.dma-controller:       DBUFF-64x8bytes Num_Chans-8 
Num_Peri-1 Num_Events-32

I also don't see any code that would read those properties. IMHO they 
should be simply removed at all, at least for the PL330 related nodes.

> ---
>   arch/arm/boot/dts/exynos3250.dtsi             |  8 ++++----
>   arch/arm/boot/dts/exynos4.dtsi                | 12 +++++------
>   .../boot/dts/exynos4210-universal_c210.dts    |  4 ++--
>   arch/arm/boot/dts/exynos5250.dtsi             | 16 +++++++--------
>   arch/arm/boot/dts/exynos5410.dtsi             |  8 ++++----
>   arch/arm/boot/dts/exynos5420.dtsi             | 20 +++++++++----------
>   6 files changed, 34 insertions(+), 34 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
> index 41bb421e67c2..7bdd4f0782c3 100644
> --- a/arch/arm/boot/dts/exynos3250.dtsi
> +++ b/arch/arm/boot/dts/exynos3250.dtsi
> @@ -429,8 +429,8 @@ pdma0: dma-controller@12680000 {
>   			clocks = <&cmu CLK_PDMA0>;
>   			clock-names = "apb_pclk";
>   			#dma-cells = <1>;
> -			#dma-channels = <8>;
> -			#dma-requests = <32>;
> +			dma-channels = <8>;
> +			dma-requests = <32>;
>   		};
>   
>   		pdma1: dma-controller@12690000 {
> @@ -440,8 +440,8 @@ pdma1: dma-controller@12690000 {
>   			clocks = <&cmu CLK_PDMA1>;
>   			clock-names = "apb_pclk";
>   			#dma-cells = <1>;
> -			#dma-channels = <8>;
> -			#dma-requests = <32>;
> +			dma-channels = <8>;
> +			dma-requests = <32>;
>   		};
>   
>   		adc: adc@126c0000 {
> diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
> index 5fd17bc52321..2a244aaf84b4 100644
> --- a/arch/arm/boot/dts/exynos4.dtsi
> +++ b/arch/arm/boot/dts/exynos4.dtsi
> @@ -676,8 +676,8 @@ pdma0: dma-controller@12680000 {
>   			clocks = <&clock CLK_PDMA0>;
>   			clock-names = "apb_pclk";
>   			#dma-cells = <1>;
> -			#dma-channels = <8>;
> -			#dma-requests = <32>;
> +			dma-channels = <8>;
> +			dma-requests = <32>;
>   		};
>   
>   		pdma1: dma-controller@12690000 {
> @@ -687,8 +687,8 @@ pdma1: dma-controller@12690000 {
>   			clocks = <&clock CLK_PDMA1>;
>   			clock-names = "apb_pclk";
>   			#dma-cells = <1>;
> -			#dma-channels = <8>;
> -			#dma-requests = <32>;
> +			dma-channels = <8>;
> +			dma-requests = <32>;
>   		};
>   
>   		mdma1: dma-controller@12850000 {
> @@ -698,8 +698,8 @@ mdma1: dma-controller@12850000 {
>   			clocks = <&clock CLK_MDMA>;
>   			clock-names = "apb_pclk";
>   			#dma-cells = <1>;
> -			#dma-channels = <8>;
> -			#dma-requests = <1>;
> +			dma-channels = <8>;
> +			dma-requests = <1>;
>   		};
>   
>   		fimd: fimd@11c00000 {
> diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> index 138d606d58a5..c1b11704b8ee 100644
> --- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
> +++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> @@ -666,8 +666,8 @@ mdma0: dma-controller@12840000 {
>   		clocks = <&clock CLK_MDMA>;
>   		clock-names = "apb_pclk";
>   		#dma-cells = <1>;
> -		#dma-channels = <8>;
> -		#dma-requests = <1>;
> +		dma-channels = <8>;
> +		dma-requests = <1>;
>   		power-domains = <&pd_lcd0>;
>   	};
>   };
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index df80ddfada2d..c4c0b4c08094 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -700,8 +700,8 @@ pdma0: dma-controller@121a0000 {
>   			clocks = <&clock CLK_PDMA0>;
>   			clock-names = "apb_pclk";
>   			#dma-cells = <1>;
> -			#dma-channels = <8>;
> -			#dma-requests = <32>;
> +			dma-channels = <8>;
> +			dma-requests = <32>;
>   		};
>   
>   		pdma1: dma-controller@121b0000 {
> @@ -711,8 +711,8 @@ pdma1: dma-controller@121b0000 {
>   			clocks = <&clock CLK_PDMA1>;
>   			clock-names = "apb_pclk";
>   			#dma-cells = <1>;
> -			#dma-channels = <8>;
> -			#dma-requests = <32>;
> +			dma-channels = <8>;
> +			dma-requests = <32>;
>   		};
>   
>   		mdma0: dma-controller@10800000 {
> @@ -722,8 +722,8 @@ mdma0: dma-controller@10800000 {
>   			clocks = <&clock CLK_MDMA0>;
>   			clock-names = "apb_pclk";
>   			#dma-cells = <1>;
> -			#dma-channels = <8>;
> -			#dma-requests = <1>;
> +			dma-channels = <8>;
> +			dma-requests = <1>;
>   		};
>   
>   		mdma1: dma-controller@11c10000 {
> @@ -733,8 +733,8 @@ mdma1: dma-controller@11c10000 {
>   			clocks = <&clock CLK_MDMA1>;
>   			clock-names = "apb_pclk";
>   			#dma-cells = <1>;
> -			#dma-channels = <8>;
> -			#dma-requests = <1>;
> +			dma-channels = <8>;
> +			dma-requests = <1>;
>   		};
>   
>   		gsc_0: gsc@13e00000 {
> diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
> index 4d797a9abba4..6dc08cb0622c 100644
> --- a/arch/arm/boot/dts/exynos5410.dtsi
> +++ b/arch/arm/boot/dts/exynos5410.dtsi
> @@ -196,8 +196,8 @@ pdma0: dma-controller@121a0000 {
>   			clocks = <&clock CLK_PDMA0>;
>   			clock-names = "apb_pclk";
>   			#dma-cells = <1>;
> -			#dma-channels = <8>;
> -			#dma-requests = <32>;
> +			dma-channels = <8>;
> +			dma-requests = <32>;
>   		};
>   
>   		pdma1: dma-controller@121b0000 {
> @@ -207,8 +207,8 @@ pdma1: dma-controller@121b0000 {
>   			clocks = <&clock CLK_PDMA1>;
>   			clock-names = "apb_pclk";
>   			#dma-cells = <1>;
> -			#dma-channels = <8>;
> -			#dma-requests = <32>;
> +			dma-channels = <8>;
> +			dma-requests = <32>;
>   		};
>   
>   		audi2s0: i2s@3830000 {
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index 21b608705049..08198d82ce8d 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -437,8 +437,8 @@ adma: dma-controller@3880000 {
>   			clocks = <&clock_audss EXYNOS_ADMA>;
>   			clock-names = "apb_pclk";
>   			#dma-cells = <1>;
> -			#dma-channels = <6>;
> -			#dma-requests = <16>;
> +			dma-channels = <6>;
> +			dma-requests = <16>;
>   			power-domains = <&mau_pd>;
>   		};
>   
> @@ -449,8 +449,8 @@ pdma0: dma-controller@121a0000 {
>   			clocks = <&clock CLK_PDMA0>;
>   			clock-names = "apb_pclk";
>   			#dma-cells = <1>;
> -			#dma-channels = <8>;
> -			#dma-requests = <32>;
> +			dma-channels = <8>;
> +			dma-requests = <32>;
>   		};
>   
>   		pdma1: dma-controller@121b0000 {
> @@ -460,8 +460,8 @@ pdma1: dma-controller@121b0000 {
>   			clocks = <&clock CLK_PDMA1>;
>   			clock-names = "apb_pclk";
>   			#dma-cells = <1>;
> -			#dma-channels = <8>;
> -			#dma-requests = <32>;
> +			dma-channels = <8>;
> +			dma-requests = <32>;
>   		};
>   
>   		mdma0: dma-controller@10800000 {
> @@ -471,8 +471,8 @@ mdma0: dma-controller@10800000 {
>   			clocks = <&clock CLK_MDMA0>;
>   			clock-names = "apb_pclk";
>   			#dma-cells = <1>;
> -			#dma-channels = <8>;
> -			#dma-requests = <1>;
> +			dma-channels = <8>;
> +			dma-requests = <1>;
>   		};
>   
>   		mdma1: dma-controller@11c10000 {
> @@ -482,8 +482,8 @@ mdma1: dma-controller@11c10000 {
>   			clocks = <&clock CLK_MDMA1>;
>   			clock-names = "apb_pclk";
>   			#dma-cells = <1>;
> -			#dma-channels = <8>;
> -			#dma-requests = <1>;
> +			dma-channels = <8>;
> +			dma-requests = <1>;
>   			/*
>   			 * MDMA1 can support both secure and non-secure
>   			 * AXI transactions. When this is enabled in

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

