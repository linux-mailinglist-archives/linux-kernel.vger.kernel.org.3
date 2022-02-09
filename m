Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D406B4AFED8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 22:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbiBIVBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 16:01:07 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbiBIVBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 16:01:04 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF00C02B66C;
        Wed,  9 Feb 2022 13:01:04 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id r27so3841541oiw.4;
        Wed, 09 Feb 2022 13:01:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qlhsBrk58d+PBEsXLf1Gub/eoly18zDY283TQ4/24uE=;
        b=s31XP1+NG1cWnTFZsnGh5P7bzRbGI+TVE2rh3BpjvsbbbQvD+HY7Fko+/VcvVm6tLX
         B1qr0T/7K7k/EwYO2eaVyK43h6c9OpBs1/6AGN3Q+CSAbX8P3V0xLgjj7ehRzn22iCCs
         2PpDz3Umr1v1IaIM3GcTmp1oSuFdXhKUkp4UIDA8+gAwJecyei8hutBTJvPJvTcF9k7d
         6iyzbpmX+TpXyIrdBYQp1+OfH5UTvXW22h+Bahf4QtvYPl8ozNaLc7SPJqCYDWXFisOL
         i79JBveOa79mYWzRwbH5JhHY/1q2GjrjlExrCfgvGnNvV+U5CxmEGL5CpUAyEVjrlsOm
         pvfg==
X-Gm-Message-State: AOAM531sm0gzvYwSBgIC6LDcKRBhwNjtGEr+dqtF2yQJ/O468S/lM07P
        WfFfaPCdsuFtB0WIQ0I8dQ==
X-Google-Smtp-Source: ABdhPJwN9Iri/QtKQz+h7hiiBCG1hg4kn8lg+yCYP0VL97uHevl4I27jl5SQWVaVsOJvaAHd6lKzKQ==
X-Received: by 2002:a54:4785:: with SMTP id o5mr1897126oic.96.1644440463320;
        Wed, 09 Feb 2022 13:01:03 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 11sm7377197oar.18.2022.02.09.13.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 13:01:02 -0800 (PST)
Received: (nullmailer pid 902113 invoked by uid 1000);
        Wed, 09 Feb 2022 21:01:01 -0000
Date:   Wed, 9 Feb 2022 15:01:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 4/6] ASoC: dt-bindings: samsung,smdk5250: convert to
 dtschema
Message-ID: <YgQrjY3Ri9Kar9lq@robh.at.kernel.org>
References: <20220129122357.45545-1-krzysztof.kozlowski@canonical.com>
 <20220129122430.45694-3-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129122430.45694-3-krzysztof.kozlowski@canonical.com>
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

On Sat, 29 Jan 2022 13:24:28 +0100, Krzysztof Kozlowski wrote:
> Convert the audio complex on SMDK5250 boards with Samsung Exynos SoC to
> DT schema format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/sound/samsung,smdk-wm8994.txt    | 14 -------
>  .../bindings/sound/samsung,smdk5250.yaml      | 38 +++++++++++++++++++
>  2 files changed, 38 insertions(+), 14 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/samsung,smdk-wm8994.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/samsung,smdk5250.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
