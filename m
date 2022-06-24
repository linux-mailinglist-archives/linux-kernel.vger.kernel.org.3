Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6305598A4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 13:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbiFXLkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 07:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiFXLkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 07:40:53 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C354F680A7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 04:40:52 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id sb34so4074164ejc.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 04:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yy24MqgNoh04Wcf3D2OtiN2cBgfAiEXHDzWGPuJGK9o=;
        b=lHmUiWiXPi9B6UOOWeyFYwQG8hPeZnA+ltsmMKdFIkgssbt3bc684dUGLED1PcrHNV
         zMtTDHV/vSMKeBUEQ1Ns1/822af0cGXN8FeH4f2/E6SLnOFUhcney0xFzsZxsz0b0MyN
         G3jediLVRnPaG1/NpHAFBYX/ln8O/mom1ODWhtlEPyGtEMvv1cKMSDF1SBRG/j7lB+ZQ
         Qdumnn8pu+Cm6YQ0v0NjDM4F1eLMIplOVmRRp5HR3J5IzQN0w9befAomRwaqKgmLLk6d
         2UPtKOgwUxDnQxxMsrtMO6e0bE3TX6pISD0q/NU9c0jeMPSMHgUXEwsnC3f43eCzTyQR
         0Tnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yy24MqgNoh04Wcf3D2OtiN2cBgfAiEXHDzWGPuJGK9o=;
        b=CPRVELY9nMx0ntL0pXCQIoBu2Y492WkuPiM9FMiybFwPpHElzdQ0/TzLRsqGVmwnhR
         bMAq0Kh+R2w6FLrGVNeBZc/4c6gFvK+tGAfv0/v/72B0dcmKS7utEtnYtxo7p4pe2nhE
         WsbwDGCGAhnG1CnP1jMCXl/rZPM32u3GEKyZ0njzU7ldBTrk3PlJvg1xUSluEboHKcho
         OPqlBWwY8IJZS8BEspzH7JQVd2J8JywM6l0dlMD+Whkqp9MfSZtCeLCb+YnTf7ftT2Wh
         oSKS22mOuxn6uSOkr+nZPeeGSCnm7RSF1KgHAsHcC1BtDnwgbudnowv7UXEy5G6995GK
         EYhQ==
X-Gm-Message-State: AJIora+nSPOqr9T4aXw/rPz9dxvwnLJ9321HvFVEBPAYW4e85TXjWrPN
        vnSdwKXrEy6sOR+z3wvmnBG4zw==
X-Google-Smtp-Source: AGRyM1tD0+on2/SUIA73VKnd1ynphMygj9K2ZiDycQZkB6sBMq+S76vrTE6qtDUnJ8sffk6YYFEaAg==
X-Received: by 2002:a17:907:9722:b0:706:19d0:80b5 with SMTP id jg34-20020a170907972200b0070619d080b5mr12930874ejc.33.1656070851427;
        Fri, 24 Jun 2022 04:40:51 -0700 (PDT)
Received: from [192.168.0.235] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id n18-20020a05640204d200b00435a08a3557sm1844443edw.27.2022.06.24.04.40.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 04:40:51 -0700 (PDT)
Message-ID: <22dc8eba-af71-ff7c-fd74-bf5778655bfc@linaro.org>
Date:   Fri, 24 Jun 2022 13:40:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/2] dt-bindings: iio: dac: mcp4922: expand for mcp4921
 support
Content-Language: en-US
To:     Kory Maincent <kory.maincent@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Welling <mwelling@ieee.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     thomas.petazzoni@bootlin.com, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>
References: <20220624095619.1415614-1-kory.maincent@bootlin.com>
 <20220624095619.1415614-2-kory.maincent@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220624095619.1415614-2-kory.maincent@bootlin.com>
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

On 24/06/2022 11:56, Kory Maincent wrote:
> Add device tree bindings for the MCP4921 DAC.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>  Documentation/devicetree/bindings/iio/dac/microchip,mcp4922.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
