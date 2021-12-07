Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF25B46B646
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbhLGIpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:45:06 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:32883 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhLGIpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:45:03 -0500
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J7Yg45PQMzcbg5;
        Tue,  7 Dec 2021 16:41:20 +0800 (CST)
Received: from [127.0.0.1] (10.67.102.125) by dggeme756-chm.china.huawei.com
 (10.3.19.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.20; Tue, 7
 Dec 2021 16:41:32 +0800
Message-ID: <61AF1E3B.5060706@hisilicon.com>
Date:   Tue, 7 Dec 2021 16:41:31 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     David Heidelberg <david@ixit.cz>, Rob Herring <robh+dt@kernel.org>
CC:     <~okias/devicetree@lists.sr.ht>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: hisilicon: update deprecated property name
References: <20211029104211.29079-1-david@ixit.cz>
In-Reply-To: <20211029104211.29079-1-david@ixit.cz>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 2021/10/29 18:42, David Heidelberg wrote:
> hisi,rst-syscon property name is deprecated, use hisilicon,rst-syscon
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 4 ++--
>  arch/arm64/boot/dts/hisilicon/hi3670.dtsi | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index 8bd6d7e8a474..3fd80f1f7c1e 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -345,7 +345,7 @@ crg_ctrl: crg_ctrl@fff35000 {
>  		crg_rst: crg_rst_controller {
>  			compatible = "hisilicon,hi3660-reset";
>  			#reset-cells = <2>;
> -			hisi,rst-syscon = <&crg_ctrl>;
> +			hisilicon,rst-syscon = <&crg_ctrl>;
>  		};
>  
>  
> @@ -376,7 +376,7 @@ iomcu: iomcu@ffd7e000 {
>  
>  		iomcu_rst: reset {
>  			compatible = "hisilicon,hi3660-reset";
> -			hisi,rst-syscon = <&iomcu>;
> +			hisilicon,rst-syscon = <&iomcu>;
>  			#reset-cells = <2>;
>  		};
>  
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> index 636c8817df7e..9eac9a339654 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> @@ -155,7 +155,7 @@ crg_rst: crg_rst_controller {
>  			compatible = "hisilicon,hi3670-reset",
>  				     "hisilicon,hi3660-reset";
>  			#reset-cells = <2>;
> -			hisi,rst-syscon = <&crg_ctrl>;
> +			hisilicon,rst-syscon = <&crg_ctrl>;
>  		};
>  
>  		pctrl: pctrl@e8a09000 {
> @@ -196,7 +196,7 @@ media2_crg: media2_crgctrl@e8900000 {
>  
>  		iomcu_rst: reset {
>  			compatible = "hisilicon,hi3660-reset";
> -			hisi,rst-syscon = <&iomcu>;
> +			hisilicon,rst-syscon = <&iomcu>;
>  			#reset-cells = <2>;
>  		};
>  
> 

Thanks!
But this may break the compatibility of old kernels with new dts files here.
And we have discussed this at [1].
That is why we did not update the dts file yet.

[1]: https://www.spinics.net/lists/arm-kernel/msg887577.html

Best Regards,
Wei

