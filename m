Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A42524012
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 00:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245479AbiEKWIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 18:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239751AbiEKWIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 18:08:42 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CC11ECBBB;
        Wed, 11 May 2022 15:08:41 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BLqgEe012777;
        Wed, 11 May 2022 22:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=RebwC26p5Wfow7qyFro4avBymjb+i3xQnZigePH8kn0=;
 b=mzL9P13o/eawGUP9AlBIyxU0bjkg278oQ4j9i2XlDF/gTkpjmTI0Rq/Xas4wn6RyzsNG
 Y9fAqzngoMnYz9GugFgSvpcusir8FkCYNMi6eb9K+69PZzrKmrxOj4CmJJd5DKugoMcJ
 ULZ4s7MItOP9U/DwHFyAD9uL04/owJfPEF2OvTyUjVgFAU00SQXAi9rTkPTd+cDgnW/W
 OdGDTq5zhd5Aq5aotaNtKK2RpcxO+E3Rmi9DhUKpE+gsItDUwUhGEwUMBrDaNysBpQoQ
 ClU+RVhqbT3rgXcrufAJEf4TwQ7CnVqfZcg16fa24Z1g73PcDu0dcCLHQTxL1wSgrQ7t 9w== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g0nes09bk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 22:08:26 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24BM3EEc017328;
        Wed, 11 May 2022 22:08:25 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma02wdc.us.ibm.com with ESMTP id 3fwgd9y6kj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 22:08:25 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24BM8PQ433882590
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 22:08:25 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1C1B7805E;
        Wed, 11 May 2022 22:08:24 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 939CB7805F;
        Wed, 11 May 2022 22:08:24 +0000 (GMT)
Received: from [9.211.61.211] (unknown [9.211.61.211])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 11 May 2022 22:08:24 +0000 (GMT)
Message-ID: <7b4f2991-1dce-77d2-53c2-c4c358cbfe77@linux.ibm.com>
Date:   Wed, 11 May 2022 17:08:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/2] dt-bindings: iio: humidity: Add si7020 bindings
Content-Language: en-US
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dbarksdale@uplogix.com,
        miltonm@us.ibm.com
References: <20220511190835.51046-1-eajames@linux.ibm.com>
 <20220511190835.51046-2-eajames@linux.ibm.com>
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20220511190835.51046-2-eajames@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sksZU_YEqcaKthbltK_OC-5v7vLil0VO
X-Proofpoint-ORIG-GUID: sksZU_YEqcaKthbltK_OC-5v7vLil0VO
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_07,2022-05-11_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=972 bulkscore=0
 suspectscore=0 impostorscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205110098
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/11/22 14:08, Eddie James wrote:
> Document the si7020 bindings with a new "silabs,skip-reset" property.


I missed the entry in trivial-devices.txt. I can push a v2 or a separate 
patch for that.

Eddie


>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>   .../bindings/iio/humidity/silabs,si7020.yaml  | 42 +++++++++++++++++++
>   1 file changed, 42 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/iio/humidity/silabs,si7020.yaml
>
> diff --git a/Documentation/devicetree/bindings/iio/humidity/silabs,si7020.yaml b/Documentation/devicetree/bindings/iio/humidity/silabs,si7020.yaml
> new file mode 100644
> index 000000000000..ab53bb8d9606
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/humidity/silabs,si7020.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/humidity/silabs,si7020.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SI7020 humidity + temperature sensor
> +
> +maintainers:
> +  - David Barksdale <dbarksdale@uplogix.com>
> +
> +description: |
> +   The Silicon Labs Si7013/20/21 Relative Humidity and Temperature Sensors
> +   are i2c devices which have an identical programming interface for
> +   measuring relative humidity and temperature.
> +
> +properties:
> +  compatible:
> +    const: silabs,si7020
> +
> +  reg:
> +    maxItems: 1
> +
> +  siliabs,skip-reset:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Disables resetting of the device during probe
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    si7021-a20@40 {
> +        silabs,skip-reset;
> +        compatible = "silabs,si7020";
> +        reg = <0x40>;
> +    };
> +...
