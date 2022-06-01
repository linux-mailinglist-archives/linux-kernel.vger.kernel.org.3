Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1ADB53ADFE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 22:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiFAUsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 16:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiFAUrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 16:47:05 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809666F4B1;
        Wed,  1 Jun 2022 13:38:48 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id k11so4113108oia.12;
        Wed, 01 Jun 2022 13:38:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xRz8WTc++E/Jydb7FMNOLlt8oZQ5VXJmtj71a3RfnaY=;
        b=dE/Ds7dqsbj65pHGUjo3EZVYxqf4qMCi6+Upwb38VuZemlwfsxzkDUcdqhA+Nwd0Pl
         fMAiI5oeQnx0pras+CXjGvzlel7CudiKdouVaJU3hf4ise4Au3dEVddMg4GsqaXV2Bdu
         Y+KdX6sLiShHlX/h1+du31GxwNFdRvzLQVng0fYzWBHlajqzu3EqNVkg6FzJr64i4Tzs
         4gAkcyvApKq2LDUbnUjMfcgaUABxx2TvgL/WD5D/CPNsvluxpPjuqPk+t1SWpgz+0aM6
         j5V3vB684xnkAGQWop3sVVZCkkwkKToCGrNZ5qKlC0GmPw6hpJxjYfJXhWzWm+akC9ia
         epRg==
X-Gm-Message-State: AOAM533hX0SbiDYSH958YTgxDc07GAWfHZJ81jrAzWOTgvs/R9/YG6Jp
        vaMH7v7KY5UScHeNYuAFiK/C0Q3WCg==
X-Google-Smtp-Source: ABdhPJxcJb/XqsmIRQMb2lYc01pOYbvBfafkRH51jgoAfdrhlG47KxqXZcw3D1gUMxkbvYi213aErA==
X-Received: by 2002:a05:6808:1599:b0:32b:18e3:3e04 with SMTP id t25-20020a056808159900b0032b18e33e04mr15943062oiw.227.1654113754778;
        Wed, 01 Jun 2022 13:02:34 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i15-20020a056871028f00b000f342119f41sm1064127oae.42.2022.06.01.13.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 13:02:34 -0700 (PDT)
Received: (nullmailer pid 340030 invoked by uid 1000);
        Wed, 01 Jun 2022 20:02:33 -0000
Date:   Wed, 1 Jun 2022 15:02:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     y.oudjana@protonmail.com, miles.chen@mediatek.com,
        matthias.bgg@gmail.com, linux-clk@vger.kernel.org,
        kernel@collabora.com, wenst@chromium.org,
        devicetree@vger.kernel.org, rex-bc.chen@mediatek.com,
        martin.botka@somainline.org, chun-jie.chen@mediatek.com,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        weiyi.lu@mediatek.com, konrad.dybcio@somainline.org,
        linux-mediatek@lists.infradead.org, p.zabel@pengutronix.de,
        ikjn@chromium.org, paul.bouchara@somainline.org,
        fparent@baylibre.com, sam.shih@mediatek.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        marijn.suijten@somainline.org, sboyd@kernel.org,
        ck.hu@mediatek.com, mturquette@baylibre.com,
        linux-arm-kernel@lists.infradead.org, tinghan.shen@mediatek.com,
        jason-jh.lin@mediatek.com, bgolaszewski@baylibre.com
Subject: Re: [PATCH v2 3/7] dt-bindings: reset: Add bindings for MT6795 Helio
 X10 reset controllers
Message-ID: <20220601200233.GA339992-robh@kernel.org>
References: <20220518111652.223727-1-angelogioacchino.delregno@collabora.com>
 <20220518111652.223727-4-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518111652.223727-4-angelogioacchino.delregno@collabora.com>
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

On Wed, 18 May 2022 13:16:48 +0200, AngeloGioacchino Del Regno wrote:
> Add the reset controller bindings for MT6795.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  include/dt-bindings/reset/mt6795-resets.h | 50 +++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 include/dt-bindings/reset/mt6795-resets.h
> 

Acked-by: Rob Herring <robh@kernel.org>
