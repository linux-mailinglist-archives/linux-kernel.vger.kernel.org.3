Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0025B54CAD6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355945AbiFOOFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353163AbiFOODG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:03:06 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1714911455
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:02:59 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id h192so11475751pgc.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=M66DAB+19p6w4Na1SDbCKZUUw5Zn5mhELOHN0rTlLtM=;
        b=UDjUEJIiRoVktXJeykSYszQEk/7Fo9qKyvSGWv6zm3yB6tuZvYVMddV+i8fQajPkE2
         aAaZE2cW8WfJiV9Bl+ja/qocfZ84YXu66CvwLgyWfYpBuRUjIAVQEVjMuyhiy55sy0gE
         YOvQWptxx1hqEzX37f8EcQieP+Vbu9XWAZq5akpeLLmyBJFhwQ9UhvZYcBtFuhISrnOI
         FfbJhNxSShwSO+3+Rz9AZhWy9ZSyMi/6umtFS4lMPcttPWLIfe2s52GsUErh6DBdP0Kg
         Z2qNqFD+vvD2WozRI6qLTIw42MhWmb8/TfULi1FUTchhKTMP2R5yRC8BhddQzPIyQxHd
         +i8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=M66DAB+19p6w4Na1SDbCKZUUw5Zn5mhELOHN0rTlLtM=;
        b=A196mN3+osVHGkDnJsfI4MLnooQLN0yPVIPUEN7UUnMH9P5vb5/R0rl1EZW0B/3Jyd
         nyw12f7i6CWrnYnba5gDYOThnih9k5XmZEihdd+0yI6flEetGRjUKnB9mxMC2TZ1cxqg
         Tjpj8aQ+65wb19jmpz5/ml5yv0E9y/kyfcwMh5pCHzoX3oA9ssV00/h9l5cGjVg61cJU
         /F8+l36nnxh4qkaPRvuaVYXht+bFT6YdQVa2GITdeen43isBy6kBwoIiw3V94wflm7BB
         FGX7ihp5xOc1cX66Dyw1FnIFoZcDAAZX+4nh6oxNoHvW8kaUvrlEQ5Gwzlr0RMk3ExEq
         CP2A==
X-Gm-Message-State: AJIora93du7QITKEIi12r+RmzN66+Wn+G429g7keWo2HcoI6ZkuBVy3j
        psVRHOgw97SNbQVP2xyYdZ6xtg==
X-Google-Smtp-Source: ABdhPJx3UrcgrUWHd4kpkHv8SdYGvKistJLOVKNX4XSrYpzd92CUkt0EJ89uNYlWk0nQnhp3+4adig==
X-Received: by 2002:a05:6a00:421a:b0:522:8b4c:69a9 with SMTP id cd26-20020a056a00421a00b005228b4c69a9mr9997626pfb.60.1655301778548;
        Wed, 15 Jun 2022 07:02:58 -0700 (PDT)
Received: from [172.20.0.255] ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id x3-20020a1709029a4300b001663165eb16sm9358196plv.7.2022.06.15.07.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 07:02:58 -0700 (PDT)
Message-ID: <53d94169-d724-7763-1b34-30f219c9963c@linaro.org>
Date:   Wed, 15 Jun 2022 07:02:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v18 10/10] ARM: dts: Add Sunplus SP7021-Demo-V3 board
 device tree
Content-Language: en-US
To:     Qin Jian <qinjian@cqplus1.com>, sboyd@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        mturquette@baylibre.com, linux@armlinux.org.uk, arnd@arndb.de,
        olof@lixom.net, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <cover.1655194858.git.qinjian@cqplus1.com>
 <0574ed0ad1e9ec4c12645fe2d2dde8f701d285e5.1655194858.git.qinjian@cqplus1.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <0574ed0ad1e9ec4c12645fe2d2dde8f701d285e5.1655194858.git.qinjian@cqplus1.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2022 01:31, Qin Jian wrote:
> Add the basic support for Sunplus SP7021-Demo-V3 board.
> 
> Signed-off-by: Qin Jian <qinjian@cqplus1.com>
> ---
> Fix the comments from Krzysztof.
> ---
>  MAINTAINERS                                  |   1 +
>  arch/arm/boot/dts/Makefile                   |   2 +
>  arch/arm/boot/dts/sunplus-sp7021-achip.dtsi  |  84 +++++
>  arch/arm/boot/dts/sunplus-sp7021-demo-v3.dts |  26 ++
>  arch/arm/boot/dts/sunplus-sp7021.dtsi        | 318 +++++++++++++++++++
>  5 files changed, 431 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sunplus-sp7021-achip.dtsi
>  create mode 100644 arch/arm/boot/dts/sunplus-sp7021-demo-v3.dts
>  create mode 100644 arch/arm/boot/dts/sunplus-sp7021.dtsi
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
