Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69821511D3C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242474AbiD0QN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242256AbiD0QMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:12:03 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18953ECC92
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:08:23 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id p18so2497830edr.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=EH19v7uRS5y35PzgKTDX53x9j+gtyqhUDRdsKb/IaUM=;
        b=ybse66WgmNsBI29z+NNV6x8EFLgtMxe6qFw8I8vTnLFgoYkWXlVyNDekvdljpmae8Q
         dWx62rAf7xRwXPxV2X1FxO0/4/DGvPc3zYbb7OBAkhzjuut4c1v1tt7ty/2dghm+TWlj
         YvTykt8HW80i/plhDgwxbKz2P3lgZwGSamHjUBUgkqlc8X/LxHQQf0tzR7dKt8P8/VNs
         YSLddjait6XwavUyJTWWmCHCZKqdJQ9hl3Lc5bizgtcR9SM/6pV82NuKUZurRSj2xVa+
         rUNNtTz4LyQdK8OVzomJzlLjGro0iItms1bu/vXzchVgW0jMPG/NVM0TqpQKodPoJCZM
         yeAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EH19v7uRS5y35PzgKTDX53x9j+gtyqhUDRdsKb/IaUM=;
        b=jy5gMYIafcghDfFTqCBQP2THgZdTlOUflYttWc3nfTDkYKDmVN/SrDxqToTA+LfQ+8
         etPu6Wtj99HQMAWuAfHOAjvwl74OK3c0/5kzbv8/zn0yMoXWkU+/N/gI3MXxw1+44IwW
         jblQqFz5wF1eUkotJ2KRsqHFD7+4ju04yObFVmK0bzAgBNUUZf3k3lxyEFkjMF3S67Ej
         4K7Vc5/uJLHi6l3fbWp8cxqVYgoTei/JB5BO4Cir6MbqUXkMRaXP/f8X6YM6vuEhE8cE
         xDxhjhIrCRiAYxThmYekbEo91StPL/jDgmiuDIWqs1w84uY5Wu+FWuVnr3wgl74dCRnX
         V/rw==
X-Gm-Message-State: AOAM533s/bAc750Aqj72s7dGwV8Tg5oFSISTuSfXs4+931t+J+zYqA+c
        nOA76vZ0eDljIfjbS7mJKQKbXg/H3Kstxw==
X-Google-Smtp-Source: ABdhPJx/S8bwtVp+agXtCpxr/09KbDVlmln3NcFIhrjgot+hU0xUEJktlvNVH4ZgcBbXYGegOatVTQ==
X-Received: by 2002:a05:6402:400b:b0:425:f59a:c221 with SMTP id d11-20020a056402400b00b00425f59ac221mr13269412eda.307.1651075652996;
        Wed, 27 Apr 2022 09:07:32 -0700 (PDT)
Received: from [192.168.0.155] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id e17-20020a170906505100b006f3beab8af8sm2074452ejk.204.2022.04.27.09.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 09:07:32 -0700 (PDT)
Message-ID: <a8472edd-388c-7bcf-de6a-9924dee6f959@linaro.org>
Date:   Wed, 27 Apr 2022 18:07:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 00/0x] dmaengine/ARM: use proper 'dma-channels/requests'
 properties
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220427160538.646044-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220427160538.646044-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2022 18:05, Krzysztof Kozlowski wrote:
> Hi,
> 
> The core DT schema defines generic 'dma-channels' and 'dma-requests'
> properties, so in preparation to moving bindings to DT schema, convert
> existing users of '#dma-channels' and '#dma-requests' to the generic
> variant.
> 
> Not tested on hardware.

Sorry for the mess, but I missed here one patch.

I will resend.

Best regards,
Krzysztof
