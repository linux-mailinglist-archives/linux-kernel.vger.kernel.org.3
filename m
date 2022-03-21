Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F55F4E2FD8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 19:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352070AbiCUSXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 14:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243327AbiCUSXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 14:23:38 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BE751597;
        Mon, 21 Mar 2022 11:22:12 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id n7so17111723oif.5;
        Mon, 21 Mar 2022 11:22:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jPpBt5CMXkZhRhdIU/BLWvRxEOokz8q1mszwxpflsEk=;
        b=XF7rIvdZexGkjfe41RVMWdfGcqzIr7iwZLjVshMh5SLe5aAwsDz2AT6jmqd0xZFYy7
         ICf4Oo0LnYSkOCrvhnAsXXAnkmYKO3OkhwRjET/g+t6hQs5IuhGml+eUTkYWjk4cBV96
         3Je6un88IEe8nUZv3H5F3c/Udvch0Gb0MCiahkDOukm2UqR3pxhDPJ6IPGCvQIMJsHaW
         6ntTlfbEtmm4wKsJeMeu0kpFyDFa5GpgiUTJF9beSbcBFbFrLXQub9Dalc7BMFrrG++j
         jEqEwvWQL02uHxKK81DzAzzdUbiqOcqorGWHT68Oz7XWbNdQb6SwA6lLZ2q5tbQuouCF
         CtXA==
X-Gm-Message-State: AOAM531jphNzht4uQOssSRCA0hcbU6wYqsrebTN5G0XD9wDoEko7JAuv
        vRmsqh0z+zJUaJ577KJ73Q==
X-Google-Smtp-Source: ABdhPJyhSCB8epzuBfPCHNF2aPHzZ9GS2sNitb9TnzDDC3cqg3Wa304fSoHZHvmLZQ3TEkGP/RIklw==
X-Received: by 2002:a05:6808:1b22:b0:2da:7725:f278 with SMTP id bx34-20020a0568081b2200b002da7725f278mr244489oib.90.1647886932051;
        Mon, 21 Mar 2022 11:22:12 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z26-20020a9d62da000000b005b23f5488cdsm7523947otk.52.2022.03.21.11.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 11:22:11 -0700 (PDT)
Received: (nullmailer pid 317197 invoked by uid 1000);
        Mon, 21 Mar 2022 18:22:09 -0000
Date:   Mon, 21 Mar 2022 13:22:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-gpio@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-clk@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        Jesse Taube <Mr.Bossman075@gmail.com>,
        linux-tegra@vger.kernel.org, Alexander Shiyan <shc_work@mail.ru>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 1/2] dt-bindings: gpio: pca95xx: drop useless consumer
 example
Message-ID: <YjjCUUz5yiQQK2Q3@robh.at.kernel.org>
References: <20220316130858.93455-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316130858.93455-1-krzysztof.kozlowski@canonical.com>
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

On Wed, 16 Mar 2022 14:08:57 +0100, Krzysztof Kozlowski wrote:
> Consumer examples in the bindings of resource providers are trivial,
> useless and duplication of code.  Remove the example code for consumer
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml | 8 --------
>  1 file changed, 8 deletions(-)
> 

Applied, thanks!
