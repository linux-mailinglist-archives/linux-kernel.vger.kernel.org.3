Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AB54D042D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 17:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244202AbiCGQbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 11:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244197AbiCGQa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:30:57 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDCC6E547
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 08:30:02 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 93A313F223
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 16:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646670600;
        bh=lYugkCjRW/OhfdxdR0LUXG4Uici1AcMBOSNAUfInjq4=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=j0h9thi9bu7i4JVxBZC7Dbynuh6U/moFcDhj9kR7D4hqS9/bCvZopzsew8qkvFyV1
         X0EQi6eUzsAEeJlWDNUBRT2tRuT5VD4LXBQPgTiN/GqabXMPylIhf/So8PtADeiC74
         mP+luJ7GPLdseIe8jYEXvCSuTb1uTbdJ7eFupxAk6Eysz2tWd6r8LkcKOWbxGpGoA4
         /DVvU8QjqWskAIfen6Msax8fs4mswwA28EupgGb/4Dwgb67frk5EADuxmfsP7OyotL
         g1rblACA6wgrFSEo5J6Z/Fdz0pM5c9ca2alRVNs1lutzCUjbHjiTE0Mu9Pn80MQ9Uj
         ijc16RWlgayIw==
Received: by mail-ed1-f70.google.com with SMTP id x5-20020a50ba85000000b004161d68ace6so3821262ede.15
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 08:30:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lYugkCjRW/OhfdxdR0LUXG4Uici1AcMBOSNAUfInjq4=;
        b=MWfk88l3H+TMKVX+NDH5p3dreDd8+ziD1DZQONl7F4JzzvNtYCc0tfd8ZBm74rx2MU
         PYZ3dmSp4ZRc6jhhMZeRe1AWAk7fgqOcDN/NbJYNvqGb1NRAd9oaXjjZ6MHi281K3aAr
         375wArY4oT45NJ+8DqX0lEqGrMGnuKqKM/1znX1T4UDyZTJTdU8ZSNX2/7JUXpKt0DmS
         O/tSaLpP471gPDtx0OW3jHdxEYshTZP7v+cPQ1sOTa11heRAG26j4iutLcKXt81feJBE
         Bttq/ZqdrgEdUEtTJOxhgC0Xgj4FDWDcK4JwWNhjsbazHg0l7W9jGX4VD6Go9gI4dxfK
         /mXw==
X-Gm-Message-State: AOAM533yZwZVNNGISyObJEUUhsTZoBWcwbDTaX5JBDWWFJgOX74/Djb1
        Cw8QyvTye1gzkKzcvp/mHnHvvbV9Kop6o/MgZ1R7+PripnGjF+YLvQhe+jJAunW/8qwJHEL2Xdx
        BAINoX+tfTuik0DGYga4xQ9DLb0rbPbFra3H+uvI0dw==
X-Received: by 2002:a50:9505:0:b0:416:4496:5ec4 with SMTP id u5-20020a509505000000b0041644965ec4mr6259998eda.309.1646670600296;
        Mon, 07 Mar 2022 08:30:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzgIDIfs4Uv+2hCWR8xkLdqKgfR0rTZ1uyE2m99wgR5h8pk++5/Mn+yekJDhNMAqpMU4JEJbA==
X-Received: by 2002:a50:9505:0:b0:416:4496:5ec4 with SMTP id u5-20020a509505000000b0041644965ec4mr6259981eda.309.1646670600102;
        Mon, 07 Mar 2022 08:30:00 -0800 (PST)
Received: from [192.168.0.142] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id dz10-20020a0564021d4a00b0041665989a9csm148646edb.41.2022.03.07.08.29.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 08:29:59 -0800 (PST)
Message-ID: <c2d56288-a134-21a4-75f3-d25b050da6a0@canonical.com>
Date:   Mon, 7 Mar 2022 17:29:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/2] dt-bindings: pwm: convert atmel pwm to json-schema
Content-Language: en-US
To:     Sergiu Moga <sergiu.moga@microchip.com>,
        claudiu.beznea@microchip.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        robh+dt@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220307153656.177589-1-sergiu.moga@microchip.com>
 <20220307153656.177589-2-sergiu.moga@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220307153656.177589-2-sergiu.moga@microchip.com>
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

On 07/03/2022 16:36, Sergiu Moga wrote:
> Convert PWM binding for Atmel/Microchip SoCs to Device Tree Schema
> format.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> ---
>  .../bindings/pwm/atmel,at91sam-pwm.yaml       | 42 +++++++++++++++++++
>  .../devicetree/bindings/pwm/atmel-pwm.txt     | 35 ----------------
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 43 insertions(+), 36 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pwm/atmel-pwm.txt
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
