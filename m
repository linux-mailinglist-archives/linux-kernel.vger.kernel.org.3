Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B180C4ADE85
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 17:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352300AbiBHQof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 11:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238504AbiBHQoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 11:44:34 -0500
X-Greylist: delayed 1368 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 08:44:32 PST
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018F1C061579;
        Tue,  8 Feb 2022 08:44:31 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 218GLaqt094798;
        Tue, 8 Feb 2022 10:21:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644337296;
        bh=pUuWQr+L14zdI+Vc3J1KTPWgbWU9dWvEhXxZKxw3cCk=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=GpDKsn9r44cfaqqMWKNvTVOHoo3C3VZt8oW0UDJ2JEBWbPRyZ1TR2HJO5SBr6FAnV
         EX5QzWSZdUuaP/HrM7XA4PQX5Ry1D26Ch9V1cs2wpBjtZ6UdnwoYzzAqVlPV4IFBoW
         Z7CS7ifGsDiyPmlwXT/LNnTr2hAC/ipthtcHSF8U=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 218GLa2k116010
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Feb 2022 10:21:36 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 8
 Feb 2022 10:20:24 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 8 Feb 2022 10:20:24 -0600
Received: from [10.250.233.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 218GKLAD068450;
        Tue, 8 Feb 2022 10:20:22 -0600
Message-ID: <93916792-67f6-9018-e93b-4bdc8987af20@ti.com>
Date:   Tue, 8 Feb 2022 21:50:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5] ASoC: dt-bindings: davinci-mcasp: convert McASP
 bindings to yaml schema
Content-Language: en-US
To:     =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
        <robh+dt@kernel.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220103074427.4233-1-j-choudhary@ti.com>
 <2cf3c89c-169f-3421-25d4-c80a6c9737ae@gmail.com>
 <83c51ee4-ac10-0e44-d1cc-f69cebcbf0b8@gmail.com>
 <f2bf4959-af15-04ad-78c3-aca883173d65@ti.com>
 <609b03e1-66e0-9bfd-cbe1-810d816df659@gmail.com>
From:   Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <609b03e1-66e0-9bfd-cbe1-810d816df659@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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



On 29/01/22 01:48, Péter Ujfalusi wrote:
> 
> On 1/17/22 12:07, Jayesh Choudhary wrote:
> 
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    enum:
>>>>> +      - ti,dm646x-mcasp-audio
>>>>> +      - ti,da830-mcasp-audio
>>>>> +      - ti,am33xx-mcasp-audio
>>>>> +      - ti,dra7-mcasp-audio
>>>>> +      - ti,omap4-mcasp-audio
>>>
>>> This is the only thing which bugs me: the pointless '-audio' postfix for
>>> the compatible string...
>>>
>>
>> Removing the postfix would also require a lot of dts changes which might
>> be backward incompatible. So it is probably not a good idea.
> 
> My plan was to not convert the ti,*-mcasp-audio txt file to yaml in the
> first place, but do it right with as ti,*-mcasp
> 
> One of the outstanding issue is the multiple serializer support. It
> should be in core as things are just working by luck atm when more than
> one serializer is in use (via the card node).
> 
>> Should we still consider this?
> 
> Since we are officially documenting the -mcasp-audio, I don't think it
> would be a good idea to introduce different binding for the very same IP
> just for the sake of it.
> 
> The new (and imho correct) binding would require quite a bit of work in
> the driver and in the core level (plus the simple-card family), but I'm
> afraid, I will not have time for it.
> 

Peter,

I think all the new changes can be picked up later on.
For now, to support the current device tree and binding, I am posting a
v6 patch with 'acked-by' and 'reviewed-by' so that they are not lost in
this thread and this patch could be merged.
