Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F8D589B11
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 13:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238750AbiHDLbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 07:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236209AbiHDLbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 07:31:40 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF0D39B8D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 04:31:38 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id v7so2375911ljj.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 04:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6FA3ZfEeBAC9Kp15wqTU0k5tZ0dhaTTUmtqbwpsyYTY=;
        b=RotSEOoQTObCi0Yo4Rk2W1EXU5o1KIIBkVg4ckpcWxwE1mIYKZWNo1qH7vuL6Hb0Lz
         yq0rkhznpi9/8km3g3h7y956DhTFWCB6W/1MB1GJhRITv666gVAZtFN5FFpmXriJj12i
         a9e8u8ntItsOgNRnNgNJq932KPxwL4My2QGn7dcYzTmnZYQ6m0fgnWRR16vidbbH2JJt
         gvLq18qKywsk4wVMG6jygCQHM6bQRLrNLJ63ch4gJr4T4J8nUq881YNb6zkuii4Oz1Ws
         nyWDolJkafj8RGzGy1UJnCPm/unjBRTNd7cxx1oLGj/KuZmYhCUuLiElb/5QOFth9Kt6
         v1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6FA3ZfEeBAC9Kp15wqTU0k5tZ0dhaTTUmtqbwpsyYTY=;
        b=vOd8JPt0D4aE8K65iWNlgRXFIhuJw1EgyZnGicHK77fwHnJ/XY8H35M51+uuY14OzU
         cBtI2XKgjoJAVmokoW8o3/UtoxUIxsecrI3VeWLnoJwLtkPM6gdUNp9amnydMD3ErsZI
         G3vCgmv3ReA0ruC/eH00hkfWCcbGd2vrmX+sqdUpzgyOzbVAozbTsZVySVCc/CjPvSIm
         VgL0j+QAObWGvvsohoomOXGPyuN/OMeaxF0NVX+Cbi7sAUOo2NscEH3+ZiJk1nwitJvx
         5gVV1LCjjd9otzD+FpK+MkIcC2uIOxZPfxK34PoWh0m85042KMF3jpRfjfaLD/z3okBP
         XFQQ==
X-Gm-Message-State: ACgBeo19NLhYTMEdWIuD5TBncnnNnokg3A72ZaTiPwj6vrvapXJmvueY
        dDWbt3//3XJMgLWQO+/yB0BYyA==
X-Google-Smtp-Source: AA6agR6qGtsHgJ27BPzUx/ISEKRhgxZ20jwAk8krk4pAMSe22eoioT7tH9INbpYDZ3Bx8ZME5cJmdA==
X-Received: by 2002:a2e:804e:0:b0:25e:7231:c304 with SMTP id p14-20020a2e804e000000b0025e7231c304mr445863ljg.257.1659612696954;
        Thu, 04 Aug 2022 04:31:36 -0700 (PDT)
Received: from [192.168.1.6] ([77.222.167.48])
        by smtp.gmail.com with ESMTPSA id a17-20020a05651c031100b0025dd5b3fabesm87543ljp.102.2022.08.04.04.31.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 04:31:36 -0700 (PDT)
Message-ID: <b9cc3290-f0cb-0423-7ff0-dae40b52a379@linaro.org>
Date:   Thu, 4 Aug 2022 13:31:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] spi: dt-binding: add Microchip CoreQSPI compatible
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor.dooley@microchip.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220801094255.664548-1-nagasuresh.relli@microchip.com>
 <20220801094255.664548-2-nagasuresh.relli@microchip.com>
 <6d36b192-9e63-ec13-5583-22b81c99c18b@linaro.org>
 <Yuki3jpCSJDdXcWA@sirena.org.uk>
 <dc7bca02-5eb3-3b33-8911-a950b630f197@linaro.org>
 <Yup4JLh00HZxFQLc@sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Yup4JLh00HZxFQLc@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2022 15:29, Mark Brown wrote:
> On Wed, Aug 03, 2022 at 08:11:03AM +0200, Krzysztof Kozlowski wrote:
>> On 02/08/2022 15:13, Mark Brown wrote:
>>> On Tue, Aug 02, 2022 at 10:52:25AM +0200, Krzysztof Kozlowski wrote:
>>>> On 01/08/2022 11:42, Naga Sureshkumar Relli wrote:
> 
>>>>> +    oneOf:
>>>>> +      - description: Microchip's Polarfire SoC SPI controller.
>>>>> +        const: microchip,mpfs-spi
>>>>> +      - description: Microchip's Polarfire SoC QSPI controller.
> 
>>>> Useless descriptions - they repeat compatible. Just keep it as enum and
>>>> skip descriptions. What value do they bring?
> 
>>> Someone not familiar with the full Microchip product line might not be
>>> aware of the expansion of mpfs, it's not blindingly obvious.
> 
>> Then it should be explained in title/description of the binding, not in
>> compatible. This is the usual way of providing some text description,
>> not for each compatible by repeating the compatible text.
> 
> I'm not convinced this is a useful rule to try to enforce, and I'm not
> sure how well it will work if the same IP is used in several different
> places.  It's not clear to me what the benefit is intended to be.

First, the description here is really not adding any useful information.

"description: Microchip's Polarfire SoC SPI controller."
Microchip - already in comaptible
SPI controller - already in compatible and in device description

The only useful piece could be extending pfs to Polarfire SoC.

And now imagine every binding doing the same, adding such
acronym-explanations in every compatible list. Basically we loose easy
to read, compare, analyze and check for errors enum:
  enum
    - microchip,mpfs-spi
    - microchip,mpfs-qspi
    - microchip,coreqspi-rtl-v2
    - microchip,mpfs-some-more-spi
    - microchip,mpfs-even-newer-spi

into double-sized oneOf with additional descriptions each one explaining
"mpfs".

  oneOf:
    - description: Microchip's Polarfire SoC SPI controller.
      const: microchip,mpfs-spi
    - description: Microchip's Polarfire SoC QSPI controller.
      const: microchip,mpfs-qspi
    - description: Microchip's FPGA QSPI controller.
      const: microchip,coreqspi-rtl-v2
    - description: Microchip's Polarfire SoC some-more SPI controller.
      const: microchip,mpfs-some-more-spi
    - description: Microchip's Polarfire SoC even newer SPI controller.
      const: microchip,mpfs-even-newer-spi

Why do you need to explain "mpfs" more than once? Why explaining these
are SPI or QSPI controllers? It's obvious from compatible.

Just keep it simple and small. We all have too much code to look at...

Best regards,
Krzysztof
