Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BAD51FA85
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiEIKyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 06:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiEIKyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 06:54:33 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E32233A58;
        Mon,  9 May 2022 03:50:38 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 341A21F43B9C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652093437;
        bh=MIuLmVe6TIzgT754hZGMYSoOyD19xD3PkF1IXcgoh98=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MaHkG/E3YW6LJ0G4SAtovaqL+jdNBJVE7a3iT0Iu++K4sfapfWhqcY5cd+EZQZ27y
         Ix+vNnxkEsWHplam96f531sR+hi1mAfSJmaWeZZwumwaL0LqXAEg01wFCvsX7V2UqP
         da0oJ+fb2xi8Ff8KGf3utMwi7s/1Wn8IbkI1R9eBH/aiJ2ReDRQm1dUgxi1FRIzA1+
         k7aOXbcYKAgy7KgwXBMme94SXNGKXIE3oH68474nZ+sw1kjQMLKkGxGLjksK+8eyk9
         kSvfIcy8xIdcRhbz4pWKX1dpug9cAiF7pnmLnnBMksfdu9TNixAiUJ1q0zX5U/V6KS
         tGBvfTnFh9vUw==
Message-ID: <85fcdcd0-e7c5-5192-9113-c69f9c3a6385@collabora.com>
Date:   Mon, 9 May 2022 12:50:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 3/3] dt-bindings: mediatek: add ethdr definition for
 mt8195
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
Cc:     "airlied@linux.ie" <airlied@linux.ie>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20220509044302.27878-1-rex-bc.chen@mediatek.com>
 <20220509044302.27878-4-rex-bc.chen@mediatek.com>
 <46bc32df-e4e8-ac47-426d-8056714f0d5c@linaro.org>
 <5462209c5afb0a638ed777ec1829bb2717c8d76e.camel@mediatek.com>
 <98505974-afad-9639-d4f2-814097b0523b@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <98505974-afad-9639-d4f2-814097b0523b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 09/05/22 12:44, Krzysztof Kozlowski ha scritto:
> On 09/05/2022 10:54, Rex-BC Chen wrote:
>>>> +    soc {
>>>> +        #address-cells = <2>;
>>>> +        #size-cells = <2>;
>>>> +
>>>> +        disp_ethdr@1c114000 {
>>>
>>> No underscores in node name. Generic node names, so display-
>>> controller?
>>>
>>
>> OK, we will change the node name to ethdr like in dts
>> like this:
>> ethdr0: ethdr@1c114000 {
>> ...
>> }
> 
> Is "ethdr" a generic name? Is it an abbreviation of "EnergyTrace™ High
> Dynamic Range"? If yes, it also looks specific to Texas Instruments...
> 
> Best regards,
> Krzysztof


That's mediatek-drm, and this refers to the HDR block in the display IP...

Though, I have no idea of what "ET" stands for in "ETHDR", so, it would be
definitely nice if MediaTek can write the meaning in the description, like

description:
   ETHDR (E??? T??? High Dynamic Range) is designed for HDR video and ...blah

Cheers,
Angelo
