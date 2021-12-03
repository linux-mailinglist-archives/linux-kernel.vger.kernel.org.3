Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6570C46786C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 14:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352218AbhLCNhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 08:37:05 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42972 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242569AbhLCNhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:37:04 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B3DXTOa016247;
        Fri, 3 Dec 2021 07:33:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638538409;
        bh=2BTIwpZWs505yUnlvfsgeCO0G1zLHHfoI/aYR2OSCjk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ZOZ+14Z/Z6COFrnWTPUcGCBexdle/9/UOu/aCZ2WBov15KccF73+8mFLu42j59ym8
         HpsjHvWq+A+DiWDL0hredpRwwn6pMAqmr9Ags0ZCwVNlYV8A8HAO/ba0UKG4x1niyf
         bRwkT5LeRDSsuCPR2r3Jct2kw9kH0krdFySkCIqE=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B3DXToa080095
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Dec 2021 07:33:29 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 3
 Dec 2021 07:33:29 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 3 Dec 2021 07:33:28 -0600
Received: from [10.250.234.139] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B3DXPCa130997;
        Fri, 3 Dec 2021 07:33:26 -0600
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am64-main: add timesync router node
To:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        <linux-kernel@vger.kernel.org>
CC:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
References: <20211202173114.9936-1-christian.gmeiner@gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <0f641180-d369-6536-1e48-30c1ce5fba6d@ti.com>
Date:   Fri, 3 Dec 2021 19:03:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211202173114.9936-1-christian.gmeiner@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/12/21 11:00 pm, Christian Gmeiner wrote:
> The Time Sync Event Router (TIMESYNC_INTRTR0) implements a set of
> multiplexers to provide selection of active CPTS time sync events for
> routing to CPTS capable modules.
> 
> This patch adds DT node TIMESYNC_INTRTR0 using "pinctrl-single" bindings.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>

Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> Changes in v2:
>   -  Use pinctrl for node name
> 
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> index 5ad638b95ffc..e16d2ccdd818 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -564,6 +564,14 @@ cpts@39000000 {
>  		ti,cpts-ext-ts-inputs = <8>;
>  	};
>  
> +	timesync_router: pinctrl@a40000 {
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
