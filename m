Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF684FFEF0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238211AbiDMTPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238633AbiDMTNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:13:24 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A87F7938D;
        Wed, 13 Apr 2022 12:09:07 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-e2442907a1so2989192fac.8;
        Wed, 13 Apr 2022 12:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DLfFRlPR18ak0Dg98RjZkZ+swlB0PONrUxc3NZGeV2c=;
        b=vPebnLDsWtFRRCt7KvZX9tAeUU6BxIg+CZBdi/YxNeyLLAx4ifffad8wZS5YU0gRue
         jcGxNppYBXAEr1rmnZDJVxUtl+gZgoCGk26CtgCFhliPvLqURvm/nSVcm643KMJ5yjRz
         tJSo+dqktAnXHck4VSWfMSSWLS49R+WqbZYOA33/inuKPsHVkyDDtdYLMh5Cyf8h8zqp
         ypl1J6qCTJQDi2D54oNv1f5wU98yqIxTMz9kkIYrBRvilVKSuz8W+5n/FW/i2dpe+KuQ
         ZdyxPEEG0craU+4dr8VQWkkkeQ9nPkq13cWxA1HLypNtJaxmwQeFzA/OoRZw8t/Vhf68
         yrew==
X-Gm-Message-State: AOAM532R9kZDvC+ZhQ9rcSA6wX42jDozhkqglFGI/MTL8oTXSuwKkPR7
        RhGlXXEKPkKyeaDQj0Fl5xTo04nQxg==
X-Google-Smtp-Source: ABdhPJw7hT2QmeBA/ltdKB38j/W8WiKNHRYpddijFqt+fqHm6/4cCtwZkGaKp1wKMMN4w5kGnCJ2/g==
X-Received: by 2002:a05:6870:b525:b0:e3:9db:e075 with SMTP id v37-20020a056870b52500b000e309dbe075mr90116oap.41.1649876946855;
        Wed, 13 Apr 2022 12:09:06 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l14-20020a056820030e00b00320edaf9b8esm13631840ooe.44.2022.04.13.12.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:09:06 -0700 (PDT)
Received: (nullmailer pid 3659930 invoked by uid 1000);
        Wed, 13 Apr 2022 19:09:05 -0000
Date:   Wed, 13 Apr 2022 14:09:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: interrrupt-controller: uniphier-aidet: Use
 unevaluatedProperties
Message-ID: <Ylcf0QOBAne6fKQr@robh.at.kernel.org>
References: <1649317664-21391-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649317664-21391-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 04:47:44PM +0900, Kunihiko Hayashi wrote:
> This refers common bindings, so this is preferred for
> unevaluatedProperties instead of additionalProperties.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../bindings/interrupt-controller/socionext,uniphier-aidet.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/socionext,uniphier-aidet.yaml b/Documentation/devicetree/bindings/interrupt-controller/socionext,uniphier-aidet.yaml
> index f89ebde76dab..77f2d58a9c3f 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/socionext,uniphier-aidet.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/socionext,uniphier-aidet.yaml
> @@ -49,7 +49,7 @@ required:
>    - interrupt-controller
>    - '#interrupt-cells'
>  
> -additionalProperties: false
> +unevaluatedProperties: false

As mentioned elsewhere, not necessary here.

Rob
