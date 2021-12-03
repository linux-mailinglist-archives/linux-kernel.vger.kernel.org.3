Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639A6467160
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 06:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351764AbhLCFOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 00:14:16 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59562 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349313AbhLCFOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 00:14:10 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B35Ahh1013691;
        Thu, 2 Dec 2021 23:10:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638508243;
        bh=7YPusAw1dTZ1uA0ZnlzN0Mq+Wg14w8hatYGYAm9krPI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=vaVxLkvQSAnxHFf+TaSOteUQA4rUuO5Cs48jREOrPjl42i2dkuE+HGfsjxx1k4/DT
         kLsg7SLEib0xXENuBFwDGiJcRXy8CBkH2XTqCvQUuvGIA3WU3dQ2WaEowTE9dAa2wN
         TsVwLAszfpfWtGdjnGGUapLaSDcGlp/JekG70SHQ=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B35AhMa084378
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 2 Dec 2021 23:10:43 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 2
 Dec 2021 23:10:42 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 2 Dec 2021 23:10:42 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B35AeIo002126;
        Thu, 2 Dec 2021 23:10:40 -0600
Subject: Re: [PATCH 1/2] arm64: dts: ti: j7200-main: Fix 'dtbs_check'
 serdes_ln_ctrl node
To:     Kishon Vijay Abraham I <kishon@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20211126084555.17797-1-kishon@ti.com>
 <20211126084555.17797-2-kishon@ti.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <9a1124f3-89c9-5c5d-bd99-03fee830b977@ti.com>
Date:   Fri, 3 Dec 2021 10:40:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211126084555.17797-2-kishon@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/11/21 2:15 pm, Kishon Vijay Abraham I wrote:
> Fix 'dtbs_check' in serdes_ln_ctrl (serdes-ln-ctrl@4080) node by
> changing the node name to mux-controller@4080.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---

Reviewed-by: Aswath Govindraju <a-govindraju@ti.com>

>  arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> index d60ef4f7dd0b..05a627ad6cdc 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> @@ -32,7 +32,7 @@
>  		#size-cells = <1>;
>  		ranges = <0x00 0x00 0x00100000 0x1c000>;
>  
> -		serdes_ln_ctrl: serdes-ln-ctrl@4080 {
> +		serdes_ln_ctrl: mux-controller@4080 {
>  			compatible = "mmio-mux";
>  			#mux-control-cells = <1>;
>  			mux-reg-masks = <0x4080 0x3>, <0x4084 0x3>, /* SERDES0 lane0/1 select */
> 

