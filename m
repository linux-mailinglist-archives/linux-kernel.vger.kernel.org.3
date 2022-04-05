Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EC64F50AE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1842977AbiDFBfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343881AbiDEM47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 08:56:59 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4604F6BDF0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 04:59:40 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id p15so26158320ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 04:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oKfl96ffJzP0jk2BGX9X8+oVaB0Jilri5i9RHEz+bkk=;
        b=bVV5ndjxBJSAES/HgU+ux2AI7Bty9KrqQwHtYKeW9eSIQv4Po2YJsQHgLPohipx8IP
         PxRvdXLmsyIPVjT9j4Tc5Yhxic4T/Eja6UcPn/nQcTeR2sqwT2wwtKPdYinJD9KpPznu
         zCTrlPZc0fsA263zJHGypILi1/yZ5y0WzBYeTNtNggQ3nEkCAPcxxCxVv5u6a9a58Rkn
         pzDpJHUhJ6nirgZljWXvZYVvZD3eBtaK2lihlc9+NR4rKdxtDH1QAXNBC9VEKEKYrdSQ
         8/RMef6ffPxTX3CBb9hBjgZkYMuXNHdWx640l+5/ar95azlmk9Puv8QtSjUjoYWo4mB8
         hDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oKfl96ffJzP0jk2BGX9X8+oVaB0Jilri5i9RHEz+bkk=;
        b=m22ucuTRnF3JCJscFMy8eNP1By+1x/UD3nJQxds20SDgPXs3V7blmQ/Ho6+YygRnaK
         Zo4utQt7aU4WgAzdp/5NeQXxWA6dggcPWGs7jJ4G+9Nwbj1sxptVzjxT2mIJMQURU6lf
         4BXowyeABPAjCDOKUKDVLfKANgSLC8lViSHL79IakKElTDXUjtelKhaIGbwgC1L/F7Sx
         4W22tKZAJSYnkf9x8FEzMZVVe4ujtY8Ffa1s2MmLtLaAIZnev4Ed+sAeXMQ49Cn/kX7j
         lgXjdVD+QYbrgCwLOvtviZxBJ/bWRD06wx9xdHh9TrD4Y6pYASShvQ7IWNxr2si23grI
         crDA==
X-Gm-Message-State: AOAM5319v5WarX+gVZy0ucJZz8cvc1ec1n3MYqyIOJKH0XAD5YB+7RUT
        0ds54fNdVJ7Y8G8uQaS0INnjrw==
X-Google-Smtp-Source: ABdhPJzMcNUjaa3bb1bVgn7DmGJkg+zPMPP6CGc9NuQO6JPcTcmni3gRSsg5r+DqqBrN5dw/F5Rurg==
X-Received: by 2002:a17:907:6d9b:b0:6db:8eab:94e0 with SMTP id sb27-20020a1709076d9b00b006db8eab94e0mr3116827ejc.687.1649159978936;
        Tue, 05 Apr 2022 04:59:38 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id f1-20020a056402194100b00416b174987asm6660211edz.35.2022.04.05.04.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 04:59:38 -0700 (PDT)
Message-ID: <14ce8189-6ea7-75d8-1b03-56dcb8eda2ac@linaro.org>
Date:   Tue, 5 Apr 2022 13:59:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RFC net-next v2 1/3] dt-bindings: net: convert mscc-miim
 to YAML format
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220401215834.3757692-1-michael@walle.cc>
 <20220401215834.3757692-2-michael@walle.cc>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220401215834.3757692-2-michael@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2022 23:58, Michael Walle wrote:
> Convert the mscc-miim device tree binding to the new YAML format.
> 
> The original binding don't mention if the interrupt property is optional
> or not. But on the SparX-5 SoC, for example, the interrupt property isn't
> used, thus in the new binding that property is optional. FWIW the driver
> doesn't use interrupts at all.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  .../devicetree/bindings/net/mscc,miim.yaml    | 56 +++++++++++++++++++
>  .../devicetree/bindings/net/mscc-miim.txt     | 26 ---------
>  2 files changed, 56 insertions(+), 26 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/mscc,miim.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/mscc-miim.txt
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
