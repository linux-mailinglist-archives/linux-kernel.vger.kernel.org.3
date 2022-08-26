Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091435A23FB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 11:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343500AbiHZJRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 05:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245675AbiHZJRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:17:19 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644D1D598F
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:17:17 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bt10so1236596lfb.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=kWwbtT/54FyUEO6wWPpRIwL8GLUA5z0zpRQ+oeLgI4Q=;
        b=uJjezohYlWYNbj23GA51zYTVzXsn8I7264i22VBOIJep8GJraT5Hxo5M2oUcFlo9t8
         miozsWwpM3suEEtBt/XymJNCw64FRkiKlXgLuk+td0iSoBnLuR3IjxKDuSMEg1oOIAx2
         YaYjoRrDhOf1VkNfbMKgnBkwWrze5ZOktyz2+9aItoZaAoCq3E50LjaR4Vd7q3llBgek
         uymRe4/ctK+sj5GKuRojGTMF93WUrWkgQ+kaPtPbme2aSJoAJvPusqJ8rkCY3JZDJVRD
         mD23zRydF7fb5y61iBYTCxjfz2nhqt9YuXXWADe6g2P+GZhJGHmj6S8qeAZ9UvB/QttY
         masg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=kWwbtT/54FyUEO6wWPpRIwL8GLUA5z0zpRQ+oeLgI4Q=;
        b=JpZd5jCnrfB6hra5A4AgLOH5YHU5lHh/WUcbsPkQ7jlbGZCIkSsK/da6Kf/uOz0XIy
         OD6kKrgk1ztaTYOdhv490uytQUEcbo9SNoxcK+LX47aAexXRnZCnfZLAP7iUgDaSN734
         7dv8smUtWQDtJZ0fcLBUC/hV/668hKZEt5gpRlJ9uRuk11mEjxwawJ6v/n8bsSS43G4b
         dHjQQDrdiAEVcifWSWjvGukcwvUYpOTsuicgumw99bYo5BAILQ1G4Bg8z+5WMppVcLUn
         owk+rWzv6yGTnMDefhDNOb0foLk8ftTwzp2+Qha0mSQjpQT6pEkXlHs7Hvpdlgra3QkG
         Ndvg==
X-Gm-Message-State: ACgBeo2Rwk+UUJyrqyLV7NscHCbn1DL9Z53IuC94RDMdsxDaUnw93y2e
        F8t69HS024WKDmxJmSsbg2iL/VI0ZN9lhwXVpSeKaQ==
X-Google-Smtp-Source: AA6agR6c3bAZ3/2TopOviym18sXnze1yRcZBfeJcwIh55DYHGT4eqQP86GgpcX4QIr2GKajCvRrr7MX6kWdrKaBnJ2o=
X-Received: by 2002:a05:6512:6ca:b0:492:ef21:c085 with SMTP id
 u10-20020a05651206ca00b00492ef21c085mr2340299lff.71.1661505435752; Fri, 26
 Aug 2022 02:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220819190729.32358-1-a-nandan@ti.com> <20220819190729.32358-3-a-nandan@ti.com>
In-Reply-To: <20220819190729.32358-3-a-nandan@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 26 Aug 2022 11:16:38 +0200
Message-ID: <CAPDyKFpn+3MUA-Vp9cnY8a=rpg0kLQk0_c5+4=FgF0FbW7mxLg@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: mmc: Fix 'dma-coherent' was unexpected
To:     Apurva Nandan <a-nandan@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        Hari Nagalla <hnagalla@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Aug 2022 at 21:07, Apurva Nandan <a-nandan@ti.com> wrote:
>
> dma-coherent is mentioned in almost all TI K3 platform mmc
> nodes. Fix warning generated due to its missing match in
> yaml schema.
>
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-am654.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> index 0ab07759b472..ea9121fb188d 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> @@ -51,6 +51,9 @@ properties:
>
>    sdhci-caps-mask: true
>
> +  dma-coherent:
> +    type: boolean
> +
>    # PHY output tap delays:
>    # Used to delay the data valid window and align it to the sampling clock.
>    # Binding needs to be provided for each supported speed mode otherwise the
> --
> 2.17.1
>
