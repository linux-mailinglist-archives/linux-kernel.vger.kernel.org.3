Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991344B2B0E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351817AbiBKQzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:55:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbiBKQzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:55:43 -0500
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7866221F;
        Fri, 11 Feb 2022 08:55:42 -0800 (PST)
Received: by mail-qk1-f173.google.com with SMTP id g145so8798477qke.3;
        Fri, 11 Feb 2022 08:55:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1UwYLCupktfjJ9mUj4/QYlTAZwDMfe5S5C3K0edWIBg=;
        b=fUdBWbNdCXx8ojtAcgxNl4vXqIy2Os4aHxTwHDyP7r1/U05DTpOubeknxWtZjuOHci
         UKoaxKwhX8MsrPNibB23ztkNWl2V40PdYb74ozlwtZqR4OBDTb4kISePmdQwijuW35lR
         9dXo/JXi5rV7xaZ+YQpxZQ2AKdDA9dSEby3CF8epRhn2Eu4tL1RNSuS92+zk1BON5m4t
         3OF2c3mpOGmO+leBQrwTHGd1OYkMVzpsoRmDZgiLN0b3RPl+22OBefNOdV7kYMHRLDNT
         /lIERsbOqSJQN5u7sTeV1Kv45M33pf4nLbokjDl8Qri1xfxhxfRsZ8sBBYqd15w7AiCY
         n1SQ==
X-Gm-Message-State: AOAM530UaDFAwYsv0O7YPfNNcauHx1q/2LXUYaKNyrD//UtN57fMYOY9
        KF8xibbKcshahNBufJ8vcjWLg0NOQg==
X-Google-Smtp-Source: ABdhPJzWhtYP/lUed83bNEhXzwT/Rs7Lt75nHeV6b3tF2GWmTTD5Cck+mTKwvTJDx3LpaD35b0Op9A==
X-Received: by 2002:a05:620a:d45:: with SMTP id o5mr1221552qkl.731.1644598541587;
        Fri, 11 Feb 2022 08:55:41 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:5fee:dfce:b6df:c3e1:b1e5:d6d8])
        by smtp.gmail.com with ESMTPSA id bk19sm11503188qkb.125.2022.02.11.08.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 08:55:40 -0800 (PST)
Received: (nullmailer pid 512729 invoked by uid 1000);
        Fri, 11 Feb 2022 16:55:38 -0000
Date:   Fri, 11 Feb 2022 10:55:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Leilk Liu <leilk.liu@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/6] dt-bindings: spi: Add compatible for Mediatek IPM IP
 with single mode
Message-ID: <YgaVCmizWJfFMK5I@robh.at.kernel.org>
References: <20220209111938.16137-1-leilk.liu@mediatek.com>
 <20220209111938.16137-2-leilk.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209111938.16137-2-leilk.liu@mediatek.com>
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

On Wed, Feb 09, 2022 at 07:19:33PM +0800, Leilk Liu wrote:
> This commit adds dt-binding documentation for
> Mediatek SPI IPM IP with single mode.
> 
> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> ---
>  Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> index bfa44acb1bdd..0a2fc0404cb3 100644
> --- a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> +++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> @@ -41,6 +41,7 @@ properties:
>                - mediatek,mt8135-spi
>                - mediatek,mt8173-spi
>                - mediatek,mt8183-spi
> +              - mediatek,ipm-spi-single

Is IPM an SoC? Compatible strings should be SoC specific or whatever 
granularity could have a unique errata.

Rob
