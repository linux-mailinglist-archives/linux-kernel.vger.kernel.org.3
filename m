Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523335050BF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 14:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239199AbiDRM1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 08:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238788AbiDRM0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 08:26:22 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB10712609
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 05:20:26 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id lc2so26482055ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 05:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IrspqwoC0i8xWBSDGv/e81WYq/G3Gaial55KaXcpMB4=;
        b=EROJPtVhkTWMC362VRxsn28ErAWXjxRwSGzBrXd/ILtzWuytV08hvlbx49encLOOqc
         yeMw9yc7SKrF1+IquHFumnC5nzv8sCjiS/9h3Ie6onCCBYKAmaLf0suDnplCv4q3oEDF
         knghEFqpRQpYEfE3tDtNwMu2obylGzqhbXAdLhvCLWIQKLnEXd8Sw7hYct4HM0iizOxM
         KJxVev9k4sh5XJ89IrjxtG8nz5L8AoKnxF88C74xHknJiavH0KHq7Pxu0mOPH9XvZWze
         PiVvIKdjNyMdM4oEgTDgrWs57aI2jc86pzv2U3KyxgYxeQX5iqZEIrJxIMY3Y4NeUc0Y
         leDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IrspqwoC0i8xWBSDGv/e81WYq/G3Gaial55KaXcpMB4=;
        b=vX67QmYTS7HZWsvw4mSjUK8uqaRzsyKwDUT8WUjVVPPxVIFm+8CzZF3jipVsOdHeCm
         HABaOQ6hXzDyug1iYn6ALCL983E86Q6QZlCHT3GkpcbywSGPQVvMv/4eE4+ndsXWzmnl
         xni2pYqGUj+9GxZiHsIREt7APPvIv297CN2aZ3h6BD5/YioU56Ff4hzwNpZELmhBOLfi
         P65+FrZKVyU1HKsAxIcQjjua7lRGr3OUBYKZk6GmHaconyemCDukWzc0qLq9X+uEAxja
         5zBrP38KHNB3rNSd7FjKwXPPQy/8Dgzw68XTEN1I0vLPwVhkXeA+tSbExtKTdUkBoyUN
         nhNA==
X-Gm-Message-State: AOAM532jqvkRSFdMnp23otN3Xj1lE/9RV0SPCA1+VbyMAURwVB19bGpp
        bdKzt9I4KvjfmyPmYjrjTmo+Ug==
X-Google-Smtp-Source: ABdhPJzoDxvcNzmEcyeGaDq97ow/WOeOSzYmXAahpLo2Kg1wrT2tHDDGSBII00dY0Cob+6Pqx4rvHQ==
X-Received: by 2002:a17:907:7e9f:b0:6e8:92eb:4171 with SMTP id qb31-20020a1709077e9f00b006e892eb4171mr8636712ejc.53.1650284425490;
        Mon, 18 Apr 2022 05:20:25 -0700 (PDT)
Received: from [192.168.0.217] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id o14-20020a170906774e00b006d5b915f27dsm4538016ejn.169.2022.04.18.05.20.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 05:20:25 -0700 (PDT)
Message-ID: <60e50c11-118d-431f-7120-95fcbb53eeb5@linaro.org>
Date:   Mon, 18 Apr 2022 14:20:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 3/5] arm64: dts: nuvoton: Add initial support for
 MA35D1
Content-Language: en-US
To:     Jacky Huang <ychuang3@nuvoton.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, ychuang570808@gmail.com
Cc:     robh+dt@kernel.org, sboyd@kernel.org, krzk+dt@kernel.org,
        arnd@arndb.de, olof@lixom.net, will@kernel.org, soc@kernel.org,
        cfli0@nuvoton.com
References: <20220418082738.11301-1-ychuang3@nuvoton.com>
 <20220418082738.11301-4-ychuang3@nuvoton.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220418082738.11301-4-ychuang3@nuvoton.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2022 10:27, Jacky Huang wrote:
> Add the initial device tree files for Nuvoton MA35D1 Soc.
> 

(...)

> +	gic: interrupt-controller@50800000 {

The unit address does not match first reg property. Don't you have
warnings with this?

> +		compatible = "arm,gic-400";
> +		#interrupt-cells = <3>;
> +		interrupt-parent = <&gic>;
> +		interrupt-controller;
> +		reg = <0x0 0x50801000 0x0 0x1000>,
> +		      <0x0 0x50802000 0x0 0x2000>,
> +		      <0x0 0x50804000 0x0 0x2000>,
> +		      <0x0 0x50806000 0x0 0x2000>;
> +		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_RAW(0x13) |
> +			      IRQ_TYPE_LEVEL_HIGH)>;
> +	};
> +};

Best regards,
Krzysztof
