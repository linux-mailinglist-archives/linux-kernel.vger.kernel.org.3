Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8A94B08A1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237732AbiBJIlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:41:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237655AbiBJIlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:41:04 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C92BEB4;
        Thu, 10 Feb 2022 00:41:01 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 1F71E1F45FED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644482459;
        bh=dxxB5y7E7AReW2OAClnLIQexw3iKhotkP4SOeOAGdAE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lymY0FiuiysUb7/sSKRGIAg4jthJDb4GiQzlbfekQkSWXBOvc5GXsheGI2D39J1Qi
         k3vPiOsX1+GILO03JWThkAH1dG6l+O2/r5mfnGztJ0BOCm05187+jqRK+CupRNXscf
         8dVNhlmp9hrk5o4Ovl1lidzZFLamLR6CSZwgupmALF+H0sAgSH1XA9hwLQqYRDgzh+
         q0WsnrGIZDrVnlsWpC4OslPfBt9Ww3yFdx067aDeyIWs8l4V+hlIwGYGc5mfb1ossx
         jKqVmmQpyz+sUPAhv1UfvSxb/UCIP2+mkls3Ei8ZXuqiZEcWe8v06niHjVo4uepz4E
         k7FeUraA0G4cg==
Message-ID: <f807c862-d327-5b12-7443-c4fed6e1ef6a@collabora.com>
Date:   Thu, 10 Feb 2022 09:40:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2, 1/7] dt-bindings: media: mtk-vcodec: Adds decoder
 dt-bindings for lat soc
Content-Language: en-US
To:     "yunfei.dong@mediatek.com" <yunfei.dong@mediatek.com>,
        Rob Herring <robh@kernel.org>
Cc:     Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220128035440.24533-1-yunfei.dong@mediatek.com>
 <20220128035440.24533-2-yunfei.dong@mediatek.com>
 <YgQl8CtttQ99+8lB@robh.at.kernel.org>
 <aa72bec2064e25990e1a3641b920cb5528cfccd4.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <aa72bec2064e25990e1a3641b920cb5528cfccd4.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/02/22 04:06, yunfei.dong@mediatek.com ha scritto:
> Hi Rob,
> 
> Thanks for your suggestion.
> On Wed, 2022-02-09 at 14:37 -0600, Rob Herring wrote:
>> On Fri, Jan 28, 2022 at 11:54:34AM +0800, Yunfei Dong wrote:
>>> Adds decoder dt-bindings for compatible "mediatek,mtk-vcodec-lat-
>>> soc".
>>
>> What's lat soc? How does this relate to what's already there in this
>> binding.
>>
> lat soc is another hardware, is related with some vdec larb ports.
> Won't be used to decode, but must to write it in dtsi, or hardware
> can't work well.

Hello Yunfei,

as a suggestion, writing the meaning of the "LAT" acronym may also
help to clear some doubts around (please, also do that in the yaml file,
other than the commit description).

Thank you!
Angelo

> 
> Need to enable clock/power/iommus, no interrupt.
>> The subject space is limited, avoid saying the same thing twice
>> (dt-bindings).
>>
> 
> Best Regards,
> Yunfei Dong
>>>
>>> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
>>> ---
>>>   .../media/mediatek,vcodec-subdev-decoder.yaml | 49
>>> +++++++++++++++++++
>>>   1 file changed, 49 insertions(+)
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-
>>> decoder.yaml
>>> b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-
>>> decoder.yaml
>>> index 6415c9f29130..a3c892338ac0 100644
>>> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-
>>> subdev-decoder.yaml
>>> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-
>>> subdev-decoder.yaml
>>> @@ -189,6 +189,55 @@ patternProperties:
>>>   
>>>       additionalProperties: false
>>>   
>>> +  '^vcodec-lat-soc@[0-9a-f]+$':
>>> +    type: object
>>> +
>>> +    properties:
>>> +      compatible:
>>> +        const: mediatek,mtk-vcodec-lat-soc
>>> +
>>> +      reg:
>>> +        maxItems: 1
>>> +
>>> +      iommus:
>>> +        minItems: 1
>>> +        maxItems: 32
>>> +        description: |
>>> +          List of the hardware port in respective IOMMU block for
>>> current Socs.
>>> +          Refer to bindings/iommu/mediatek,iommu.yaml.
>>> +
>>> +      clocks:
>>> +        maxItems: 5
>>> +
>>> +      clock-names:
>>> +        items:
>>> +          - const: sel
>>> +          - const: soc-vdec
>>> +          - const: soc-lat
>>> +          - const: vdec
>>> +          - const: top
>>> +
>>> +      assigned-clocks:
>>> +        maxItems: 1
>>> +
>>> +      assigned-clock-parents:
>>> +        maxItems: 1
>>> +
>>> +      power-domains:
>>> +        maxItems: 1
>>> +
>>> +    required:
>>> +      - compatible
>>> +      - reg
>>> +      - iommus
>>> +      - clocks
>>> +      - clock-names
>>> +      - assigned-clocks
>>> +      - assigned-clock-parents
>>> +      - power-domains
>>> +
>>> +    additionalProperties: false
>>> +
>>>   required:
>>>     - compatible
>>>     - reg
>>> -- 
>>> 2.25.1
>>>
>>>
> 

