Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E3C4E5496
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 15:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244747AbiCWOxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 10:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237776AbiCWOxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:53:43 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F797E0A8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 07:52:13 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id p189so1098908wmp.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 07:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZrbNTOA94fOoCgNHi9Lle4MXzkybga7qD4nhhAEi0f4=;
        b=uh2ZadXZBrtTM3w9Ozpr4C05o3OzAZgte79gES0hKVEHTwcIeZYZOUF7MyKDzdRIPH
         YnOuBhq6Qllu90TMxXWXKcnQU/X+AlqKiBlymTpDbqlAFgPNhxfAQnLn7l69DyFmAWKb
         1EtyN61XPIWuCny+Ilp7M+eZl+TM4wDK6s/j0vsf37FyEv6vi8lHZs861WTgmg9iuoGF
         FbiSQxGv2OfCbOCL5opVUoVf1S0JgidHTgciYPG55HLvTX8UG91ebFie1qNe1mh+1PAS
         wCUXCYR6FBC8k62aoptRIDMaxi+wR4qQm8jH0nowF1h2O4Vx0ZgB+R9xTx1wG0nwXhA/
         99KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZrbNTOA94fOoCgNHi9Lle4MXzkybga7qD4nhhAEi0f4=;
        b=k5kmRmAf8UIq7QIxOjC0Yt4kyuy5vLg2/CVh9KnOBVSd3LPpdmC7p+EeUUeRcaXxpK
         r/yVvlHLyqnzVLc7ZOgpxLnUiRC4cuCOPIo5uLe8RK6usUqdI7gFtZbr9xUkzUlTFMW3
         XVPyHl2+VY7dnZI3QInoREcM1M8qkcsEq7VOneQPKJ/0LkaX+fxnXQA2gdfwy0lGtW6l
         LI0cuPvvu6soMD3e2Rh2AeAs3Dd91PXT/N9ZiY8UvMxui7/ztVMiRs15zHizNanvqrTv
         FJGAE1OPx7//JmP7OW+UmRXeHSQGXIsMDu60+CfeeNFIMeS6vlSg+Kj2afg4RHJS6cXP
         tfKg==
X-Gm-Message-State: AOAM5319c9cMgiXMf2+d/hsZnbh8WqmDqgydPTbVkum60Wb7I4zqsPNi
        nmTwdj7e6QKJKVE2ffKx4OSOcg==
X-Google-Smtp-Source: ABdhPJy8o7fDNMB74trqiXToyNmO/RhOnk/OJVhTyj0QG979uz6ERNLz62u9KEqogSaw/kVaHmCLVg==
X-Received: by 2002:a1c:f415:0:b0:37f:ab4d:1df2 with SMTP id z21-20020a1cf415000000b0037fab4d1df2mr9531693wma.75.1648047131994;
        Wed, 23 Mar 2022 07:52:11 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id y5-20020a1c4b05000000b0038cbf571334sm116547wma.18.2022.03.23.07.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 07:52:11 -0700 (PDT)
Date:   Wed, 23 Mar 2022 14:52:09 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: syscon: add
 microchip,lan966x-cpu-syscon compatible
Message-ID: <Yjs0GaddtCRWuuxJ@google.com>
References: <20220313003122.19155-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220313003122.19155-1-michael@walle.cc>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Mar 2022, Michael Walle wrote:

> Add the Microchip LAN966x CPU system registers compatible.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
