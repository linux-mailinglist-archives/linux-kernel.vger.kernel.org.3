Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73E45276C3
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 11:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236186AbiEOJyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 05:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiEOJyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 05:54:43 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDF53153D
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 02:54:42 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bq30so21313496lfb.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 02:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gQEfQ5vJQL6jpC1Tvs1WzVX7/mZ31DOC5y2HUnjzALI=;
        b=xS7pUV/3EkrxlycX0L6/FEA6iJPGxOoiDzuzWU3a1KmAOMiEyAhmSQGQRXrb35Yzt9
         zqTlWpN3qcThnhAFGsRCEPaN5aF7968EHYnTZaiIpmzmbuAjHUXpsHyF7lfYTl6V2i50
         rVhOXY2NzeI0vMCPQZWMBC/s5aEkH7pes1lAmxtw5aW9jGWK1pfS3qYXrjyf1Gsq40Q0
         fJvozTUM1W2RvfsErXyZEdMPvGhRvx+Ad3d9f4152J5VJL94ks4Weyn0miOBARtKis5u
         xuKbum/TRUKnk+0+YCDWObPH1VvS24mPFOKN1uKB1oSL6oMiuXXRxCwx9Ai3erRqJIIy
         NWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gQEfQ5vJQL6jpC1Tvs1WzVX7/mZ31DOC5y2HUnjzALI=;
        b=7p7QQiT/+mn0stKFdHjszE9GVN2x5IufFoN/L9D+yo0jGUaRcBMsnDYok0APZXqVQI
         io5kA3sxZh01oBR3sRaNbgDi/Ou2oWbIgD3qb1kL6EKdA3zhjNmAfzoOwoaSHBby7eX9
         uvG/4ys/KlXW/ihG9BCKMwJe9H8GLrsER9Zcn4X+tCLfEcCrn8IjpkCcIqQ+ulj5iCpi
         Lefx1q5PJ93HowSZQ+YzXEfxdUne9DJiWtPshzHcpqUw02j0/E0RNmrtGdISkQjlVGbe
         n/NR0P6cq+UR9/HmJxSxbElfG+lbIlDrvhCuN7bKw5crtqDUVHLwjlN2GRtuTRN5amrf
         9ugw==
X-Gm-Message-State: AOAM531VopMlC+NdoHQCHvCNl/14CtkofFqkGgxvTIw7HR+jPf2XPqwU
        NBv9bgH9BiD9nn2+QnFYonQp4g==
X-Google-Smtp-Source: ABdhPJxcWukAIjcjb8gEHeipeH5rLBbB9Ymlx5x3k+a5VGCaBreyrDbuRJ5b5csmpQ8av1yz5XbC3Q==
X-Received: by 2002:a05:6512:3048:b0:473:a3d4:5252 with SMTP id b8-20020a056512304800b00473a3d45252mr9274506lfb.50.1652608480591;
        Sun, 15 May 2022 02:54:40 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y4-20020a2e9d44000000b0024f3d1dae9fsm1133677ljj.39.2022.05.15.02.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 May 2022 02:54:40 -0700 (PDT)
Message-ID: <c3b8a28d-087f-f973-17db-da9c0fed10dd@linaro.org>
Date:   Sun, 15 May 2022 11:54:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH V4 3/5] arm64: dts: nuvoton: Add initial support for
 MA35D1
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>,
        Jacky Huang <ychuang3@nuvoton.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, sboyd@kernel.org, krzk+dt@kernel.org,
        arnd@arndb.de, olof@lixom.net, catalin.marinas@arm.com,
        will@kernel.org, soc@kernel.org, cfli0@nuvoton.com
References: <20220510032558.10304-1-ychuang3@nuvoton.com>
 <20220510032558.10304-4-ychuang3@nuvoton.com>
 <03ac0a67-bd1f-12ca-74f7-8d5b05857ea7@linaro.org>
 <46a55b01-ee9f-604f-72c9-916bc2f02a09@nuvoton.com>
 <0e72e176-d7b0-ed10-08f3-ba7d4729a931@linaro.org>
 <db333ce4-6b21-7807-15fa-384619cde6f8@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <db333ce4-6b21-7807-15fa-384619cde6f8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2022 07:53, Jacky Huang wrote:
> 
> On 2022/5/13 下午 02:57, Krzysztof Kozlowski wrote:
>> On 13/05/2022 08:48, Jacky Huang wrote:
>>>>> +
>>>>> +	hxt_24m: hxt_24mhz {
>>>> No underscores in node name. Generic node names, so "clock-X" or
>>>> "clock-some-suffix"
>>> OK, I will modify it as
>>>    hxt-24m: hxt-24mhz
>> No, it is not a generic node name. Please read my reply again.
> 
> I  would modify it as
> 
>     clock-hxt: clock-hspd-ext-crystal
> 
> 
>>
>>>>> +		compatible = "fixed-clock";
>>>>> +		#clock-cells = <0>;
>>>>> +		clock-frequency = <24000000>;
>>>> This does not look like property of SoC. Where is this clock defined? In
>>>> the SoC or on the board?
>>> It's an external crystal on the board.
>>> I add this node, because it's the clock source of clock controller.
>>> It always present on all ma35d1 boards.
>>>

Then such clock is not a property of a SoC, but a board. Feel free to
simplify DTS by storing most of the clock node in DTSI, but frequency
should be defined by each board.



Best regards,
Krzysztof
