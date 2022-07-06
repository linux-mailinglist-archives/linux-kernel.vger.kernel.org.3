Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C134568D7A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 17:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbiGFPnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 11:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235094AbiGFPnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 11:43:11 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9CD2F03F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 08:36:50 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id t19so25940399lfl.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 08:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/3bPZqTRdflIiXLL8U8luN1bqZnH5disuECgPvDTbyA=;
        b=t6VexcMz2hiUMyqtZuYA6IFPdq58Ama0cu9nzuLM1kCROsn3lKYCy4HLSvTkNkrbPv
         Ml58v86Sw6WzVq6H4DVXaUNJhYDIh49X4+29ovyHHT1VvawTprk96QRRG+jyPd81h+o8
         HqRyoiarsRM5fSv8c4wSXK8HUMl4EMVa4wxeBT/m+9TzxpO+Q5Niy75fXQv4XOqYPmKM
         6ZHrfWK5Qii+6zDHZBdBQU7xomGbh3zOuVZ78QBivosuTRxT28O1iSCbdz6Zb58CS+iO
         LZS5U/StKayEh7MfIF9leyUE7VugAU+N49GwzXVCwhC3KdTFw4RE6gw50pQtWlMr2nhR
         g2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/3bPZqTRdflIiXLL8U8luN1bqZnH5disuECgPvDTbyA=;
        b=cQMhtuWMGzu0ptLsw+9+JvCWhK4j5OU3YPAvLwS1d1M1o1e+SOO2hIvCOmhW7F3McN
         +Lhhcp1XhjC0OaBbVOhriz7ht0PBLZXHfKgxX9+21ikL4SSGa6V2IAS9/2oJMIuDqwcA
         MVyjExI7PGoNbN6/BjX+16BiURSw4ooOd7YeEjdd7VGSBAOMviRBz1xi5dgJy+kwB12w
         /AquKRT1m6IX4Us6wMvehOZ3MBUWidwnS47UtZLenOgPPphxhhuoTkuKTWg98xBdRhe6
         RECC76/3k2j0gNtZyaUP9X8UbIrDE/JrEhQZRyrlZIp4E4HdygBc8tfF0P0PTIs9bzyj
         LY8A==
X-Gm-Message-State: AJIora+mwqXXTfFyYhuHm6vo1EJEQSSz6sFEoGasR3djlM6j8DjEg2wA
        0aHg0rxO4KQzqkF+dGbWM2bHHc5+zcbnYcrZ
X-Google-Smtp-Source: AGRyM1stEUKNw32v0KSUxSuBpHNUbaQ6rT8pQqskgO/HGl45Idq4x3SKxz3EcjiXU2ySPZR+XqCFaw==
X-Received: by 2002:a05:6512:3ca0:b0:47f:a9f3:f26 with SMTP id h32-20020a0565123ca000b0047fa9f30f26mr28314150lfv.297.1657121805528;
        Wed, 06 Jul 2022 08:36:45 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id h15-20020a2eb0ef000000b00255500154fasm6270992ljl.52.2022.07.06.08.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 08:36:44 -0700 (PDT)
Message-ID: <25b43586-eeb3-4b7b-7362-2d599aa89cf0@linaro.org>
Date:   Wed, 6 Jul 2022 17:36:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] [RFT] dt-bindings: leds: Add
 cznic,turris1x-leds.yaml binding
Content-Language: en-US
To:     =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220705000448.14337-1-pali@kernel.org>
 <20220705155929.25565-1-pali@kernel.org> <20220706131507.353f0bed@thinkpad>
 <20220706111912.hz2mx4dc35lgq6l5@pali> <20220706172732.6228d180@thinkpad>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220706172732.6228d180@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2022 17:27, Marek Behún wrote:
> On Wed, 6 Jul 2022 13:19:12 +0200
> Pali Rohár <pali@kernel.org> wrote:
> 
>> On Wednesday 06 July 2022 13:15:07 Marek Behún wrote:
>>> On Tue,  5 Jul 2022 17:59:28 +0200
>>> Pali Rohár <pali@kernel.org> wrote:
>>>   
>>>> +examples:
>>>> +  - |
>>>> +    #include <dt-bindings/leds/common.h>
>>>> +
>>>> +    cpld@3,0 {  
>>>
>>> The generic node name should be just "bus". That it is a CPLD
>>> implementation should come from compatible string.  
>>
>> Sorry, I do not understand why "bus". Why other memory chips are named
>> e.g. "nand" or "nor" and not "bus" too?
> 
> As far as I understand this is because that is the preferred name for
> busses and this is a bus, since there is also the simple-bus compatible.
> 
>> By this logic should not be _every_ node called just "bus"? Hm... and 
>> are names needed at all then?
> 
> :-)
> 
> The schema
>   https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/simple-bus.yaml
> allows for different names (soc|axi|ahb|*-bus) to avoid warnings on
> existing old dts files.
> 
> The preferred way is to not have the implementation in nodename,
> similar to how we use 'switch' instead of 'mv88e6xxx', or
> 'ethernet-phy' instead of 'mv88e151x', or 'led-controller', ...

Thanks Marek for detailed explanation.
The cases above rather trigger my comments and this one here, after
Pali's explanation, do not fit them. pld is a generic class of a device,
so it is okay here. cpld probably as well (although one could argue that
it is a subset of pld, so the generic name is pld, but then one would
say fpga also should be called pld). For me it does not have to be bus,
just don't want mv88e6xxx or any other vendor/model names. Therefore
cpld is fine.

> 
> I wasn't there when people started requesting for this to be that way,
> but I guess it makes some sense to make it more readable and less
> redundant (the generic name in nodename and the implementation in
> compatible string...).




Best regards,
Krzysztof
