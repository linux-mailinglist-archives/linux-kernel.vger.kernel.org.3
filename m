Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F2E4F877C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 20:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347035AbiDGS4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 14:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbiDGS43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 14:56:29 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C29A264
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 11:54:25 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id p15so12765744ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 11:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=P5t7OevoqfgFjRrAxyC45i6wviQtAlsVjUBZbWy7gH4=;
        b=KL/jdqB/8wdHm4tVl+cty3roBUjEw3Xvp55KEqJIMDyghPTHAE0/0T73Vd1qsKJxin
         5+YJC8KR/eytHSAoJ6LIrG5Di+EIl7xOGc9zdSUw+zGv0Wi41TCRv/qpA2nov2p8/yCt
         XATM2jxZJLIAX/CKfNSEoGfFNp+SIFMAWP+sezxJUrUgekOvp1DIIeP+HAZ01uC2tR0O
         2J3yaYFjUv/mbjagVfCubLMLtnPEpZV9JNecY+kqDzwvHBnx0MH6dko+rasZiCf6GnjY
         5y1AC2uDPaL3nLiPAPLc1doKpIV2oTGzQgXJKd6nxUwl05S7APxhLtM7MhcuDJph+mSu
         akfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=P5t7OevoqfgFjRrAxyC45i6wviQtAlsVjUBZbWy7gH4=;
        b=TIMqxy+YBjeMK1QyRv4zZALepRRW2vjOKmpuVDbmTGDnkvgG6KvQ85uQ+Sde756rpt
         Fhykg2oyhvl0uMVjYvqWwwjIDrZ+im7jr0OzTWZUSBFTIBLL7WfB024UzZKcuPXUAgkH
         abBaPA+ytwg7Uo0KX2kWR4UYuNnT66a34ee0aLaKnXuIFPa9QuiTQl0uPxFQku1+J1KP
         FL1NMSx87z4M3l5lqrbCGvF70Mi/ZHmDwnYoM5jvBY7IxfcJZg0o8tW0DpoGF9Fl40g3
         +HVdyA4F3PRLSWBTJxA/RsOg7ULwQre3lkWSXinhq+Sp2Og4XgGPab6CBDeJAdvbwbDn
         iULQ==
X-Gm-Message-State: AOAM532SKZV0LYGb/sWqSSDUvhjC9Q935c4mUd+JvAPT1e/Zds7aDeTm
        D4+AIp5lNl8a7AF62Qx4SHjCsQ==
X-Google-Smtp-Source: ABdhPJycXKO2QYwQvSX8Ts92BaP32pn1JJgkuHfAY4U1V8JbdPo1sOdSx8Jvd+rm4dqfMoRhPVwlig==
X-Received: by 2002:a17:907:3e22:b0:6e7:d37:204e with SMTP id hp34-20020a1709073e2200b006e70d37204emr14870135ejc.375.1649357664158;
        Thu, 07 Apr 2022 11:54:24 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id x9-20020a05640226c900b0041d015bb8a5sm1380703edd.26.2022.04.07.11.54.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 11:54:23 -0700 (PDT)
Message-ID: <a2f89f06-f586-2bf3-fbfa-f0fd1b6ad057@linaro.org>
Date:   Thu, 7 Apr 2022 20:54:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 01/11] dt-bindings: arm: add Pensando boards
Content-Language: en-US
To:     Brad Larson <brad@pensando.io>,
        linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        dac2@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220406233648.21644-1-brad@pensando.io>
 <20220406233648.21644-2-brad@pensando.io>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220406233648.21644-2-brad@pensando.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2022 01:36, Brad Larson wrote:
> Document the compatible for Pensando Elba SoC boards.
> 
> Signed-off-by: Brad Larson <brad@pensando.io>
> ---
> Change from V3:
> - Add description and board compatible
> 
>  .../bindings/arm/pensando,elba.yaml           | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/pensando,elba.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/pensando,elba.yaml b/Documentation/devicetree/bindings/arm/pensando,elba.yaml

It seems you ignored to Cc devicetree binding maintainers for all your
devicetree bindings patches.

Please rebase on a recent kernel tree and use scripts/get_maintainers.pl
to get list of people to Cc. Your tree could not have my address, but
why Rob is missing is a surprise...

Best regards,
Krzysztof
