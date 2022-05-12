Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735CA525569
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 21:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357928AbiELTLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 15:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357922AbiELTLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 15:11:31 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFA83E0C8;
        Thu, 12 May 2022 12:11:30 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CIRWY9013204;
        Thu, 12 May 2022 19:11:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=erGBUJ07wNUJV+sPUuGngCGtTCXo+k3qkrV4vWOiECc=;
 b=NtTZRFqZFca0PWldtWwrZnnw6PSKA6IeSJWa5WxaOL29cn+bfUtYAWlPNhb187G9rzkw
 Y1twkCN3GyuH/qcxWx4MZfZsbruRaW5smW/+pJ/iIRfjevjhIMMC5lmsacw05HQVlPSH
 LiVuR0KlcroJg5R0dRjTKrn0AljJYOWUjaBIK0XOTFN1aTMy0lUHHR0Iaf85r/PnIrWH
 R6WZFN+y8Ubxm4hVXT2/Fg45s7kEkwR+JzUPm+A7kNg/hYFqk/nJTYEdp0cH++C2t0Ze
 ruuvdKioG75HVKv1AK19Nvm/apP0cNHEb5Nhmdn50TDpYlSRcAQNG8Y7ePc/nIc0Oq+m 9g== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g173b9f2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 19:11:09 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24CIvDkX019581;
        Thu, 12 May 2022 19:11:08 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01dal.us.ibm.com with ESMTP id 3fwgdb6jqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 19:11:08 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24CJB7wr23920930
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 19:11:07 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9BD8E2805E;
        Thu, 12 May 2022 19:11:07 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C72CF28059;
        Thu, 12 May 2022 19:11:06 +0000 (GMT)
Received: from [9.211.56.168] (unknown [9.211.56.168])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 12 May 2022 19:11:06 +0000 (GMT)
Message-ID: <c2f7b09d-e046-409e-b65e-153157f84b03@linux.ibm.com>
Date:   Thu, 12 May 2022 14:11:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 0/2] iio: humidity: si7020: Check device property for
 skipping reset in probe
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, lars@metafoo.de, jic23@kernel.org,
        miltonm@us.ibm.com
References: <20220512162020.33450-1-eajames@linux.ibm.com>
 <20220512174859.000042b6@Huawei.com>
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20220512174859.000042b6@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: h0MVSw3yJcPGbeM8LBRXqFnnQ43eC3Tx
X-Proofpoint-GUID: h0MVSw3yJcPGbeM8LBRXqFnnQ43eC3Tx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_16,2022-05-12_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120083
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/12/22 11:48, Jonathan Cameron wrote:
> On Thu, 12 May 2022 11:20:18 -0500
> Eddie James <eajames@linux.ibm.com> wrote:
>
>> I2C commands issued after the SI7020 is starting up or after reset
>> can potentially upset the startup sequence. Therefore, the host
>> needs to wait for the startup sequence to finish before issuing
>> further i2c commands. This is impractical in cases where the SI7020
>> is on a shared bus or behind a mux, which may switch channels at
>> any time (generating I2C traffic). Therefore, check for a device
>> property that indicates that the driver should skip resetting the
>> device when probing.
> Why not lock the bus?  It's not ideal, but then not resetting and hence
> potentially ending up in an unknown state isn't great either.


Also, I should mention that in our case we can rely on the power on 
reset, so the device should be in a known state.

Eddie


>
> Jonathan
>
>> Changes since v1:
>>   - Fix dt binding document
>>
>> Eddie James (2):
>>    dt-bindings: iio: humidity: Add si7020 bindings
>>    iio: humidity: si7020: Check device property for skipping reset in probe
>>
>>   .../bindings/iio/humidity/silabs,si7020.yaml  | 47 +++++++++++++++++++
>>   .../devicetree/bindings/trivial-devices.yaml  |  2 -
>>   drivers/iio/humidity/si7020.c                 | 14 +++---
>>   3 files changed, 55 insertions(+), 8 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/iio/humidity/silabs,si7020.yaml
>>
