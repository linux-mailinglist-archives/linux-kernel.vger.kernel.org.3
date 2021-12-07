Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B66446B656
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbhLGIuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:50:32 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:32884 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhLGIub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:50:31 -0500
Received: from dggeme758-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J7YnN5wX1zcbr5;
        Tue,  7 Dec 2021 16:46:48 +0800 (CST)
Received: from [127.0.0.1] (10.67.102.125) by dggeme758-chm.china.huawei.com
 (10.3.19.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.20; Tue, 7
 Dec 2021 16:47:00 +0800
Message-ID: <61AF1F83.6010707@hisilicon.com>
Date:   Tue, 7 Dec 2021 16:46:59 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>, <linuxarm@huawei.com>,
        <mauro.chehab@huawei.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] arm64: dts: HiSilicon: Add support for HiKey 970
 PCIe controller hardware
References: <cover.1637063775.git.mchehab+huawei@kernel.org>    <884b83c1aed70735883e15f032f9668ebfd77a01.1637063775.git.mchehab+huawei@kernel.org>     <61AF16AC.1080506@hisilicon.com> <20211207093926.24f26dae@coco.lan>
In-Reply-To: <20211207093926.24f26dae@coco.lan>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On 2021/12/7 16:39, Mauro Carvalho Chehab wrote:
> Em Tue, 7 Dec 2021 16:09:16 +0800
> Wei Xu <xuwei5@hisilicon.com> escreveu:
> 
>> Hi Mauro,
>>
>> On 2021/11/16 19:59, Mauro Carvalho Chehab wrote:
>>> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>>
>>> Add DTS bindings for the HiKey 970 board's PCIe hardware.
>>>
>>> Co-developed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>>> ---
>>>
>>> To mailbombing on a large number of people, only mailing lists were C/C on the cover.
>>> See [PATCH 0/5] at: https://lore.kernel.org/all/cover.1637063775.git.mchehab+huawei@kernel.org/
>>>
>>>  arch/arm64/boot/dts/hisilicon/hi3670.dtsi | 107 ++++++++++++++++++++++
>>>  1 file changed, 107 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
>>> index 636c8817df7e..225dccbcb064 100644
>>> --- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
>>> +++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
>>> @@ -176,6 +176,12 @@ sctrl: sctrl@fff0a000 {
>>>  			#clock-cells = <1>;
>>>  		};
>>>  
>>> +		pmctrl: pmctrl@fff31000 {
>>> +			compatible = "hisilicon,hi3670-pmctrl", "syscon";  
>>
>> The "hi3670-pmctrl" is not documented in the devicetree binding documents yet.
>> Could we remove this part this time?
> 
> Without that, the PCI PHY won't work.
> 
> IMO, the best would be to just add this compatible to hi3670-clock,
> where it belongs.
> 
> Just sent a patch.

Got it.
Thanks!

Best Regards,
Wei

> 
> Regards,
> Mauro
> 
> .
> 

