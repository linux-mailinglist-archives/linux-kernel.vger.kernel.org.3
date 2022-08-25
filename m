Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706145A1176
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 15:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242182AbiHYNFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 09:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242354AbiHYNEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:04:50 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA913AFAE2;
        Thu, 25 Aug 2022 06:03:46 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u5so16728687wrt.11;
        Thu, 25 Aug 2022 06:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc;
        bh=5Luts5GEZA9PcqRIIAUh6yjwcNrrObsoa2UHgSUmbng=;
        b=kVtgvdG48xazTFLfxuGcsMJfy9z51VfOwQ583IS0YpmWqhk5K2XwLzwGUUFByXU/uF
         T8fEDyh/V8Jid1XJ3lW6IXae7CcySf3lqCPf7RXzsp3DxF7GHs9EgKD1i/r822AKzljC
         FFWBeniwt6aXvr59TboeIrhIubm4yJGa0FAMZGJgFMXODrDgjfSV/khe0TAl9cFsjy0k
         um7bTSRUdo7oPKRwKj15L41JproTH9en07SUnNlw0ArVdeJMlQurhRAAFmcCMgVngE6v
         /0an5pI7JL/2Di3EWMM7rYsxQ1+7V+d44qTdppjt6CzNsK9LVYQfJWAJtGPhrJLGfP4+
         FYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=5Luts5GEZA9PcqRIIAUh6yjwcNrrObsoa2UHgSUmbng=;
        b=tpbc72XpE+UL7awrmWGr4xsswQtOBHFN2X1Hx3iG85ayH8HBjkL0nCleGGcjmTGrB5
         Kil5AKwyZK7GNXrtVp0IbYrfr3NxLXUtMwJHjCB7cWCY1WSXG7Vb6/kAGBpX5+Y9Muog
         KucCGfh0z/QVQ7/jizzTQhtlgtJJ4wwXwJaoZ5vaIDH50nTqcINI3LJaFicBfh79tb5N
         hQh8Waxhc6x4RBbCswRT+Q/iHlwaYrwkDM8g5JL8jYG4EW/vkqwSLcTopHwIWy6O/9BK
         5DxdlQoCywvEeqrm6O5TIY7/gN/yvLunPidYUFlsYBzd7PpknLJ2xrevdIeVy59nPWSP
         ccNA==
X-Gm-Message-State: ACgBeo0dYG6zQZuxzW0hjxUg868Kw8PmknmdHn4M27894DTLuQ/4PhPD
        Xn1DQwyH5JVkyQnzhTHz7Pw=
X-Google-Smtp-Source: AA6agR5ukxuM0sgzKs6kswETJQECh4QnJIkYVbfzcsGqX9G3WFVzIFwWhttfJ0G3HXT4sy5iAA0qzA==
X-Received: by 2002:adf:d202:0:b0:225:4aee:d7d6 with SMTP id j2-20020adfd202000000b002254aeed7d6mr2210222wrh.364.1661432624222;
        Thu, 25 Aug 2022 06:03:44 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id s7-20020a5d6a87000000b0021ef34124ebsm19812406wru.11.2022.08.25.06.03.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 06:03:43 -0700 (PDT)
Message-ID: <83f5f34f-6e71-3d36-e715-71896f0ac9a4@gmail.com>
Date:   Thu, 25 Aug 2022 15:03:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Content-Language: en-US
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "hsinyi@google.com" <hsinyi@google.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20220825055658.12429-1-rex-bc.chen@mediatek.com>
 <3ff08ae9-a4b6-2b74-23cb-69ea1d7e1033@linaro.org>
 <d5a00dc88bed1680caa8af895a1140324b9d079e.camel@mediatek.com>
 <f7ec45b8-ccd7-4776-0524-269e3188883d@gmail.com>
 <781356a88b502661ec23b3869679d80cf682017d.camel@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH] dt-bindings: arm: mediatek: mmsys: change compatible for
 MT8195
In-Reply-To: <781356a88b502661ec23b3869679d80cf682017d.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/08/2022 13:06, Bo-Chen Chen wrote:
> On Thu, 2022-08-25 at 18:55 +0800, Matthias Brugger wrote:
>>
>> On 25/08/2022 08:59, Bo-Chen Chen wrote:
>>> On Thu, 2022-08-25 at 14:11 +0800, Krzysztof Kozlowski wrote:
>>>> On 25/08/2022 08:56, Bo-Chen Chen wrote:
>>>>> From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
>>>>>
>>>>> For previous MediaTek SoCs, such as MT8173, there are 2 display
>>>>> HW
>>>>> pipelines binding to 1 mmsys with the same power domain, the
>>>>> same
>>>>> clock driver and the same mediatek-drm driver.
>>>>>
>>>>> For MT8195, VDOSYS0 and VDOSYS1 are 2 display HW pipelines
>>>>> binding
>>>>> to
>>>>> 2 different power domains, different clock drivers and
>>>>> different
>>>>> mediatek-drm drivers.
>>
>> drop clock driver example here.
>>
> 
> Hello Matthias,
> 
> Thanks for your review.
> I am not sure what do you mean.
> Could you explain more detailedly?
> 

Never mind, it's not that important.

Regards,
Matthias

>>>>
>>>> I don't see binding to different clock drivers and anyway that's
>>>> not
>>>> really an argument here. Please focus in description on hardware
>>>> properties, IOW, are devices compatible or different. What is the
>>>> incompatible difference between VDOSYS0 and 1?
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>
>>> Hello Krzysztof,
>>>
>>> Thanks for yor review.
>>>
>>>   From the functions perspective:
>>>
>>> Hardware pipeline of VDOSYS0 has these components: COLOR, CCORR,
>>> AAL,
>>> GAMMA, DITHER.
>>> They are related to PQ (Picture Quality) functions and they makes
>>> VDOSYS0 supports PQ function while they are not including in
>>> VDOSYS1.
>>>
>>> Hardware pipeline of VDOSYS1 has the component ETHDR (HDR related
>>> component).
>>> It makes VDOSYS1 supports the HDR function while it's not including
>>> in
>>> VDOSYS0.
>>>
>>
>> Please include a description of this in the commit message.
>>
> 
> Yes, I have sent v2 and add these to commit meesage.
> 
> https://lore.kernel.org/all/20220825091448.14008-1-rex-bc.chen@mediatek.com/
> 
> BRs,
> Bo-chen
> 
>>> About mediatek ETHDR, you can refer to this series:
>>>
>>>
> https://lore.kernel.org/all/20220819061456.8042-2-nancy.lin@mediatek.com/
>>>
>>> To summary:
>>> Only VDOSYS0 can support PQ adjustment.
>>> Only VDOSYS1 can support HDR adjustment.
>>>
>>> Is this description ok for you?
>>> If it is ok, I will put them into commit message in next version.
>>>
>>> BRs,
>>> Bo-Chen
>>>
> 
