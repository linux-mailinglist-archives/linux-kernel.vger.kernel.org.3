Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A56572888
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 23:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbiGLVXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 17:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbiGLVXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 17:23:18 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB342D0E34
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 14:23:16 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id t1so12518503lft.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 14:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZIixC2bV5bk0+HIicGoB7Neycw0Y+e5g1F3XyfSlUow=;
        b=lEd2am2qFIvJv6mvwUPXijftjd8L/Wyv9Yx+kKh+EvPQy2tACUdBFYr9SBMhe52bh4
         oypuIStUzdaV9hnFKV8CZx6YYvxyWyBt+hdEKrL0xT8OBGD7oRh55m4WKmqzfkbzj5Dp
         XMjQMxMW8vWxEpXgr3S5Y1Ti7r5bCIkZ4ftbbTBEg93nORt5WH5trqMQe35/+EvhDdak
         RVOBEB9WpNO4QJ8LX7couSF9n0zEMJpevFZOlFiQKveOzKA8dDVowBooFkhWIfiz5GRv
         kiov8wQwDs2OA8iiTDK4cv5moIrCKR7v3VOys92mWJTzS/unkodYL9b7uHt/oeRUfBuP
         lbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZIixC2bV5bk0+HIicGoB7Neycw0Y+e5g1F3XyfSlUow=;
        b=mhLESZeko8E3eTL5XqkBnBhKDVAdP40KeibmmNGAiIKfokUvE12oBN8G3a1RFiqqY8
         2uyS3rWGdmFD75ukMN3vEj0PvQmR6YRf5EuxsBLhMMe03uVSAQJidbF2IsSEN35EwOAR
         bQxeVq5DLJxTgQLhl2AsNODcaVC3AHNpgxG5LR7NlMYy79EsJJG8P8ZZ43Uadk+jNP/e
         ZEVLwtcICvMIOTeUsgS9+sWEtj+cpyE1zzyjPDkpiqJWMPvCF5N4YYXagTr3Wfw36XYB
         mnm5E1z83x3Jo1FQKoug3HdWGzdCdJMR47/+3FxYSSbSM+23VpBJA/TYnWXY5mbRWbDE
         8qqg==
X-Gm-Message-State: AJIora80YNWs6upXGFTCmO5iqMTb6CPr5uWj32W8zvx+YbdrzPI8Bxuw
        1DUQPaz/1N4eGodfXf7+lNvA0A==
X-Google-Smtp-Source: AGRyM1sLfpcYmbiEjWfaKm08jr8ScrE2GfPqP64cecPIr1DDlLCmyOl86WwUnjYrA+y/rjH/i6DnAQ==
X-Received: by 2002:a05:6512:3b8f:b0:489:c6c9:f522 with SMTP id g15-20020a0565123b8f00b00489c6c9f522mr11797lfv.244.1657660996339;
        Tue, 12 Jul 2022 14:23:16 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id v11-20020ac2560b000000b0047f9dca3708sm2391737lfd.51.2022.07.12.14.23.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 14:23:15 -0700 (PDT)
Message-ID: <ca26630c-a09c-6f4d-51de-7a2ba615bd58@linaro.org>
Date:   Tue, 12 Jul 2022 23:23:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 5/5] dt-bindings: input: touchscreen: stmpe: Remove
 node name requirement
Content-Language: en-US
To:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Lee Jones <lee.jones@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-input@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <20220712163345.445811-1-francesco.dolcini@toradex.com>
 <20220712163345.445811-6-francesco.dolcini@toradex.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220712163345.445811-6-francesco.dolcini@toradex.com>
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

On 12/07/2022 18:33, Francesco Dolcini wrote:
> STMPE driver does not require a specific node name anymore, only the
> compatible is checked, update binding according to this.
> 
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  Documentation/devicetree/bindings/input/touchscreen/stmpe.txt | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
