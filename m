Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745D658E05F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 21:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344864AbiHITnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 15:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344958AbiHITmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 15:42:52 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF7D2656F;
        Tue,  9 Aug 2022 12:42:51 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 279JZ8CR010407;
        Tue, 9 Aug 2022 19:42:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=8GHTxJxSue6pJbphfO1vtqP9e/vY/kGFFepmcQaEPF0=;
 b=WEb4jQEfYo3CMrJWUVnl4X/IZVXLfgWqK8d5w32XYzvcPdGFIAZeFFbMt2AFi3uqtEqB
 ToydP7hGovJhQ2ey6yzWm7XbNhlocPoLaf/n8kJoT3Zx217Fw8CQzq2NGIMvWPasPNpU
 tL8naG3jymFMbTo5Mwy2pdfMHW2uCbI12xyrU16lxOMGAltd6BK4MgqMIl+HOtAm0duP
 glTuV+h3akIe8xnGX1kJ/pQFUFTwRiU5SVecjqqDZoIpcPN2n3szQpcDm4KpYAMkYQDF
 EbAvyvtHd563O3I07uoQbxywkiDznUr10GD/IxODwAHlpNA2mekHrbt+qyNxR4Eonnwg YA== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3huwv6r69s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 19:42:21 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 279JZjcE031712;
        Tue, 9 Aug 2022 19:42:20 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma03dal.us.ibm.com with ESMTP id 3huwvk8190-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 19:42:20 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 279JgJrL34865624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Aug 2022 19:42:19 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3047CBE051;
        Tue,  9 Aug 2022 19:42:19 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 248BDBE04F;
        Tue,  9 Aug 2022 19:42:18 +0000 (GMT)
Received: from [9.160.17.179] (unknown [9.160.17.179])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  9 Aug 2022 19:42:17 +0000 (GMT)
Message-ID: <59ee8c2f-3d6c-14ed-c9f8-2bbd9377a7da@linux.ibm.com>
Date:   Tue, 9 Aug 2022 14:42:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] dt-bindings: hwmon: Add IBM OCC bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        joel@jms.id.au
Cc:     linux@roeck-us.net, jdelvare@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-fsi@lists.ozlabs.org,
        devicetree@vger.kernel.org
References: <20220802194656.240564-1-eajames@linux.ibm.com>
 <20220802194656.240564-2-eajames@linux.ibm.com>
 <297ddf1f-8ddc-902c-ff3d-06b9d19c6a7b@linaro.org>
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <297ddf1f-8ddc-902c-ff3d-06b9d19c6a7b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uvO5j0nznAN3zuD0hi5jl8v32rvo6bQD
X-Proofpoint-ORIG-GUID: uvO5j0nznAN3zuD0hi5jl8v32rvo6bQD
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_05,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 adultscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208090073
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/3/22 01:55, Krzysztof Kozlowski wrote:
> On 02/08/2022 21:46, Eddie James wrote:
>> These bindings describe the POWER processor On Chip Controller accessed
>> from a service processor or baseboard management controller (BMC).
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>>   .../bindings/hwmon/ibm,occ-hmwon.yaml         | 40 +++++++++++++++++++
>>   1 file changed, 40 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/hwmon/ibm,occ-hmwon.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/ibm,occ-hmwon.yaml b/Documentation/devicetree/bindings/hwmon/ibm,occ-hmwon.yaml
>> new file mode 100644
>> index 000000000000..8f8c3b8d7129
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwmon/ibm,occ-hmwon.yaml
>> @@ -0,0 +1,40 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/hwmon/ibm,occ-hwmon.yaml#
> typo here
>
> Does not look like you tested the bindings. Please run `make
> dt_binding_check` (see
> Documentation/devicetree/bindings/writing-schema.rst for instructions).


I actually did but it didn't catch that somehow. I had to use a somewhat 
hacked together python/pip on my system so perhaps that's to blame.


>
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: IBM On-Chip Controller (OCC) accessed from a service processor
>> +
>> +maintainers:
>> +  - Eddie James <eajames@linux.ibm.com>
>> +
>> +description: |
>> +  This binding describes a POWER processor On-Chip Controller (OCC)
> s/This binding describes a//
> But instead describe the hardware. What is the OCC?


OK I'll fix that. It's a management engine for system power and thermals.


>
>> +  accessed from a service processor or baseboard management controller
>> +  (BMC).
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ibm,p9-occ-hwmon
>> +      - ibm,p10-occ-hwmon
>> +
>> +  ibm,inactive-on-init:
>> +    description: This property describes whether or not the OCC should
>> +      be marked as active during device initialization. The alternative
>> +      is for user space to mark the device active based on higher level
>> +      communications between the BMC and the host processor.
> I find the combination property name with this description confusing. It
> sounds like init of OCC and somehow it should be inactive? I assume if
> you initialize device, it is active. Or maybe the "init" is of something
> else? What is more, non-negation is easier to understand, so rather
> "ibm,active-on-boot" (or something like that).


Well, the host processor initializes the OCC during it's boot, but this 
document is describing a binding to be used by a service processor 
talking to the OCC. So the OCC may be in any state. The init meant 
driver init, but I will simply the description and change the property 
to be more explicit: ibm,no-poll-on-init since that is what is actually 
happening. Similar to the FSI binding for no-scan-on-init.


>
>> +    type: boolean
>> +
>> +required:
>> +  - compatible
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    occ-hmwon {
> just "hwmon"
>
>> +        compatible = "ibm,p9-occ-hwmon";
>> +        ibm,inactive-on-init;
>> +    };


Thanks for the review!

Eddie


>
> Best regards,
> Krzysztof
