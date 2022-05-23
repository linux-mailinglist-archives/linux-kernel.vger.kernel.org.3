Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D44530FFA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235658AbiEWMgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 08:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbiEWMft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 08:35:49 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C726D49CBB;
        Mon, 23 May 2022 05:35:24 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24N9xcs3026146;
        Mon, 23 May 2022 14:34:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=qIqK8sKEylUqg49Cc+Izo93o3wEhAt3Jq4iiQrYTUbQ=;
 b=6PmZ9b6rKmjdRP4tdvYnyvxBnK6nHrMvYE2wr20DGpObItpskv+GN69bswIDXXVdfLt4
 WFXNY8YEhrBX6ZT/TLCcH+NrGaH4w80XSYp2irmLVpPquWcINhel53BlBSwmNEIkFbR3
 QENy0RM0AkAJoVSpIOSl513OCVsihsAfWToqnEVs8YrX3JkWOdVNh/O/OIpKtPmWjvYC
 obS4NLuJUwsIfmUtEta6n/Lf1OfPQNeShDtGaHQU/x1NtZ02n0M7cyuPIHmjOUDJGv+2
 39RdwjCKdsfJ5llE4hs3erRbSpSfsyVy3kGLF5lGZmOM+i+KJ+LRfVQ7uyHMGBjtQFzx hQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3g6s02935u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 14:34:51 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 182A8100034;
        Mon, 23 May 2022 14:34:51 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 03D2322789E;
        Mon, 23 May 2022 14:34:51 +0200 (CEST)
Received: from [10.201.20.168] (10.75.127.49) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Mon, 23 May
 2022 14:34:50 +0200
Message-ID: <ceb2d1a3-dccd-865e-ed74-54444e49f349@foss.st.com>
Date:   Mon, 23 May 2022 14:34:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/6] dt-bindings: rtc: stm32: add alarm A out property to
 select output
Content-Language: en-US
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220504130233.330983-1-valentin.caron@foss.st.com>
 <20220504130617.331290-1-valentin.caron@foss.st.com>
 <YnLhw+Y7m8G2xJpK@mail.local>
From:   Valentin CARON <valentin.caron@foss.st.com>
In-Reply-To: <YnLhw+Y7m8G2xJpK@mail.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-23_06,2022-05-23_01,2022-02-23_01
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On 5/4/22 22:27, Alexandre Belloni wrote:
> Hello,
>
> On 04/05/2022 15:06:13+0200, Valentin Caron wrote:
>> STM32 RTC can pulse some SOC pins when an alarm of RTC expires.
>>
>> This patch adds property to activate alarm A output. The pulse can
>> output on three pins RTC_OUT1, RTC_OUT2, RTC_OUT2_RMP
>> (PC13, PB2, PI8 on stm32mp15) (PC13, PB2, PI1 on stm32mp13).
>>
>> Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
>> ---
>>   .../devicetree/bindings/rtc/st,stm32-rtc.yaml | 19 ++++++++++++++++++-
>>   1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/rtc/st,stm32-rtc.yaml b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.yaml
>> index 56d46ea35c5d..71e02604e8de 100644
>> --- a/Documentation/devicetree/bindings/rtc/st,stm32-rtc.yaml
>> +++ b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.yaml
>> @@ -59,6 +59,13 @@ properties:
>>         Refer to <include/dt-bindings/rtc/rtc-stm32.h> for the supported values.
>>         Pinctrl state named "default" may be defined to reserve pin for RTC output.
>>   
>> +  st,alarm:
>> +    $ref: "/schemas/types.yaml#/definitions/uint32"
>> +    description: |
>> +      To select and enable RTC Alarm A output.
>> +      Refer to <include/dt-bindings/rtc/rtc-stm32.h> for the supported values.
>> +      Pinctrl state named "default" may be defined to reserve pin for RTC output.
>> +
>>   allOf:
>>     - if:
>>         properties:
>> @@ -75,6 +82,9 @@ allOf:
>>           st,lsco:
>>             maxItems: 0
>>   
>> +        st,alarm:
>> +          maxItems: 0
>> +
>>           clock-names: false
>>   
>>         required:
>> @@ -95,6 +105,9 @@ allOf:
>>           st,lsco:
>>             maxItems: 0
>>   
>> +        st,alarm:
>> +          maxItems: 0
>> +
>>         required:
>>           - clock-names
>>           - st,syscfg
>> @@ -117,6 +130,9 @@ allOf:
>>           st,lsco:
>>             maxItems: 1
>>   
>> +        st,alarm:
>> +          maxItems: 1
>> +
>>         required:
>>           - clock-names
>>   
>> @@ -153,8 +169,9 @@ examples:
>>         clocks = <&rcc RTCAPB>, <&rcc RTC>;
>>         clock-names = "pclk", "rtc_ck";
>>         interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
>> +      st,alarm = <RTC_OUT1>;
>>         st,lsco = <RTC_OUT2_RMP>;
> Shouldn't that be exactly the opposite? You have two pins that can
> output different functions. The property should be the pin and the value
> the function. I'd go even further and I would say this is actually
> pinmuxing.
>
You're right, if the property is the pin and the value the function, 
this looks like a pinctrl node.
We choose to develop theses functionalities in the reverse order, to 
avoid the complexity of adding
the pinctrl framework to our driver. Moreover, LSCO and AlarmA may 
haven't a peripheral client and
this would probably require to also implement pinctrl hogging.

Is the implementation that we have proposed is acceptable regarding 
theses elements ?

Thank you,
Valentin

