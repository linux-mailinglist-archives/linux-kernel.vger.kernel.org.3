Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D224ED44D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 08:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbiCaHAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 03:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbiCaHAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 03:00:12 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C8C16A6AF;
        Wed, 30 Mar 2022 23:58:24 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 22V6wCPC067667;
        Thu, 31 Mar 2022 01:58:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1648709892;
        bh=AKXYZYJQk6Gd3XdFMwvObICTeG3oes9S7zg+r0yF2XA=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=g+3cWkA6nYk4Y9oBr5yPMS8NT2/YyApS3cj5KyFHFvPDfDe04ydeSgBk7swyTbXbI
         EaTZCk+uWcpQ9viSOW9W/YScbvtC/r+/HWn9bntz0ZvC1ytqqH6hGKN8SCemvZ7H8Q
         CVt8LAnYAtf/O+Tzy3vO1K81BVV8b4ed2q28MyJM=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 22V6wCqP109750
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Mar 2022 01:58:12 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 31
 Mar 2022 01:58:12 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 31 Mar 2022 01:58:12 -0500
Received: from [10.250.235.115] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 22V6w8od127963;
        Thu, 31 Mar 2022 01:58:09 -0500
Message-ID: <16ad1a82-1e99-2957-720f-08d1238edcf4@ti.com>
Date:   Thu, 31 Mar 2022 12:28:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC] arm64: dts: ti: introduce a minimal am642 device tree
Content-Language: en-US
To:     Wadim Egorov <w.egorov@phytec.de>, Bryan Brattlof <bb@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220321155417.13267-1-bb@ti.com>
 <73a4a16b-193a-3075-61e9-82bcf21fc7d2@phytec.de>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <73a4a16b-193a-3075-61e9-82bcf21fc7d2@phytec.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wadim,

On 30/03/22 7:25 pm, Wadim Egorov wrote:
> Hi Bryan,
> 
>> +/* (optional) for console */
>> +&main_uart0 {
>> +    pinctrl-names = "default";
>> +    pinctrl-0 = <&main_uart0_pins_default>;
>> +};
>> +
>> +/* reserved for firmware */
>> +&main_uart1 {
>> +    status = "reserved";
>> +};
> 
> k3-image-gen says UART0 is used as a debug interface. See
> 
> 
> https://git.ti.com/cgit/k3-image-gen/k3-image-gen/tree/soc/am64x/evm/board-cfg.c#n81
> 
> 
> So it seems that you can enable uart1 here. But people may run into a
> conflict with uart0 and k3-image-gen compiled with ENABLE_TRACE=1.
> 
> If I am wrong, can you please clarify why you mark uart1 as reserved.
> 

We just seem to have same macro shared across multiple SoCs,
BOARDCFG_TRACE_DST_UART0 means logs are also directed to UART. Instance
of UART used for logging is platform specific.

On AM64 SYSFW logs are directed to MAIN UART1 (MAIN UART0 is used for
linux console). I will work internally and get SYSFW documentation
updated to reflect the same. Thanks!

Regards
Vignesh
