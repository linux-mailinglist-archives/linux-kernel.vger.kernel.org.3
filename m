Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828B9571347
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 09:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbiGLHlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 03:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbiGLHlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 03:41:25 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E431A9B562
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:41:22 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id d12so12513706lfq.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=n4cgbC+MIUp7gq2F/f93AMQT43MDyPz48ScZFytg3Ks=;
        b=jTZAol4P/nP6j0TBCz7/xV4ECPoEbnP1ahVh2DKMQsTro9hRGyHT9fZY3Y1DIyVJsw
         ZFgCF1ldvrMt1AL0cezxjWCDvLvUWdoRTkeXG83BrojT68CYJfdxHGkgFwZFvHeKwjnV
         JAYhlV5/1YGZa448BglA3qAjWpeMdjziUeGUc1adgC01Q8lsQ2pm7JeTW3AP8jhKXi0F
         /ufqPTidkqzjsCi2QTUwga0ylGoqG+bzvnRE4vlSwszKQZ+PMR0k5SUX/kTgms+qOClV
         sFYFpmSet3WMB4g3d3rxoQgwna8afnSJOE8V5vvp7Dr0ZJpat6ryye2mLev5XNCPnn9S
         gsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n4cgbC+MIUp7gq2F/f93AMQT43MDyPz48ScZFytg3Ks=;
        b=oZmivInml6QFOK0/d2t26koRQRd2lqvrXWmEgcicCHAEYDCLkCxXOsDRwJqrQApF8O
         6JVhMOMFdlg5qye1rBoZO7nVexpdG6NIVy7GkYHxHahU/vT1+wEc5N9ysecUKO4hHBwf
         8kZRy2DeoaO0l9iRaqFhbjDN9px00qxhoi61uKOHZEs5Yl9j3j1Z7TZpyJ6/at26WaKp
         IdTfqMKb0ZxICMbS6/3n7eNQfHKgYcyINzxdR2WQrN7z5pN4UrQvYJeUtC73k3maq9Fe
         Or1fbAcqvzLKcDCKA+UzA+ax6G3Hz0kyVspCwrn0grzbCVP+IbmYwp1ch2R3R5H/g0Lc
         GDEQ==
X-Gm-Message-State: AJIora+Ahi6/3g6tIGrbkiUjsQznYlpJa0bE0sBnHu+jpdd4LpZ136+t
        eDufF7muuxK2dRKSi7J+4c+VCJlcoDzJlgZ/
X-Google-Smtp-Source: AGRyM1s0xY1Dvk7h/HYdb9BXURZKQnSJCJYxJBXRDES3lOvN80m7bKKond3YBXlKBW066BtrzIjZQg==
X-Received: by 2002:a05:6512:128f:b0:47f:879b:dc9c with SMTP id u15-20020a056512128f00b0047f879bdc9cmr15109909lfs.478.1657611681308;
        Tue, 12 Jul 2022 00:41:21 -0700 (PDT)
Received: from [10.0.0.8] (fwa5cab-55.bb.online.no. [88.92.171.55])
        by smtp.gmail.com with ESMTPSA id e12-20020ac25cac000000b00478772eb18esm2032237lfq.92.2022.07.12.00.41.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 00:41:20 -0700 (PDT)
Message-ID: <3b839a00-d660-7deb-4935-f986ff78d662@linaro.org>
Date:   Tue, 12 Jul 2022 09:41:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: fsl: Add Moxa UC8210/8220 series
Content-Language: en-US
To:     Jimmy Chen <u7702045@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>
Cc:     Jimmy Chen <jimmy.chen@moxa.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220712045505.4500-1-jimmy.chen@moxa.com>
 <20220712045505.4500-2-jimmy.chen@moxa.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220712045505.4500-2-jimmy.chen@moxa.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2022 06:55, Jimmy Chen wrote:
> Moxa UC8210/8220 use Freescale i.MX7d CPU
> 
> Signed-off-by: Jimmy Chen <jimmy.chen@moxa.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index ef524378d449..0746801aeb27 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -767,6 +767,9 @@ properties:
>                - toradex,colibri-imx7d-emmc    # Colibri iMX7D 1GB (eMMC) Module
>                - zii,imx7d-rmu2            # ZII RMU2 Board
>                - zii,imx7d-rpu2            # ZII RPU2 Board
> +              - moxa,uc-8210              # MOXA UC-8210 board
> +              - moxa,uc-8220              # MOXA UC-8220 board

Keep existing order, do not introduce differences.

> +

Why adding this blank line?

>            - const: fsl,imx7d
>  
>        - description: TQ-Systems TQMa7D SoM on MBa7x board


Best regards,
Krzysztof
