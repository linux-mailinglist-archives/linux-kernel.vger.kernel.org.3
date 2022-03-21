Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13924E2FE8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 19:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352124AbiCUSZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 14:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352118AbiCUSZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 14:25:02 -0400
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB061205F8;
        Mon, 21 Mar 2022 11:23:36 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id y27-20020a4a9c1b000000b0032129651bb0so20207819ooj.2;
        Mon, 21 Mar 2022 11:23:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ku41EwMrpike2rw1zkBgegHuSBM8D1pxwnRie00HI3s=;
        b=ifa5iJdQpJAqwQD9NDVar3BiAxcUtXDmy5m3ssz6e4Z12t9RLt+MuTXvD967hNRIat
         99Pztr17EW8CUifk0CiFU2wswSvwUQZApytCMY6ROO8rPwaieU9kMNdPj885FcZnLKwP
         h9EZDEt0p6MRGAqZRTuy2tbh7eHUDAG8UPueAk1/D5uv93MjqgM3fh8o9+7jO6sUGhs8
         mCTGU4V3HznQYL+oIlI0R3aqZREWoHND9NYU8se1tfjXHCSQr9tjGbl8oTtt2hiF3BWd
         Vjt+kwVmQ2Q5RyyAS8AoZ+tfrPYmmBmXHL8T4DcIHmMDV5hIEaYYkv6kOhkaMvQTv4+m
         0NcA==
X-Gm-Message-State: AOAM532O0FP7cuSIc6oY2Gi6frPT52qvUPzC5uaGG/EAZ+IOSLrTrC5R
        /E+wdRXV7/D7hXrU3vqksg==
X-Google-Smtp-Source: ABdhPJxEbbdQHTHasMqPbVoEvSXN5GqzSXj2JN10aOeMu119s+b2yNq16XRHjwNknIXSn2Ux3/bbGg==
X-Received: by 2002:a05:6870:4586:b0:da:6a35:fcd with SMTP id y6-20020a056870458600b000da6a350fcdmr182637oao.140.1647887016156;
        Mon, 21 Mar 2022 11:23:36 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bm51-20020a0568081ab300b002da5c44e0bdsm7304841oib.28.2022.03.21.11.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 11:23:35 -0700 (PDT)
Received: (nullmailer pid 319364 invoked by uid 1000);
        Mon, 21 Mar 2022 18:23:33 -0000
Date:   Mon, 21 Mar 2022 13:23:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Alexander Shiyan <shc_work@mail.ru>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Jesse Taube <Mr.Bossman075@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: [PATCH 2/2] dt-bindings: clock: drop useless consumer example
Message-ID: <YjjCpQ9vwFoEmFFi@robh.at.kernel.org>
References: <20220316130858.93455-1-krzysztof.kozlowski@canonical.com>
 <20220316130858.93455-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316130858.93455-2-krzysztof.kozlowski@canonical.com>
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

On Wed, Mar 16, 2022 at 02:08:58PM +0100, Krzysztof Kozlowski wrote:
> Consumer examples in the bindings of resource providers are trivial,
> useless and duplication of code.  Remove the example code for consumer
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/clock/bitmain,bm1880-clk.yaml           | 12 ------------
>  .../devicetree/bindings/clock/idt,versaclock5.yaml   |  7 -------
>  .../devicetree/bindings/clock/imx1-clock.yaml        |  9 ---------
>  .../devicetree/bindings/clock/imx21-clock.yaml       |  9 ---------
>  .../devicetree/bindings/clock/imx23-clock.yaml       |  9 ---------
>  .../devicetree/bindings/clock/imx25-clock.yaml       |  8 --------
>  .../devicetree/bindings/clock/imx27-clock.yaml       |  9 ---------
>  .../devicetree/bindings/clock/imx28-clock.yaml       |  9 ---------
>  .../devicetree/bindings/clock/imx31-clock.yaml       |  8 --------
>  .../devicetree/bindings/clock/imx35-clock.yaml       |  8 --------
>  .../devicetree/bindings/clock/imx7ulp-pcc-clock.yaml | 11 -----------
>  .../devicetree/bindings/clock/imx7ulp-scg-clock.yaml | 11 -----------
>  .../devicetree/bindings/clock/imx8qxp-lpcg.yaml      | 11 -----------
>  .../devicetree/bindings/clock/imxrt1050-clock.yaml   |  8 --------
>  .../bindings/clock/nvidia,tegra124-car.yaml          |  7 -------
>  .../bindings/clock/nvidia,tegra20-car.yaml           |  7 -------
>  16 files changed, 143 deletions(-)

Doesn't apply to my tree (no imxrt1050-clock.yaml), so

Acked-by: Rob Herring <robh@kernel.org>
