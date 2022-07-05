Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DA45672CD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiGEPih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbiGEPia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:38:30 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE28101A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 08:38:29 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id t19so20573438lfl.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 08:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5lac26hSsxq2bqnIIbfo8iISJEnKW0GSTyf9EVWeE/Q=;
        b=fQ22/amhPh/I/Xg9BYSELh7tZekP3MwvTy0jBXI7Rb8+FG2nRtPqMPqIHrO6WVwZIU
         lTv93pXJqRsza/X+5D34Cd/zOn6u6V5ksIiRnP1qwUgBY0uPPU8hP1+EAZLJAnD7Pyma
         Zk7HKsXc+Ql4z0/CA3osKYg3Z+PcTp65hZLDhsyw2SK0Bw8uR6+84F4vHVEszweSCXMP
         mi82fIrrjPFiaKbhBNDYhLDbK2OsDOUThTAaU0vb4MM3xHtG9QkCpRrzezOR2RNm6WnL
         Al8WFMIioAyE+5TIGbCNNzTl7rPsxHt1VYiUEexZuJxMctYm6XcTk159GzZPhpT8rAl3
         TmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5lac26hSsxq2bqnIIbfo8iISJEnKW0GSTyf9EVWeE/Q=;
        b=so1RY3rVwBOUERvLrd7Yceg+ZxkOukqfJO+naB+1pxFdi10bAqN91aMFXi8vXkIfJg
         C37oZ5YvuoSASFtXUpfkyXV9swDTp4qKGEkMrCwKbJwNrTKoTjnsLGSvDx+vdseiKT9z
         1otm1eEus/Hzl3q1mIkhc6nUbXeJgCW6LCVD45slsVwzePuW7f1Zj+W5J5Hud4EoYxBW
         xdxBqcusH75Jm0vS3WNN1SZQMcfBv7EM5MzX5ZmWrxua2hdAANjXQMXNk4YYpmplJMn8
         vs2ounlolhbXpV3Xmj+P55C18+xhNPhr3xVY05zVuvg+ehMHBX9s4B0uj5cIo73mUdHK
         HlxQ==
X-Gm-Message-State: AJIora+Eg+t3Jfr1hsa7Ho+E8sE2fosxP2MZ/vfVowAQsYKpAO/W6NUv
        /C2txMhsYxl87hVk589jvgwdFg==
X-Google-Smtp-Source: AGRyM1tmXLh3z47oCGKtYz2FIn0NiD6p981KwThQufhF/Jz38GQV4qLcO+NFEqfJnt590d8d+yj6eQ==
X-Received: by 2002:a05:6512:6d4:b0:47f:74b4:4ec4 with SMTP id u20-20020a05651206d400b0047f74b44ec4mr22043767lff.654.1657035507235;
        Tue, 05 Jul 2022 08:38:27 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id a9-20020a19ca09000000b00477a6c86f17sm5746920lfg.8.2022.07.05.08.38.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 08:38:26 -0700 (PDT)
Message-ID: <0bd271e9-8d9b-7388-2d9b-65cc39a54f8c@linaro.org>
Date:   Tue, 5 Jul 2022 17:38:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 07/11] dt-bindings: spi: spi-nxp-fspi: add a new property
 nxp,fspi-dll-slvdly
Content-Language: en-US
To:     Han Xu <han.xu@nxp.com>
Cc:     Michael Walle <michael@walle.cc>, Bough Chen <haibo.chen@nxp.com>,
        ashish.kumar@nxp.com, yogeshgaur.83@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        singh.kuldeep87k@gmail.com, tudor.ambarus@microchip.com,
        p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org, festevam@gmail.com,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, zhengxunli@mxic.com.tw
References: <1657012303-6464-1-git-send-email-haibo.chen@nxp.com>
 <1657012303-6464-7-git-send-email-haibo.chen@nxp.com>
 <ef676df1-77e0-b8ee-3950-97eade8ddd5b@linaro.org>
 <VI1PR04MB40167A70FBE772DF91047A4190819@VI1PR04MB4016.eurprd04.prod.outlook.com>
 <59d360ef-5374-c7a7-2995-854ab3715b25@linaro.org>
 <DU2PR04MB87747C9A8F18D8300461D6B197819@DU2PR04MB8774.eurprd04.prod.outlook.com>
 <f33ad190-f5c7-d9fa-088b-5538ab1f4d59@linaro.org>
 <DU2PR04MB877492F346BAA10B2AA7428497819@DU2PR04MB8774.eurprd04.prod.outlook.com>
 <62f113a0cdb0d58bf04ab0b274912eb7@walle.cc>
 <be521f90-97ce-c61d-d7d6-8f2bde24d824@linaro.org>
 <20220705145226.tarpvub6bh67tj63@umbrella>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220705145226.tarpvub6bh67tj63@umbrella>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2022 16:52, Han Xu wrote:
> On 22/07/05 04:12PM, Krzysztof Kozlowski wrote:
>> On 05/07/2022 16:06, Michael Walle wrote:
>>>
>>>>>
>>>>> I think you could use here clock cycles or clock phase, but then it 
>>>>> has to be obvious
>>>>> it is that unit.
>>>>
>>>> Hi Krzysztof,
>>>>
>>>> Let me clarify it, in the document a term "delay cell" was used to
>>>> descript this register bit. Each delay cell equals "1/32 clock phase",
>>>> so the unit of delay cell is clock phase. The value user need set in
>>>> DT just number to define how many delay cells needed.
>>>
>>> Then should the unit be "-degrees" and the possible range 0-180?
>>
>> Thanks. We don't have it documented currently, but the unit seems
>> reasonable.
> 
> IMO, use the unit "-degrees" makes it more complicate. Personaly I would
> calculate how many clock cycle delay needed, such as 1/4 clock cycle or half
> clock cycle. Using degree brings extra calculation.

And what if the next device uses a bit different divider? Like 1/16?
This is why we have standard units so people won't push register values
into the bindings.

> 
> The granularity of the clock phase change is 1/32 of 180 degree, but the range
> 0-180 make people feel it can be set in any degree in range.

Yes, because that's how the bindings are being written - allowing any
reasonable value, not register-specific value, to be used because it is
the most flexible, hardware-independent and allows further customization
of bindings (e.g. new devices). Embedding device programming model into
the bindings contradicts it.

Second, nothing stops you from narrowing the acceptable values with an
enum. This still allows extension. Your 1/32 does not.

> 
> If I describe all details of the relation between "nxp,fspi-dll-slvdly" and
> "delay cell" in patch v2, do you think it's clear for users?

1/32 could be a nice unit, but degrees is better. Just like uV is better
than 1/32 of V. Like 1 us is better than 1/32 of ms.

Do you see  in the bindings many other values like time, potential,
current or power described in 1/32 units?

Best regards,
Krzysztof
