Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19178520F03
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 09:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236842AbiEJHv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 03:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbiEJHvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 03:51:23 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D31189E6C;
        Tue, 10 May 2022 00:47:26 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24A4C6ou025914;
        Tue, 10 May 2022 09:47:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=Ty8V9iwX1zolMe/EYzmSOenyETw9D+oy8Fkl2LeWaHc=;
 b=nMFvM5BsDN5UkMt3bfHddX09ptZtFYHlTllgyAlYGez5BLA1uW0f8C1WPwBLaQ4SWLDu
 wWE8fmvgbUAP7a8StH0kx/Z9dwjxt1OaYsgcjufhxYyQDg0ETqqmCaWsz3NrRskrAt7S
 qaJTKIfOPHjMo4zbhEkqR4ize/u6Hpf9GQWxxmRedJCCyLnjai9KQ9kDwgP7utiMFloF
 oiaeGHW52/0l+7+UmJKL3F1n5oQZpDiv4JuFpcFNJhAVKt5ZikDTQ3wBbKR9stJ7UL5o
 tj09jgpruzSTyHZDc/en/GVWoc+6tD1/PND9bZHV1MjHwy7MlY12Tn226GcS/MPliq88 ig== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3fwe6kpm9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 09:47:10 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1F61D100034;
        Tue, 10 May 2022 09:47:09 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0E4B920FA5A;
        Tue, 10 May 2022 09:47:09 +0200 (CEST)
Received: from [10.201.21.93] (10.75.127.45) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 10 May
 2022 09:47:05 +0200
Message-ID: <ddd5d5b2-32a5-6464-80a6-0054c376dd96@foss.st.com>
Date:   Tue, 10 May 2022 09:47:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dt-bindings: clock: stm32mp1: adapt example for
 "st,stm32mp1-rcc-secure"
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Stephen Boyd <sboyd@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220509134658.16267-1-alexandre.torgue@foss.st.com>
 <1652123805.754133.27398.nullmailer@robh.at.kernel.org>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <1652123805.754133.27398.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-10_01,2022-05-09_02,2022-02-23_01
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob

On 5/9/22 21:16, Rob Herring wrote:
> On Mon, 09 May 2022 15:46:58 +0200, Alexandre Torgue wrote:
>> For "st,stm32mp1-rcc-secure" schema, clocks and clock-names entries are now
>> required properties.
>>
>> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Error: Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.example.dts:27.33-34 syntax error
> FATAL ERROR: Unable to parse input tree
> make[1]: *** [scripts/Makefile.lib:364: Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.example.dtb] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1401: dt_binding_check] Error 2
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/patch/
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 

I just updated dtschema and yamllint seems to be well installed. I don't 
see the see above. I wrote this patch on top of my stm32-next tree. Do I 
have to send it directly to arm-soc in order to be merged on top of my 
latest pull-request ?

Alex

