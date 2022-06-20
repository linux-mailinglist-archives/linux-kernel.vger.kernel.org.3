Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121965521AB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243821AbiFTP5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243362AbiFTP5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:57:04 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E9E1DA69
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 08:57:03 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id fd6so12984000edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 08:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BLJok6X/XP9rRP7OVZBxo2FoWIuF2yxnMwl8P3cexO4=;
        b=Xt7y5Qe7+Wa7yYibcVvdOfwMtbLwRTN0Zq/M6R55v21ht1WGi/IPChYQ+SvJSe5Brc
         B6UA+MJObyH2Fm+8VXqwNRvg1mfurkHWqw8Xbq8NPqQmqVIqnya1L4ZahflvmPBtyeXD
         VR938s9+lVuSDM/XmiZewPLFp4twSGcwligcvSmIjjVgtuPVp18bhkKjkYllVesSTaZs
         Jp3PInwjuiJ6YQT3OjVPWlrCjvSeG8i4XyiMH2ryEGFTehrTgAEF1eroWKXB3auLr8r4
         rBXbBgtscJ94JK8zvmoHlBJtsNtdaiYDWxMtwmVzVyGytdzcjzV4nZS7ol/DknUXGzjx
         5TxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BLJok6X/XP9rRP7OVZBxo2FoWIuF2yxnMwl8P3cexO4=;
        b=Y0MiArBErhtw/pP3lXEfFF7MOmNp/pNqPqcuroPpA+koOnSnUwJ+N+oLCD5XbxYzFE
         IpziBAqCBIGm7s0LycmijELGEwl2VA9zh6NcIPlPNbNWF7vA6Cdx6zKKMP7USr1fhKx3
         9fRThA9S5aHJLPha4w5dUw6XLFzNH6+8V3GhqhTqv1cXR7HniVc7t3B0Vob87AH6RlIA
         TnYXgM/78DIh2glfhnmtVRJVWns5GDryAzd1/rcujatLDd09zWLnhbhnI4lgTHFXs0rF
         rvIQnM4p1qMqxFAb6i4SlLb7uzOzIubcVhxhnvSR8eXi4X1NA4MtBihrlf0DKpz4qzgO
         NoaA==
X-Gm-Message-State: AJIora/Z5K09dJW+BfjaM1T5tZ5vvxZ5xNhYIDalyWYuWSOrWbRpcamA
        Ml1h+xVhnrRQVZFc8/SQjlUZtA==
X-Google-Smtp-Source: AGRyM1vB4w9kMQvsDMIwngcwm/lZJao/j8ndNodHf3Z/j1CnWv4Tx74ZUtC1ToZcNlh2DUsmeckxOQ==
X-Received: by 2002:a05:6402:5c8:b0:433:545f:a811 with SMTP id n8-20020a05640205c800b00433545fa811mr30285866edx.101.1655740622007;
        Mon, 20 Jun 2022 08:57:02 -0700 (PDT)
Received: from [192.168.0.210] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id e1-20020a056402148100b004357171dcccsm5866342edv.12.2022.06.20.08.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 08:57:01 -0700 (PDT)
Message-ID: <bc3268e1-2a6e-8faf-3d3b-a8841569a42f@linaro.org>
Date:   Mon, 20 Jun 2022 17:57:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/4] dt-bindings: net: broadcom-bluetooth: Add CYW55572 DT
 binding
Content-Language: en-US
To:     Hakan Jansson <hakan.jansson@infineon.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
References: <cover.1655723462.git.hakan.jansson@infineon.com>
 <acd9e85b1ba82875e83ca68ae2aa62d828bfdfa3.1655723462.git.hakan.jansson@infineon.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <acd9e85b1ba82875e83ca68ae2aa62d828bfdfa3.1655723462.git.hakan.jansson@infineon.com>
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

On 20/06/2022 14:01, Hakan Jansson wrote:
> CYW55572 is a Wi-Fi + Bluetooth combo device from Infineon.
> Extend the binding with its DT compatible.
> 
> Signed-off-by: Hakan Jansson <hakan.jansson@infineon.com>
> ---
>  Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
