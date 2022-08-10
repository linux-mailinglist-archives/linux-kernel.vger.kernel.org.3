Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B518158EDB4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbiHJN5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbiHJN5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:57:15 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B32B59275;
        Wed, 10 Aug 2022 06:57:14 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27AD4HG8029931;
        Wed, 10 Aug 2022 13:56:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=kiy7WXqD6IJTKwOY8MP6pKu62ib325Ly8oJCzgZBf7E=;
 b=Vw2tLpK+1iqXPowS/3JnjNh45F+mjbA3LUt2A2gkfCPbYBcF4bZY9Qktj3D/3pRJzaYt
 tSXJy/+yzPlMqnzbFJYCLt9o8J6yUZ7T1hwlPhMkC0SR9poajw0+wFUOKtgaPPMatcjX
 6d2B1lj3xm0yN3+5wZpxj5Q4rs6vEwk+3Jfox12AEHPVx6VGQmNguxG+rDeVStra6H7c
 E0l8Jd/0PjV8YYhoWGXixq+OaJ+dksAR/OOoT8JjEjY5oDtKAL3F5HOzCi+l5IzkSbD1
 eHFx1OXxf8+xY6Vl5LvT13m2vu0XaAF4bri7K4wLBVacmBYsxWlAtFb1epwJdihxgX5y vA== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hv31vv4fp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 13:56:48 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27ADohvB001640;
        Wed, 10 Aug 2022 13:56:47 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma05wdc.us.ibm.com with ESMTP id 3hvcmr8e35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 13:56:47 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27ADukQa31064362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Aug 2022 13:56:46 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 426C1BE054;
        Wed, 10 Aug 2022 13:56:46 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2096DBE051;
        Wed, 10 Aug 2022 13:56:44 +0000 (GMT)
Received: from [9.160.17.179] (unknown [9.160.17.179])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 10 Aug 2022 13:56:44 +0000 (GMT)
Message-ID: <8b2fcd61-16d6-09d1-e6ef-f5964378ab9f@linux.ibm.com>
Date:   Wed, 10 Aug 2022 08:56:44 -0500
MIME-Version: 1.0
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
 <59ee8c2f-3d6c-14ed-c9f8-2bbd9377a7da@linux.ibm.com>
 <25eefb70-a7ae-876e-c05a-bd308d41053e@linaro.org>
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <25eefb70-a7ae-876e-c05a-bd308d41053e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mIRS1J6dM9Y4FJFn5qM3iaMOMkC0WZsK
X-Proofpoint-ORIG-GUID: mIRS1J6dM9Y4FJFn5qM3iaMOMkC0WZsK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_08,2022-08-10_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208100042
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/10/22 02:43, Krzysztof Kozlowski wrote:
> On 09/08/2022 22:42, Eddie James wrote:
>>>> +  ibm,inactive-on-init:
>>>> +    description: This property describes whether or not the OCC should
>>>> +      be marked as active during device initialization. The alternative
>>>> +      is for user space to mark the device active based on higher level
>>>> +      communications between the BMC and the host processor.
>>> I find the combination property name with this description confusing. It
>>> sounds like init of OCC and somehow it should be inactive? I assume if
>>> you initialize device, it is active. Or maybe the "init" is of something
>>> else? What is more, non-negation is easier to understand, so rather
>>> "ibm,active-on-boot" (or something like that).
>>
>> Well, the host processor initializes the OCC during it's boot, but this
>> document is describing a binding to be used by a service processor
>> talking to the OCC. So the OCC may be in any state. The init meant
>> driver init, but I will simply the description and change the property
>> to be more explicit: ibm,no-poll-on-init since that is what is actually
>> happening. Similar to the FSI binding for no-scan-on-init.
> no-scan-on-init is not a good example. It wasn't even reviewed by Rob
> (looking at commit). In both cases you describe driver behavior which is
> not appropriate for bindings. Instead you should describe the hardware
> characteristics/feature/bug/state which require skipping the initialization.


Yep... there is no such hardware thing. The driver should never poll the 
OCC during driver initialization (since host state isn't known), but it 
did for the first couple of years of the drivers existence because we 
didn't catch that it could cause problems. I submitted a patch to change 
the driver behavior, but it does change the user space interface, so the 
argument is that the new behavior should be optional.

I suppose one correct way to control that would be a module parameter, 
but that really doesn't work well on embedded-like systems like ours.

Thanks very much for your feedback Krzysztof. Joel, any suggestions here?

Eddie


>
>
> Best regards,
> Krzysztof
