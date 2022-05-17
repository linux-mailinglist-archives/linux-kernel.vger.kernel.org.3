Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FD55295C6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 02:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbiEQAFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 20:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbiEQAFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 20:05:09 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DE740A0C;
        Mon, 16 May 2022 17:05:08 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-f16a3e0529so11994022fac.2;
        Mon, 16 May 2022 17:05:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jWYtWpLhhjBqtuLhNRQ5oLKTvb74DusGXdvkLvUpC1U=;
        b=FKQHhk/e/kXiyL2tpet80LQHxjJcEj5upXGqZ/f3Cx4FpuuWXYn91GkUYebBkfUqf6
         Oc0/C1mQqzgZJaGG7eHiUjXkD63VdQnAzlIicFlRubVfjr1m2/13k7WSSUY0LpbK4Mig
         6sPafop0UXiSp2d5U5g23ggHp9FpY+pNiOr87bOHgPhij2F5x9QtWxbbvfDMbgNhn1Af
         fGLAxBfoBJ/2s5i6nn5Il+zTQs9apfGgsu/EibGxNuz5LATF9aJIh+p6w0pW7N3fzB0l
         juD+3BYGpP0IlUxahyD1gNPPAbhf4enPtGSuw30BrJzMurwDpP5FPTqlcGNilY1kQrob
         rauw==
X-Gm-Message-State: AOAM530Lj2gS5KZAtgTq5zhcK5uwIo480NBIsTtlqOPP/TcTJ6Zk7VI3
        bpOPesrW/r3BoZyHqpZ2Sw==
X-Google-Smtp-Source: ABdhPJyhQpNe3I/6mrl2AJB/BeKrGiDth8qUcXzNQTW3WZuAhG5ZIixm4jAYljeHufC/IzN0icKCog==
X-Received: by 2002:a05:6870:524a:b0:f1:28ae:f9cc with SMTP id o10-20020a056870524a00b000f128aef9ccmr11200403oai.269.1652745907961;
        Mon, 16 May 2022 17:05:07 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h13-20020a4ab44d000000b0035eb4e5a6d1sm4671362ooo.39.2022.05.16.17.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 17:05:07 -0700 (PDT)
Received: (nullmailer pid 3609021 invoked by uid 1000);
        Tue, 17 May 2022 00:05:06 -0000
Date:   Mon, 16 May 2022 19:05:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-gpio@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@lists.collabora.co.uk, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com, Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCHv2 18/21] dt-bindings: pinctrl: rockchip: increase max
 amount of device functions
Message-ID: <20220517000506.GA3608979-robh@kernel.org>
References: <20220504213251.264819-1-sebastian.reichel@collabora.com>
 <20220504213251.264819-19-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504213251.264819-19-sebastian.reichel@collabora.com>
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

On Wed, 04 May 2022 23:32:48 +0200, Sebastian Reichel wrote:
> RK3588 can have 10 different device functions, so increase the maximum
> amount appropriately. Considering rockchip uses auto-generated pinmux
> files, adding a quite complex if construct to increase the limit just
> for rk3588 does not seem to be worth the effort.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
