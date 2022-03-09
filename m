Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B564D2BF8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbiCIJaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiCIJaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:30:23 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D09516E7F7;
        Wed,  9 Mar 2022 01:29:25 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2297dkET010366;
        Wed, 9 Mar 2022 03:28:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=cnOds1P2HYMESzPFz39oF0gCUJHlgInu9tI0YBb37ME=;
 b=qEDhi0fDzrUDTtw6O9p55Ji32CEH4LBZ03lH9Jz3DuQq31Jm7rsOWLy+nkQqSnUeFRmz
 VQgPcnQZtrPHkugyrkCpKrG+Mp5gll9U+KbxCl+qHqy2D6NoExgzNjniS8oV2UJLVz/q
 eSMH1nTgu+9fals4bIxfEerV+sMe4jgU5MKeUyS2xO1kqt/0qk+Bv0hCxcD6SlRTVPHT
 nSz/JAGslfCSt3i8dft2XmDUa00PrKEU84XioTFrF8bkil49UOFBxXUKkTdSVsJ+jP1y
 7ecQ6rg7DlT3jNOrPnn2UTxBUqfkqjqyaaF5aQKr8TxzU15q4Igulv5e5ftNPIemkN0N Ig== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3em55swdv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 09 Mar 2022 03:28:40 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Mar
 2022 09:28:38 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Wed, 9 Mar 2022 09:28:38 +0000
Received: from [198.61.65.38] (unknown [198.61.65.38])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5956546C;
        Wed,  9 Mar 2022 09:28:38 +0000 (UTC)
Message-ID: <a5fe73dc-1126-0f46-cbc0-1ab864843ea6@opensource.cirrus.com>
Date:   Wed, 9 Mar 2022 09:28:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 15/16] ASoC: dt-bindings: cs35l41: Document CS35l41
 External Boost
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        David Rhodes <drhodes@opensource.cirrus.com>
References: <20220308171730.454587-1-tanureal@opensource.cirrus.com>
 <20220308171730.454587-16-tanureal@opensource.cirrus.com>
 <20220309012043.GA1694603@robh.at.kernel.org>
From:   Lucas tanure <tanureal@opensource.cirrus.com>
In-Reply-To: <20220309012043.GA1694603@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: howsFYvVvDI4cucQBfeq_h8T-Enuu5Fn
X-Proofpoint-GUID: howsFYvVvDI4cucQBfeq_h8T-Enuu5Fn
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/22 01:20, Rob Herring wrote:
> On Tue, Mar 08, 2022 at 05:17:29PM +0000, Lucas Tanure wrote:
>> From: David Rhodes <drhodes@opensource.cirrus.com>
>>
>> Document internal and external boost feature for ASoC CS35L41.
>> For internal boost the following properties are required:
>> - cirrus,boost-peak-milliamp
>> - cirrus,boost-ind-nanohenry
>> - cirrus,boost-cap-microfarad
>>
>> For external boost, the GPIO1 must be configured as output,
>> so the following properties are required:
>> - cirrus,gpio1-src-select = <1>
>> - cirrus,gpio1-output-enable
>>
>> Signed-off-by: David Rhodes <drhodes@opensource.cirrus.com>
>> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
>> ---
>>   .../bindings/sound/cirrus,cs35l41.yaml        | 44 +++++++++++++++++--
>>   1 file changed, 41 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
>> index 3235702ce402..09b515924c59 100644
>> --- a/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
>> +++ b/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
>> @@ -75,6 +75,19 @@ properties:
>>       maximum: 3
>>       default: 2
>>   
>> +  cirrus,boost-type:
>> +    description:
>> +      Configures the type of Boost being used.
>> +      Internal boost requires boost-peak-milliamp, boost-ind-nanohenry and
>> +      boost-cap-microfarad.
>> +      External Boost must have GPIO1 as GPIO output. GPIO1 will be set high to
>> +      enable boost voltage.
>> +      0 = Internal Boost
>> +      1 = External Boost
>> +    $ref: "/schemas/types.yaml#/definitions/uint32"
>> +    minimum: 0
>> +    maximum: 1
> 
> What does not present mean? Might be better to make this boolean depending
> on what you are trying to accomplish.
Not present means Internal boost. There will be other types of boost in 
the future, so I would like to keep it as is.

> 
>> +
>>     cirrus,gpio1-polarity-invert:
>>       description:
>>         Boolean which specifies whether the GPIO1
>> @@ -131,9 +144,32 @@ required:
>>     - compatible
>>     - reg
>>     - "#sound-dai-cells"
>> -  - cirrus,boost-peak-milliamp
>> -  - cirrus,boost-ind-nanohenry
>> -  - cirrus,boost-cap-microfarad
>> +
>> +allOf:
>> +  - if:
>> +      properties:
>> +        cirrus,boost-type:
>> +            const: 0
> 
> Note that this will be true if cirrus,boost-type is not present. You
> probably want to add 'required'.
Yes, that's expected. We want to continue to support old device trees 
without boost type, and for that case it sets to internal boost.

> 
>> +    then:
>> +      required:
>> +        - cirrus,boost-peak-milliamp
>> +        - cirrus,boost-ind-nanohenry
>> +        - cirrus,boost-cap-microfarad
>> +    else:
>> +      if:
>> +        properties:
>> +          cirrus,boost-type:
>> +            const: 1
>> +      then:
>> +        required:
>> +          - cirrus,gpio1-output-enable
>> +          - cirrus,gpio1-src-select
>> +        properties:
>> +          cirrus,boost-peak-milliamp: false
>> +          cirrus,boost-ind-nanohenry: false
>> +          cirrus,boost-cap-microfarad: false
>> +          cirrus,gpio1-src-select:
>> +            enum: [1]
>>   
>>   additionalProperties: false
>>   
>> @@ -150,6 +186,8 @@ examples:
>>             VA-supply = <&dummy_vreg>;
>>             VP-supply = <&dummy_vreg>;
>>             reset-gpios = <&gpio 110 0>;
>> +
>> +          cirrus,boost-type = <0>;
>>             cirrus,boost-peak-milliamp = <4500>;
>>             cirrus,boost-ind-nanohenry = <1000>;
>>             cirrus,boost-cap-microfarad = <15>;
>> -- 
>> 2.35.1
>>
>>

