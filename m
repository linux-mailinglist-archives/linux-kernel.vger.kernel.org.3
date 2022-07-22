Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EFA57E648
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 20:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236237AbiGVSKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 14:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbiGVSKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 14:10:43 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3927C37187
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 11:10:42 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id a10so6345776ljj.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 11:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VAU6tgd7nCtwghNmO7f0d3fFyhG1h4AEauJuDoEQdi8=;
        b=wXaQaOec609oVa4eWdHw2f4aaPyceXdJIl2j6WNYR+OCc2863eVHQgVQyqZktje32H
         wPEKJOMgHGK+nT/ixbc9WhBs4EKDKsgAfZgHbHBcsxmBkOQDmdJsnZEZU6qlAKlFxRjA
         5QcpMttI072K3lZmMrpmb93zAOd+h8pn9rTVHLG19QsN0bLH56CgBGP5n/7oNWEVMwel
         96cC5DYd6kn9Op+529gzO/2py153w2NjuS4hTeFdkFP6E1WWro0yZQBKO5QziCCN8PLu
         nhDUQlqW0wqkLN3tc5jVxe64I89F7om+4F+NgpWX1QksNxTZBxUJ1rz3yuS2iIkT3Psx
         ME9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VAU6tgd7nCtwghNmO7f0d3fFyhG1h4AEauJuDoEQdi8=;
        b=NYER7IVtMWk4uq67bWudqUTUzuX/jOFIjgoTAKQ8enS1FHA9/gRAchXxv8uVsYweAV
         xc8sW2gLEE3F7U8t6t0Cd3NuWtr3z3l3pVRHrxbwb8Xy1M+sd4CCL00kqERhPnFI43d+
         K/IVjI6ZdRCLKSknA0roFLYSITwEdZa7h9qs5g6UwWbh46ZvZUnEiqoOUxCpzTbAwv+S
         bpwARiG19z3eL+gp6YVgnObiM5U8Jb0yQbOCNnpEonOK7gKNZkWYIhIgkEDReqJ79vPI
         a419E77G0qRuScou9x98p3U8JJsxGw7xKPs5gRrwjls0HV3UCeNm4e5dp/0qYJ7fLrG6
         xQVA==
X-Gm-Message-State: AJIora+O0JUhTGgJ32HTofzwULZKd8AIuqEoPTHcP/KXHs5tef9k2Fb0
        hHcuFCQc1oHFSVdetIxi5hRImg==
X-Google-Smtp-Source: AGRyM1tib2blqsuZkhwaPPSkLkmTgx7QUcFJmRPVCx1EMFcG2dQ0dbMNuMywjaLtY/YDAYsIIwPJpA==
X-Received: by 2002:a2e:a162:0:b0:25d:9c00:2834 with SMTP id u2-20020a2ea162000000b0025d9c002834mr414805ljl.437.1658513440500;
        Fri, 22 Jul 2022 11:10:40 -0700 (PDT)
Received: from [192.168.10.173] (93.81-167-86.customer.lyse.net. [81.167.86.93])
        by smtp.gmail.com with ESMTPSA id t8-20020a192d48000000b0047f8132d10bsm1168989lft.281.2022.07.22.11.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 11:10:40 -0700 (PDT)
Message-ID: <36b3b0f0-b4fd-c3fe-f16d-0c23778e3c35@linaro.org>
Date:   Fri, 22 Jul 2022 20:10:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] ASoC: dt-bindings: atmel-i2s: Convert to json-schema
Content-Language: en-US
To:     Ryan.Wanner@microchip.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220722152945.2950807-1-Ryan.Wanner@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220722152945.2950807-1-Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/07/2022 17:29, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Convert atmel i2s devicetree binding to json-schema.
> Change file name to match json-schema naming.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
> Note: running dtbs_check will fail unless updated with this patch,
> https://lore.kernel.org/linux-arm-kernel/20220707215812.193008-1-Ryan.Wanner@microchip.com/
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
