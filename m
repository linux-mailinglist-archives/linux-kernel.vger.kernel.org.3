Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E992C4661A5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 11:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357049AbhLBKr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 05:47:59 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:47204 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbhLBKr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 05:47:58 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B2AiSPV039153;
        Thu, 2 Dec 2021 04:44:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638441868;
        bh=tVa90xiSbSoY1tRcCyHb0YgsNeYRASbSTeyOl8WLfko=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=eaS2Y5f8QDsWdaPnQq/NThuZNTtykjReOP0QLt1WirleddDDovrlI4LZ5JGdn1EwC
         0kSUzsVKgfUvMT/r72W0iwesTMojRxIMPEn5GPWrt+dMFNUXjDH6KLjSSczAhxfGaz
         PROVACdFSjAtWsh22F69qsBWase9/XTJmhCShfwY=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B2AiSmA109954
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 2 Dec 2021 04:44:28 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 2
 Dec 2021 04:44:27 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 2 Dec 2021 04:44:28 -0600
Received: from [10.250.235.8] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B2AiOOA115426;
        Thu, 2 Dec 2021 04:44:25 -0600
Message-ID: <22db4807-7772-abe6-50c6-5812d9692ccc@ti.com>
Date:   Thu, 2 Dec 2021 16:14:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] arm64: dts: ti: k3-am64-main: add timesync router node
Content-Language: en-US
To:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        <linux-kernel@vger.kernel.org>
CC:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
References: <20211109150158.164778-1-christian.gmeiner@gmail.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20211109150158.164778-1-christian.gmeiner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/9/21 8:31 PM, Christian Gmeiner wrote:
> The Time Sync Event Router (TIMESYNC_INTRTR0) implements a set of
> multiplexers to provide selection of active CPTS time sync events for
> routing to CPTS capable modules.
> 
> This patch adds DT node TIMESYNC_INTRTR0 using "pinctrl-single" bindings.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> index 42d1d219a3fd..c9321a80353a 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -564,6 +564,14 @@ cpts@39000000 {
>  		ti,cpts-ext-ts-inputs = <8>;
>  	};
>  
> +	timesync_router: timesync-router@a40000 {

Node with "pinctrl-single" would need to be named pinctrl@reg.
Else this would probably fail dtbs_check once pinctrl-single bindings is
converted to YAML format.

> +		compatible = "pinctrl-single";
> +		reg = <0x0 0xa40000 0x0 0x800>;
> +		#pinctrl-cells = <1>;
> +		pinctrl-single,register-width = <32>;
> +		pinctrl-single,function-mask = <0x000107ff>;
> +	};
> +
>  	usbss0: cdns-usb@f900000{
>  		compatible = "ti,am64-usb";
>  		reg = <0x00 0xf900000 0x00 0x100>;
> 

Regards
Vignesh
