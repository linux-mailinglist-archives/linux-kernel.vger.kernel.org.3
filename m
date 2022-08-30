Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DEA5A68CB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiH3QwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiH3Qvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:51:43 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072036BD7C
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:51:10 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id w19so9029381ljj.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=SQovu++wBssiNt/lvte+mXBs/8BwZ0B4LH7+PSZ/aBI=;
        b=pDQUfO0iA4NwWBf7tBCl+NqyUMTQt6DvONBAoZAN/ev7Ptj2ncfdCa7LJuyCvMTIVH
         36Rqjj7RK4Ijq2FMZUjMmetbAxhVFy09DRQL7fDawkAshxnJe2HARBsj8IS3HqA1Pe/X
         icKCB3ihu9VWpBlb1CbcXsoYAoslpY6gbIu1eX+XbInAfx8yGl+djB7hzJwmZ9YmoP22
         a82DU7qrSA9n6LyDk9UPxtUUxYrKuRrc16/fEft+d0HSaOTQWtj1/0JWzt0tq+YD1Nhc
         jG/y3jPTxp0WieRyOwWbfoayvZA91WCo21EOg9oBjDOVN23zUMA3t2jcj26v3PPCHj1c
         +WhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=SQovu++wBssiNt/lvte+mXBs/8BwZ0B4LH7+PSZ/aBI=;
        b=g0xMhLpbQWURjIvtUgnEXRp6ccTlGe+e5yO3Ihfx4r0uAgaUWTXC3JtkhZW/CZ3LxE
         ku320z96jUOjIgfzizRbufOa4SPNdFZSUTmFtL9JWHcKmbNn75WcCbcJ/WHysKgRu3mc
         5cS9gKsakmRmdiQjreJ0vBYszBlcV/mZuFgh9WGYwXG5hbjZodjHorxXPp3U0adwbNhw
         17vrYkOiFYYp2F/qS547NhqqFHsYNn8RzDXf4eYL6hIuDQSbNbLmK/I72SJPdT4K++2d
         EWHr3SQ5ac9zEC8+w0Ap24Uww8KDhmaHzxyztx78TCyUotvU3Qt2cmOSeMpEidG7eVkn
         /PBw==
X-Gm-Message-State: ACgBeo05G+CFoDgyqGloIHGFh33iTjQonjf4jA+S8zH2qMEv7/oScMXN
        uNnqdNY9cJibCTbhPAK4stZThg==
X-Google-Smtp-Source: AA6agR6DiHnd7tA+r2Tco/NoVHvEFhgtsIJAcO+GmtCXiYngel/e0wISL+UnywcIYksd4X2Okvpo8Q==
X-Received: by 2002:a05:651c:178d:b0:261:bd23:a5f8 with SMTP id bn13-20020a05651c178d00b00261bd23a5f8mr6817382ljb.411.1661878262406;
        Tue, 30 Aug 2022 09:51:02 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id j9-20020a056512344900b00492f04f300bsm703010lfr.202.2022.08.30.09.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 09:51:00 -0700 (PDT)
Message-ID: <6d558914-2667-9e48-b662-980b9c7ca094@linaro.org>
Date:   Tue, 30 Aug 2022 19:50:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: ti: k3: Sort the am654 board enums
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Tero Kristo <kristo@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220830160507.7726-1-nm@ti.com>
 <20220830160507.7726-2-nm@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220830160507.7726-2-nm@ti.com>
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

On 30/08/2022 19:05, Nishanth Menon wrote:
> Use alphabetical sort to organize the am654 board names.
> 
> Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

It's not a bug, so it should be rather "Suggested-by".

> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  Documentation/devicetree/bindings/arm/ti/k3.yaml | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
