Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269865AB4AB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237166AbiIBPHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237160AbiIBPGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:06:48 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7793814D46D;
        Fri,  2 Sep 2022 07:36:22 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 282EZ0ZO038880;
        Fri, 2 Sep 2022 09:35:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1662129300;
        bh=oSDGQv0Ql4lDvw323MfY82wndn83ffKDgFCZsmZsf/I=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=pTQ7Bx9/v/k4xwV555XoEfws1N+ogVlgGWWlXnWVYKehrVptAixD+4lPhZp8ekj2V
         0TDlJmcW6rLh+mt3zeuNPOmHDFoWCkgUQ6ylr+Aqvr3RZRHb+0KsHGSKLQiQfrS5wO
         Z9yIkcXO5f7ZDwqKfCMDNU13B8+wlJ1XVb3Szprc=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 282EZ091000914
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Sep 2022 09:35:00 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 2 Sep
 2022 09:35:00 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 2 Sep 2022 09:35:00 -0500
Received: from [172.24.145.182] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 282EYwGj044829;
        Fri, 2 Sep 2022 09:34:59 -0500
Message-ID: <652841a9-a97e-0c87-8742-701be6633b82@ti.com>
Date:   Fri, 2 Sep 2022 20:04:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH RESEND 2/6] arm64: dts: ti: k3-j721s2-main: Add SERDES and
 WIZ device tree node
Content-Language: en-US
To:     Matt Ranostay <mranostay@ti.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>
References: <20220810094000.248487-1-mranostay@ti.com>
 <20220810094000.248487-2-mranostay@ti.com>
 <8c130e92-9970-54d3-d263-37ae2f722b34@ti.com> <YxFEk5zU4l9Yraek@ubuntu>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <YxFEk5zU4l9Yraek@ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/09/22 05:17, Matt Ranostay wrote:
> On Thu, Sep 01, 2022 at 02:15:28PM +0530, Vignesh Raghavendra wrote:
>>
>>
>> On 10/08/22 15:09, Matt Ranostay wrote:
>>> From: Aswath Govindraju <a-govindraju@ti.com>
>>>
>>> Add dt node for the single instance of WIZ (SERDES wrapper) and
>>> SERDES module shared by PCIe, eDP and USB.
>>>
>>> Cc: Vignesh Raghavendra <vigneshr@ti.com>
>>> Cc: Nishanth Menon <nm@ti.com>
>>> Acked-by: Matt Ranostay <mranostay@ti.com>
>>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>>> ---
>>>  arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 70 ++++++++++++++++++++++
>>>  1 file changed, 70 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>>> index f7e359da8690..f1e02d896168 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>>> @@ -5,6 +5,13 @@
>>>   * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
>>>   */
>>>  
>>> +/ {
>>> +	serdes_refclk: serdes-refclk {
>>
>> clk-X
>>
> 

Sorry for the confusion, I meant clock-<abc>. DT specification says all
clock nodes should follow above naming convention

> So something like 'serdes_refclk: clock-cmnrefclk' would seem to match the current
> naming style of other K3 platforms (albeit except j7200).
> 

Make sense...

>>> +		#clock-cells = <0>;
>>> +		compatible = "fixed-clock";
>>> +	};
>>> +};
>>> +
>>>  &cbass_main {
>>>  	msmc_ram: sram@70000000 {
>>>  		compatible = "mmio-sram";
>>> @@ -33,6 +40,13 @@ scm_conf: scm-conf@104000 {
>>>  		#size-cells = <1>;
>>>  		ranges = <0x00 0x00 0x00104000 0x18000>;
>>>  
>>> +		serdes_ln_ctrl: mux-controller@80 {
>>
>> mux-controller-X
>>
> 
> 80 is the index into the mmio region. So should it still have @ for the node
> name?
> 

@addr can only be used with nodes that have reg property. And since
there is no reg here -> would follow mux-controller-<abc> convention.

> Also this is how the rest of the K3 platforms reference the mux controller.


We need to fix other dtsi files to drop @addr part as they are now
falling make dtbs_check

> 
>>> +			compatible = "mmio-mux";
>>> +			#mux-control-cells = <1>;
>>> +			mux-reg-masks = <0x80 0x3>, <0x84 0x3>, /* SERDES0 lane0/1 select */
>>> +					<0x88 0x3>, <0x8c 0x3>; /* SERDES0 lane2/3 select */
>>> +		};
>>> +
>>>  		usb_serdes_mux: mux-controller@0 {
>>>  			compatible = "mmio-mux";
>>>  			#mux-control-cells = <1>;
>>> @@ -728,6 +742,62 @@ usb0: usb@6000000 {
>>>  		};
>>>  	};
>>>  
>>> +	serdes_wiz0: wiz@5060000 {
>>> +		compatible = "ti,j721e-wiz-10g";
>>> +		#address-cells = <1>;
>>> +		#size-cells = <1>;
>>> +		power-domains = <&k3_pds 365 TI_SCI_PD_EXCLUSIVE>;
>>> +		clocks = <&k3_clks 365 0>, <&k3_clks 365 3>, <&serdes_refclk>;
>>> +		clock-names = "fck", "core_ref_clk", "ext_ref_clk";
>>> +		num-lanes = <4>;
>>> +		#reset-cells = <1>;
>>> +		ranges = <0x5060000 0x0 0x5060000 0x10000>;
>>> +
>>> +		assigned-clocks = <&k3_clks 365 3>;
>>> +		assigned-clock-parents = <&k3_clks 365 7>;
>>> +
>>> +		wiz0_pll0_refclk: pll0-refclk {
>>
>> please use generic node name clk-X here and elsewhere in the patch
> 
> So something like 'wiz0_pll0_refclk: clk-refpll0'?


Sorry, clock-refpll0  perhaps

[...]

-- 
Regards
Vignesh
