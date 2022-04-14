Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3575006E2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 09:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240325AbiDNHbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 03:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiDNHbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 03:31:51 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55629EAE
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 00:29:26 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id s18so8456812ejr.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 00:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KKeeqSbZ1oG7uLXWWh5cEBw2putwB1PZbZtwfxmKlRY=;
        b=WwCMUxOHDNITSrM4BtYsppqYJitSKLXUjG0tKAyUFTpDQOJLA2Zskz6nZjEtOnTTC9
         VKaq1pNmfPQEuCU3uYoKyuE3biSXM8n/4B0z3BWwDBY2y8/Ms0klBpQaOSb4fGk/DkFD
         l2H9YStwK5i0QhaP0X7wxPC9T+P6FdrbV4dCpudOai9BquaWrBgHKgCRTjjDY+R+oEnj
         hawZRhFYjEFpj0zh14M2zreTBmmrd3zAGAAi1G9FhT/dNcoYhlzZWNA3rwECZxBUD76e
         NkYMvLKxkbe+ydfOYzZyOZK/4UKLNu7e38X1rTLha8609qCKSscd2hWd3yXdWWGvwY7o
         wMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KKeeqSbZ1oG7uLXWWh5cEBw2putwB1PZbZtwfxmKlRY=;
        b=OKYLV7y9/6mem6L+5FZsWoVcxmuVuPLEkvsJGNRfkQj8KZa6BqPZO8K1mebR5Bnzqt
         uJ3VWSBj/jgSbbmckdKuVW1cZsFD1ohYuBeyk0saZYFaT2fmiaaeI1Df1fBQdO7eBIEI
         JofJ4V5kTXuRWHCSuDX1T/NFtgYTrjpluj862OBHEghLBaNtSzbFX2cpmctCGMqHwN3Q
         N3BsxkVzYD6/dEiWjrhyVBvRPf4D5TXU+wl9HYckI/QmghbR2c96aKG+08xMqlotyf16
         YQZ0/X/yXFW1o7XNCDQD4WIrwOoHW01AArZy4b54AyW2ZDEk4TZ3k5y2SDFOeHeiPq/Y
         pJlg==
X-Gm-Message-State: AOAM533IR57/iCR7vZf44Ml2LHlAa9J1l/cdOIwe3hyVegy1vb+5coor
        mGjRcsnN4eYWBSgzjsqEYgZGEA==
X-Google-Smtp-Source: ABdhPJxdySU7DfnX49+B4GSgP8fXrJc8+Zb8llYk8og/A6s4E242Mjbgk24wfgWY7MLFL2B1P/e7QQ==
X-Received: by 2002:a17:906:1798:b0:6e8:94b3:456d with SMTP id t24-20020a170906179800b006e894b3456dmr1192516eje.307.1649921364913;
        Thu, 14 Apr 2022 00:29:24 -0700 (PDT)
Received: from [192.168.0.209] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id 25-20020a170906311900b006e87e5dd529sm369242ejx.70.2022.04.14.00.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 00:29:24 -0700 (PDT)
Message-ID: <0de21e5a-f169-2830-2a8b-e92c2d309260@linaro.org>
Date:   Thu, 14 Apr 2022 09:29:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/5] dt-bindings: arm: add bcmbca device tree binding
 document
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        Joel Peshkin <joel.peshkin@broadcom.com>,
        Anand Gore <anand.gore@broadcom.com>,
        Dan Beygelman <dan.beygelman@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220413192645.7067-1-william.zhang@broadcom.com>
 <20220413192645.7067-2-william.zhang@broadcom.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220413192645.7067-2-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2022 21:26, William Zhang wrote:
> Add arch bcmbca device tree binding document for Broadcom ARM based
> broadband SoC chipsets. In this change, only BCM47622 is added. Other
> chipsets will be added in the future.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>

I gave you here an ack. What happened?


Best regards,
Krzysztof
