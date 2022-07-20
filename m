Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0909D57B3F3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 11:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbiGTJfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 05:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiGTJfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 05:35:17 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0AF1114
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 02:35:13 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id p6so20449057ljc.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 02:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NACJil9UlKguZHtyroyXmUl9NgrDukgC0WHDPhOResw=;
        b=SM+GM6u9YJ9v0kFj0Xv3j5YMyjCQ2yXS8IRm/2iyBj2e5Kk2DMZe8SyB/GIXUXsPZC
         6LaJniy4VRPs06Edvr2RXGMZ8NJotZZBMkMzK5EpkujY7ishGPmAyeTs06+VsuYGMUln
         KX4gELH6LgIXFQb09kFP0ssSpfEMeblLXAKZAQhfEA4qveknBr3LNwHoWZOURDHf3bmQ
         93/tlBqKjQEASmQbTWKis4Ko97lxx/E1QZO4F00Ua8i7/BuBiv/AigBQMWJrx1z9vJm6
         dMvHgiQWVUT8ivjwhbt35h8WzEc3o7iSWigQIOEFMHthiDiEKc3s5NTO/8n1uutEp0S4
         mYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NACJil9UlKguZHtyroyXmUl9NgrDukgC0WHDPhOResw=;
        b=k7KqkDuDgz8TjuZCkC+HwublLcrIHRSfc6GeH4W4lg5PA4aZ0zbhCVIExnzdFVRxZy
         iiSE3kt6X3rigkHqR7hO4opl6pSDi3qnwXgS7vD6IuL6+Ni895zxp3tQwkDqrTDhap3d
         DJd0cP+Y9JtNL3dIffhN96scJDVR2I04+pKT8DyHEZr5xP/2Br8x+AvydAauprkK+cFY
         zWLcLeFfxTLqGfGQy6XK6Oa/OfNGIqvifWarsf7RYpBWqVpm5yZBHBwxUV6v2lyA1wvI
         h+/eCHgyOaqdBGZRjsdhE3pdmMbl9JJEWbi9mToqjWp7Davx367ENIdAdbMIysOl+KJZ
         GonA==
X-Gm-Message-State: AJIora9PcuLQFNM/1tQMCAzDK01Dds02m4JihmBtmSGs0Ki5tgiAHB5G
        vGzZP/QhkIVn07NCoaD/ixtyEQ==
X-Google-Smtp-Source: AGRyM1vX6yDC10HC1LaQDvYd4QG7y0MZ4kcDXW2RtYD5CaLhPw3VCWvVH17wXXB8ScPl0Ba/qstALQ==
X-Received: by 2002:a2e:2e0d:0:b0:25d:48a6:827d with SMTP id u13-20020a2e2e0d000000b0025d48a6827dmr17183931lju.323.1658309711633;
        Wed, 20 Jul 2022 02:35:11 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id k10-20020a2ea26a000000b0025d55600855sm3110038ljm.25.2022.07.20.02.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 02:35:10 -0700 (PDT)
Message-ID: <bc99e06b-1aa5-441e-c86f-0fbfb0945d0c@linaro.org>
Date:   Wed, 20 Jul 2022 11:35:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/4] dt-bindings: misc: tmr-inject: Add device-tree
 binding for TMR Inject
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>,
        Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, michal.simek@xilinx.com,
        derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     appanad@amd.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@amd.com, git@xilinx.com,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
References: <20220720060016.1646317-1-appana.durga.kedareswara.rao@amd.com>
 <20220720060016.1646317-4-appana.durga.kedareswara.rao@amd.com>
 <77e8433f-6cb8-eb32-63d5-414a92d3b874@linaro.org>
 <f45fccec-4496-19af-0e14-bd626e14c7bd@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f45fccec-4496-19af-0e14-bd626e14c7bd@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/2022 10:26, Michal Simek wrote:
> 
> 
> On 7/20/22 08:15, Krzysztof Kozlowski wrote:
>> On 20/07/2022 08:00, Appana Durga Kedareswara rao wrote:
>>> From: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
>>>
>>> The Triple Modular Redundancy(TMR) Inject core provides functional fault
>>> injection by changing selected MicroBlaze instructions, which provides the
>>> possibility to verify that the TMR subsystem error detection and fault
>>> recovery logic is working properly.
>>>
>>> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
>>> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
>>
>> Keep only one SoB.
> 
> nit: First of all it is from xilinx.com that's why xilinx.com should be the first.
> 
> Just for my understanding about guidance here.
> Code was developed by Xilinx before acquisition with AMD. And because it was 
> picked from vendor tree origin xilinx.com was there to keep origin author there. 
> And upstreaming is done by new company. I can't see nothing wrong on keeping 
> both emails there but that's why my opinion. Definitely not a problem to remove 
> one of them but wanted to make sure that we do it properly for all our submissions.

It's the same person. No need for two SoBs from the same person. Since
AMD acquired Xilinx, it holds all copyrights thus @amd.com person does
not have to include previous SoB. He/She/They has the permission from
employer to submit it. The second SoB is just redundant - brings no
actual information. Otherwise please tell me which piece of DCO the
additional SoB adds/solves (comparing to single SoB - @amd.com)?

Similarly when you change jobs while resending your patch - you do not
add new SoB but just keep SoB from @previous-company.com.


Best regards,
Krzysztof
