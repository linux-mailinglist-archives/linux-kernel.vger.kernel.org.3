Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562E152EC8E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238324AbiETMsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349216AbiETMsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:48:30 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73A01668A3
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:48:28 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 27so4600537ljw.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jj/r0+A1LrJnhoO/RRceBUvJ8EYDeEnSUJDuZQ2AlkU=;
        b=uxoqHZU2Suo3X4RpgDOFGpAW8IcnZR7SmY2BErjtGQhxjegXuxRlx0i7DTWt6r4TRK
         MB3hLZKUW6Ug65Gu0XO/a51pBTruyXe9i+hnCz+MypQoGBjjxqQrQvK5RGUUxq8FccLM
         0Ee5XjA2aDcdXJn8t7AT/E95TlAK7x/wXgxDeddjAqnKde6yShTzcwe7cKHwWfZBqjap
         uxDUYLznxEhqgDL8C4omaR4HNHvPWbz0TibcjF7H6/Rqaf7eFz565jHQzI0SdvF2kTfO
         oQ08N+ThjwSPI0zYmHDfdeYa3zf2yFr3M6BhTLaYbXoBG4+FqqoChKGlQYLukRQ3/NAx
         Vymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jj/r0+A1LrJnhoO/RRceBUvJ8EYDeEnSUJDuZQ2AlkU=;
        b=3ji2ANDc2lsgu4XKb0nCjfNJgclhUGxkEn0AYFsDjyptD6voD+ayjpsn966EivbiKw
         qQTGMwm3pYRGxWCqt5DULmG2mCSJhfCEFTNIX06AutAQ7piZPuNctFTvbIOOwM1dlFAd
         L3ALDdnnyjXZ/6qjHrvH/9tAJsJrqQx29hftJEFadzf5473YHni0icEweFz6QThyfqVS
         Nz4Jri+drufk0Li1/Iz2L/FNj5nD3G+qR75UVF3pKiXSYvn/g7joznpmbnLBSdzKfJTO
         KfLvG+c1E/uXmIGAuv+hIQAD7b4XnQSiwT/FxNgDmeG7w1WPr1mVhfnzy4vtsjCPskC+
         mU/w==
X-Gm-Message-State: AOAM533XNTUpnPvJSmkQwEKl7SbJmXKGRUvTir0O3U8w8DlVud6Fb1xa
        Aeq6ki92+dUZajrKPZBBuO/ybA==
X-Google-Smtp-Source: ABdhPJxa22UihYKVAI7lxlpUTP1kaFY94T0cjcRSFc7JjQ7D4nYnaYpvDwIj5qDu/pUUvHvQIfZcaA==
X-Received: by 2002:a2e:84c9:0:b0:253:bd3e:63b3 with SMTP id q9-20020a2e84c9000000b00253bd3e63b3mr5318183ljh.350.1653050907139;
        Fri, 20 May 2022 05:48:27 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id b8-20020ac24108000000b0047408564c31sm646938lfi.286.2022.05.20.05.48.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 05:48:26 -0700 (PDT)
Message-ID: <053b0099-6d01-c3a6-f43f-df5ef0424d5c@linaro.org>
Date:   Fri, 20 May 2022 14:48:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 3/3] ARM: dts: lan966x: Add UDPHS support
Content-Language: en-US
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20220513105850.310375-1-herve.codina@bootlin.com>
 <20220513105850.310375-4-herve.codina@bootlin.com>
 <2945e445-3453-a45f-7d3d-3b07bf350b47@linaro.org>
 <20220520143726.6dd324fb@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220520143726.6dd324fb@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2022 14:37, Herve Codina wrote:
>> Generic node names, so it looks like usb. For example HCD schema
>> requires it. I am not sure which bindings are used here, but anyway once
>> they might require usb...
>>
> 
> HCD are related to the Host controller.
> Here we are talking about a device.
> 
> In existing bindings related to USB device (or OTG as an OTG can be a
> host or a device) on several SOCs, we can find:
> - usb1: gadget@fffa4000
> - usb_otg: usb@1c13000
> - usb: usb@47400000
> - udc: usb@13040000
> - usb_otg_hs: usb_otg_hs@4a0ab000
> 
> 
> So I will change to
>   udc: usb@e0808000
> 
> Is that ok for you ?

Yes, I proposed usb.

Best regards,
Krzysztof
