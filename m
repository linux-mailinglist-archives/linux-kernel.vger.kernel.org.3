Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A8E49DAA3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 07:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236721AbiA0G3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 01:29:36 -0500
Received: from cpanel.siel.si ([46.19.9.99]:43816 "EHLO cpanel.siel.si"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236716AbiA0G3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 01:29:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
        Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=XSmT03lL5vw4WJ5VY/GJkb9j/PsbZ8y8uAL8Hac31s8=; b=LvQIvmY3hm58cspzGyaKlOlaZp
        o6rddruBNKEnYQC5zrxe4r1mqj1tmgpDJPz9NGI82/+IZBDM2A8FPhCoaEa2B6OB8n9zL6S38sYrH
        gDqWEkcG7PZnzfoKTAd8sLQjZDGO1DlWZeLk3rG2EY1bikQhOGiGVqMWOBoyYiTLpqtraUBYH8zOU
        MZG3AfHwr1zpTjAywgfoILQm88IjDABquQ4Yc+pJl1Vc10UH+ZmeTFqyEhAQy4T1uXHdDwgX6T3c/
        6oaasdNP12Mu3ypcF2/rSPWooXD3RQ3uAZMC5AMocLsqXV0D0Qe+MsfFTyDd4ReXboqpvSebsVAIW
        aFRyc6nw==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:51234 helo=[192.168.69.215])
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <andrej.picej@norik.com>)
        id 1nCyHa-001dey-0C; Thu, 27 Jan 2022 07:29:29 +0100
Subject: Re: [PATCH RESEND 2/2] ARM: dts: imx6qdl: Handle unneeded
 MFD-subdevices correctly
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        y.bas@phytec.com
References: <20211216115529.2331475-1-andrej.picej@norik.com>
 <20211216115529.2331475-2-andrej.picej@norik.com>
 <20220126092741.GK4686@dragon>
From:   Andrej Picej <andrej.picej@norik.com>
Message-ID: <b7ce8b9e-e11e-fe7e-bf20-41cee9ee933b@norik.com>
Date:   Thu, 27 Jan 2022 07:29:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220126092741.GK4686@dragon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26. 01. 22 10:27, Shawn Guo wrote:
> On Thu, Dec 16, 2021 at 12:55:29PM +0100, Andrej Picej wrote:
>> From: Yunus Bas <y.bas@phytec.de>
>>
>> The proper way to handle partly used MFD devices are to describe all MFD
>> subdevices in the devicetree and disable the not used ones. This
>> suppresses any warnings that may arise as a result.
>>
>> Signed-off-by: Yunus Bas <y.bas@phytec.de>
>> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> 
> Use subject prefix like
> 
>    ARM: dts: imx6qdl-phytec: ...
> 
> Shawn

Will send a v2 with this change.

Thanks.

Andrej

> 
>> ---
>>   arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi      |  5 +++++
>>   arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi | 10 ++++++++++
>>   2 files changed, 15 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
>> index 2ec154756bbc..3590f439adf5 100644
>> --- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
>> +++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
>> @@ -213,6 +213,11 @@ pmic_rtc: rtc {
>>   		da9063_wdog: wdt {
>>   			compatible = "dlg,da9063-watchdog";
>>   		};
>> +
>> +		onkey {
>> +			compatible = "dlg,da9063-onkey";
>> +			status = "disabled";
>> +		};
>>   	};
>>   };
>>   
>> diff --git a/arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi
>> index 94b254bfd054..28a805384668 100644
>> --- a/arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi
>> +++ b/arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi
>> @@ -116,6 +116,16 @@ watchdog {
>>   			dlg,use-sw-pm;
>>   		};
>>   
>> +		thermal {
>> +			compatible = "dlg,da9062-thermal";
>> +			status = "disabled";
>> +		};
>> +
>> +		gpio {
>> +			compatible = "dlg,da9062-gpio";
>> +			status = "disabled";
>> +		};
>> +
>>   		regulators {
>>   			vdd_arm: buck1 {
>>   				regulator-name = "vdd_arm";
>> -- 
>> 2.25.1
>>
