Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507534D5E3F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347383AbiCKJUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 04:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347374AbiCKJUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:20:46 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F3A1BD04B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:19:44 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0C4B33F338
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 09:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646990383;
        bh=Av5kn9IVqiEMwOUuim1I4aokjkuB5Y7LLwWdVqqCtTY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=usMld3WJmmoljeuQyPGnz8rFhm14g5H+hEMo0fF1jnNi0rsN3TK5gc+I7Mro0ohN8
         7jeFd8kDgRXWpVtT8nq55F6WJ8wFsiV1GLiui+NPT3CPWl54gg3+CI7FGc6/PyUZFR
         PbvLHEEWOxg+OFo84C+sdfDHXRCIkTJoOrz+3r2ZoGws1ArRxpS3G//jbiyVD6zRAY
         BVg4bgi8qZEq492wE5E+YC9pQDVrUw/xajPEMiTTLixLaNK2dp43V+HrocBhekD1Im
         QLJQIP8+S9aWLDvaamFdHvNZIx0MSYeodWjJZlt2kPEYHLPjYPnQPY/57I3soQDIFj
         dSS8emon/ZTYg==
Received: by mail-ej1-f72.google.com with SMTP id r18-20020a17090609d200b006a6e943d09eso4596538eje.20
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:19:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Av5kn9IVqiEMwOUuim1I4aokjkuB5Y7LLwWdVqqCtTY=;
        b=P9/LFO8+W3yzd3Yytk1TXPi+9QVb0viAfLILknuxB7uZ4EjN3yMkHqHS2gc8qE+nCJ
         b5VJgcL/48v2O8mW3nFKeM7docoAlvnVE0YidvRxciBJ7Vy4dmboX/hivtmJbOmSkUoL
         BRX9eTdtBMkdoBxn1fy6kdRTBvfLw30WEiecLaAKe1PdNwp7fq10JiTn2s+30LwWdjUT
         jYFY7bKvKDHlCF/LnNEbQjkmTWxyb+MUgGIkk0fA3KrrfHe5jMAEw5tjKYRNb26WcR4f
         fWyG0/YofrlK0kEBJH9slw5uGgYMxrp+ykdHiAr1YISXn2fcryZjRYHY2j0OkBQ5KXj6
         IFYg==
X-Gm-Message-State: AOAM531a3TTjUsJO01Q+4V5eQNK3gKKu7kjJ+odAHIK1FFxMxXXKEoUp
        e9mrIu98lFBRNNWCWBr+m7G74XBl8lPc767nm/LRM/xjWESxciBmshkCsdVV5VktY7NDF/salTZ
        OYfx74TEe/kRIxT9SydnT0jYBNPoXOB95cXv1KsBOlw==
X-Received: by 2002:a17:906:7952:b0:6da:94c9:cccb with SMTP id l18-20020a170906795200b006da94c9cccbmr7637833ejo.469.1646990382314;
        Fri, 11 Mar 2022 01:19:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRKm1a5/uP3YrjyiVawWXoAkJeYr2NNxwI/Wq9OKmU1+1AG8kKCcxyamOntOnZjVkmmrvOxg==
X-Received: by 2002:a17:906:7952:b0:6da:94c9:cccb with SMTP id l18-20020a170906795200b006da94c9cccbmr7637825ejo.469.1646990382159;
        Fri, 11 Mar 2022 01:19:42 -0800 (PST)
Received: from [192.168.0.148] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id cf17-20020a170906b2d100b006daa59af421sm2741808ejb.149.2022.03.11.01.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 01:19:41 -0800 (PST)
Message-ID: <b0489963-4ddb-ec7f-ef0d-e48f99004be5@canonical.com>
Date:   Fri, 11 Mar 2022 10:19:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 0/3]sgpio:nuvoton:add support for Nuvoton NPCM SoCs
Content-Language: en-US
To:     jimliu2 <jim.t90615@gmail.com>, JJLIU0@nuvoton.com,
        KWLIU@nuvoton.com, linus.walleij@linaro.org, brgl@bgdev.pl,
        robh+dt@kernel.org, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, CTCCHIEN@nuvoton.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
References: <20220311060936.10663-1-JJLIU0@nuvoton.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220311060936.10663-1-JJLIU0@nuvoton.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/2022 07:09, jimliu2 wrote:
> Add sgpio feature for Nuvoton NPCM SoCs
> 

1. Explain what is SGPIO.
2. Fix all subjects to match subsystems.
3. Check git log to see what subjects are being used and how they are
formatted.

> jimliu2 (3):
>   dts: add Nuvoton sgpio feature
>   dt-bindings: support Nuvoton sgpio
>   gpio:gpio-npcm-sgpio: Add Nuvoton sgpio driver

Space missing after ':'.

> 
>  .../bindings/gpio/nuvoton,sgpio.yaml          |  78 +++
>  arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi |  30 +
>  drivers/gpio/Kconfig                          |  12 +
>  drivers/gpio/Makefile                         |   1 +
>  drivers/gpio/gpio-npcm-sgpio.c                | 634 ++++++++++++++++++
>  5 files changed, 755 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
>  create mode 100644 drivers/gpio/gpio-npcm-sgpio.c
> 


Best regards,
Krzysztof
