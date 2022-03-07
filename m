Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728EF4D0C2E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 00:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243739AbiCGXn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 18:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239450AbiCGXnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 18:43:21 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446842194;
        Mon,  7 Mar 2022 15:42:26 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id w127so6681098oig.10;
        Mon, 07 Mar 2022 15:42:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EsKRRIoThK3MQ1H0laF62b7WY6ong2NDteh+bOwJmMY=;
        b=uNGJNvEZ3c7sUj690++lMeWOHEdSGjYbdfeXseO49lI5v08xyDyCVxkiSoLG2wp9Et
         qRp95WV95eKK8TDQ3FV3MsseuK0o5/RCG+Bj+rxeVvi1imgYsJS2+29DCKQQ3hX/3OqS
         cPnPJcYuwoG8oJm/9TZ5k5FWukQHXN10W4+RAcRQlN0D77BFhVLqkL5o+9Pap2jv7I9+
         ThmWs/fSddbdId1+OM/9cZFRjxmE2QAJaeOoQM7wlMH9/wtJ8IDEd4jNaiwpgmsp55Bk
         l5Cu/c7rPzLiVpotvs2wsIdEpzmNgvqekozcowGgBDy4eKbtOCbwLhqNbZCfPvTSJ4it
         4uOQ==
X-Gm-Message-State: AOAM530eX0SExzoU+CYNLuZemMrVsJMtVFZXE15K1K4/WzH847fmHJVt
        NnTIekTiyHPmPyhrZfcLlA==
X-Google-Smtp-Source: ABdhPJwirVFf7NgTIaWCdemavUPZ6EK5UqamWYmsiMJjOCqd6t3G8W+ppN3LvgLKqKkNIV99E6Sjxg==
X-Received: by 2002:a05:6808:14cc:b0:2d9:a01a:48ac with SMTP id f12-20020a05680814cc00b002d9a01a48acmr946191oiw.247.1646696545606;
        Mon, 07 Mar 2022 15:42:25 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w4-20020a4adec4000000b0032109de628esm1060794oou.6.2022.03.07.15.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 15:42:24 -0800 (PST)
Received: (nullmailer pid 3487473 invoked by uid 1000);
        Mon, 07 Mar 2022 23:42:23 -0000
Date:   Mon, 7 Mar 2022 17:42:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Leilk Liu <leilk.liu@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH V3 6/7] dt-bindings: spi: support spi-hclk
Message-ID: <YiaYXwj0C8NeWjzz@robh.at.kernel.org>
References: <20220307065230.12655-1-leilk.liu@mediatek.com>
 <20220307065230.12655-7-leilk.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307065230.12655-7-leilk.liu@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 02:52:29PM +0800, Leilk Liu wrote:
> this patch support spi-hclk.
> 
> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> ---
>  .../devicetree/bindings/spi/mediatek,spi-mt65xx.yaml          | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> index a8a15a9a6c46..195793aa79b7 100644
> --- a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> +++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> @@ -51,16 +51,20 @@ properties:
>      maxItems: 1
>  
>    clocks:
> +    minItems: 3
>      items:
>        - description: clock used for the parent clock
>        - description: clock used for the muxes clock
>        - description: clock used for the clock gate
> +      - description: clock used for the AHB bus, this clock is optional
>  
>    clock-names:
> +    minItems: 3
>      items:
>        - const: parent-clk
>        - const: sel-clk
>        - const: spi-clk
> +      - const: spi-hclk

'spi' is redundant. Just 'hclk'.

>  
>    mediatek,pad-select:
>      $ref: /schemas/types.yaml#/definitions/uint32-array
> -- 
> 2.25.1
> 
> 
