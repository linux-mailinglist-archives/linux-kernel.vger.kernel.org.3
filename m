Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5655053B9EE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 15:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbiFBNhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 09:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbiFBNg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 09:36:58 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CEC38BFE;
        Thu,  2 Jun 2022 06:36:52 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id w130so6616387oig.0;
        Thu, 02 Jun 2022 06:36:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pwfbSlcoi2C5nDJgDNKyjclPhwf+l/0Xc9Z6UrC0aU0=;
        b=cZAWqLcUgB/uw0sG0OHI58jLiJVldyrOB9jdnyu2kGVVmKD3TDRoRrHlUnIAdKC8Lz
         dCuW2jqnCVwPAehOEMavDp3raNvEPWgUizoLSQzAPPlT9vXfRFJdF9FqPf14iRT/emko
         fs15A33bDAReQnFyb35qTIJfQ2RyyUZHMgNOP0APgPxGEYsDhZeHDhdih4OeHH6FdSLk
         dxG3wOlwTilOWpQmkqCYOpUurwZ5F0FFLiWB9NJ0+Da1WBwQ6jJkA4RIfsJFIN8RMoJE
         IW/Pd1uEtO/C2giXYbo2qMh+LjQEv0xpyQsqp9t7iQhwBG6oYNYCzXom8WLoyTVNoU/d
         Tz4A==
X-Gm-Message-State: AOAM532SR3siV58HgXeE8jk+DaCpJynV21dF0hlXsK1+Y0vGH6rmbYlT
        M23lJbVUHRyXG3gYWxLKmQ==
X-Google-Smtp-Source: ABdhPJyrAZUWQ0T2CZPatmZOUh88Y6+3CIiOzGsT97Tx4iCEE988ZVcRncw7dgmawOZ42YndW6Kv3Q==
X-Received: by 2002:a05:6808:1448:b0:326:e239:a490 with SMTP id x8-20020a056808144800b00326e239a490mr18668182oiv.253.1654177011518;
        Thu, 02 Jun 2022 06:36:51 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w5-20020a056808140500b00326cb6225f8sm2412022oiv.44.2022.06.02.06.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 06:36:51 -0700 (PDT)
Received: (nullmailer pid 2163694 invoked by uid 1000);
        Thu, 02 Jun 2022 13:36:50 -0000
Date:   Thu, 2 Jun 2022 08:36:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-tegra@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v5 4/5] dt-bindings: pinctrl: renesas,rzg2l-pinctrl:
 Document the properties to handle GPIO IRQ
Message-ID: <20220602133650.GA2163633-robh@kernel.org>
References: <20220523174238.28942-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220523174238.28942-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523174238.28942-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On Mon, 23 May 2022 18:42:37 +0100, Lad Prabhakar wrote:
> Document the required properties to handle GPIO IRQ.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  .../bindings/pinctrl/renesas,rzg2l-pinctrl.yaml   | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
