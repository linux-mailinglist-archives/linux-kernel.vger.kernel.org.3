Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E92D52EE32
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350302AbiETOcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbiETOcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 10:32:03 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A225AA54
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:32:02 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id p22so14613808lfo.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1e7jPwf06MLjtjAbeVKFlQLZUr5i8ZHbG6ieKA2ys74=;
        b=XEhgzB6MEKIt6YkGR1w9vLtnIuqx+E9V2ESEiuifE78bW1YsyqxYb8t/xME8Z7oU6P
         7GiXbUGcbPvRqylUmYF0Zx+rMKFzG6q9TkyhOrq/M/ccSr8oHrWjrx9ag9eCAhFTulsY
         nAC8BaCXq1SPB4KxZr917mZ6UkkcokMFZW41ndV46sBYQkmW8UzVgorVzyVOY6XCKzpQ
         PvF3xCxRqo5XsdPsBdkzvdSWMBVLSyqRb0h24sOnKI15Q1j7jdVjJTIzDt1gM7uwqvTB
         6jJx76Ef7vuP2gqgUyFtkf+2CyWQsKe5tdLvip6EkZqjrWb1DFBGbkQnxHrO+S40TSJ4
         w6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1e7jPwf06MLjtjAbeVKFlQLZUr5i8ZHbG6ieKA2ys74=;
        b=vkmiQfe+LguPJWCBJ35NGIzU3gvnVlPdU+D0ql+ivBKEtGNhrnLVt2HL1U0ZFbVTzK
         uIfJfEEZvqmZycIEm+Jl8YYoX1IoAnHhf8zRbgLoQLtP5DyE159HB2p5icXytlcXcahb
         9JPnApuQ63A4dWHMapUNktBPWCuIN2MMMiJEAV7P7lSaU43jinWDWeWbiQn4OPCvF6OI
         bFdFlemO0ZtfABtkkWQxpu0sQccv8pWU3H1pMeoL9cv1y8sdgTroLAu3bMqAt/vgrDpD
         LAcTqMX6YGUq/k3XTKCkJ8lC5GgsJmvPeiCX6HwJLA+Sg8m4Y5D06rJhw7C2FWRuPrKd
         Y49g==
X-Gm-Message-State: AOAM5338+ktjkVkmvb3M95HHUZmFt3hEdS4/axC719EOTIapNvoarlEz
        Fi92ZxW07JwpZPI8FJxKwiXLQ1ZYMXrx9/6c
X-Google-Smtp-Source: ABdhPJz2AkXMPrdhC1usxVcp2s2G46txCDMyED1xk9dOv7Bzy2Rf5n4syvkdiHMeIcrdONGwL6ovSw==
X-Received: by 2002:a05:6512:6c2:b0:46b:9578:7c63 with SMTP id u2-20020a05651206c200b0046b95787c63mr7549195lff.204.1653057120425;
        Fri, 20 May 2022 07:32:00 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o5-20020a2e9445000000b00253da399907sm333712ljh.114.2022.05.20.07.31.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 07:31:59 -0700 (PDT)
Message-ID: <cbdf5ce8-13ff-e80c-34bc-2c68d3e3d4f8@linaro.org>
Date:   Fri, 20 May 2022 16:31:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] ARM: dts: aspeed: Adding Jabil Rubypass BMC
Content-Language: en-US
To:     David Wang <David_Wang6097@jabil.com>,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
Cc:     edward_chen@jabil.com
References: <20220520115148.3589628-1-David_Wang6097@jabil.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220520115148.3589628-1-David_Wang6097@jabil.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2022 13:51, David Wang wrote:
> The initial introduction of the jabil server with AST2600 BMC SoC.
> 
> Signed-off-by: David Wang <David_Wang6097@jabil.com>

Why do you send a v2 second time?

Please include always changelogs under '---'.

Best regards,
Krzysztof
