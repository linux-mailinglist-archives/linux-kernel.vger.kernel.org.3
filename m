Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3844617CB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 15:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244782AbhK2OTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 09:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245267AbhK2ORK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 09:17:10 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828C2C061748
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 04:54:11 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id j3so36602749wrp.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 04:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OkTgUSUl69mUlHAOEVV6c+wE+mU4p8xYnqnvNDOdXpY=;
        b=w2G6a2aWBucu4rpcFMLQ9+mU+SYOAd7nSEssmPlgkYnAgpn1CZR2VBcUS2UGw5EKyI
         uXG4IEWfJFd/C2IUK49ViCRRj3X7YK7RWD4Y2WvSM2dQ5ECDfTHdmLLIRrfGNqlkUgfU
         MCL0CLhkhtpZBKuKdpK+FD0NJwQy949wCZF/p+2qgzEhxglvb/t+oJ/NbRc6phpYRGYc
         7hxsLSpnhlta74nJ4cPeSJHY10EKjG9CvVUlMI9mfpHbrZ/qCSL/8BSQrKeZKmwJ3Och
         a2N8KLq12hqBXjpK7o/7+soCOHnuoSSnb2htpGec4DW9K1CpancJB9NQ5SiWiTD/CGdK
         qsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OkTgUSUl69mUlHAOEVV6c+wE+mU4p8xYnqnvNDOdXpY=;
        b=T2MLtrHniziubMp88ixixHP/YC18wqijmxrN+FJU0FHggzSyAvtuf809F3gtk4aF0k
         0wmS7d1zmu6VxOR6z5XtcKfhaZbXDwJnuR3cY0TEMu897fG3SMwAhMBuhewPAk1D1Zse
         vbkIYZlJRJbS+SHWdbrxLnb1xM6hgZrjMgqyKT//V2sBr3zthhROHxaPdGMOr1POVVmB
         W2Jm9vBO93m3PAoEY9w2VovGG/YDsGD4hbd086LlujJx2cujsNP2Hx+/2QXHzJ9E82Jh
         UvdDSJ//fbURHwXtZRSRKEMo/sMZybDHWqsoT2nq5+X4GrLm4YLQuos/ScOrFkROFTcU
         PFLw==
X-Gm-Message-State: AOAM530rJiQWJDcqDa2yPmboYOjwoyPudrjs93OmPif9kUryT3p2dndW
        ClEq2/qocpIvNjwOIkO7doAztw==
X-Google-Smtp-Source: ABdhPJyghZdl1HRcWHvjrffA2ZEE2nI9BfanFl5E6aLsuOBjxWMXHzezD/nF04d+7I59XleFLtFRzQ==
X-Received: by 2002:a05:6000:2c7:: with SMTP id o7mr34377088wry.62.1638190450008;
        Mon, 29 Nov 2021 04:54:10 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id w7sm13760248wru.51.2021.11.29.04.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 04:54:09 -0800 (PST)
Subject: Re: [RFC PATCH] dt-bindings: nvmem: add transformation support
To:     Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
References: <20211123134425.3875656-1-michael@walle.cc>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <7807ac74-5b5c-f0a0-804a-497b67d2c985@linaro.org>
Date:   Mon, 29 Nov 2021 12:54:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211123134425.3875656-1-michael@walle.cc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On 23/11/2021 13:44, Michael Walle wrote:
> This is my second attempt to solve the use case where there is only the
> base MAC address stored in an EEPROM or similar storage provider. This
> is the case for the Kontron sl28 board and multiple openwrt supported
> boards.
> 
> The first proposal [1] didn't find much appreciation and there wasn't
> any reply to my question or new proposal [2]. So here we are with my new
> proposal, that is more flexible and doesn't fix the ethernet mac only.
> This is just an RFC for the device tree representation for now to see if
> this is the correct way to tackle this.
> 
> I'm also aware of the latest post process hook support [3]. This doesn't
> fix the base mac address issue, but I think it also doesn't solve the
> case with swapped ethernet addresses in the general case. That hook will
> involve the driver to do the swapping, but how would the driver know
> if that swapping is actually required. Usually the interpretation of the
> content is opaque to the driver, after all it is the user/board

But this is the path for any post processing hook, which ever direction 
we endup with(using core helpers or provider specific post-processing).

