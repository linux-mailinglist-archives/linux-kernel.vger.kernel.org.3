Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749C84E8983
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 21:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236424AbiC0TIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 15:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiC0TIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 15:08:12 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC1010FEB;
        Sun, 27 Mar 2022 12:06:32 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id u3so17408852wrg.3;
        Sun, 27 Mar 2022 12:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ll1EHkrJQGbMWuBiZ52whwPW7D9ncmXOlUyWZdkQFa8=;
        b=3gEMKWDiLghLhNx0pN6uEZNNJwmxZk6mKYFkRjgEdzAuVj6b5MN+PrgM+4OxSVKoGm
         XjHxz461BRPBJaD5R/H3xdWz3Kr6iqDqAgqZVS2yXXNKPUS9CoZmvSRodl4skVlfMOXA
         1XvVzK226CA9Ae/xLG3/RIULZk93I+Ck39zfqFvobIjZ6NEZbSJa/Sqtsr4xPxK/0Uon
         ZJE6MgRl/W7rVye1k6nHlX7aIDSJtBLxEGSignj8DIPTKaBUobXHKlHXbFEoUn9q04GA
         nEaUnXQeBQR1q7lBoZ3P2kfsgZrYvvk+OSs8ELJ9+VGCE1lrEtPfQM6sQ46vEWKTEb3q
         PV2Q==
X-Gm-Message-State: AOAM532DKS1FIRjjA0+YDdPIVMQ1uC1BUj6rSycufBjThP/rx/uZLdkR
        JfcWaF/u6DumLYq/7s7o+EU=
X-Google-Smtp-Source: ABdhPJz/my4VzDnEV9yFVeCXb5EyongRdUMvxKA1PHdYDpHE1k/AUDAJKQ34W85UwabacM7E3JqqhQ==
X-Received: by 2002:a5d:6487:0:b0:205:7c2b:b6ba with SMTP id o7-20020a5d6487000000b002057c2bb6bamr17678468wri.283.1648407990933;
        Sun, 27 Mar 2022 12:06:30 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id p8-20020a5d59a8000000b00204178688d3sm11472248wrr.100.2022.03.27.12.06.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Mar 2022 12:06:30 -0700 (PDT)
Message-ID: <edc4011d-5bfe-8ec5-e76b-61952cb3b9eb@kernel.org>
Date:   Sun, 27 Mar 2022 21:06:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 02/12] dt-bindings: timer: gpt: Add i.MXRT compatible
 Documentation
Content-Language: en-US
To:     Jesse Taube <mr.bossman075@gmail.com>, linux-imx@nxp.com
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, aisheng.dong@nxp.com, stefan@agner.ch,
        linus.walleij@linaro.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux@armlinux.org.uk, abel.vesa@nxp.com, dev@lynxeye.de,
        marcel.ziswiler@toradex.com, tharvey@gateworks.com,
        leoyang.li@nxp.com, sebastian.reichel@collabora.com,
        cniedermaier@dh-electronics.com, clin@suse.com,
        giulio.benetti@benettiengineering.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
References: <20220326144313.673549-1-Mr.Bossman075@gmail.com>
 <20220326144313.673549-3-Mr.Bossman075@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220326144313.673549-3-Mr.Bossman075@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2022 15:43, Jesse Taube wrote:
> Both the i.MXRT1170 and 1050 have the same GPT timer as "fsl,imx6dl-gpt"
> Add i.MXRT to the compatible list.
> 
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
>  Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
> index a4f51f46b7a1..716c6afcca1f 100644
> --- a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
> +++ b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
> @@ -31,6 +31,8 @@ properties:
>            - enum:
>                - fsl,imx6sl-gpt
>                - fsl,imx6sx-gpt
> +              - fsl,imxrt1050-gpt
> +              - fsl,imxrt1170-gpt
>            - const: fsl,imx6dl-gpt

This looks ok, but your usage looks wrong. Did you test your DTS with
dtbs_check?

For the bindings only change:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>


Best regards,
Krzysztof
