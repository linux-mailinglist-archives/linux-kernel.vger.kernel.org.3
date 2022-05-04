Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A9E51AF64
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbiEDUkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238632AbiEDUkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:40:02 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2224A3CB;
        Wed,  4 May 2022 13:36:25 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id e189so2370303oia.8;
        Wed, 04 May 2022 13:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=a+rDeQbRoNWpsCJ5GSOxdZJdeB0rbOuF0Fqaf+ynwHQ=;
        b=ZG+cuCYEbJQRk7q48r1E2kx4gav+8+/sVgwAulC+B3EWxibujsKUL2TAx2O+OZpwz2
         8Cv0hE7n3F4nNeF2Fbz+/LO/UTz2OabxG1Fv2iU9FbAwpOloWBJheHSbHRXJ/39cTea9
         cPSuW6hkAdx2NWEQag4nejSCDRIpZKnGCp5XJ6cmXYyb4rE0H6GfTEdk+0cMeeah3WDI
         y8Ddy4bKLjiRm3GKuUKRf2y07v9Cp4L0eVLd6Zt68wtghTsFT+knxI7ky9XdkhFhuI+x
         17BnqrqcASkrqUddlCg1pdBH2EnOIMuvxFF/c/YckQ8v3CslZr62j/e5KYEZiBQbtrEu
         2/ZA==
X-Gm-Message-State: AOAM5324jbVRDsFQQBiHgQNUTKp+AJR9dn+F/WiYrLpTP/V9P6quQRF3
        9xLt/XV/wtjdm8APGz97yA==
X-Google-Smtp-Source: ABdhPJwq8I7lPc9yVfmwk94hDaWO5KRPEC6aW2xVAAkXg9GPwtParUvYL1QsoU/8Bqov8n+SdNPpqQ==
X-Received: by 2002:a05:6808:21a6:b0:326:54ae:8d1f with SMTP id be38-20020a05680821a600b0032654ae8d1fmr690049oib.210.1651696584585;
        Wed, 04 May 2022 13:36:24 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 95-20020a9d0668000000b0060626a8e5a4sm3047394otn.74.2022.05.04.13.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 13:36:24 -0700 (PDT)
Received: (nullmailer pid 2183622 invoked by uid 1000);
        Wed, 04 May 2022 20:36:23 -0000
Date:   Wed, 4 May 2022 15:36:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mediatek@lists.infradead.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] dt-bindings: regulator: mt6315: Enforce
 regulator-compatible, not name
Message-ID: <YnLjx72gEGD8FSBM@robh.at.kernel.org>
References: <20220429201325.2205799-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220429201325.2205799-1-nfraprado@collabora.com>
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

On Fri, 29 Apr 2022 16:13:24 -0400, Nícolas F. R. A. Prado wrote:
> The MT6315 PMIC dt-binding should enforce that one of the valid
> regulator-compatible is set in each regulator node. However it was
> mistakenly matching against regulator-name instead.
> 
> Fix the typo. This not only fixes the compatible verification, but also
> lifts the regulator-name restriction, so that more meaningful names can
> be set for each platform.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> ---
> 
>  .../devicetree/bindings/regulator/mt6315-regulator.yaml         | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
