Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EE755135F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240187AbiFTIwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240148AbiFTIwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:52:00 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4AE12D31
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:51:59 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id h23so19650512ejj.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rvDozfpUth1u46mvzNNqlITVPQfdrkhSHQIaeMfchFw=;
        b=C3NCc0tF7vEHhwoLV0fuSwQQIdJuEh+/1DuVypXeKHJnwkCcSHrmhXUgIbDi/L9BLi
         8Orf+wD6b2kDhmDd9Nx4V2N6lIibh6/j96lUI/QRAYTmmnA+ouosoTOPn3KBFbMgXlfE
         XLC8aHRK8eGaWHD3rzsEYVpnB0K0vQ5WEQZkaL3Xk/0/2QwFJnsZFAHCvg4uWUMWK1WY
         dMrBZ0Q8zegFPHU+iguKm6Zl2sREi1gowFLvAHmsBBpeMJJwPizzSETXOKDjHsvSozKV
         5l5gDPUqzvCLt66o1728YU9XUBBUN0SX5eZk9pkk/NbjN68tygMCwaPF0mTY4OhK37Uw
         PVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rvDozfpUth1u46mvzNNqlITVPQfdrkhSHQIaeMfchFw=;
        b=Qw2nUF0YQdzb4CHai1zNAsP/u/veM5DNMmaxi0PnrTiuIoM0jYkFnS/ydlgWxOASH7
         RaIgkFpVX8Z2wc+YPOMHNLACfbEOMoKH4zhwSTV9NvZB4L5110BQTVdSXGSpccHMDE/L
         yB/8GeF4VQknJ79Bmi8tVXEDoTCcBF4YXFm1PHXKA+EDbvCDfCc5nAwgmaM9/VXMK53r
         Jy1b5FHCX6wE0ckRR1ueXPiTO1CF8ccwN8oFUGHgXP5ROn7lqpRXJqN12ELeBLhWPjF2
         l/9p1QNmZNPrrV1wuxCY1S/jcbHd5f/YsphwBFaIGT1hCVtRytig89ExeVy99UImzfi0
         uxQw==
X-Gm-Message-State: AJIora+MBRLNE9vPblbEgRqH+LRA5wgXSCZjVjAsQALH8emn/2/08aGW
        izfqnyM6/brIrDDJycQ55ETh4w==
X-Google-Smtp-Source: AGRyM1vosA5HJnj8GWCVoK53xdzGqpfYGN+DOWudxrPO+Dwn2p+1IKeZuKxi1oeqArmKrujW/Cs3og==
X-Received: by 2002:a17:906:d550:b0:704:ae79:7db1 with SMTP id cr16-20020a170906d55000b00704ae797db1mr19958640ejc.478.1655715117980;
        Mon, 20 Jun 2022 01:51:57 -0700 (PDT)
Received: from [192.168.0.207] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id a24-20020aa7cf18000000b004356c18b2b9sm5577856edy.44.2022.06.20.01.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 01:51:57 -0700 (PDT)
Message-ID: <3830efc5-298d-7887-5718-2cb2a7ad4895@linaro.org>
Date:   Mon, 20 Jun 2022 10:51:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 1/4] dt-bindings: dsp: mediatek: Use meaningful names
 for mbox
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, YC Hung <yc.hung@mediatek.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220616073042.13229-1-tinghan.shen@mediatek.com>
 <20220616073042.13229-2-tinghan.shen@mediatek.com>
 <629e761b-e3ad-0861-1937-ad660a8a900b@linaro.org>
 <af32751dd7013a96dac5d165c35e132fda87f2ac.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <af32751dd7013a96dac5d165c35e132fda87f2ac.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2022 08:40, Tinghan Shen wrote:
> Hi Krzysztof,
> 
> On Thu, 2022-06-16 at 06:55 -0700, Krzysztof Kozlowski wrote:
>> On 16/06/2022 00:30, Tinghan Shen wrote:
>>> Rename mbox according to actions instead of 'mbox0' and 'mbox1'.
>>>
>>> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
>>> ---
>>>  .../devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml   | 10 +++++-----
>>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml
>>> b/Documentation/devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml
>>> index b7e68b0dfa13..ca8d8661f872 100644
>>> --- a/Documentation/devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml
>>> +++ b/Documentation/devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml
>>> @@ -50,13 +50,13 @@ properties:
>>>  
>>>    mboxes:
>>>      items:
>>> -      - description: ipc reply between host and audio DSP.
>>> -      - description: ipc request between host and audio DSP.
>>> +      - description: mailbox for receiving audio DSP requests.
>>> +      - description: mailbox for transmitting requests to audio DSP.
>>>  
>>>    mbox-names:
>>>      items:
>>> -      - const: mbox0
>>> -      - const: mbox1
>>> +      - const: rx
>>> +      - const: tx
>>>  
>>
>> Commit msg lacks important piece - do you break any users with this? Do
>> you have any users of this binding?
>>
>>
>> Best regards,
>> Krzysztof
> 
> The 8195 dsp node, which uses this binding, has not yet been added to the 8195 devicetree.

Could you mention it in the commit msg? Such one sentence is enough.

With commit msg extended:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
