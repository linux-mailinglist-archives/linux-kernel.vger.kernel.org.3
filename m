Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C8C467157
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 06:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237705AbhLCFNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 00:13:42 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59486 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbhLCFNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 00:13:40 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B35ABLn013583;
        Thu, 2 Dec 2021 23:10:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638508211;
        bh=7OKoS3AyB1QlOzpJ3jPN5pRqAtLM/zGrThXNszuWedg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Jk8NM808aFIuVCwiataRUWf0yXpto/rBzanRLJYy4Vi2F36fmiA6Kq0++b5ebh+aT
         CqVxkENW+i1JAuADuM8TQgqu9gmJhgYC+VpIS+R9fOMGXfDyAfSZSZGuiGxGrqRcER
         I05iTUFyvMxO46bnDWv+YLe3Yw9KmauI1xM8k/YE=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B35ABmm083937
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 2 Dec 2021 23:10:11 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 2
 Dec 2021 23:10:10 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 2 Dec 2021 23:10:10 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B35A7wJ070413;
        Thu, 2 Dec 2021 23:10:08 -0600
Subject: Re: [PATCH 2/2] arm64: dts: ti: j721e-main: Fix 'dtbs_check' in
 serdes_ln_ctrl node
To:     Kishon Vijay Abraham I <kishon@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20211126084555.17797-1-kishon@ti.com>
 <20211126084555.17797-3-kishon@ti.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <ec4a45b9-e8d7-f11b-449f-1d6799e5e252@ti.com>
Date:   Fri, 3 Dec 2021 10:40:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211126084555.17797-3-kishon@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/11/21 2:15 pm, Kishon Vijay Abraham I wrote:
> Fix 'dtbs_check' in serdes_ln_ctrl (mux@4080) node by changing the node
> name to mux-controller@4080.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---

Reviewed-by: Aswath Govindraju <a-govindraju@ti.com>

>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> index 08c8d1b47dcd..e85c89eebfa3 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> @@ -42,7 +42,7 @@
>  		#size-cells = <1>;
>  		ranges = <0x0 0x0 0x00100000 0x1c000>;
>  
> -		serdes_ln_ctrl: mux@4080 {
> +		serdes_ln_ctrl: mux-controller@4080 {
>  			compatible = "mmio-mux";
>  			reg = <0x00004080 0x50>;
>  			#mux-control-cells = <1>;
> 