> manufacturer who does program the storage device. We might be lucky in
> the imx-ocotp case because the IMX reference manual actually states
> where and in which format the mac address is programmed.
> 
> Introduce a transformation property. This is intended to be just an
> enumeration of operations. If there will be a new operation, support for
> it has to be added to the nvmem core.
> 
> A transformation might have multiple output values, like in the base mac
> address case. It reads the mac address from the nvmem storage and
> generates multiple individual addresses, i.e. on our board we reserve 8
> consecutive addresses. These addresses then can be assigned to different
> network interfaces. To make it possible to reference different values we
> need to introduce an argument to the phandle. This additional argument
> is then an index into a list of values.
> 
> Example:
>    mac_addresses: base-mac-address@10 {
>      #nvmem-cell-cells = <1>;
>      reg = <10 6>;
>      transformation = <NVMEM_T_ETH_OFFSET 0 1 7>;

IMO, this is totally redundant. we could probably encode this info 
directly in the cell specifiers, something like:

>    }
> 
>    &eth0 {
>      nvmem-cells = <&mac_addresses 0>;

nvmem-cells = <&base_mac_addresses NVMEM_T_ETH_OFFSET 0>;

And value of #nvmem-cell-cells is dependent on the first cell specifier.

I understand that these 3 bits of info is required for this type of post 
processing and this can only come from DT and its not possible to 
determine this at runtime.

Would this address other usecases? Are you in a position to test few of 
them?

Lets wait for Rob's opinion on adding #nvmem-cell-cells property with 
cell specifiers describing the encoding information?


--srini

>      nvmem-cell-names = "mac-address";
>    };
> 
>    &eth1 {
>      nvmem-cells = <&mac_addresses 2>;
>      nvmem-cell-names = "mac-address";
>    };
> 
> The NVMEM_T_ETH_OFFSET transformation takes N additional (dt) cells and
> will generate N values. In this example BASE_MAC+0, BASE_MAC+1, BASE_MAC+7.
> An nvmem consumer can then reference the nvmem cell with an index. So eth0
> will get BASE_MAC+0 and eth1 will get BASE_MAC+7.
> 
> This should be sufficient flexible for many different transformations
> without having to touch the bindings except for adding documentation and
> checks for new transformations.
> 
> I do have one question regarding "#nvmem-cell-cells" (aside from the
> awkward naming): is it allowed to have that property optional if there
> is no additional argument to the phandle?
> 
> [1] https://lore.kernel.org/all/20210414152657.12097-2-michael@walle.cc/
> [2] https://lore.kernel.org/linux-devicetree/362f1c6a8b0ec191b285ac6a604500da@walle.cc/
> [3] https://lore.kernel.org/lkml/20211013131957.30271-1-srinivas.kandagatla@linaro.org/
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>   .../devicetree/bindings/nvmem/nvmem.yaml      | 29 +++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> index 456fb808100a..8893d045be77 100644
> --- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> @@ -26,11 +26,34 @@ properties:
>     "#size-cells":
>       const: 1
>   
> +  '#nvmem-cell-cells':
> +    enum: [0, 1]
> +    description:
> +      Must be 1 if the transformations has multiple output values.
> +      The argument is then the index into the list of output values.
> +      For example, if the nvmem cell only specify a base ethernet
> +      address the transformation can then create different individual
> +      ethernet addresses.
> +
>     read-only:
>       $ref: /schemas/types.yaml#/definitions/flag
>       description:
>         Mark the provider as read only.
>   
> +  transformation:
> +    description:
> +      Transform the content of a NVMEM cell. Sometimes it is necessary
> +      to preprocess the content of a cell so it is usable by the NVMEM
> +      consumer. There are also cases where one NVMEM cell value can
> +      generate a list of values.
> +
> +      Use one of the NVMEM_T_* prefixed definitions from the header
> +      include/dt-bindings/nvmem/nvmem.h.
> +
> +      Some transformations might have additional arguments.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +
>     wp-gpios:
>       description:
>         GPIO to which the write-protect pin of the chip is connected.
> @@ -98,6 +121,12 @@ examples:
>                 reg = <0xc 0x1>;
>                 bits = <2 3>;
>             };
> +
> +          ethernet_base_mac: base-mac-address@100 {
> +              #nvmem-cell-cells = <1>;
> +              reg = <0x100 0x6>;
> +              transformation = <NVMEM_T_ETH_OFFSET 0 1 2 7>;
> +          };
>         };
>   
>   ...
> 
