Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768854AFD6B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 20:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbiBIT2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 14:28:52 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbiBIT1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 14:27:23 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9987E00D0EB;
        Wed,  9 Feb 2022 11:19:14 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 219J5EXu106008;
        Wed, 9 Feb 2022 13:05:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644433514;
        bh=QFBm9dNFfRX8TxQN2dJMx+RT6cga02Ei3ZZsy4WZF5s=;
        h=Date:From:Subject:To:CC:References:In-Reply-To;
        b=HOeiQQfuKXsCyBaoHMugen0B9oxTy6tWjU59P1ZXsEs2sqz3eiavj0smWjfbTe1mW
         6HV9k+vo/7bINMw7ZDTsS7BCSYfU0vwx9CYx/nwCspZP9XYykX24o8QEugpPGYpFKh
         Xd4o4qtMRWZ6N9JENjZJsj7La+DvWzQujxSJ5NEo=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 219J5EXB008632
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Feb 2022 13:05:14 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 9
 Feb 2022 13:05:14 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 9 Feb 2022 13:05:13 -0600
Received: from [10.250.235.90] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 219J5AXB070883;
        Wed, 9 Feb 2022 13:05:11 -0600
Message-ID: <a2312248-f79d-4728-0257-5485d08dd6c9@ti.com>
Date:   Thu, 10 Feb 2022 00:35:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 5/5] arm64: dts: ti: Add support for AM62-SK
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220208131827.1430086-1-vigneshr@ti.com>
 <20220208131827.1430086-6-vigneshr@ti.com>
 <65bfa443-5117-9e69-8b6e-0c40099bd149@canonical.com>
Content-Language: en-US
In-Reply-To: <65bfa443-5117-9e69-8b6e-0c40099bd149@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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



On 08/02/22 10:38 pm, Krzysztof Kozlowski wrote:
> On 08/02/2022 14:18, Vignesh Raghavendra wrote:
>> From: Nishanth Menon <nm@ti.com>
>>
[...]
>> +	vmain_pd: fixed-regulator-vmain-pd {
>> +		/* TPS65988 PD CONTROLLER OUTPUT */
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vmain_pd";
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +	};
>> +
>> +	vcc_5v0: fixedregulator-vcc5v0 {
>> +		/* Output of LM34936 */
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vcc_5v0";
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		vin-supply = <&vmain_pd>;
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +	};
>> +
>> +	vcc_3v3_sys: fixedregulator-vcc-3v3-sys {
> 
> Generic node names (as in DT spec), so regulator-[0-9]. The label and
> regulator-name property describe it's user-friendly purpose.

Ah, yes, missed it, will fix in v2

Thanks for the review!

Regards
Vignesh
