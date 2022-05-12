Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB0652533D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356879AbiELRJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238286AbiELRJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:09:24 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363D2269EF6;
        Thu, 12 May 2022 10:09:23 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CGqWDG004183;
        Thu, 12 May 2022 17:09:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ePKra5FZpkKBNQOtZOHRk5h8AEU0vcuB/nXrxlxQZMI=;
 b=W7pXY+mF9c157K7UF/UpoCPupzyRkgWNvmeFE44FXujyi1+OlQGcAMuXLLNlO9uKJeRT
 QTaSAWdLFqky2fE8FFj+Q7veFXCkCGoZrHmtGw6hNG8aLJdrQlYAxmX4k73+OhuW26Mj
 dVlSIp9YhXKVkiSVPewOgvviMO3sStmMHW2oy00ZpVXqoLzh7szxFWsX+s2N/dF/xRAb
 ECMEtTJ+pGE0mcJFpbYlZP7zieApdtjkCu5kyafS2ywU+7ectrNW4zRhmrJre/4NiK6z
 ASK7E8SpSsAhuFm8dS9RD2c/pLiJlS8iILZdIgwVXt52X6fAoYwZENraV3zDefdEgUJj 6w== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g15tgrubh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 17:09:00 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24CGmU3I030362;
        Thu, 12 May 2022 17:08:59 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03dal.us.ibm.com with ESMTP id 3fwgdadsp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 17:08:59 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24CH8wrX27460066
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 17:08:58 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC80628060;
        Thu, 12 May 2022 17:08:58 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3C052805E;
        Thu, 12 May 2022 17:08:57 +0000 (GMT)
Received: from [9.211.56.168] (unknown [9.211.56.168])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 12 May 2022 17:08:57 +0000 (GMT)
Message-ID: <306c28b7-7318-9b8d-f512-d6e78bd05e51@linux.ibm.com>
Date:   Thu, 12 May 2022 12:08:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: humidity: Add si7020 bindings
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, lars@metafoo.de, jic23@kernel.org,
        miltonm@us.ibm.com, David Barksdale <dbarksdale@uplogix.com>
References: <20220512162020.33450-1-eajames@linux.ibm.com>
 <20220512162020.33450-2-eajames@linux.ibm.com>
 <20220512175125.00001a5a@Huawei.com>
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20220512175125.00001a5a@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: U9Osxt7RygooQvY3l0MSKtC5k4iFU75u
X-Proofpoint-ORIG-GUID: U9Osxt7RygooQvY3l0MSKtC5k4iFU75u
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_14,2022-05-12_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1011 bulkscore=0 adultscore=0
 spamscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120079
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/12/22 11:51, Jonathan Cameron wrote:
> On Thu, 12 May 2022 11:20:19 -0500
> Eddie James <eajames@linux.ibm.com> wrote:
>
>> Document the si7020 bindings with a new "silabs,skip-reset" property.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>>   .../bindings/iio/humidity/silabs,si7020.yaml  | 47 +++++++++++++++++++
>>   .../devicetree/bindings/trivial-devices.yaml  |  2 -
>>   2 files changed, 47 insertions(+), 2 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/iio/humidity/silabs,si7020.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iio/humidity/silabs,si7020.yaml b/Documentation/devicetree/bindings/iio/humidity/silabs,si7020.yaml
>> new file mode 100644
>> index 000000000000..9bee010f8d56
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/humidity/silabs,si7020.yaml
>> @@ -0,0 +1,47 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/humidity/silabs,si7020.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: SI7020 humidity + temperature sensor
>> +
>> +maintainers:
>> +  - David Barksdale <dbarksdale@uplogix.com>
> At least cc David if you are going to commit him to maintaining this binding :)
> +CC David at that address.


Yes, my mail to him for v1 was undeliverable... I guess I should put 
myself instead.


>
>> +
>> +description: |
>> +   The Silicon Labs Si7013/20/21 Relative Humidity and Temperature Sensors
>> +   are i2c devices which have an identical programming interface for
>> +   measuring relative humidity and temperature.
>> +
>> +properties:
>> +  compatible:
>> +    const: silabs,si7020
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  siliabs,skip-reset:
>> +    $ref: /schemas/types.yaml#/definitions/flag
>> +    description:
>> +      Disables resetting of the device during probe
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    i2c0 {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      si7021-a20@40 {
>> +        silabs,skip-reset;
>> +        compatible = "silabs,si7020";
>> +        reg = <0x40>;
>> +      };
>> +    };
>> +...
>> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
>> index e5295faef52f..47a00b478867 100644
>> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
>> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
>> @@ -317,8 +317,6 @@ properties:
>>             - sensortek,stk8ba50
>>               # SGX Sensortech VZ89X Sensors
>>             - sgx,vz89x
>> -            # Relative Humidity and Temperature Sensors
>> -          - silabs,si7020
>>               # Skyworks SKY81452: Six-Channel White LED Driver with Touch Panel Bias Supply
>>             - skyworks,sky81452
>>               # Socionext SynQuacer TPM MMIO module
