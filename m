Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D424EE254
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 22:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241235AbiCaUHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 16:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241220AbiCaUHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 16:07:39 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352CF192583
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 13:05:51 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bi12so1600223ejb.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 13:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZfN067mnS5BlIsfHVe3ZlU7DqSlk7Ld3MnZB4ytVmqg=;
        b=c3ynxR9y7v1gW+mWfnZMhiqsH3K4IQGW0eFYu2rMtfQDOE8DvnLWJwT6ahalulW1BD
         8MQ7GXPoyvQLLh2LHp7kyR5PigjxABECaVIVFmxVRyKpa0X7Twp8I1bVJ5syUAp+nGOw
         HTBRFxuUuspnz/e4eLXrzJGCDDZBWcsi04aqV/sip2i8BRSQlzRpY62h4x6zdX+y2okJ
         Rr754XNh2ehFdmw1IRpNmo2U4j8EvozYQV4oYwPCB37+JE5q3p0DZRHFXmY3FEWbykCU
         E2YxVdR4jk0GyeCpJ0xuu7RZCth0A1gUKxAM2mh7H6YyxXIBMLGOhOdWx9FI8oNgF42E
         sXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZfN067mnS5BlIsfHVe3ZlU7DqSlk7Ld3MnZB4ytVmqg=;
        b=CcE/15fN7tseWMATw5G9PaPi/w6sjaxbtOJztMO78MRmBzZidb2fbCwyF/m2K/6tc3
         2DPZBz/b39vH/k3EKLxvlCa0SVZ6RPh4jZedm4sKWXgO4GAn5VisON3cJSaTSUq/OLQn
         e8NJF9upjlNvmE1VElXi7M76RjXiwc5VYfG4+oyoAGT4tDc9evf7FPHYABl8OoROBZnJ
         TV+QMJGwF1iuB4xUu0lQlt5uaMAuawfIo5EiV3b7tryPTuyCevciM0fWviB4U+IlFRem
         mhv5eI3u4fPr7fKLn06tjD89J29KPCkdYsCj4XQKtUcBFjh7NWwcr7ceJr6JU0mtgO7E
         BXKg==
X-Gm-Message-State: AOAM532tullxhG7GFonvQrAuT1Lv0Ub+NVg2+ogvufFwZ7CACpwkFRrB
        AE/NIAN9WFrL/ytmlVTAeLqq+g==
X-Google-Smtp-Source: ABdhPJx3tm7hWCSHu7HsyyNZCnghrvmyGAJpe24l53pAa8mUdy+wSgwnyvwLib/kWiGTjkDX+RsJfg==
X-Received: by 2002:a17:906:7d52:b0:6df:a6c7:2c5 with SMTP id l18-20020a1709067d5200b006dfa6c702c5mr6609550ejp.540.1648757149826;
        Thu, 31 Mar 2022 13:05:49 -0700 (PDT)
Received: from [192.168.0.167] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id gv9-20020a170906f10900b006d7128b2e6fsm151290ejb.162.2022.03.31.13.05.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 13:05:49 -0700 (PDT)
Message-ID: <dfb10165-1987-84ae-d48a-dfb6b897e0a3@linaro.org>
Date:   Thu, 31 Mar 2022 22:05:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RFC net-next 2/3] dt-bindings: net: mscc-miim: add clock
 and clock-frequency
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220331151440.3643482-1-michael@walle.cc>
 <20220331151440.3643482-2-michael@walle.cc>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220331151440.3643482-2-michael@walle.cc>
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

On 31/03/2022 17:14, Michael Walle wrote:
> Add the (optional) clock input of the MDIO controller and indicate that
> the common clock-frequency property is supported. The driver can use it
> to set the desired MDIO bus frequency.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  Documentation/devicetree/bindings/net/mscc,miim.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/mscc,miim.yaml b/Documentation/devicetree/bindings/net/mscc,miim.yaml
> index b52bf1732755..e9e8ddcdade9 100644
> --- a/Documentation/devicetree/bindings/net/mscc,miim.yaml
> +++ b/Documentation/devicetree/bindings/net/mscc,miim.yaml
> @@ -32,6 +32,11 @@ properties:
>  
>    interrupts: true
>  
> +  clocks:
> +    maxItems: 1
> +
> +  clock-frequency: true

This looks unusual clock-frequency is usually for clock providers but
this is a consumer, so it is not a common frequency here. You mention
that "driver can use it", so it's not a hardware description but some
feature for the driver. We have this already - use assigned-clock* in
your DTS.

Best regards,
Krzysztof
