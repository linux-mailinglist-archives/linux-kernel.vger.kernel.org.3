Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C82346B658
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbhLGIul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:50:41 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42098 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbhLGIul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:50:41 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B78l2Ht097708;
        Tue, 7 Dec 2021 02:47:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638866822;
        bh=6U5vHZpzFUTQY97WBAPBTkMZI0yqRKpWkl7E9wlXO/M=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ynyT97hU+3wPsxMo4lkzv8f985S3a6oUyC+lrW8ZSUWISZ+HnDpS2LRPgXZMno1u8
         cWTMOLrw6wnAnSyRDWMGsvf88pv19VC8+EgK+JNQFT7cpj9yi+bB1C+wCksroHIuIO
         VsGID54ftOEljjCRDu2Mkhg+yXj2LRzjpM44FyDM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B78l11o023229
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Dec 2021 02:47:02 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 7
 Dec 2021 02:47:01 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 7 Dec 2021 02:47:01 -0600
Received: from [172.24.145.75] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B78kwUh112592;
        Tue, 7 Dec 2021 02:46:59 -0600
Subject: Re: [PATCH] arm64: dts: ti: iot2050: Disable mcasp nodes at dtsi
 level
To:     <jan.kiszka@siemens.com>
CC:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211117053806.10095-1-j-choudhary@ti.com>
From:   Jayesh Choudhary <j-choudhary@ti.com>
Message-ID: <d8a0c212-2275-c87f-21b5-e0cd64b4e2ea@ti.com>
Date:   Tue, 7 Dec 2021 14:16:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211117053806.10095-1-j-choudhary@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,
Could you please ACK this patch if you are okay with the changes?

On 17/11/21 11:08 am, Jayesh Choudhary wrote:
> Disable mcasp nodes 0-2 because several required properties
> are not present in the dtsi file as they are board specific.
> These nodes can be enabled via an overlay whenever required.
> 
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> index 65da226847f4..c9407ed67866 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> @@ -731,3 +731,15 @@
>   &icssg2_mdio {
>   	status = "disabled";
>   };
> +
> +&mcasp0 {
> +	status = "disabled";
> +};
> +
> +&mcasp1 {
> +	status = "disabled";
> +};
> +
> +&mcasp2 {
> +	status = "disabled";
> +};
> 
