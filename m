Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C946D49DA9D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 07:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236691AbiA0G2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 01:28:33 -0500
Received: from cpanel.siel.si ([46.19.9.99]:43424 "EHLO cpanel.siel.si"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231461AbiA0G2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 01:28:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
        Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=FgwRnq9LXy5OB93h4wH7N1/Jh1xMOSG6nh6fj6lu7CM=; b=cxVhi0uUtDf5c9OY3Z6Pt/TgaL
        EyqOoz/lPQ82/opoxLAQnLkFd6Pnja/e6LUe7JK/ozaD2oKHKUEH78NBWEVaUqdZdPhSkESmCsTDH
        mZXrzW7wdL47/5QmEhG/vf9eASkA9czB7xA4zD65lTKINmXc3LVh0QpSje04teTjvm2MJMLLfhSRW
        erCq44jwGjGcxC94cTqHi87vUXaOi9P19k2RDgqCNm5d9nvCrFVDrkD9gtDUCjdcTOyxnxdXXK7Dr
        lA64x1cDbb6AbrJ0qYhzltAHmJvewSdVpHaS08sdwTfKjbWUkwxvY8Vpe6QlXxkC62ivMUWqRxN2J
        ToDvOmvg==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:51200 helo=[192.168.69.215])
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <andrej.picej@norik.com>)
        id 1nCyGY-001dVz-Bq; Thu, 27 Jan 2022 07:28:25 +0100
Subject: Re: [PATCH RESEND 1/2] ARM: dts: imx6: phyFLEX: add missing pmic mfd
 subdevices
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        y.bas@phytec.com
References: <20211216115529.2331475-1-andrej.picej@norik.com>
 <20220126092426.GJ4686@dragon>
From:   Andrej Picej <andrej.picej@norik.com>
Message-ID: <38498017-dd47-ac02-0db7-85cf7fc48a59@norik.com>
Date:   Thu, 27 Jan 2022 07:28:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220126092426.GJ4686@dragon>
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

Hi Shawn,

On 26. 01. 22 10:24, Shawn Guo wrote:
> On Thu, Dec 16, 2021 at 12:55:28PM +0100, Andrej Picej wrote:
>> phyFLEX PMIC DA9063 has also RTC and watchdog support. Add both
>> mfd subdevices so they can be used.
>>
>> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
>> ---
>>   arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
>> index f3236204cb5a..2ec154756bbc 100644
>> --- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
>> +++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
>> @@ -205,6 +205,14 @@ vdd_mx6_high_reg: ldo11 {
>>   				regulator-always-on;
>>   			};
>>   		};
>> +
>> +		pmic_rtc: rtc {
> 
> Maybe a more specific label like the following?
> 
> 		da9063_rtc: rtc
> 
> And it's more aligned with da9063_wdog below.
> 
>> +			compatible = "dlg,da9063-rtc";
>> +		};
>> +
>> +		da9063_wdog: wdt {
> 
> watchdog for the node name.
> 

I'll apply your suggestions and send v2.
Do you agree that I also change the commit subject line to "ARM: dts: 
imx6qdl-phytec: ...", as you suggested in patch 2/2?

Thanks for your review.

Andrej
