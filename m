Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8AC46B1F6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 05:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236269AbhLGEkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 23:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236237AbhLGEka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 23:40:30 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C68C061746;
        Mon,  6 Dec 2021 20:37:01 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id BB52142181;
        Tue,  7 Dec 2021 04:36:56 +0000 (UTC)
Subject: Re: [PATCH] arm64: dts: apple: t8103: Expose PCI node for the WiFi
 MAC address
To:     Mark Kettenis <kettenis@openbsd.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     maz@kernel.org, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211206183817.31964-1-kettenis@openbsd.org>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <72298f81-8085-e807-5fd6-e5ff72f38de2@marcan.st>
Date:   Tue, 7 Dec 2021 13:36:54 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211206183817.31964-1-kettenis@openbsd.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2021 03.38, Mark Kettenis wrote:
> Expose the PCI node corresponding to the WiFi device and give it
> a 'local-mac-address' property. The bootloader will update it
> (m1n1 already has the required feature).
> 
> Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> ---
> 
> This change is based on the asahi-soc/dt branch since the
> t8103-jxxx.dtsi file isn't present in 5.16-rc3 yet.
> 
> 
>   arch/arm64/boot/dts/apple/t8103-jxxx.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi b/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
> index 876278fe0afe..acad6afcb1d9 100644
> --- a/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
> +++ b/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
> @@ -12,6 +12,7 @@
>   / {
>   	aliases {
>   		serial0 = &serial0;
> +		wifi0 = &wifi0;
>   	};
>   
>   	chosen {
> @@ -64,4 +65,9 @@ hpm1: usb-pd@3f {
>    */
>   &port00 {
>   	bus-range = <1 1>;
> +	wifi0: network@0,0 {
> +		reg = <0x10000 0x0 0x0 0x0 0x0>;
> +		/* To be filled by the loader */
> +		local-mac-address = [00 00 00 00 00 00];
> +	};
>   };
> 

Applied to asahi-soc/dt. Thanks!

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
