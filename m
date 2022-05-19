Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5AD52CDE3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 10:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbiESIGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 04:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbiESIGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 04:06:16 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D280755372
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 01:06:14 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id d15so7736228lfk.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 01:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YQu4TSu2p0KMGwL1YiCJK+tIvwswRm4g+esi1EtLUqY=;
        b=o1apGfVokpVYUvl11XsDGw3sWAaJlnSrEiMNO9glke1zNuuTNworCaiu1tmv55uxg/
         4O4XmJmvlHX98cUknYG54RMHW0iYedyKoLd2nzud8R0yBBNCI4h4uQar3VFd12gH/Z7k
         zIblUDwVHJPgcOG5BTvBf5UcwPJWwTSmf4h5ScV0X23a3QFdtbEvpde/5S8N7uow+MIs
         L8Fi31CUT6M687O4q/Miv1SfmXLtYFj6xS1gh6PSD6aTAebK1S5jOrY3TzquWUZNtUn0
         Xa46PSfa4877JX8WeBwhhzc3pWPFJFG6mZijTWP4xuIYXBbd+uXv1C4zefE6ZBvTHEVI
         9AAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YQu4TSu2p0KMGwL1YiCJK+tIvwswRm4g+esi1EtLUqY=;
        b=vFTJnMygd3FvjLucgNDF7Yyya6dDYblVWGL9KxVKpjm6zixGCrxGagYBBBUi1IctRc
         ClctziFcZKzMqDH0gD5J9lMTBG7IBZM0mpVUW9SGZ2xB77dtJHVS45RVdPgMJ1tynHfP
         VlOKUyj7wo6IvN67XyF97l8gDC5RhKNrLoEXGYtWCipU+Ld3VRA5zOPo24cZwRt6oqZa
         nG2h0KZa5nOSOn/7J9d/8hMt6dMi+mq7x14DLQnflmmQGzgYeYgu9Pr3BxQXk67oHsmw
         Ga86r66sjnrIcpiPtgc0x9RAFRB1aDjW94XNRC/M3rE28tDvn2Hu1xDX87x14n+tNGy5
         TTow==
X-Gm-Message-State: AOAM533XbOxQCxiepXOFqioS15eKZOJIqChriagzuIDQzmgQgOaYs9CO
        1bOyHKx1JI9AD8rhQVzImdixm6skPkrRKWxQ
X-Google-Smtp-Source: ABdhPJynRmhFrlhx3kRSatFsRgdvlOCMXWMPPfZKsFEulfDFTderFYUY4ADZeD8pVWnFHXOACwdNqg==
X-Received: by 2002:a05:6512:2256:b0:473:a584:9905 with SMTP id i22-20020a056512225600b00473a5849905mr2437032lfu.639.1652947570707;
        Thu, 19 May 2022 01:06:10 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id s18-20020a2e9c12000000b00253d5618718sm140705lji.34.2022.05.19.01.06.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 01:06:10 -0700 (PDT)
Message-ID: <04837608-8c12-5bc0-9eca-fdcac83c5c4f@linaro.org>
Date:   Thu, 19 May 2022 10:06:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC net-next] dt-bindings: net: xilinx: document xilinx emaclite
 driver binding
Content-Language: en-US
To:     Radhey Shyam Pandey <radheys@xilinx.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        Harini Katakam <harinik@xilinx.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>
References: <1652373596-5994-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <8b441f8f-7aa2-0fab-9b90-6618a1e8c899@linaro.org>
 <SA1PR02MB856027DD26AAB5C38C345BBAC7D19@SA1PR02MB8560.namprd02.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <SA1PR02MB856027DD26AAB5C38C345BBAC7D19@SA1PR02MB8560.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/2022 17:47, Radhey Shyam Pandey wrote:
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Friday, May 13, 2022 2:23 PM
>> To: Radhey Shyam Pandey <radheys@xilinx.com>; davem@davemloft.net;
>> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
>> robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; Harini Katakam
>> <harinik@xilinx.com>
>> Cc: netdev@vger.kernel.org; devicetree@vger.kernel.org; linux-
>> kernel@vger.kernel.org; git <git@xilinx.com>
>> Subject: Re: [RFC net-next] dt-bindings: net: xilinx: document xilinx emaclite
>> driver binding
>>
>> On 12/05/2022 18:39, Radhey Shyam Pandey wrote:
>>> Add basic description for the xilinx emaclite driver DT bindings.
>>>
>>> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
>>> ---
>>>  .../bindings/net/xlnx,emaclite.yaml           | 60 +++++++++++++++++++
>>>  1 file changed, 60 insertions(+)
>>>  create mode 100644
>>> Documentation/devicetree/bindings/net/xlnx,emaclite.yaml
>>
>> Why is this RFC? Do you expect DT maintainers review or not? Maybe there is
>> no point for us to review something which is not going to be applied?
> 
> I intentionally made it RFC so that all aspects are reviewed as this driver didn't
> had an existing binding. I will send out next version with below comment 
> addressed. Thanks!

RFC means you develop something which is not ready, not sure how to do
it, you send an initial idea. Sending a regular bindings as RFC, without
explaining what you expect, is a bit confusing.

Best regards,
Krzysztof
