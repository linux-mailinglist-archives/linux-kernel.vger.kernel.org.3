Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998835829CF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 17:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbiG0PkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 11:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbiG0PkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 11:40:20 -0400
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16DD60C2;
        Wed, 27 Jul 2022 08:40:19 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id d4so9006575ilc.8;
        Wed, 27 Jul 2022 08:40:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t3FU8d4Wj0M3Eyh9HoxKqYpBbMzTEHv/yrad80ETmLM=;
        b=fR5FECsJJydlsO1Rp/lnHYyuKt3Z5o271o7GDFoF14ZkM0lX9De6WXPZBzFVpt13VE
         B4Fz+R/x7Ob2RQpwhVO5mSkRVVLPiMXHkONqjM9CPWenfGseNakjSiVScF4lxNHyrtwh
         HQDu+OCtr3WUX43qegO2evBxlmZa2DTWj6nO4uL3yrcGROKRi1o9q+XPglk7uhtLRZ3+
         4aaGaQ8vXsMXmkzpoj9jbTP4U7OXtBU7cT4cT5THXCpnqIlSnEU7xc13bPHp4tZvSZen
         kTPwwWjVdh/kgUD3aNfaZSdxJ0MI1q1AmeXi752G6+NMsNwsnCUPZ7dSSTa6T3bBBzLz
         KUdQ==
X-Gm-Message-State: AJIora+W3fxrtnVgW1E49JbTJa6ot7sJtBC54Pd/Pic9x+mFlPesDqfo
        Sf1OaBpVa0HWcrPXmHCfq2JrqA+F1w==
X-Google-Smtp-Source: AGRyM1t20vXhVdoB7I3TKoBxYqHb5rVTy2avw7tGmc9yR+PHWyeHgKTvBxryzQ/rY+Tf9/sCSO06FQ==
X-Received: by 2002:a05:6e02:1bca:b0:2dc:c06d:9212 with SMTP id x10-20020a056e021bca00b002dcc06d9212mr8254407ilv.58.1658936419106;
        Wed, 27 Jul 2022 08:40:19 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id m128-20020a6b3f86000000b006794eecbce3sm8507967ioa.18.2022.07.27.08.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 08:40:18 -0700 (PDT)
Received: (nullmailer pid 2722149 invoked by uid 1000);
        Wed, 27 Jul 2022 15:40:16 -0000
Date:   Wed, 27 Jul 2022 09:40:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: renesas: Document RZ/Five SoC
Message-ID: <20220727154016.GA2719108-robh@kernel.org>
References: <20220726175315.1147-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726175315.1147-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 06:53:15PM +0100, Lad Prabhakar wrote:
> RZ/Five SoC is pin compatible with RZ/G2UL (Type 1) SoC. This patch
> updates the comment to include RZ/Five SoC so that we make it clear
> "renesas,r9a07g043-pinctrl" compatible string will be used for RZ/Five
> SoC.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  .../devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml      | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Same comments as here[1].

Rob

[1] https://lore.kernel.org/all/20220727153738.GA2696116-robh@kernel.org/
