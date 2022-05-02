Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944555173B0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 18:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349529AbiEBQHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 12:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237266AbiEBQHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 12:07:43 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE70BC1E;
        Mon,  2 May 2022 09:04:14 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id r8so15638135oib.5;
        Mon, 02 May 2022 09:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=noR4HJFk7F0HSQNOMAQMG2M3tgi4T2ok0ZfyfqSOv20=;
        b=MDAAafoaKw+ZpEgRfHoQ/UhiczJMpbkVCzo5BWFRDhU7S+4sHzUkBT8c+VhxHpScez
         je1Bn1yjd0tR9X+UacR4iP+2ZuQIyD3XP2UnLSz6XEfyuNnQT5Q9u3sI3ouR0eKNST09
         GZ2QaHjGeOSBzAubof9nQIVMtXJQBHZcxe78GHmQm2ZEBJj5PlcrZAvQj14upXwD77bh
         F7CzxVQOXi6ob+llAu1zVI+5DBcCvTWBFUIrDyUPrNz3BCXrjkn4ElnTAKDukc1BGKid
         MmPNt7Psj779KfyhJ+wRgpWmCw8s6Qg2o0TbzjTcNEeF2TggWRhIvTgQrSpJOntd3PHG
         0Gwg==
X-Gm-Message-State: AOAM533YwXklBK5kwJ6nqef6taUZ6OAXi/fSNd7jx583vjm9KKX6sjSz
        2qMh9pbuJLi537ZTgA3UzQO2x+F8dg==
X-Google-Smtp-Source: ABdhPJyp3N6PwcEyY2JXcQYDhoqtY3kwoqFv7iQuO063fxQxQ8tSr8xXiV7qNElm4YmaKCFaLGRjOA==
X-Received: by 2002:a05:6808:1b0a:b0:325:ee07:e289 with SMTP id bx10-20020a0568081b0a00b00325ee07e289mr2987836oib.281.1651507453547;
        Mon, 02 May 2022 09:04:13 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e12-20020a4ae0cc000000b0035eb4e5a6d9sm3957814oot.47.2022.05.02.09.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 09:04:12 -0700 (PDT)
Received: (nullmailer pid 1215744 invoked by uid 1000);
        Mon, 02 May 2022 16:04:12 -0000
Date:   Mon, 2 May 2022 11:04:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: remoteproc: mediatek: Add optional
 memory-region to mtk,scp
Message-ID: <YnAA+7eqP/WzGrhQ@robh.at.kernel.org>
References: <20220429211111.2214119-1-nfraprado@collabora.com>
 <20220429211111.2214119-3-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220429211111.2214119-3-nfraprado@collabora.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 05:11:10PM -0400, Nícolas F. R. A. Prado wrote:
> The SCP co-processor can optionally be passed a reserved memory region
> to use. Add this property in the dt-binding.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> 
>  Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> index ec9ddeb6ca2c..64a9d2c7ed0d 100644
> --- a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> @@ -51,6 +51,10 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  memory-region:
> +    $ref: /schemas/types.yaml#/definitions/phandle

memory-region has a type already, so drop. What's needed is how many 
entries and what they are if more than 1.

> +    description: phandle to reserved memory region.
> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.36.0
> 
> 
