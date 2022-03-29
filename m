Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4369C4EA530
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 04:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiC2CdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 22:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbiC2Cc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 22:32:58 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7510B243157;
        Mon, 28 Mar 2022 19:31:16 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D8ADD5C0145;
        Mon, 28 Mar 2022 22:31:15 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute5.internal (MEProxy); Mon, 28 Mar 2022 22:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=kK2DRy1+No44UenKxPaxwWVsfCcLkPWK8fo2q+
        Rxkxc=; b=PNuzVVvJVDsKCeehljd29k8q0Rg/Smx8P9vv1kUWmqmsqhEg//LJQ1
        yvFVAqMIpT+jV6pe7MxE2A0+4juAwug9pE6/cuVwsP9W4VEaAd4+YTj15F0oyxD0
        2xCBm1DeJ4qrOAjZNrh8Faz8hoWajZ6U4X9uKx0gPbuRCznX48yY5W4R0uF4dwHU
        2WZd+dLxk7yeW2mrjbiyeAlnbhDUtZAhcNK3/9jPXN5HTGMlgjEA/eDeLKEf+23d
        74DNO1WBBIBGb2hMq92HXpPeFpluDmODwMDh7owPHIEMLAN0ovu+BpzvcNarszSk
        KOCZYgToIqutw8ipCRrWhfLml8SCDaBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=kK2DRy1+No44UenKx
        PaxwWVsfCcLkPWK8fo2q+Rxkxc=; b=XUeaFQfhIR9hVO0am/DYaFDlz8zI+IE4J
        oYTBSTzYmDIapeeHg3Wa4xtAKuTouBEzQq62yuqQfZdYDoLCh5PXkMxjfkr4dBYu
        8aWZhEO/qM3dSUVXA8y/7T/+eM8Tv7uXsDdntOsJ8Z7k95Hx2+3KawwVNGcvm6+8
        j41apzoOBkgPewubEuBW6wBl/XxzNGTsIhQaUPTbSOYxB76HpGK1qGHge+Pck9Kh
        mgc6VHmFPmTedzj68EDppsO9oJyIpuozR4cOCrf6unUo8w6U8YuaPVcY/q6lc+7e
        i5nG5SOwyhQTSQlBNv9QJm3UGfzyEvE9QLcWsYd8jt/VoNiBLqRqg==
X-ME-Sender: <xms:c29CYg9atpETlg6mT7Dnp39-2_r7xEYfFNM4QV9QHocgix-RQBgxug>
    <xme:c29CYovuVy_SW7jLJ7tV1CMIh0fdpMDs6CzGD4PSXVqFDMBEY3qGCJ4M5o-HIpjv0
    NQl0FtS8i6gKmbDdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudehkedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhephefhfeekgfekudevheffheeihedujeefjeevjeefudfgfeeutdeuvdeh
    hfevueffnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:c29CYmDLRZKTRaPz7b2N_mioiJu5lb8AfcoNmnRspz2gqsT0K9Ym6A>
    <xmx:c29CYgdE0_1HLG04auQj3V7EllqFfiO0boeNU6VAaTpFeu4Sr4L8nw>
    <xmx:c29CYlMFyuavj1rGlxjx3sOqhVHu_IufWEGTPOWwhhNeRcphLA_GdA>
    <xmx:c29CYo0m1Z-QTbUYYeXYcFDmRRq5C_oJsv1teZPLm7Qmd3jjbudpFA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9E174F60440; Mon, 28 Mar 2022 22:31:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4911-g925b585eab-fm-20220323.003-g925b585e
Mime-Version: 1.0
Message-Id: <d1aacc80-779e-419b-bc8c-c43aeb704586@www.fastmail.com>
In-Reply-To: <SG2PR06MB2315F24A708B71CA594F8DAEE61E9@SG2PR06MB2315.apcprd06.prod.outlook.com>
References: <SG2PR06MB2315F24A708B71CA594F8DAEE61E9@SG2PR06MB2315.apcprd06.prod.outlook.com>
Date:   Tue, 29 Mar 2022 13:00:55 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Howard Chiu" <howard_chiu@aspeedtech.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Joel Stanley" <joel@jms.id.au>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Troy Lee" <troy_lee@aspeedtech.com>
Subject: Re: [PATCH v3 2/2] ARM: dts: aspeed: ast2600-evb: Support KVM
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Howard,

On Tue, 29 Mar 2022, at 12:08, Howard Chiu wrote:
> Enable video engine and reserve memory for it.
> Enable USB for HID support

These should be two separate patches. They're unrelated in the sense 
that the video engine is separate from USB (even if your overall goal 
is to enable KVM).

>
> Signed-off-by: Howard Chiu <howard_chiu@aspeedtech.com>
> ---
>  arch/arm/boot/dts/aspeed-ast2600-evb.dts | 39 +++++++++++++++++++-----
>  1 file changed, 31 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts 
> b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> index b7eb552640cb..d535a711bf5a 100644
> --- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> +++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> @@ -23,6 +23,19 @@ memory@80000000 {
>  		reg = <0x80000000 0x80000000>;
>  	};
> 
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		video_engine_memory: video {
> +			size = <0x04000000>;
> +			alignment = <0x01000000>;
> +			compatible = "shared-dma-pool";
> +			reusable;
> +		};
> +	};
> +
>  	vcc_sdhci0: regulator-vcc-sdhci0 {
>  		compatible = "regulator-fixed";
>  		regulator-name = "SDHCI0 Vcc";
> @@ -250,14 +263,6 @@ &fsim0 {
>  	status = "okay";
>  };
> 
> -&ehci1 {
> -	status = "okay";
> -};
> -
> -&uhci {
> -	status = "okay";
> -};
> -
>  &sdc {
>  	status = "okay";
>  };
> @@ -300,3 +305,21 @@ &sdhci1 {
>  	vqmmc-supply = <&vccq_sdhci1>;
>  	clk-phase-sd-hs = <7>, <200>;
>  };
> +
> +&ehci1 {
> +	status = "okay";
> +};
> +
> +&uhci {
> +	status = "okay";
> +};

This movement of the ehci1 and uhci nodes seems unnecessary?

Andrew
