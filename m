Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080F150E782
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240357AbiDYRw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240316AbiDYRw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:52:26 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E352315F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:49:21 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id k27so4185823edk.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ebs8VcYRuiG+zzhZhkPws5bq5vcKW6ksXUqkXvhEbOo=;
        b=iXrgNRyV83lwioUyOZL8W/AIYM5JHiPr6br+5XItDScpeJEhyxUamNqrkP1GNvuB4F
         0rtU2XS2uFQnFAr1PgzutYWxU/15uokzTnOaF7LHSS7UaVIIN6Qzg9Mk+AXUxAye5tgW
         AwA6ZnaFTjpxG6F0NfvbuawjkDYhOG2IL/y0UASQtX57S3SH3vcEpRBD5+Qylfm/q2eJ
         c4oW4BbeFD5xqFwqAZz4weOzvYCue1dPWqgYNNv1triLjtfLRVEbO3/QG95bgDbgcC1d
         DeJPnyRE0Ftd7yReucky1l0aLvE7D4r36f6IuQEU10mxrNl5+R28vgpoeiXKXfGRxWWn
         4kTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ebs8VcYRuiG+zzhZhkPws5bq5vcKW6ksXUqkXvhEbOo=;
        b=etloIDlzLoHC1v3+ZnI/wklyH+wkqCJuOoFUJjGkifgiTqjoCHG85um37mr6ZUBBFq
         hGPfvfZfWWQDuH8tY/Z9yEuoF/Ppcy2652Qov26ORoQ5/VCptSFu2SBy0yRsDs/p4m10
         g9TiNRTlPzZXuXATdlTbO0VHBihKGDQL1WGk/zLuxilZafPH7OVGz0/M4SeHO4UOqLdM
         q6CRd3QxCB1HmiJij1Ryvy4shK4wV6nTYeBk0dy5+69VSd8X+RPJNUzmqonEWZMdJLxF
         Ri0NB2KSeY4eg54+g++FE2HfqpYq6nZgiaknEDW/2CCmCzJRpQbakM7iqEOvxBaspGvV
         ftFw==
X-Gm-Message-State: AOAM532G3OUgbC2bFeIlqjxl7dZ8S1Z35m7MDpgIHapINctDq+nFQrVp
        /9ogatf9n7VnPFkYLLlg3oLPsQ==
X-Google-Smtp-Source: ABdhPJytD6knxvp6CsJvkJx/IH81yIZHxKnzXf77zdVl/498MQRk/dpFPQ8ZQs0MWHIyvlEj4hDaKg==
X-Received: by 2002:a05:6402:1e88:b0:412:fc6b:f271 with SMTP id f8-20020a0564021e8800b00412fc6bf271mr20657984edf.345.1650908959893;
        Mon, 25 Apr 2022 10:49:19 -0700 (PDT)
Received: from [192.168.0.244] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id z19-20020a1709067e5300b006f39880d8e5sm1205180ejr.78.2022.04.25.10.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 10:49:19 -0700 (PDT)
Message-ID: <ede50fc5-177d-3821-1f47-7297a7a8ebf3@linaro.org>
Date:   Mon, 25 Apr 2022 19:49:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3] dt-bindings: gnss: Rewrite Mediatek bindings in YAML
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220425132947.1311171-1-linus.walleij@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220425132947.1311171-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2022 15:29, Linus Walleij wrote:
> This rewrites the Mediatek GNSS bindings in YAML.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Add the missed gnss-fix-gpios.
> - Move allOf to right before the properties.
> - Keep the description on timepulse-gpios because it documents
>   which pins are used on this chip.
> ChangeLog v1->v2:
> - New patch since Krzysztof pointed out there is really just
>   one more binding to convert, so why not.
> ---
>  .../devicetree/bindings/gnss/mediatek.txt     | 35 -----------
>  .../devicetree/bindings/gnss/mediatek.yaml    | 59 +++++++++++++++++++

Bindings look good, just the filename should be probably more specific,
to match the model... but then who is the vendor? mediatek,pa6h.yaml or
mediatek,globaltop-pa6h.yaml? I sincerely do not know, so:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
