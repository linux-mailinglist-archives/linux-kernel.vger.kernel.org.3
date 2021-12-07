Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D43446B553
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbhLGINH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:13:07 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:32882 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbhLGIMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:12:48 -0500
Received: from dggeme706-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J7Xxs4vfWzcbt4;
        Tue,  7 Dec 2021 16:09:05 +0800 (CST)
Received: from [127.0.0.1] (10.67.102.125) by dggeme706-chm.china.huawei.com
 (10.1.199.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.20; Tue, 7
 Dec 2021 16:09:16 +0800
Message-ID: <61AF16AC.1080506@hisilicon.com>
Date:   Tue, 7 Dec 2021 16:09:16 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linuxarm@huawei.com>, <mauro.chehab@huawei.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] arm64: dts: HiSilicon: Add support for HiKey 970
 PCIe controller hardware
References: <cover.1637063775.git.mchehab+huawei@kernel.org> <884b83c1aed70735883e15f032f9668ebfd77a01.1637063775.git.mchehab+huawei@kernel.org>
In-Reply-To: <884b83c1aed70735883e15f032f9668ebfd77a01.1637063775.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme706-chm.china.huawei.com (10.1.199.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On 2021/11/16 19:59, Mauro Carvalho Chehab wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Add DTS bindings for the HiKey 970 board's PCIe hardware.
> 
> Co-developed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
> 
> To mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH 0/5] at: https://lore.kernel.org/all/cover.1637063775.git.mchehab+huawei@kernel.org/
> 
>  arch/arm64/boot/dts/hisilicon/hi3670.dtsi | 107 ++++++++++++++++++++++
>  1 file changed, 107 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> index 636c8817df7e..225dccbcb064 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> @@ -176,6 +176,12 @@ sctrl: sctrl@fff0a000 {
>  			#clock-cells = <1>;
>  		};
>  
> +		pmctrl: pmctrl@fff31000 {
> +			compatible = "hisilicon,hi3670-pmctrl", "syscon";

The "hi3670-pmctrl" is not documented in the devicetree binding documents yet.
Could we remove this part this time?
Thanks!

Best Regards,
Wei

