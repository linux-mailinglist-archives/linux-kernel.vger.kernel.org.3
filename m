Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF4752957F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 01:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349052AbiEPXtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 19:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348163AbiEPXta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 19:49:30 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7144A3E5DF;
        Mon, 16 May 2022 16:49:29 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-f189b07f57so8783064fac.1;
        Mon, 16 May 2022 16:49:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RVhdYRsH1wOBb6tq7hHf/sKGXBHaPx+8CRN3GtKz0gI=;
        b=VSOQoPnOy8osVldQ0JwVDTYvWM3/EyD9PV06enstwRLmpm+jLcj9+Jcrb5csxza22/
         aFoDzUbdtJMPZxDM7n+vyxFburItyr+hfU3K3Ta+h0WtG6nUG2/np8NyeJQPwC/cIUjL
         Dh1AI2Y1YN6ufAq6vk/5LUZ+EuEu322nPzsaAgMRYVL4fZjC3ei2lBL+2EEl0p/itzz8
         n2tPl8aAyaC2131Q+bmZnAhLMDAwsNaFZinJ2xcuS+wJP6iXIkQvPLcmF0txENQzq7Qy
         hFUWLhPcxqiMpPxQWu92EIDKBJoloUY2c69HoASrz93hocNUT1OIMcY+gpPHoqvvlXoE
         UgXw==
X-Gm-Message-State: AOAM533srDcxat7Mz9TrUEfJVemZJY3QCD7wLY5ATblqJ/5vC5OjoEbE
        8+B4dIoWGlEalVJqYkcIDg==
X-Google-Smtp-Source: ABdhPJw64qmMf6hF6uFHOu6opKTOZ5XCwwNHoa14aVFcSxQjLzTHedcTcj7LzCiWChH+py5Al0JXrw==
X-Received: by 2002:a05:6870:73c9:b0:f1:86e3:fa15 with SMTP id a9-20020a05687073c900b000f186e3fa15mr6527074oan.248.1652744968802;
        Mon, 16 May 2022 16:49:28 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n20-20020a9d7414000000b0060603221276sm4361473otk.70.2022.05.16.16.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 16:49:28 -0700 (PDT)
Received: (nullmailer pid 3564415 invoked by uid 1000);
        Mon, 16 May 2022 23:49:26 -0000
Date:   Mon, 16 May 2022 18:49:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        Miles Chen <miles.chen@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Sam Shih <sam.shih@mediatek.com>, linux-kernel@vger.kernel.org,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        devicetree@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 02/13] dt-bindings: reset: Add MT6735 reset bindings
Message-ID: <20220516234926.GA3564356-robh@kernel.org>
References: <20220504122601.335495-1-y.oudjana@protonmail.com>
 <20220504122601.335495-3-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504122601.335495-3-y.oudjana@protonmail.com>
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

On Wed, 04 May 2022 16:25:51 +0400, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add reset definitions for Mediatek MT6735 resets provided by
> infracfg and pericfg.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  MAINTAINERS                                   |  2 ++
>  .../reset/mediatek,mt6735-infracfg.h          | 31 +++++++++++++++++++
>  .../reset/mediatek,mt6735-pericfg.h           | 31 +++++++++++++++++++
>  3 files changed, 64 insertions(+)
>  create mode 100644 include/dt-bindings/reset/mediatek,mt6735-infracfg.h
>  create mode 100644 include/dt-bindings/reset/mediatek,mt6735-pericfg.h
> 

Acked-by: Rob Herring <robh@kernel.org>
