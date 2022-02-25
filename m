Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943014C444A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 13:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbiBYMI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 07:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbiBYMIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:08:55 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF1E1A39FE;
        Fri, 25 Feb 2022 04:08:23 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21P4SjAs015204;
        Fri, 25 Feb 2022 06:08:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=PnyIEGMUB/zij9tNaJ3PJr930XqiWXvaO3E0rGGsd6c=;
 b=Katb5zY2kmpJDWvN5lVrncqHU5CRWbjnrpHq/1ib9+CxGTQCWh1zVvGwqKJtFwZEfCgn
 2nf6CexcUroY+lP7CV2ZawEnARnCFNWaLr8PJorEWrLJvg5xz/ShFAfmMeVX7T9NXmz8
 iaKwmKFHR3zpmLxDo0dupXkvsjk77fLghM2OFTQkyxAcOopEC6zT9gyD3+UHgnijhrJk
 rlJATnydjevvU1aJCvkP/oOuAcT9Rz3xBd/Fj+cPmKbIf2XtFBzJQ+HDBO8p2v23EHQh
 qFZFSXYLrWV7x/sQgnQXvDQSwvBGbUWRzeIzar4vo7mezqBJ4X0WwUdl2eDahdZKkb8m Mg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ednxtk342-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 25 Feb 2022 06:08:02 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 25 Feb
 2022 12:08:00 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 25 Feb 2022 12:08:00 +0000
Received: from [10.0.2.15] (AUSNPC0LSNW1.ad.cirrus.com [198.90.251.79])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 194B2B10;
        Fri, 25 Feb 2022 12:08:00 +0000 (UTC)
Subject: Re: [PATCH V2 1/2] ASoC: dt-bindings: audio-graph-port: Add
 dai-tdm-slot-width-map
To:     Rob Herring <robh@kernel.org>
CC:     <broonie@kernel.org>, <kuninori.morimoto.gx@renesas.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20220217134835.282389-1-rf@opensource.cirrus.com>
 <20220217134835.282389-2-rf@opensource.cirrus.com>
 <YhgCbKzfPXEVauwW@robh.at.kernel.org>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <7d11f36e-4b56-8c17-a114-d024f76f3b9e@opensource.cirrus.com>
Date:   Fri, 25 Feb 2022 12:08:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YhgCbKzfPXEVauwW@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: IfFZpD1AJt6Oo2nIABD5FeX_ybMecCzr
X-Proofpoint-ORIG-GUID: IfFZpD1AJt6Oo2nIABD5FeX_ybMecCzr
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

On 24/02/2022 22:10, Rob Herring wrote:
> On Thu, Feb 17, 2022 at 01:48:34PM +0000, Richard Fitzgerald wrote:
>> Some audio hardware cannot support a fixed slot width or a slot width
>> equal to the sample width in all cases. This is usually due either to
>> limitations of the audio serial port or system clocking restrictions.
>>
>> This property allows setting a mapping of sample widths and the
>> corresponding tdm slot widths.
>>
>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>> ---
>>   .../devicetree/bindings/sound/audio-graph-port.yaml        | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
>> index 476dcb49ece6..420adad49382 100644
>> --- a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
>> +++ b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
>> @@ -71,4 +71,11 @@ patternProperties:
>>           description: CPU to Codec rate channels.
>>           $ref: /schemas/types.yaml#/definitions/uint32
>>   
>> +      dai-tdm-slot-width-map:
>> +        description: Mapping of sample widths to slot widths. For hardware that
>> +          cannot support a fixed slot width or a slot width equal to sample
> 
> A variable slot width sounds like a feature, not a limitation.
> 

Depends on point of view. Most interfaces allow setting a fixed slot
width but in some cases that's not possible so it is more likely to be
seen as a limitation. It is however a feature in the sense that it can
avoid using higher frequencies that are necessary.

>> +          width. An array containing one or more pairs of values. Each pair
>> +          of values is a sample_width and the corresponding slot_width.
> 
> That sounds like a matrix, not an array. N entries of 2 cells each.
> 
>> +        $ref: /schemas/types.yaml#/definitions/uint32-array
>> +
> 
> I'd think there are some constraints on the values? Slots should be at
> least 8 bits, right? A max of 2x32 bits or is there more

True. I didn't think it was appropriate for a generic binding to enforce
a range when that depends on the exact hardware. But if you want I can
enforce a range that's likely to be true for all hardware.

> than stereo within a slot? In any case, it's for sure no where near 2^32
> max.

One sample per slot.

> 
> Is there a need for specifying where in the slot the data is?

I don't believe so, all the protocols I know of have the data bits
transmitted first followed by padding. There's no harm adding a
reserved field to allow for this info if it is ever needed, but it would
be unused at present as there's no kernel API to do this.

> 
> Rob
> 
