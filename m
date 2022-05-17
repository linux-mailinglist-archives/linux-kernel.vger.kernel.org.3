Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A8852A5D4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 17:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349773AbiEQPP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 11:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347421AbiEQPPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 11:15:25 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9A64A3F1
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 08:15:23 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id bu29so31987900lfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 08:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gc0B+KUO3JMWAuRjz+x4dN12ndY0LGxXybxfOh3RP7w=;
        b=sWzOi30fpeE8gWvv5iUlfYcr08ViW4rXRceTN3iOnpyevLP/1HFKpR+jlzOWzIHT2o
         4zXjyr+Z1Bsim5sytLd1s0VCBVFWwdD3+zDB8vEC03AMrpp+svfzdwQUM0NQGvO9H49S
         AfddPp3jDQeSCaZOmmnmIDpQWwoOeVn0gwEDCMct3zzjVH2CifoOKGtzpredlrP1D5J7
         hAAQ7GhQDitrstrYMECaoWTXFGp6/VgkkA1yTFszZ3dRLqj69ixKsbz3aTXLGz3P1Vrf
         OPshM5D8myxn3MVV43VqpxNc77qPVv/NZn3QBwSBbWqFjz0RTfHRfdp+6Mc5j6NKT8z/
         WL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gc0B+KUO3JMWAuRjz+x4dN12ndY0LGxXybxfOh3RP7w=;
        b=xZAwCd9/VE/Vh5d3TOI67AxKjGs1UMFJ8yYJexH0To+dMj8p4+3iqdVvPX9KmwZ65N
         g90Y+lgEZsJqPX9taMHcH1EYXnkYh+58QDhuZ6JGCGBkp3HpcUUBeT6Eot1DF19BriKS
         S1LXD165xvibW6r2ccMikPlUh6yx1TBDMIOmKGBhpCNLHyApmS2yveGtYURZLji2pAYb
         3UKadq4J/82sP9ilqfAInqumRmyaJ5GoW8qG451Nvfr2sqT4V6X9TPe/r076aSW55QNQ
         /rKtrRgYnw9upj/CatpjJRRxf1Z2aBR2mvDZaldpPnDS3/YbHERSYgdsBARxZuLplTZK
         tuPQ==
X-Gm-Message-State: AOAM531Yrze53GWGLXOsLAsO1OzS5GWxwYWOoKOOEzrNGDNOSek1qJHU
        kaW5sdd4tCp2J2MDs+RN2xojfA==
X-Google-Smtp-Source: ABdhPJxfWdLc2ErvnQ7M2Ug26y8sHs3Ee958zCZBJ/jvxQoVx4aN3jQPaADUKCkg9G7AF3MkvasvYQ==
X-Received: by 2002:a05:6512:2821:b0:474:5127:8f6 with SMTP id cf33-20020a056512282100b00474512708f6mr17461964lfb.66.1652800522120;
        Tue, 17 May 2022 08:15:22 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id h2-20020a05651c114200b0024f3d1daf02sm1915201ljo.138.2022.05.17.08.15.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 08:15:21 -0700 (PDT)
Message-ID: <08a4097c-268a-81c0-8fa5-754d92216035@linaro.org>
Date:   Tue, 17 May 2022 17:15:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v8 1/2] dt-bindings: thermal: k3-j72xx: Add VTM bindings
 documentation
Content-Language: en-US
To:     "J, KEERTHY" <j-keerthy@ti.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, daniel.lezcano@linaro.org,
        rui.zhang@intel.com, amitk@kernel.org, kristo@kernel.org
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org, vigneshr@ti.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220517121423.8017-1-j-keerthy@ti.com>
 <20220517121423.8017-2-j-keerthy@ti.com>
 <03c0e4fa-ccfb-fd86-0899-92a1086cac09@linaro.org>
 <324bd9c8-06b4-b9f5-7213-0e4b2a50653b@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <324bd9c8-06b4-b9f5-7213-0e4b2a50653b@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2022 17:07, J, KEERTHY wrote:
> 
> 
> On 5/17/2022 8:08 PM, Krzysztof Kozlowski wrote:
>> On 17/05/2022 14:14, Keerthy wrote:
>>> Add VTM bindings documentation. In the Voltage Thermal
>>> Management Module(VTM), K3 J72XX supplies a voltage
>>> reference and a temperature sensor feature that are gathered in the band
>>> gap voltage and temperature sensor (VBGAPTS) module. The band
>>> gap provides current and voltage reference for its internal
>>> circuits and other analog IP blocks. The analog-to-digital
>>> converter (ADC) produces an output value that is proportional
>>> to the silicon temperature.
>>>
>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>>
>> It seems I am repeating myself... Tags are still missing...
> 
> I still do not have a Reviewed-by from you. Should i add yours?
> You are still giving additional comments so I did not add.

You got Rob's:
https://lore.kernel.org/all/YnB4rtn87l5nXtRM@robh.at.kernel.org/


Best regards,
Krzysztof
