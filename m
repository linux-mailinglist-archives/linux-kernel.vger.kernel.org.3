Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC4452957A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 01:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349098AbiEPXsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 19:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348163AbiEPXsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 19:48:30 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1745D3E0FA;
        Mon, 16 May 2022 16:48:29 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id m25so20564904oih.2;
        Mon, 16 May 2022 16:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x5LTIsaWOZ1f/mxn/cSQ8aiFsbE9yJUuVihPv1xCLlc=;
        b=SGht4dtQ8vD76za2dV2LqCjwhXiJiVcMmFB+/NJmv/nDhIZBTAOflObUwuhqdfN/wk
         KzeDMW/sO/zWQ94nd5MJtG4UXhVxgnqvJKUNvwvS6gdGEU8zaYgYKcW8kQ+LB26JkP8a
         WwISY1HSmqXDewZEOw60AG5tRHhiFWeeAuqfI+vkdZENHjTj15ZEBir/T+FUhn9oa8qS
         bf6dajoWPDuWES1LtCv1ezrhJfP/6XVb1yCCfgfFwNAlT1Gk+igOx3CCsasqmvAMiZdD
         gdI8NKzXNa3hXeNHbiNc7Q9K9BbtkNJBm4cWxrCcyOAmkEPv2D2Dtmk9OUDbGmeHlIiK
         E14Q==
X-Gm-Message-State: AOAM533iq5/AhWOYQGIFViTQBZwUltcaclphpBPUpIbgmxeJyM/VvR09
        O0kpWl+EJjpUVPFwDGDkQw==
X-Google-Smtp-Source: ABdhPJzUTvob60phC3sXqn1ijohn0Mstb3isikonSGXRcErxRuL+nbisyBQbWnEoaQYItLPI3NWDgg==
X-Received: by 2002:a05:6808:14c2:b0:326:c129:d308 with SMTP id f2-20020a05680814c200b00326c129d308mr8919957oiw.193.1652744908349;
        Mon, 16 May 2022 16:48:28 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id fo26-20020a0568709a1a00b000e686d1387csm6038708oab.22.2022.05.16.16.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 16:48:27 -0700 (PDT)
Received: (nullmailer pid 3562715 invoked by uid 1000);
        Mon, 16 May 2022 23:48:26 -0000
Date:   Mon, 16 May 2022 18:48:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Miles Chen <miles.chen@mediatek.com>,
        devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Sam Shih <sam.shih@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 01/13] dt-bindings: clock: Add Mediatek MT6735 clock
 bindings
Message-ID: <20220516234826.GA3562658-robh@kernel.org>
References: <20220504122601.335495-1-y.oudjana@protonmail.com>
 <20220504122601.335495-2-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504122601.335495-2-y.oudjana@protonmail.com>
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

On Wed, 04 May 2022 16:25:50 +0400, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add clock definitions for Mediatek MT6735 clocks provided by
> apmixedsys, topckgen, infracfg and pericfg.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  MAINTAINERS                                   | 10 +++
>  .../clock/mediatek,mt6735-apmixedsys.h        | 16 ++++
>  .../clock/mediatek,mt6735-infracfg.h          | 25 ++++++
>  .../clock/mediatek,mt6735-pericfg.h           | 37 +++++++++
>  .../clock/mediatek,mt6735-topckgen.h          | 79 +++++++++++++++++++
>  5 files changed, 167 insertions(+)
>  create mode 100644 include/dt-bindings/clock/mediatek,mt6735-apmixedsys.h
>  create mode 100644 include/dt-bindings/clock/mediatek,mt6735-infracfg.h
>  create mode 100644 include/dt-bindings/clock/mediatek,mt6735-pericfg.h
>  create mode 100644 include/dt-bindings/clock/mediatek,mt6735-topckgen.h
> 

Acked-by: Rob Herring <robh@kernel.org>
