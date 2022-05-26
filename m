Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A615A5348D1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 04:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345999AbiEZCUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 22:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346144AbiEZCU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 22:20:28 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AC7BCE9E;
        Wed, 25 May 2022 19:20:28 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id h9-20020a056830400900b0060b03bfe792so157342ots.12;
        Wed, 25 May 2022 19:20:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fUiiPmbA6QA10aF/JY98KAXUhHU/traPAFGkrXb+0G0=;
        b=zfWE0HEyVbNwLOVkKrpahLWdVY/yCqp7Y4leZ74zbgF1X593uD7sZRmK92TkB3gAyg
         cFedUjUz1m74tmZv+vtB+4TwxhLZOeuFemXJ0bRVmpkVDOx8qbd7OMaxOF+rvmHevOwm
         I9esSTOMx6Kt7389FlfurBPmvd/tO9gIuyo/GVbhMmiKHP2o88NfXpYHLV/213S39SxY
         gWbAvH0rnBe5CZ3dwGumEs9cTh1oEW3qVNj7YdtVYqwvLaGGNnYXphP9OinU7fG44oPI
         k+uUCBsuftsBZqdV07aOzPqTSA+31Y216A2V/Rm+pWQfnRmIdaCw2vgB9THPBSQ0YntU
         ia9w==
X-Gm-Message-State: AOAM530RTBApj5M7+2uMtzrVs66q3gTpGOr76BUoxHZ0rJadZxm2g4hL
        FHFh1u78VciCCCFIcFG/O7YflgnoAQ==
X-Google-Smtp-Source: ABdhPJxBCfHQ008+Adc+zsviLOOkVnJ/rGNw8PkoxUiB69RgS7icKXJHHy8ufZ+Wi9jZxRkCuoabqg==
X-Received: by 2002:a05:6830:3496:b0:60b:1d91:81e4 with SMTP id c22-20020a056830349600b0060b1d9181e4mr5872153otu.110.1653531627387;
        Wed, 25 May 2022 19:20:27 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id kz5-20020a056871408500b000f2be69ec8asm194318oab.17.2022.05.25.19.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 19:20:26 -0700 (PDT)
Received: (nullmailer pid 2933346 invoked by uid 1000);
        Thu, 26 May 2022 02:20:25 -0000
Date:   Wed, 25 May 2022 21:20:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jeff LaBundy <jeff@labundy.com>
Subject: Re: [PATCH] dt-bindings: input: use generic node names
Message-ID: <20220526022025.GA2933288-robh@kernel.org>
References: <20220524093136.7980-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524093136.7980-1-krzysztof.kozlowski@linaro.org>
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

On Tue, 24 May 2022 11:31:36 +0200, Krzysztof Kozlowski wrote:
> Devicetree specification expects nodes to have generic names, if
> possible, so replace custom ones with something generic.  For gpio-keys,
> the more popular format is "key-xxx" instead of "xxx-key", so choose the
> first one.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: Andreas Kemnade <andreas@kemnade.info>
> ---
>  .../devicetree/bindings/input/fsl,mpr121-touchkey.yaml        | 4 ++--
>  Documentation/devicetree/bindings/input/gpio-keys.yaml        | 4 ++--
>  Documentation/devicetree/bindings/input/iqs269a.yaml          | 2 +-
>  Documentation/devicetree/bindings/input/iqs626a.yaml          | 2 +-
>  .../devicetree/bindings/input/microchip,cap11xx.yaml          | 2 +-
>  5 files changed, 7 insertions(+), 7 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
