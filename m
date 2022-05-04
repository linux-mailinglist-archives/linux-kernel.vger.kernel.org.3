Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0095B51AF72
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378193AbiEDUmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235824AbiEDUmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:42:35 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226FA4FC5E;
        Wed,  4 May 2022 13:38:58 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id v65so2365673oig.10;
        Wed, 04 May 2022 13:38:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AcpEU69sAJkwiV3catvTf9Ba2Nirs+uxT6TgvfUDezQ=;
        b=aI1+bxMjx+oP8zZqlFHPpvekCh3BHxh13601zAKUIN8tanqW7Egx5swO7Xp0CIqVZD
         TaWQSaJ8lB+OoImnVOUPEaljDAg5DKyiSRz7DzDJEHyPzHCwTZXJ5TWUQlZ/8ratyCjl
         +Kg1DeBy36IkFh5aHPdls+kIT4JpKamE69rPgv3YegqtF2CO8HD3XH3Ww6SxToMngjpI
         TLLOXIaaIOBf/XiuhPb59JS5/mSgxKJ6VAqkY04xB4OrgB9afE77JZo2vi8THBHL+gN+
         821bOIR1hfafGixQvhSxciSKZguie+2em4L95giU2SSooPGimF4348SpM603/WPS41bl
         2BbQ==
X-Gm-Message-State: AOAM533AHZViDc9k4pzR205BKZftWV9qzt0eXDPARwCKYBdHBSUOGcqI
        J5Fo3uRKvkgQgwHATKdaFA==
X-Google-Smtp-Source: ABdhPJxqGL2rYGTLd4lmJ9hpkXvtgU1omEZJ82uy+vc3bVbntykS23hu/PcAgWaMqP8CbQy4JAssJw==
X-Received: by 2002:aca:545:0:b0:325:6e7:992d with SMTP id 66-20020aca0545000000b0032506e7992dmr673969oif.244.1651696737433;
        Wed, 04 May 2022 13:38:57 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id dv2-20020a056870d88200b000e93d386d97sm8387005oab.31.2022.05.04.13.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 13:38:57 -0700 (PDT)
Received: (nullmailer pid 2187220 invoked by uid 1000);
        Wed, 04 May 2022 20:38:56 -0000
Date:   Wed, 4 May 2022 15:38:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     Mark Brown <broonie@kernel.org>, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Shane Chien <shane.chien@mediatek.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: mediatek: mt8192: Add i2s-share
 properties
Message-ID: <YnLkYKmJ0TJ8uyjC@robh.at.kernel.org>
References: <20220429203039.2207848-1-nfraprado@collabora.com>
 <20220429203039.2207848-2-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220429203039.2207848-2-nfraprado@collabora.com>
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

On Fri, Apr 29, 2022 at 04:30:37PM -0400, Nícolas F. R. A. Prado wrote:
> The Mediatek AFE PCM controller for MT8192 allows sharing of an I2S bus
> between two busses. Add a pattern for these properties in the
> dt-binding.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> ---
> 
>  Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml b/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
> index 7a25bc9b8060..5b03c8dbf318 100644
> --- a/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
> +++ b/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
> @@ -54,6 +54,11 @@ properties:
>        - const: aud_infra_clk
>        - const: aud_infra_26m_clk
>  
> +patternProperties:
> +  "^i2s[0-35-9]-share$":
> +    description: Name of the I2S bus that is shared with this bus
> +    pattern: "^I2S[0-35-9]$"

Why not a phandle to the the other bus? That would be the DT way to do 
it. But I'm not sure I really understand who is sharing what here.

> +
>  required:
>    - compatible
>    - interrupts
> -- 
> 2.36.0
> 
> 
