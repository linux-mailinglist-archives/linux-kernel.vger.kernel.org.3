Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C47562BE0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 08:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbiGAGi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 02:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbiGAGi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 02:38:27 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EC4193C8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 23:38:25 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id q6so2197563eji.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 23:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jSUhQ3rBFKJxU2LCa9Ql4GrsO3TLNvrpxzwTvNvCTBU=;
        b=KR6dlzrqc5KAGSH9q86OuFL5a+BEdvq6u4BADqzj2u4IsWpTYBto01KpxaRquYf7o0
         JtiDRx/EyAFV+Cgl87CMVn8WN8HIEmG9LenpcmVVzSOvx+64M2BMif34Ryj1EWc5AOFw
         fYwxSBePaevTU7jMLWsvxwTKWDcn87aGdBdmm0sxLXhyzBwIBwpzD4KT7gyiC7VxyfNv
         uHVB9jLUHzbOWpzFgjBqcmsnAnHklk34pQDS0rTbq2/FYY0HRtcx/JVWOP2N114fQYUZ
         M4+c23OEagK0HqTdKz9FxEcJaQD4psedtmE5SHRxcA0KMZO2obWfzBbCZJRV9wn0TrIc
         x3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jSUhQ3rBFKJxU2LCa9Ql4GrsO3TLNvrpxzwTvNvCTBU=;
        b=XRXGP2DblVEle56rHmJCJoPAspk9ejuQ3ocmEBK47nkhtu4oW2OVt3KaSghVganWw9
         TVnlqZ0Hulnq6pcLaMHJ2RaX4UTxiYvQ8U+2fAxuuDaMnZ33mA//mXOU67GcrAx1fBj4
         vv5mbiM6mEDsadcVVRhDLhj0PhTCecgk7cEnc5BVcPQdElFbx77OUdvYpzCQ05+G5L+4
         HJuvXjMUeNSzshr/wIMhco110hgQhEHmJMJK4CL3PowFvxfbq/A2ItXhRHjvHx+qsT56
         +q7Dk6VGAwav1WAl4fo/zD8dRYRqgGCKh/1uX4k896mJoOwd1pbhfaudUFw16+L6xcCN
         Ts1A==
X-Gm-Message-State: AJIora9QEWSFuiWz+9wTUBCPdbGXzrHXnjizYyE5bSGOTSWi83JTvIJy
        opd7H7rXmI/n2yHP5rRgUOoFng==
X-Google-Smtp-Source: AGRyM1u1+fKIC+2Zyq9jouPxdVF4hWeo0y+1sNSQER05/bn7i/qCLb8ToWpi8wtdaJkhU/0g3pvttA==
X-Received: by 2002:a17:907:7636:b0:72a:9297:37d1 with SMTP id jy22-20020a170907763600b0072a929737d1mr293126ejc.349.1656657504110;
        Thu, 30 Jun 2022 23:38:24 -0700 (PDT)
Received: from [192.168.0.190] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id s27-20020a170906355b00b00702d8b37a03sm9951428eja.17.2022.06.30.23.38.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 23:38:23 -0700 (PDT)
Message-ID: <5dbf57e4-7573-fa63-d8f1-6ecde08a0875@linaro.org>
Date:   Fri, 1 Jul 2022 08:38:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: ti,adc128s052: Add adc08c and
 adc10c family
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Florian Eckert <fe@dev.tdt.de>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
References: <20220701042919.18180-1-nm@ti.com>
 <20220701042919.18180-2-nm@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220701042919.18180-2-nm@ti.com>
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

On 01/07/2022 06:29, Nishanth Menon wrote:
> The adcxx4s communicates with a host processor via an SPI/Microwire Bus
> interface. The device family responds with 12bit data, of which the LSB
> bits are 0 for the lower resolution devices. I have been able to test
> adc102s051, hence adding just the missing ones in that family.
> 
> Lets reuse the binding to support the family of devices with name
> ADC<bb><c>S<sss>, where
> * bb is the resolution in number of bits (8, 10, 12)
> * c is the number of channels (1, 2, 4, 8)
> * sss is the maximum conversion speed (021 for 200 kSPS, 051 for 500 kSPS
>   and 101 for 1 MSPS)
> 
> Complete datasheets are available at TI's website here:
>   https://www.ti.com/lit/gpn/adc<bb><c>s<sss>.pdf
> 
> Handling of 8, 10 and 12 bits converters are the same, the
> unavailable bits are 0 in LSB :)
> 
> Inspired-by: drivers/hwmon/adcxx.c
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 
> Checkpatch does complain with Inspired-by: insisting it to be an email
> address.. but I was really inspired by the hwmon driver.. Don't know
> what else to say here.. we could probably drop it?

Drop it or convert to just test.

When passing checkpatch:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
