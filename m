Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB97F544699
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240344AbiFIIwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242568AbiFIIur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:50:47 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BFD11462
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 01:50:25 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id o10so30240390edi.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 01:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lxOgUlJyz8a7UYb2M1MBxjNZkRHBfLtu/g8L8My5Mz0=;
        b=uHvfPhheb4CBnufbTCJYyiEXKEJb4FHVu97WqK+OZ99EN+3+lwLY/hnMPEHxqm1vjU
         Je7qViUqfurEOwe564htO7TN4UD/MUxZ0jBRaMZ1gFzpyzVWiKoW2U0pYLnx4iFethuC
         BaskC2CbbuH7PpRgKV3Iwn/g4TfK79/bVNxqLMJKweFVMKOBy3UKRDqwrw2VCfopzuQo
         Xit79lWfe/2kOFDMIC7CMbbu+aHPRTA/Lq7PExIeZOuLf7zwUYYiOlIvrNiGxOZHEE//
         d9Xj9e5Inve8xWME4NcUMYmHj18ro6RiiWyxlCPWuJFp0m+HH09eJ6K52N/hURkJcJ65
         Y9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lxOgUlJyz8a7UYb2M1MBxjNZkRHBfLtu/g8L8My5Mz0=;
        b=35efsMF54kVWDPAr604XEUb/iUuQuMn00vLD6l0J7eKEjt54ObkFhO9SO5EmJod1ak
         J7uvG7ixCtYIpVkDL0911vyNrWFPyWj32XEvSAFuT5Q0riHCzlTwAMxNSajZ0uB/zltZ
         1GO4J5+G41pWfg5QJ/y7BdWhPoPE08Z8+ejgPZl1PyZdIJ+VaHxPWHRaJEpaG/FG52K5
         9sGsZWEAnHtwKEdlVZoFzvu2Rl4oHR7I2ycun0dNRUNI4Dt9ybVaviY+uk778kRggFJ+
         8RvyYN480ibpjRIdSXAqhi6r9y7+zDqfEXi8KhcLaZ8fK7sXKKt//KWZBz+Z+5fLmyIB
         0L3A==
X-Gm-Message-State: AOAM533TeMin7OX2t2/2+uW0j/ucQuc7x6TMfV3YxSMO6wu9Nayr0Xa0
        vimVPVRgdCyoaw3cyyMJ0J4cyA==
X-Google-Smtp-Source: ABdhPJxopZoI5H9UIi9hA0nAtC2Lsd7tS3S03ZDv5nUh3GJjBFK2zTrrgHW1da594jw7949GsRgytA==
X-Received: by 2002:a05:6402:1f83:b0:42d:8d6f:a5d4 with SMTP id c3-20020a0564021f8300b0042d8d6fa5d4mr44413558edc.74.1654764624093;
        Thu, 09 Jun 2022 01:50:24 -0700 (PDT)
Received: from [192.168.0.195] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id jt2-20020a170906dfc200b006f4cb79d9a8sm10311094ejc.75.2022.06.09.01.50.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 01:50:22 -0700 (PDT)
Message-ID: <c86be8e0-8350-5d73-8055-e04a4e88f3b6@linaro.org>
Date:   Thu, 9 Jun 2022 10:50:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/7] dt-bindings: vendor-prefixes: document several
 vendors for Aspeed BMC boards
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Lee <steven_lee@aspeedtech.com>,
        Ken Chen <chen.kenyy@inventec.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     David Wang <David_Wang6097@jabil.com>
References: <20220529104928.79636-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220529104928.79636-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/2022 12:49, Krzysztof Kozlowski wrote:
> Add vendor prefixes for manufacturers of Aspeed SoC based BMC boards:
> ASrock, ByteDance, Ingrasys, Inventec and Quanta.  Move also bticino to
> proper alphabetical place.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Joel, Andrew,

Any comments on this patchset? Are you going to pick it up? If you
prefer me taking it, I can, but new boards depend on the bindings, so
this should rather go via your tree.

Best regards,
Krzysztof
