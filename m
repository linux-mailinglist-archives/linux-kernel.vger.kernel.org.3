Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3E4557380
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 09:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiFWHFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 03:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiFWHFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:05:41 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E51845513
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 00:05:40 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ay16so19686286ejb.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 00:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FUqOVP3OH7BWYjo6vdlKJOAexlQHETbAKu5icdi+qLI=;
        b=Z3kQtFflp9ce1ZM08KTXQjN3/rys8fUPdg6bFciqs7HRkuvSLYCXT30XIGG74Whnbo
         2w2TMEoeFr/jQ7RQNYBZX3WPP5GrFk6oOSuyDI9iPU2/AHQZ6C3F6D69i7TAYI3AQQtz
         03JTE7KKCSegXy9fyXaKRjsfYlgjaEyvipR/xWN811r3xokYYx+HFE3F5ZdyalC7aENR
         vA1meuxYwHmUkmw/DxdH3xTNO2C67JIpX/1FtHHpbjEWfLwrWMaDNk579g3X2kiFsKrt
         e7ADgDiACVsdABiMnm2fv7466/IE4PddktbRMemlBGqZsK+KKh5QmuNkv2XKCq9hHXvk
         aKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FUqOVP3OH7BWYjo6vdlKJOAexlQHETbAKu5icdi+qLI=;
        b=Hoct8YQJwILrdy6goAJqWzRTQTFhuEtEIpGmUsPfHhtBw2gY1k7qXtLKG55fI1ts2x
         Vxj+UCbRWxg5UX907vmXaofbwtMOqqkjvKYT4pCYfvfIvMWLYJ+MYaM0HTzDcXn/Kq/p
         O0NVvu8Yhi02kmPciCHlIjOF5P1PvPhedAfLXyneVa2TkMZpVY0cOIzbAbUMmEJBKYN1
         GeqyUC+thK0k+2SMS+GsvELIjop2R6vul3SXPQer8YiwCNba/eBlR8wp8tDcFvcnvZpS
         iVC3MoEu557rOPhB+Y1436DdllVdS3qLonzRwSmKBQ9uU//zOk1+M/P38URx+I+p+2S6
         J74Q==
X-Gm-Message-State: AJIora+a7mV7a6L4qbojAR6jtz/kQH0FJZmPEW8aIbDgz6Cq/BheBHXV
        ZUxSIC0zFJ90gdcmC/Z9dM4QCQ==
X-Google-Smtp-Source: AGRyM1sSWLw+uz9Wo/Vqcc2Qzmpm0rtmfs9IKZ6vHicf79GE/X5RwZggFtUqWDuVFpql/v0tm0c+Uw==
X-Received: by 2002:a17:906:9c82:b0:6df:c5f0:d456 with SMTP id fj2-20020a1709069c8200b006dfc5f0d456mr6845907ejc.287.1655967938872;
        Thu, 23 Jun 2022 00:05:38 -0700 (PDT)
Received: from [192.168.0.226] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id a24-20020aa7cf18000000b004356c18b2b9sm12227191edy.44.2022.06.23.00.05.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 00:05:38 -0700 (PDT)
Message-ID: <84cba0c8-fb31-3314-5e2c-7a0c13030b9a@linaro.org>
Date:   Thu, 23 Jun 2022 09:05:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: (subset) [PATCH 7/7] ARM: dts: aspeed: centriq2400: use qcom
 compatible
Content-Language: en-US
To:     Joel Stanley <joel@jms.id.au>
Cc:     Steven Lee <steven_lee@aspeedtech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Ken Chen <chen.kenyy@inventec.com>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        David Wang <David_Wang6097@jabil.com>
References: <20220529104928.79636-1-krzysztof.kozlowski@linaro.org>
 <20220529104928.79636-7-krzysztof.kozlowski@linaro.org>
 <165589305701.29629.10216921074802952879.b4-ty@linaro.org>
 <CACPK8XfxXi8kQr+vxta8rD6SBgxLf_oBjAH0UkPBacQta552YQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CACPK8XfxXi8kQr+vxta8rD6SBgxLf_oBjAH0UkPBacQta552YQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2022 07:34, Joel Stanley wrote:
> On Wed, 22 Jun 2022 at 10:17, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On Sun, 29 May 2022 12:49:28 +0200, Krzysztof Kozlowski wrote:
>>> "qualcomm" is not a documented compatible and instead "qcom" should be
>>> used.
>>>
>>>
>>
>> Applied, thanks!
> 
> What tree did you apply this to? Did you get review from the maintainer?

Tree was mentioned below.

> 
> This board is unmaintained and unused. I would prefer it removed
> rather than meaningless fixes be applied.

I can drop the patch. I'll send the patch to remove the board.

> 
>>
>> [7/7] ARM: dts: aspeed: centriq2400: use qcom compatible
>>       https://git.kernel.org/krzk/linux/c/6202c6063145cf9ec22b40aac219122dd702a10f
>>
>> Best regards,
>> --
>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
