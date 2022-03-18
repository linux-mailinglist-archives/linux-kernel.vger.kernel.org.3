Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8834DD719
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 10:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbiCRJa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 05:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbiCRJaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 05:30:55 -0400
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC87B2E711A;
        Fri, 18 Mar 2022 02:29:36 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id s25so10561376lji.5;
        Fri, 18 Mar 2022 02:29:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=JP93varl936CcJKPvOokM9x60gJyGqTR3tO80wLaHjw=;
        b=4UBa1MrpF8UwC5WtEaG6fD9l0Phh7BpqHnPoVMYOk9aY7aKqvTQyFJlDVXOv1RyNsZ
         D18ZBUD2Iok1S0GrK9VRAQT4IO4JiUyqkflFF1qac8XPRauSQvXhKco4Jb4lDMwgVAUv
         35HnAruN+6VHzKxmfQqmzVgJwvC2CJ+iYslUqpfYnIt0DefrY6XMscpXJ/Ickc3dyCa5
         YyoFKngWM4rcLJVbOL0penBUsnjOSiKl5flNn/YZ6pDqRCj1DUVPatH9NaIzYQ00SgIl
         if2hgi+lMpZkVMwMNA8aTTI2C0oiLiWxqVh0OMN5XqM45eJS8sjOZq8OxmxAOBIYLyeZ
         HvpA==
X-Gm-Message-State: AOAM533aHIPUWHexFsdjXXb3yNIvPml3Cvqq1AnL0lTt7cO7vIih/o6j
        5Qu3fsvuVrPcDY8laOtdeMJrjFKpxis=
X-Google-Smtp-Source: ABdhPJyaySK0Yd0ffwNBswotDY0OD7OmAPS5rPZTeAOVNJFz6BnUFdl7UNzmHkXBWyCnx7iHjJuaDw==
X-Received: by 2002:a2e:9cd:0:b0:244:d41d:69ef with SMTP id 196-20020a2e09cd000000b00244d41d69efmr5402375ljj.386.1647595774992;
        Fri, 18 Mar 2022 02:29:34 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id a6-20020ac25046000000b004477c9fad7asm766637lfm.115.2022.03.18.02.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 02:29:34 -0700 (PDT)
Message-ID: <d1fab3e6-a9ee-0d3e-9d4b-d082317d8b72@kernel.org>
Date:   Fri, 18 Mar 2022 10:29:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 4/5 v2] dt-bindings: gnss: Add two more chips
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220317225844.1262643-1-linus.walleij@linaro.org>
 <20220317225844.1262643-4-linus.walleij@linaro.org>
In-Reply-To: <20220317225844.1262643-4-linus.walleij@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/2022 23:58, Linus Walleij wrote:
> The CSR GSD4t is a CSR product using the SiRFstarIV core, and
> the CSR CSRG05TA03-ICJE-R is a CSR product using the SiRFstarV
> core.
> 
> These chips have a SRESETN line that can be pulled low to hard
> reset the chip and in some designs this is connected to a GPIO,
> so add this as an optional property.
> 
> Update the example with a reset line so users see that it need
> to be tagged as active low.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Add maxItems: 1 to the reset-gpios
> ---
>  Documentation/devicetree/bindings/gnss/sirfstar.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>


Best regards,
Krzysztof
