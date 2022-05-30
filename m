Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9709D53752E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbiE3GeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 02:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbiE3GeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 02:34:02 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF19C3DA75
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 23:34:00 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id jx22so18749358ejb.12
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 23:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6JI8S2sEVNpLFXVCCEM7RQxXwQYpgOWv8/i6hytBxdw=;
        b=zI0PXh8CUyED8Aak6eOmi1pxsLjx5iKfEyhp11LMUldq9XFq2NWH8BDXYIBnH+GXzu
         AJhdwBrl/HQ7z2DFlsk5iIZ9GGMKbdvq7WFOv8XsL3ni9sP5RAMDaUw7GZReXuyf/unq
         t6JshwYWAFLqRkE7demdu8wDwWO13TszkVQyVTORH+qUU6WdRhjCCtgQBd7q2WvLW3Bf
         5kULMLzBV6kXyaXywJzA3k62rdn+HVZoZgW3TUU4k3yYrSThwo38Q5WhoPEG6qIj+Dwx
         mTUc84qbWdXLO50Z4mzpvy2NVjZYNZ1PvNKr1UUdYznfM+cmo2cro+UzgFQ6cJP0rCEa
         mtnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6JI8S2sEVNpLFXVCCEM7RQxXwQYpgOWv8/i6hytBxdw=;
        b=ixEiIJmS2KkUGH7GOf3sjpzQwiRZp/kaugD6zOJcdWqI4BmHPka4H39jkTk6NK0SXZ
         vEv11fXOAQX+y7bit8FbguqOIby/ipH3KwgaUguxjE/slAQ/8TVO/zaaVDje814gG80V
         ebrxeaf5eUOHOHYyM9S6quLRT6aAncYaw/emJq5OIfRLi3ijspAIFJMI2ezaTPKN2uAs
         RMuDR2WzeuRXNVLty31xEqDVyWk7pVyLaLOprM4V8PGpxgpsf11FIkzxiRJzPzcEy3vE
         56GoomAnr3L+rUO8eDCL7H3mjXUk3ffAklV9CvuFgyGPR4k994VfHqfZ6qWPKNI+wbpN
         IOFg==
X-Gm-Message-State: AOAM530CQ91UB3owwaEmbEM1y3q6D1bpsa5Ehe3mBVNM9YHB6YV16rjw
        2slJj6q6Hi8GwRZqcpXUSzVjPg==
X-Google-Smtp-Source: ABdhPJzPKJqFPcOz5A+5ihWfyOrl8uqS8EvJFQzv0kmgEA19KzEXCpq17Xg4yZLMD6GQ3DGaOgt0zA==
X-Received: by 2002:a17:906:3a92:b0:6fe:9029:b62c with SMTP id y18-20020a1709063a9200b006fe9029b62cmr47653469ejd.569.1653892439407;
        Sun, 29 May 2022 23:33:59 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id w7-20020a170906130700b006f3ef214dfesm3680224ejb.100.2022.05.29.23.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 May 2022 23:33:58 -0700 (PDT)
Message-ID: <0c08eb44-285d-975d-ac6a-f55ccfb34420@linaro.org>
Date:   Mon, 30 May 2022 08:33:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 2/3] ARM: dts: aspeed: Add USB2.0 device controller
 node
Content-Language: en-US
To:     Neal Liu <neal_liu@aspeedtech.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Felipe Balbi <balbi@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Li Yang <leoyang.li@nxp.com>
Cc:     "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>
References: <20220523030134.2977116-1-neal_liu@aspeedtech.com>
 <20220523030134.2977116-3-neal_liu@aspeedtech.com>
 <TY2PR06MB32135A0DAA9F152E2498CD1C80DD9@TY2PR06MB3213.apcprd06.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <TY2PR06MB32135A0DAA9F152E2498CD1C80DD9@TY2PR06MB3213.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2022 03:27, Neal Liu wrote:
> Gentle ping on this path, thanks.

It's a merge window, so now not much might happen. Please resend in a week.

> 
>> -----Original Message-----
>> From: Neal Liu <neal_liu@aspeedtech.com>
>> Sent: Monday, May 23, 2022 11:02 AM
>> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Rob Herring

(...)

>>
>> Add USB2.0 device controller(udc) node to device tree for AST2600.
>>
>> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>

You don't need my ack here, but anyway FWIW:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
