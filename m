Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7984A9CB3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 17:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376398AbiBDQOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 11:14:38 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54892 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbiBDQOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 11:14:37 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 214GEOef068883;
        Fri, 4 Feb 2022 10:14:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1643991264;
        bh=Fbi8/tvcaB7PLbrenrm7FF6i1b0iLV/HQYwG9hOZUko=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=btVFEKj54O1+TLhWYTydI2cZl5q4SspiVx477U6uN4idjyH7ES0YjMcjfoQmLbjFo
         6XmalA+V79V3OsuT6S+ZRSpgjoXkHR3XHOHwgAgVPoFAlWPsUm3nG7OMhsnrzYS0Zg
         M4uzmga92VaBu1reXUy3p3LJg3ceiTfI7w1EgTIE=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 214GEOT8020741
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Feb 2022 10:14:24 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 4
 Feb 2022 10:14:23 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 4 Feb 2022 10:14:23 -0600
Received: from [10.250.233.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 214GEInF061888;
        Fri, 4 Feb 2022 10:14:19 -0600
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-am65: disable optional peripherals
 by default
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Nishanth Menon <nm@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <5beef188724ef42b0c2147ca9bf6e6ca25c75dec.1641900122.git.matthias.schiffer@ew.tq-group.com>
 <20220202203217.sf2cr4orwl4usvyf@starry>
 <e427670b-0570-df33-c114-fd0633ac1d44@siemens.com>
 <76703db31c4562dba1301e839c70381cf8e403b3.camel@ew.tq-group.com>
 <2e375860-83d6-c5bb-3ab4-1b02e672c2e5@siemens.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <a5c2f411-ae1a-d98f-0304-b249d190cd6d@ti.com>
Date:   Fri, 4 Feb 2022 21:44:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <2e375860-83d6-c5bb-3ab4-1b02e672c2e5@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03/02/22 10:58 pm, Jan Kiszka wrote:
> On 03.02.22 14:06, Matthias Schiffer wrote:
>> On Thu, 2022-02-03 at 12:39 +0100, Jan Kiszka wrote:
>>> On 02.02.22 21:32, Nishanth Menon wrote:
>>>> On 12:25-20220111, Matthias Schiffer wrote:
>>>>> All peripharals that require pinmuxing or other configuration to
>>>>> work
>>>>> should be disabled by default. Dependent DTS are adjusted
>>>>> accordingly.
>>>>>
>>>>> The following nodes are now "disabled" according to dtx_diff and
>>>>> were not
>>>>> overridden to "okay", as they define no pinctrl:
>>>>>
>>>>> k3-am654-base-board:
>>>>> - mcu_i2c0
>>>>> - mcu_spi0..2
>>>>> - cal
>>>>> - main_i2c3
>>>>> - ehrpwm0..5
>>>>> - main_uart1..2
>>>>> - main_spi1..4
>>>>>
>>>>> k3-am65-iot2050*:
>>>>> - mci_spi1..2
>>>>> - cal
>>>>> - ehrpwm0..5
>>>>> - main_spi0..4
>>>>>
>>>>> Signed-off-by: Matthias Schiffer <
>>>>> matthias.schiffer@ew.tq-group.com>
>>>>
>>>> Jan: you ok with this series? Please ack.
>>>>
>>>
>>> Just rebased the still-too-long backlog to our system fully working
>>> over 
>>> mainline.
>>
>> Thanks for testing. As noted earlier, I will send a v2 of this patch
>> that fixes one more inconsistency.
>>
>>> Basically looks good, but this might be a regression of the 
>>> patch:
>>>
>>> [    1.810083] OF: /bus@100000/pcie@5600000: phandle pcie-mode@4070
>>> needs 1, found 0
>>> ...
>>> [    1.854840] OF: /bus@100000/pcie@5600000: phandle pcie-devid@210
>>> needs 1, found 0
>>>
>>> Jan
>>>
>>
>> That seems to be an older issue, rather than a regression of this
>> patch:
>>
>> k3-am65-main.dtsi defines:
>>
>>     ti,syscon-pcie-id = <&pcie_devid>;
>>     ti,syscon-pcie-mode = <&pcie0_mode>
>>
>> While according the driver binding docs something like the following is
>> expected:
>>
>>     ti,syscon-pcie-id = <&scm_conf 0x0210>;
>>     ti,syscon-pcie-mode = <&scm_conf 0x4060>;
>>
>> I assume that the k3-am65-main.dtsi section was imported from ti-linux
>> without accounting for the mainline driver's different binding.

Mainline driver and DT for AM65 used the phandle without the offset. However we
received comments for other platform to convert to use phandle + offset [1]

[1] ->
http://lore.kernel.org/r/CAL_JsqKiUcO76bo1GoepWM1TusJWoty_BRy2hFSgtEVMqtrvvQ@mail.gmail.com

This is similar to what is done for other k3 platforms [2]
[2] -> https://lore.kernel.org/all/20210105151421.23237-3-kishon@ti.com/

So as a first step, AM65 driver was modified to support phandle + offset in
commit 7dcf07ac88676a365ce3245b44af2be432f21120.

Update to DT was due and it should be similar to what Jan has posted below
in addition to removing the pcieX_mode and pcie_devid nodes

-		pcie0_mode: pcie-mode@4060 {
-			compatible = "syscon";
-			reg = <0x00004060 0x4>;
-		};
-
-		pcie1_mode: pcie-mode@4070 {
-			compatible = "syscon";
-			reg = <0x00004070 0x4>;
-		};
-
-		pcie_devid: pcie-devid@210 {
-			compatible = "syscon";
-			reg = <0x00000210 0x4>;
-		};
-

Let me know if I have to send a formal patch for this?

Thanks,
Kishon
>>
> 
> Yep, 7dcf07ac88676a365ce3245b44af2be432f21120 caused it, and this seems 
> to be the fix (though I cannot find a negative impact yet, except for 
> the warning):
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index 09cfdc72c64b..be79c0bc1776 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -694,8 +694,8 @@ pcie0_rc: pcie@5500000 {
>  		#size-cells = <2>;
>  		ranges = <0x81000000 0 0          0x0 0x10020000 0 0x00010000>,
>  			 <0x82000000 0 0x10030000 0x0 0x10030000 0 0x07FD0000>;
> -		ti,syscon-pcie-id = <&pcie_devid>;
> -		ti,syscon-pcie-mode = <&pcie0_mode>;
> +		ti,syscon-pcie-id = <&scm_conf 0x0210>;
> +		ti,syscon-pcie-mode = <&scm_conf 0x4060>;
>  		bus-range = <0x0 0xff>;
>  		num-viewport = <16>;
>  		max-link-speed = <2>;
> @@ -723,7 +723,7 @@ pcie0_ep: pcie-ep@5500000 {
>  		reg =  <0x0 0x5500000 0x0 0x1000>, <0x0 0x5501000 0x0 0x1000>, <0x0 0x10000000 0x0 0x8000000>, <0x0 0x5506000 0x0 0x1000>;
>  		reg-names = "app", "dbics", "addr_space", "atu";
>  		power-domains = <&k3_pds 120 TI_SCI_PD_EXCLUSIVE>;
> -		ti,syscon-pcie-mode = <&pcie0_mode>;
> +		ti,syscon-pcie-mode = <&scm_conf 0x4060>;
>  		num-ib-windows = <16>;
>  		num-ob-windows = <16>;
>  		max-link-speed = <2>;
> @@ -740,8 +740,8 @@ pcie1_rc: pcie@5600000 {
>  		#size-cells = <2>;
>  		ranges = <0x81000000 0 0          0x0   0x18020000 0 0x00010000>,
>  			 <0x82000000 0 0x18030000 0x0   0x18030000 0 0x07FD0000>;
> -		ti,syscon-pcie-id = <&pcie_devid>;
> -		ti,syscon-pcie-mode = <&pcie1_mode>;
> +		ti,syscon-pcie-id = <&scm_conf 0x0210>;
> +		ti,syscon-pcie-mode = <&scm_conf 0x4070>;
>  		bus-range = <0x0 0xff>;
>  		num-viewport = <16>;
>  		max-link-speed = <2>;
> @@ -769,7 +769,7 @@ pcie1_ep: pcie-ep@5600000 {
>  		reg =  <0x0 0x5600000 0x0 0x1000>, <0x0 0x5601000 0x0 0x1000>, <0x0 0x18000000 0x0 0x4000000>, <0x0 0x5606000 0x0 0x1000>;
>  		reg-names = "app", "dbics", "addr_space", "atu";
>  		power-domains = <&k3_pds 121 TI_SCI_PD_EXCLUSIVE>;
> -		ti,syscon-pcie-mode = <&pcie1_mode>;
> +		ti,syscon-pcie-mode = <&scm_conf 0x4070>;
>  		num-ib-windows = <16>;
>  		num-ob-windows = <16>;
>  		max-link-speed = <2>;
> 


> Jan
> 
