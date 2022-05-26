Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C93534B21
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 10:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344035AbiEZIEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 04:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346630AbiEZID6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 04:03:58 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41ABEAFB12
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 01:03:44 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id d22so871489edj.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 01:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=H3qZQPfYcQDrwNThr/nx2Fw+OZKl6viapx6qaBl2hyE=;
        b=L7pdE4ktFCgPkL6z1znNqAG/ruCdJP7IOel1dMAAo0G1ULESc1wjkxFZCUDpeH4whA
         M4PPaPEWh4AQeuuVmmu0C8DyA2QAUXKPjolhcwMBvBKe9zD46w8rwRhS/7akONDcmJCh
         zwQf4JptN9e/hx3XKBvBK0FQBEEUm2ezXiUVZL6z0eElfVC6rGr84rtmUYP2vq8JEL1u
         PPfP8EzBDWD13nPscbhQ6d2lLLtwz1lMjj8YPifJSt4tLaw71g96+8wXv5aXpWh8gWSj
         2g8V8x765FQD+8SqnaJh6amzLTzz61rPO2QED26y7twwoRdiWPMz0f8zBUCkiEw5UGSM
         75KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=H3qZQPfYcQDrwNThr/nx2Fw+OZKl6viapx6qaBl2hyE=;
        b=YehM4QhpiqnitnfqXkkHa5g2T9z0AruvuzIGLS6+lJ73tFxM9IX2IZVpPTvNW16Uco
         qvbvCO7f2uuQ2lnnMICl45cD9hM8CdE/y+iZq2suYvrcbaKCxHTrQmpPxAfoJ16z8NIR
         1JWMVbSkvBT9XTJ6XNdOFxc71gM7F5OueaG6Sgr4z9ZYYsxhfFbicUjKrB/itzFADLDB
         E9GRvMxGCDvxxP3V0RvsqZbTQB402dI08blBvKfglNh2oZednyrMtg8y1rP9slHbFj0v
         MENgSmrUFGIoMZWSBZW3IIm/SoJ3yJ+Yl0oL077JevFXzJLmIxy3Fe++m6ZqifmJhxPL
         lS/Q==
X-Gm-Message-State: AOAM533aW+2HsDVJFUU2HYpXvI9TQTfVrEaMDOEzXZLYo6bB5OH7HgWj
        8FbJXxIjVJk3U2p3pUdiZ2z3Mg==
X-Google-Smtp-Source: ABdhPJwvYIk5z43IfyJP8m+KqMTnieC9EUg4SCQn7QvsiUsnhp9SGjZYLVstYiEf0QOqKiCQCTZyXg==
X-Received: by 2002:aa7:d851:0:b0:42b:d6f4:bc0e with SMTP id f17-20020aa7d851000000b0042bd6f4bc0emr2933642eds.21.1653552222720;
        Thu, 26 May 2022 01:03:42 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gx27-20020a1709068a5b00b006f3ef214e12sm276736ejc.120.2022.05.26.01.03.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 01:03:42 -0700 (PDT)
Message-ID: <93156c4a-c409-4da5-9960-0443cd64ca70@linaro.org>
Date:   Thu, 26 May 2022 10:03:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] arm64: dts: ls-10xx: use generic dma node name
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, shawnguo@kernel.org,
        leoyang.li@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
References: <20220526035449.4062846-1-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220526035449.4062846-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/2022 05:54, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> dma-controller is preferred for dma node.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
