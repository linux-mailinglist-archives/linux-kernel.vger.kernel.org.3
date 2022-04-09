Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CFB4FA814
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 15:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241911AbiDINQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 09:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbiDINQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:16:05 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDA092D25
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 06:13:58 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id u15so3624812ejf.11
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 06:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=d0410HLBP6KDAh1PJS07oAulungk6qL8Pp4HkxfBbq4=;
        b=wdXpe2opIoSojVyd0Er2F1SBdOz1jlzcWmMpvT4AoYCiUCqrYlmMpVCyxzPAPKuC38
         8FkGrIpMOfz57tTCHs76qi01VpoSYGdMU7OSxwn5ovDH5LLuT6CFp0aEuReP3gzDxExH
         l4w8c8UfYVtSgifZCqC73FDjHA/iEIUYy39Sm3DICwklq8PPUCZlJ8/Pfp2WLjMKaJqD
         LgoM6sGZR+Xr3ntcTHzmCkQFFOySfAZChAOWMLorhZxCEhd7ykQ6p21yMfzaDjjis4Fx
         bBepaRxFCuQeNPkEVkU43CXpsoc4Hjm3rfB7hbHmf+31NmFZbMlBDdr7N60tXjJAdGGE
         7jOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=d0410HLBP6KDAh1PJS07oAulungk6qL8Pp4HkxfBbq4=;
        b=D/kHTAo4fpbepgYCxzDLx4Zm4bX0j5y0i4aqAF2HB0nXmJcSWt/ccGY8WV+dxrXTSy
         MekTAZtWY/MZrsl84wXofib5tHWzhzwvhNLHMDATtxxOFv+/LyeqdNXgH9bZ1aI1yjXV
         bXLQfVbUm8Da6kL4rV4K0eaVJoKrzucB10n46LbQNbZHKOdi+1JQ2u71VcFe3sh1fJgR
         VL386YCw26YzgdHFWHYoYQIJiXpj8JdERHfi6CAUgfFn2g+XBDyAONLXPm+cCUb3LXvt
         C7q6n1YC1XQZm7KqzcIB19L11vIvFSWzkRgdybYmT+iA0HVRAL7Te4T4I4uBovi2Bvrf
         Vnng==
X-Gm-Message-State: AOAM530Yd89D9+2/lFt0z5zxziFiGBblvTa8jLmLcTiqmGuVaG8W22NP
        ZFr/2ANIhdteKfzHUEq+HMcilLK5hEfN+du8
X-Google-Smtp-Source: ABdhPJynznWXeu0fS5zY5vii5EuYYK4aSuoB4bkjD9wMFfAG0g+7uTbOlL0pOjAniA4bC4Hq0NNc7A==
X-Received: by 2002:a17:907:948c:b0:6e7:fe2b:68f0 with SMTP id dm12-20020a170907948c00b006e7fe2b68f0mr22510421ejc.749.1649510036643;
        Sat, 09 Apr 2022 06:13:56 -0700 (PDT)
Received: from [192.168.0.188] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id t12-20020a1709067c0c00b006e86db76851sm794137ejo.193.2022.04.09.06.13.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 06:13:56 -0700 (PDT)
Message-ID: <c84b5ec0-0193-ab62-1985-25bc2baa9f05@linaro.org>
Date:   Sat, 9 Apr 2022 15:13:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 05/18] MIPS: DTS: jz4780: fix pinctrl as reported by
 dtbscheck
Content-Language: en-US
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org
References: <cover.1649443080.git.hns@goldelico.com>
 <1941bc4ed553b27f399ad00ea61ff2b0237d14e3.1649443080.git.hns@goldelico.com>
 <e905896e-335d-a88a-1961-d17b92e46585@linaro.org>
 <530E0F7F-FC03-45DD-BF87-D049D3108AD3@goldelico.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <530E0F7F-FC03-45DD-BF87-D049D3108AD3@goldelico.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2022 15:04, H. Nikolaus Schaller wrote:
> 
> 
>> Am 09.04.2022 um 13:13 schrieb Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>:
>>
>> On 08/04/2022 20:37, H. Nikolaus Schaller wrote:
>>> arch/mips/boot/dts/ingenic/ci20.dtb: pin-controller@10010000: $nodename:0: 'pin-controller@10010000' does not match '^(pinctrl|pinmux)(@[0-9a-f]+)?$'
>>> 	From schema: Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.yaml
>>>
>>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>>> ---
>>> arch/mips/boot/dts/ingenic/jz4780.dtsi | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
>>> index 5f44cf004d473..b5299eaffb84a 100644
>>> --- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
>>> +++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
>>> @@ -155,7 +155,7 @@ rtc_dev: rtc@10003000 {
>>> 		clock-names = "rtc";
>>> 	};
>>>
>>> -	pinctrl: pin-controller@10010000 {
>>> +	pinctrl: pinctrl@10010000 {
>>
>> Do it once for all DTSes, not one file at a time. There are four more
>> places with this.
> 
> Well, automation has no notion of "similarity" in this case to
> merge several patches.

What does that mean? One cannot create multiple patches and apply them?

> And they are not related. Every one is based on a different .yaml
> schema file.

Which does not matter, because the name of the node does not matter. We
enforce it in schema to makes things organized and easier in testing.
This does not fix any real problem, just the problem we created by
ourselves with schema.

> 
> That in all cases the result looks similar comes from similar
> requirements by the schemata and has no inherent connection.

All schemas will require it, won't they? The same for arm...

Best regards,
Krzysztof
