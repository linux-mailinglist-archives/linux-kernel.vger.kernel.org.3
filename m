Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4877C4E9F67
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 21:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245458AbiC1THZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 15:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245450AbiC1THV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 15:07:21 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEBC2717D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 12:05:39 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r13so21712284wrr.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 12:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uUdjHAsVm4xbzQBk+yOgGDcnf60WJNqDav+QAZGIBGc=;
        b=kKgcul+h2c29wBVCA9AcSOte+viDCutPTJ1XX3geLLK28Jx+YHx81quekRwAcbYMrt
         QcPVNqdiZr7daz85yrlXBBweSuTo8pbCBUqtkAAMhb2RCov/OmMLbrzXsGf/EI7G083a
         XCt1qlVVYhnHSvTvHvzF1gCFbk387MDtvaJBwV1bupsuIFW+kVCSjce+vXqs/PUIlNwn
         Ypjyzp/2Pdp789GgOJz4B2f6p/3Ksyjd1/d6/P9NvYvpqyri/wM0px90efH35XzIxNQ3
         pm9hE4zVZE5GObEf/np71ZtI9C9LeXRLz0l8Ob2dOLemWZ3iQIBduc1yp7mbhPIwPA8/
         O1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uUdjHAsVm4xbzQBk+yOgGDcnf60WJNqDav+QAZGIBGc=;
        b=Se7lSX0JNrW6suH31t63+EIvDi9EKdW+uMJdrx/pri9+eVFk8PL+pkVbq61TS1HJfX
         W2fGdfrEugKhahZ/NqJxms23CbxUzpLD6QJPhKwvX4GGcJP/fFjle0iPIhtOWUpPfege
         GFXnA3nQ2JFJnmbvGFpAUEHvAAtElzTNKc9nLvjzdITt0o7wbZ0mr8ed9yRdqqws0yoc
         XUrJllz8tGHpxRgTAMqcU9w8FKv0OVmqMGl321KVLdG4+stJ1Z7QYxtrVdp21pBnVD/s
         KbkBdyRm1HZg2k7/te+8xLG+k7z7l/6KDpVC1d3qPCPD1Q3M/87isjKmU6naUfe1G+yQ
         NGmQ==
X-Gm-Message-State: AOAM533rwh2mA0uJHbssI3qwLZIgjBLa2QQ/qag0ckA1VQ7wPNaZrBdl
        JA0wkdoEugJ+ZSVIf69IFASTOA==
X-Google-Smtp-Source: ABdhPJxB3V2IpQMOgoiJpdUHlpSZ6hN187p8hb0D0T19ivE0K0gQMJdw8/J0ljl5j1O5gBXoBW149A==
X-Received: by 2002:a05:6000:154c:b0:203:d46b:ede4 with SMTP id 12-20020a056000154c00b00203d46bede4mr25844397wry.501.1648494338367;
        Mon, 28 Mar 2022 12:05:38 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id z18-20020adfec92000000b00203f04ed4a8sm12670645wrn.13.2022.03.28.12.05.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 12:05:37 -0700 (PDT)
Message-ID: <eff14382-5ef7-8b84-8689-70f69c1521e9@linaro.org>
Date:   Mon, 28 Mar 2022 21:05:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: serial: uniphier: Add "resets" property as
 optional
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1648430772-21786-1-git-send-email-hayashi.kunihiko@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1648430772-21786-1-git-send-email-hayashi.kunihiko@socionext.com>
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

On 28/03/2022 03:26, Kunihiko Hayashi wrote:
> UniPhier UART controller has a reset lines from system controller.
> Add "resets" property to fix the following warning.
> 
>   uniphier-ld11-global.dtb: serial@54006800: 'resets' does not match any of the regexes: 'pinctrl-[0-9]+'
>       From schema: Documentation/devicetree/bindings/serial/socionext,uniphier-uart.yaml
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../devicetree/bindings/serial/socionext,uniphier-uart.yaml    | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/socionext,uniphier-uart.yaml b/Documentation/devicetree/bindings/serial/socionext,uniphier-uart.yaml
> index d490c7c4b967..d14d8c9cfe4d 100644
> --- a/Documentation/devicetree/bindings/serial/socionext,uniphier-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/socionext,uniphier-uart.yaml
> @@ -22,6 +22,9 @@ properties:
>    clocks:
>      minItems: 1

This should be fixed to maxItems as well (separate patch).

>  
> +  resets:
> +    minItems: 1

maxItems

> +
>    auto-flow-control:
>      description: enable automatic flow control support.
>      $ref: /schemas/types.yaml#/definitions/flag


Best regards,
Krzysztof
