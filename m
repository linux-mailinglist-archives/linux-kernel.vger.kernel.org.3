Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B2255FCDC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 12:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbiF2KIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 06:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiF2KIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 06:08:43 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0493C14D25
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 03:08:41 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id d2so19803723ejy.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 03:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oo6FD3PpKl1W51j/l69LdeaPmYx4GZrNK/rUNYnw0Ec=;
        b=opA3oyLfvUwtkgE2PgU4cPGEEpUAvj1CC3GID3pYjdj1qMqzo2Zi6OQGmdENY8TXAf
         wgt7y36JjUbVxfpXuDq4K0pGel8p/fQB59ZinDCrbX+cqazoJCHC9p3CZVmcXODAnQt9
         fbHFZHtQeqsLbc+Fvf0ELz6nv2hBbHA1k8phjUVvVru0VId8AeR2LfJdRJSth29yhPhi
         BI/WSwE/tTLaLl3Klb6BkAuc6k44rmY/2TDFlLTrc36+R1oePI+V1IXXRSxesWTTjy1d
         iEr+vf6IL9v4Avl/MEiSri+ZNJD9Vs/ZQj9S6EUeejwo2PW1rOVIqr13cGZDcKACkbdI
         Tbsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oo6FD3PpKl1W51j/l69LdeaPmYx4GZrNK/rUNYnw0Ec=;
        b=Yqrtup8gOZ68gCQPDN/g4+q4DLCPM5e2PU7h8EVPROi0U3QrhIJF/jtWDffF9qcSO9
         pl4Dz8DttB4/oNBK8+3KDWg35vNfOiQywewiPVUwF4vwA4gNIOYVbGZi0S/gYLTt4jwi
         N/mYp2VrVT8ZEpO476DtUOkbJcechPFRo+lThI2nLfY+9xRKK4xLI8mIAL8aUHwzIAr5
         /laC1ky6ov8L+TDrrIjUnksFUikHxplZ9GeFTkL+3061v6pw6yWnSKNJrwK8VUUvop5z
         nNIfYEC2DpVohPcVhImh3PULcOstme/r63WyXsHdatcZRgKigRL8QXIkYJSg1DFjbKg6
         Ynyg==
X-Gm-Message-State: AJIora9a/6s/eG+o38hOQKcVVarEnOq5l/80tY5AdlQPAbTI7UaMq/d6
        jtWHdiSxmnL9wqEjPn4sTPCn8g==
X-Google-Smtp-Source: AGRyM1vpbQIImVeFxmN9284sQKkYWMnNI+ylqKoYmWkqOXQQOX0SvLAgbUBbCkp/TJxmwjA5uHd9pg==
X-Received: by 2002:a17:907:7745:b0:6f3:674a:339 with SMTP id kx5-20020a170907774500b006f3674a0339mr2576078ejc.207.1656497319525;
        Wed, 29 Jun 2022 03:08:39 -0700 (PDT)
Received: from [192.168.0.183] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id zj4-20020a170907338400b00726ef422b80sm1476458ejb.177.2022.06.29.03.08.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 03:08:38 -0700 (PDT)
Message-ID: <1ba34d2b-113f-360e-bdd1-ab440bc456df@linaro.org>
Date:   Wed, 29 Jun 2022 12:08:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 3/4] dt-bindings: misc: tmr-inject: Add device-tree
 binding for TMR Inject
Content-Language: en-US
To:     Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org
Cc:     git@amd.com, git@xilinx.com
References: <20220628054338.1631516-1-appana.durga.rao@xilinx.com>
 <20220628054338.1631516-4-appana.durga.rao@xilinx.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220628054338.1631516-4-appana.durga.rao@xilinx.com>
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

On 28/06/2022 07:43, Appana Durga Kedareswara rao wrote:
> This commit adds documentation for Triple Modular Redundancy (TMR)

No "This commit"

https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> Inject IP.
> 
> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
> ---
>  .../bindings/misc/xlnx,tmr-inject.yaml        | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml b/Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml
> new file mode 100644
> index 000000000000..4daf9539000b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/xlnx,tmr-inject.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx TMR Inject Device Tree Bindings

Same comments.

> +
> +maintainers:
> +  - Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
> +
> +description: |
> +  The Triple Modular Redundancy(TMR) Inject core provides functional fault
> +  injection by changing selected MicroBlaze instructions, which provides the
> +  possibility to verify that the TMR subsystem error detection and fault
> +  recovery logic is working properly.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - xlnx,tmr-inject-1.0
> +
> +  reg:
> +    maxItems: 1
> +
> +  xlnx,magic:
> +    minimum: 0
> +    maximum: 255
> +    description: |
> +      Magic number used when injecting faults. The fault inject write data least
> +      significant byte (bits 7:0) must match this number to have any effect.

And why exactly register value is a property of DT?

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +required:
> +  - compatible
> +  - reg
> +  - xlnx,magic
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    tmr-inject@44a30000 {

fault-inject?

> +            compatible = "xlnx,tmr-inject-1.0";
> +            reg = <0x44a10000 0x10000>;
> +            xlnx,magic = <0x46>;
> +    };


Best regards,
Krzysztof
