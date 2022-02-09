Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D436E4AFEE0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 22:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbiBIVCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 16:02:17 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbiBIVCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 16:02:09 -0500
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0C9C08C5F5;
        Wed,  9 Feb 2022 13:02:11 -0800 (PST)
Received: by mail-oo1-f46.google.com with SMTP id v17-20020a4ac911000000b002eac41bb3f4so3902456ooq.10;
        Wed, 09 Feb 2022 13:02:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uqMJ5pzDSIfGFtp8phHCNpFXexGgfsJe1tkP341IGSw=;
        b=eCaN/dAk9m9/Ot+H03Xylxi+leU18gPbg5dF529pD0LOOv/203smV8bzcaOMfZCjKy
         2Eu33ZSyuRD/0TArn3dLnW5AoRcAWUIJwX6F3VTjUqNnfZMx68avaNW6Zfr54TQPNVRK
         V52SQNI/FomvtE5BHv0mKTCO5Pznxmgz6kex7LRmP6oWY7Mft0we3rZ2NZhZovwMPXcE
         9JeIKJXyug2y1Gdffawkt9AIdrdKFWluyB3JQFGtQB4/+arA7sNhdZuf64inZZAFK22f
         O8QgHuUXrB4XM8RXtlvqj8S28ZfgOynSGPhTfKK2DloPITb0XpCsL0KKuMW7CNHYzTC1
         c3VA==
X-Gm-Message-State: AOAM532VjAZP91Q30Xi8rAjZ9O+4xn73gyeugHXClOHKFNKcrbHkx+/Y
        8o97xcpVPBSSlBvpkCVT6Q==
X-Google-Smtp-Source: ABdhPJzXACJWwdiM5VhZ/DDuTscLU4MFdCxK6TgQGBOID8HvPrRhukIR3/QEt6KA8gv9Ks5tKVBJ3Q==
X-Received: by 2002:a05:6870:e7c5:: with SMTP id q5mr1605332oak.284.1644440530853;
        Wed, 09 Feb 2022 13:02:10 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l15sm7101269ots.28.2022.02.09.13.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 13:02:09 -0800 (PST)
Received: (nullmailer pid 904638 invoked by uid 1000);
        Wed, 09 Feb 2022 21:02:09 -0000
Date:   Wed, 9 Feb 2022 15:02:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] ASoC: dt-bindings: samsung,snow: convert to
 dtschema
Message-ID: <YgQr0BTV4WDnDXrd@robh.at.kernel.org>
References: <20220129122357.45545-1-krzysztof.kozlowski@canonical.com>
 <20220129122430.45694-4-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129122430.45694-4-krzysztof.kozlowski@canonical.com>
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

On Sat, 29 Jan 2022 13:24:29 +0100, Krzysztof Kozlowski wrote:
> Convert the audio complex on Google Snow boards with Samsung Exynos SoC
> to DT schema format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/sound/samsung,snow.yaml          | 74 +++++++++++++++++++
>  .../devicetree/bindings/sound/snow.txt        | 31 --------
>  2 files changed, 74 insertions(+), 31 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/samsung,snow.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/snow.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
