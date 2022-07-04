Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DEF565069
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbiGDJIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbiGDJIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:08:37 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A91265A;
        Mon,  4 Jul 2022 02:08:35 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2647VSbn031460;
        Mon, 4 Jul 2022 11:08:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=hSr9h6Lsw/kEcOYpJnY2XLYWBREQsrXq8yfjO4tL5Dk=;
 b=34ygLB0JfpcZEgnNsReUDny7p1awHtZEqP75BaOKY00TghJpSjzhtTOjm/1J76HWHj2J
 Af0r4FlUSBWJAO4Eoo1jyH1pOb4Kwd2RQqx24m/mJQz7LWsz9y2iZPn6yzrsdJ3JIQOI
 WHnvEteqBsXc33NgBKTvEnLzsf9FxXTMREv5au3q/t2itYTfAwIt8KoVIRojECbCsMZX
 6Kei9RRYgbfb1ZKSsgzDWAs/wysjqpH2VBSEIaj9ihbYvd4Yx10FdYBpAc2AIrH1p4q+
 RjNb1IY0Jl/XlqRd2VCvqgfPjGCDom8WYazXWx8hYBru4BfoBu0TcLzq2lUfPIiqGqJE ow== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3h2cwhs073-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 11:08:25 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 248DC10002A;
        Mon,  4 Jul 2022 11:08:23 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9752F215158;
        Mon,  4 Jul 2022 11:08:23 +0200 (CEST)
Received: from [10.48.1.102] (10.75.127.47) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Mon, 4 Jul
 2022 11:08:23 +0200
Message-ID: <13266b3e-7571-23fa-13bd-1c8107a5f90d@foss.st.com>
Date:   Mon, 4 Jul 2022 11:08:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/4] dt-bindings: usb: typec: add bindings for stm32g0
 controller
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <amelie.delaunay@foss.st.com>, <alexandre.torgue@foss.st.com>,
        <gregkh@linuxfoundation.org>, <heikki.krogerus@linux.intel.com>
References: <20220624155413.399190-1-fabrice.gasnier@foss.st.com>
 <20220624155413.399190-2-fabrice.gasnier@foss.st.com>
 <ddb0e946-c955-1404-c1cd-c2548f34ec35@linaro.org>
 <845d6817-d2e4-7925-f7f5-da1102514636@foss.st.com>
 <286633b2-43d2-655e-b3f1-54bf5c7a4a21@linaro.org>
 <6ef58f1f-ee8a-b060-6fda-d1388b3ede6d@foss.st.com>
 <f86dd47c-0fc5-6c93-a49e-534610d10c49@linaro.org>
 <dfad8fb5-6205-d620-81eb-5d44b9175e05@foss.st.com>
 <0821acfe-bcfe-b1d8-c1a9-81023f4ab6a0@linaro.org>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <0821acfe-bcfe-b1d8-c1a9-81023f4ab6a0@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-04_07,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/22 09:55, Krzysztof Kozlowski wrote:
> On 01/07/2022 12:04, Fabrice Gasnier wrote:
>>
>> Then I no longer get this warning upon build. But the dtbs_check complains:
>> ---
>> connector: ports: 'port@0' is a required property
>> 	From schema: ..
>> Documentation/devicetree/bindings/connector/usb-connector.yaml
>>
>> So It looks like to me there's something missing to handle the single
>> port case in usb-connector.yaml, when using the "ports".
>>
>> Maybe usb-connector could be updated to handle "port" (w/o unit-addr) ?
> 
> Not really, the dtc warning looks false-positive. Especially that you
> need port@1 for USB 3.0 (super speed), unless you do not support it?

Hi Krzysztof,

Having USB2.0 High speed port only is perfectly valid. port@1 is
optional to support USB3.0 as you mention.

I've no opinion regarding a possible false positive warning. I'd like to
sort this out, perhaps Rob has some recommendation regarding this ?

Please advise,
Best regards,
Fabrice

> 
>> I'm talking about:
>>     required:
>>       - port@0
>>
>> So, I came up with:
>>
>> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
>> @@ -176,6 +176,9 @@ properties:
>>        port number as described below.
>>
>>      properties:
>> +      port:
>> +        $ref: /schemas/graph.yaml#/properties/port
>> +
>>        port@0:
>>          $ref: /schemas/graph.yaml#/properties/port
>>          description: High Speed (HS), present in all connectors.
>> @@ -189,8 +192,11 @@ properties:
>>          description: Sideband Use (SBU), present in USB-C. This
>> describes the
>>            alternate mode connection of which SBU is a part.
>>
>> -    required:
>> -      - port@0
>> +    oneOf:
>> +      - required:
>> +          - port
>> +      - required:
>> +          - port@0
>>
>>
>> Do you agree on this approach ? (I can add a pre-cursor patch to this
>> series, to handle the single port case)
> 
> 
> 
> Best regards,
> Krzysztof
