Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBC3509E49
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 13:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388725AbiDULLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 07:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388710AbiDULLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 07:11:22 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C33A18E0F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 04:08:32 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id el3so1238714edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 04:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GSok/vFHwV72WAw96IE5vtv5p/qzm+ga1Qb4JW55xnY=;
        b=F+tHNPGpxSD0dIGvmViPIkv5RyHAY7qtAY2pS6j042XrpT/t3iCMbeJw9ouzV/JkP5
         ZLJ2hpxZPcs7e6aHhkNvRzTEU9EnzYYKJkqjIwyyCtwpsUgz2/fPqoVyZBbR0Qa+x5XU
         HJqbfZR3nQM+V9yCnK44kryiQi2W90U4+GYn1sK7PNvm5R8x16Na3Ef2sZ2IlO8XaXtz
         XePsgDX7eDKXfBM8pobFJ05WCFw4SmenlLlZPh3uw+0lsfH9wmVLJbveTzG2BQ10LIgw
         cUfSuhbcmTmImCJE1t0Pj6YQAvijL3O22rhR0aLY3qROqDdwgypBqyQ3acnm3R7Xgf8a
         sxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GSok/vFHwV72WAw96IE5vtv5p/qzm+ga1Qb4JW55xnY=;
        b=Ncr3FoLvm6Ll3syT6GdsRh5HQmxEsIHe3fSFilNA8egGO7bsleR3Tp692vtdEGWkPH
         RP/UeodUAb0GyRlGwpcDpt7uYeMKepusaDoUx6ofD8d4/k4m4xm09n029QmKx5Xmq7tA
         i7k0LuG+jAS2thVWCgRXNqLOW8vvOb7Ia7qDaqE+aoX1ZUW4+h3TzoKUe6VSzyVXHZRX
         GnFYoO2pbO+OBSid66XQP+w5hnZavskzgDUMIT8R5LJ5b82DEa1Pz5ypuIYIitSRu29n
         oxhwJ4jPyPnz1zpiMLvWLRQy9DGCbEZP9zej0orI90qN/HxP12EMKrT7ZZN31ARrB6iB
         LviQ==
X-Gm-Message-State: AOAM532aPtFo/tkoebISdSHTt87JNUjsTNKa61kBiYsPWl85SuRA+cTl
        jBnEg8f7IITWqO8n2xMPdmTzSA==
X-Google-Smtp-Source: ABdhPJxIjYAFyO0rlyseB0/5jZQHRn+DpdsPcfs/S7QuWfO1YLPX8nI/Ep08uFLDGqlS5IxVsxhoow==
X-Received: by 2002:a05:6402:2213:b0:425:8a5c:4b44 with SMTP id cq19-20020a056402221300b004258a5c4b44mr2785059edb.200.1650539310584;
        Thu, 21 Apr 2022 04:08:30 -0700 (PDT)
Received: from [192.168.0.226] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id lx17-20020a170906af1100b006e873dd9228sm7632859ejb.52.2022.04.21.04.08.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 04:08:29 -0700 (PDT)
Message-ID: <663d9e81-9036-6986-f52a-3846b4b5c673@linaro.org>
Date:   Thu, 21 Apr 2022 13:08:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [EXT] Re: [PATCH 1/2 v4] dt-bindings: dspi: added for semtech
 sx1301
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>
Cc:     broonie@kernel.org, devicetree@vger.kernel.org,
        jerry.huang@nxp.com, krzysztof.kozlowski+dt@linaro.org,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        robh+dt@kernel.org, shawnguo@kernel.org,
        Vladimir Oltean <olteanv@gmail.com>
References: <f6086989-a4c1-4223-fad0-79bd5719432e@linaro.org>
 <20220421094421.288672-1-michael@walle.cc>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220421094421.288672-1-michael@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2022 11:44, Michael Walle wrote:
> On 21/04/2022 11:11, Jerry Huang wrote:
>>> Please also answer Michael's comments.
>>>
>>> [Jerry Huang] I double checked the MikroBus devices, we used two MikcroBus devices:
>>> BLE P click: https://www.mikroe.com/ble-p-click
>>> BEE click: https://www.mikroe.com/bee-click 
>>> Both of them are SPI interface connect to ls1028ardb through MiKcroBus interface.
>>> So the name "semtech sx1301" is not correct for this node.
>>
>> I asked to remove the words "Devicetree bindings" and this was not finished.
>>
>> Now you mention that entire name of device is wrong... It's confusing. I
>> don't know what device you are describing here. I expect you know. :)
>>
>> What is this binding about exactly?
> 
> I *think* it's just exposing the mikrobus connector as an spidev device.
> There was a former attempt by Vladimir here [1]. 

That explains a lot, thanks! It's a pity it was not described here.

> Now as it the nature
> of such a connector that you can connect a myriad of devices there, it
> doesn't really make sense to have a just particular one described. What
> happens if that one will switch from spidev to a real driver in the
> kernel? So using "spidev" for the compatible would be the first reflex.
> But as described in the spidev driver this is plain wrong (and also causes
> a warning/info message it) because it should describe the actual hardware.

spidev device nodes are in general allowed, using the specific
compatible for a real device attached to the SPI.

Here it seems clearly that it's not the case. Using roghm,dh2228fv as a
"spidev" compatible for something else was wrong.

Adding another device - sx1301 - also does not look correct, if it is
not there.

> 
> Thus I proposed to use DT overlays which are loaded according to what
> is actually attached to the header, so a real driver could be loaded.
> 
> But there *could* be a sane default which then could be replaced in
> an DT overlay. Like "mirkobus-socket" or similar, which might expose
> spidev. Actually it is more than just SPI, there is GPIO and resets and
> I2C. Maybe it should be an MFD? I don't know. But that is something for
> the DT maintainers to decide if they'll allow such "generic" devices.

I think if you have DT overlay, you can add device node and there is no
need for placeholder, right?

Best regards,
Krzysztof
