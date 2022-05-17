Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBB75295BB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 02:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350526AbiEQAEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 20:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiEQAEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 20:04:30 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CECA40A09;
        Mon, 16 May 2022 17:04:29 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id j12so20615159oie.1;
        Mon, 16 May 2022 17:04:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v4STRcHnMatgEQR197RgHKy8LyvFwW+m6RPmmztPcD0=;
        b=k+94YHGqWnDnAdAqzfOI9yP2RFfLCm1jHYsyxt/bq2AbypihYhjrH0sdX+/Gc/zZtp
         ZKbUp3q7T3ollTYa7FoaUbKQAX0LwvC6U70AdrBEtWccDLR9NSvSUVSI2SiHUGXSAs0z
         IuSEWefPMabeJsiMH2tzain44b1TA6TMBZ0z9fexI3nmx0wz3o41JNe1BQ9Y3oa0Uf26
         Y/Ba03yKOhMALWmsy0nI6I7Tx4qi6siJgEtOB/WlALO1zWJG2kqHfGMKQA+RQeLeiekJ
         uk55e3QKm5Vq8IoyBZ0YKka5V6Igrgrh+JzXZ9xHVVsfF36be+yony8V6Iigf69oF+Cs
         0GHA==
X-Gm-Message-State: AOAM531mpg/n+90HtpCL+ZBeiySCfnJjcojzolSPnRqnCRkZ1r3vJKO1
        1HBIJqkBMPdo5fANssgxNg==
X-Google-Smtp-Source: ABdhPJwfrPdhplgtuJJnkIgFL9WjqMLk32l2nfeQM88QcWf/6HJcLmMomdYGa186dZi2YKYNru9ibA==
X-Received: by 2002:aca:1c18:0:b0:325:a6db:29fb with SMTP id c24-20020aca1c18000000b00325a6db29fbmr13787692oic.212.1652745868880;
        Mon, 16 May 2022 17:04:28 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d8-20020a056870e24800b000eb0e40b4b8sm6384188oac.48.2022.05.16.17.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 17:04:28 -0700 (PDT)
Received: (nullmailer pid 3607735 invoked by uid 1000);
        Tue, 17 May 2022 00:04:27 -0000
Date:   Mon, 16 May 2022 19:04:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel@lists.collabora.co.uk, Stephen Boyd <sboyd@kernel.org>,
        linux-mmc@vger.kernel.org, linux-clk@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-rockchip@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv2 16/21] dt-bindings: soc: rockchip: add initial rk3588
 syscon compatibles
Message-ID: <20220517000427.GA3607701-robh@kernel.org>
References: <20220504213251.264819-1-sebastian.reichel@collabora.com>
 <20220504213251.264819-17-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504213251.264819-17-sebastian.reichel@collabora.com>
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

On Wed, 04 May 2022 23:32:46 +0200, Sebastian Reichel wrote:
> Add IOC and PHP GRF syscon compatibles for RK3588.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
