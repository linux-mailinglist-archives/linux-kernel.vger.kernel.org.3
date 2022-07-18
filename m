Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB2B5782B3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbiGRMtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbiGRMtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:49:20 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB3423B
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:49:18 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id u14so5454309lju.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lUlSkIwoa0KzHw9QrZR7cNs1ycaTg0FS1rjq47UUS0w=;
        b=eELotu+FdmWVALlGK5uMq0g9BiMRH2RlOqrfZ46byJ3x5SpUkqBMuPimRLgiWeFkNJ
         rRrM24Rt+fS+jK4ynNAq7AObWvK1qYHSC7myWahYn+zPG/T3E5Hi4bIn3JoEOEonBYdi
         3UOf3M4qKEsDbLUiuR5O0vrpjfl3GCHRrXJEz8tS4t47RJ7JwiIW+riDb6z9POLBqrGE
         z4i1NHJ3NKPV2XMG4SHsjsJcH0t2+x6yHCM8ff3K/XMsPrUK39YTfm+QcM5jVIQz1Wqg
         EaJNxL4xtJ7IQukABjBq8TS0aZD2lxL774QuNcRwx2Z0W+9mJNE9IHPmhtq1hoD/xdV1
         tb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lUlSkIwoa0KzHw9QrZR7cNs1ycaTg0FS1rjq47UUS0w=;
        b=xW88vLXioHW2cpKfPI4zMnPg1SEgG8Kct75Ax43AiE3JNROTshAaa/Xrw8v2cnenza
         hdVt5SMhiYjkKW/E7KWYX+EicYCqfEAbi61XqZkBh16Y9vUfewwcjfwC3N71XZGDZqAT
         AVXXbEeYfO2kQNKrc3LZUkxdt1298EZWzW4APyP0kEyIj3qpkcDGNAy/MYU/+x96wTlN
         fKed3BAvbvqp6LBJJcmAKUil+vi8+4Bem6/raVZbTH4mQFYTlWb6qichcgW9FfRZ61QK
         BfoF+DicQhBb9Er6jb5ZP8nOdC4YYDHD29cancp6/y2SCh+OQxzBGaN6ueikl03zvJW0
         B6Mg==
X-Gm-Message-State: AJIora93VYScGhzgZK/Isu3YPxG7F/C1hM5JDWjQ/YF7ia2H0Emmt2fm
        4MmdqreFGPqj8+8tl//bZnALow==
X-Google-Smtp-Source: AGRyM1t+n/cfxhgEhyqi/ZTHwWLswVSQSZSDTx60S3Yof2Vl+DTp/b3bgb4+BWqHf3i3D3CW8W1mXA==
X-Received: by 2002:a2e:95c4:0:b0:25d:b198:c0f3 with SMTP id y4-20020a2e95c4000000b0025db198c0f3mr3814100ljh.529.1658148556994;
        Mon, 18 Jul 2022 05:49:16 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id b25-20020a05651c033900b0025d65d4e178sm2085488ljp.120.2022.07.18.05.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 05:49:16 -0700 (PDT)
Message-ID: <add23ad7-2539-cef3-8684-10ec8e680483@linaro.org>
Date:   Mon, 18 Jul 2022 14:49:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH v2] ARM: dts: Add TS-7553-V2 support
Content-Language: en-US
To:     kris@embeddedTS.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Mark Featherston <mark@embeddedTS.com>
References: <20220713221233.8486-1-kris@embeddedTS.com>
 <55dccabb-41e9-dc45-f404-c333f5472e75@linaro.org>
 <1657833995.2979.1.camel@embeddedTS.com>
 <eb993f8d-e72f-aba3-e7a4-1bbd2ac00f6c@linaro.org>
 <1657907657.2829.1.camel@embeddedTS.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1657907657.2829.1.camel@embeddedTS.com>
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

On 15/07/2022 19:54, Kris Bahnsen wrote:
> On Fri, 2022-07-15 at 08:42 +0200, Krzysztof Kozlowski wrote:
>> On 14/07/2022 23:26, Kris Bahnsen wrote:
>>> On Thu, 2022-07-14 at 10:34 +0200, Krzysztof Kozlowski wrote:
>>>> On 14/07/2022 00:12, Kris Bahnsen wrote:
>>>>> Add initial support of the i.MX6UL based TS-7553-V2 platform.
>>>>
>>>> Use subject prefix matching the subsystem. git log --oneline --
>>>
>>> Can you please elaborate? The subject prefix is "ARM: dts:", I'm not
>>> sure what is missing. Should it be something like
>>> "ARM: dts: imx6ul-ts7553v2:" in this case?
>>
>> Run the command, you will see.
> 
> I had previously run the command and the output of it did not make sense in
> the context of your prior comment. Forgive my ignorance, but I'd like to
> understand specifically what you mean here so we can do the correct thing
> in the future.
> 
> $ git log --oneline -- | head -n 20

This obviously does not make sense. -- as you can read in git log help
and several other Unix/Linux commands is marking path arguments. You
want to run it on specific subsystem, don't you?

Best regards,
Krzysztof
