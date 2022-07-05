Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123AB56761B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 20:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiGESBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 14:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiGESBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 14:01:14 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CED419C11
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 11:01:13 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id t25so21880830lfg.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 11:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0079lLmav/VCCFzPGL1GXPUq4bAgsYoN8nrtlXETWH8=;
        b=KYcHBYys3eLsXJLm/eYQ/ZNS+mx8xvwor3pYgFX5OQk5VLfScF2Zw6XEaC9gwWDo4j
         mcLzHVi9MnfgJtP8ceZceddHpveWbfkaMLYpS4HC7fK/lKAwkrusIckPnJjWcYNzuRRH
         MRLgEoedTLKgS96qcCc2SiauxBsXUtv77fmJ0D7AGCDvTsZkNBBUFJ88uAPlOSXspbxr
         MP/0EmUiIv3PBWAqry8cZQgbCioCpcYbBEKfdmw2tpLp2z6rXdfhNXLHD1RYiTNW4qbq
         7ZpIqoqifj2U6IYgwfFGInm4dTBoPEU4KLS2/tvgtuLy4Em14B3LHV5WWp0O02sKR4o8
         d/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0079lLmav/VCCFzPGL1GXPUq4bAgsYoN8nrtlXETWH8=;
        b=A8j/Lk63UhaXNJs8AAEg8yy0cRnDw1cxYRn1YhDOAxOEIdRH3qnvlqppKftNx3UNEl
         QlVEUN2lsTx7Vt/l0SqN+TeS2nxNQBxY2Bl+yWUG0ae2LfDsRCUs+8avfl+1uJuVu/5m
         SE0YvWtaPH/sqXgl0EDD5yNEUjzir6RfE1N3WkPsouW0+Z0P4fmwSxi3C3WMzcwDedxY
         /c79QoTzyePdNsqKgw4ANecVZItyq0dw7+Emd0/65QLiie95ofkifWt5rGJcFkD7ptrk
         /trv+XCn6pXEbFqK8a6ox/hLYgYTY/OsU2erqo58/SuYUIwugISPQZfbuaJ+d4JwEE0t
         L8nA==
X-Gm-Message-State: AJIora9ZiWHZb467nySfBkUD1wU2azDgwWSTVFkQNEfvAZg8euDw8YUo
        71Wt9191xlMQFIF1lzqSM2DfKw==
X-Google-Smtp-Source: AGRyM1upKilZU4ZKNQrEZdcfM1s7N9ZuleYTw86ANBrPbDZ8QK/h77KQm2CPc3QLLwp33Gl5u1kdjQ==
X-Received: by 2002:a05:6512:260a:b0:47f:ab30:d624 with SMTP id bt10-20020a056512260a00b0047fab30d624mr24227411lfb.326.1657044071745;
        Tue, 05 Jul 2022 11:01:11 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id bi37-20020a05651c232500b0025d3ba76992sm201662ljb.97.2022.07.05.11.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 11:01:10 -0700 (PDT)
Message-ID: <919d53fc-b2c0-bd9e-09fe-d6402ad3af8b@linaro.org>
Date:   Tue, 5 Jul 2022 20:01:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] dt-bindings: sound: Convert atmel CLASSD to json-schema
Content-Language: en-US
To:     Ryan.Wanner@microchip.com, Claudiu.Beznea@microchip.com,
        nicolas.ferre@microchip.com, alexandre.berna@microchip.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220705163046.18409-1-Ryan.Wanner@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220705163046.18409-1-Ryan.Wanner@microchip.com>
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

On 05/07/2022 18:30, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Convert atmel CLASSD devicetree binding to json-schema.
> Change file name to match json-scheme naming.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  .../bindings/sound/atmel,sama5d2-classd.yaml  | 111 ++++++++++++++++++
>  .../bindings/sound/atmel-classd.txt           |  55 ---------
>  2 files changed, 111 insertions(+), 55 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/atmel,sama5d2-classd.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/atmel-classd.txt
> 

All comments from your other patch apply here as well. It's easier to
send them in a patchset...


Best regards,
Krzysztof
