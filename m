Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908065624E3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 23:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236976AbiF3VKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 17:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbiF3VKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 17:10:09 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E281220195;
        Thu, 30 Jun 2022 14:10:08 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id p13so233841ilq.0;
        Thu, 30 Jun 2022 14:10:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rjdHED37H0OUB684Aslr4zF7ujtW00cOnAULxFJZi2s=;
        b=NpfRqdsAMOexiWGqGeSORc7fOhgMGiWSLTV4ycQH8QhK9n1Mz+/AZ/UGm/rlPwh7K6
         2tQIdIKXBgsD+Dl3xIVeEhF6habBJ/2ZlK2jvyF2y6nRdM2+IMXmbwCHGrJ4ZajiRV7S
         liJWhxS45+pm9WW4ui/lDq+BNI6sOJ1m2SsyTZi1oZ0p8jcZLqigkFeRFxbZwHoNzLlQ
         EhV1cnP8ZW/MA7If/Bhr0WO2tSO9z9n9QzsH4029qr6uVR9sx2D+vCdcsD6ZoMoFwv+C
         cRFaAz4apd8Vpr9heX7N3wlhwmULqdb/RKdM76163InYEfSwo/2l8WpRXd+AR514wrhk
         V2HA==
X-Gm-Message-State: AJIora/1bD+ukYA1plEzb3OK90dVsds+nsugy7P7jVfh5fXSbeesC487
        ASorf37rd0jiCy1/VL2OaW1RRUVUww==
X-Google-Smtp-Source: AGRyM1sb8JdYuHxyemtwGY0+ubzfkotm4D+9kKuqhtvxDwhx7morcyWKXDm1LlxKB6K0jnyQPNch7Q==
X-Received: by 2002:a92:9412:0:b0:2da:7fb4:435d with SMTP id c18-20020a929412000000b002da7fb4435dmr6483187ili.33.1656623408168;
        Thu, 30 Jun 2022 14:10:08 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id f26-20020a02241a000000b00339f1d1c090sm8874407jaa.113.2022.06.30.14.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 14:10:07 -0700 (PDT)
Received: (nullmailer pid 3303222 invoked by uid 1000);
        Thu, 30 Jun 2022 21:10:02 -0000
Date:   Thu, 30 Jun 2022 15:10:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     martin.botka@somainline.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, y.oudjana@protonmail.com,
        sboyd@kernel.org, bgolaszewski@baylibre.com,
        jason-jh.lin@mediatek.com, ikjn@chromium.org,
        rex-bc.chen@mediatek.com, matthias.bgg@gmail.com,
        paul.bouchara@somainline.org, sam.shih@mediatek.com,
        linux-mediatek@lists.infradead.org, marijn.suijten@somainline.org,
        ck.hu@mediatek.com, p.zabel@pengutronix.de,
        miles.chen@mediatek.com, mturquette@baylibre.com,
        weiyi.lu@mediatek.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-kernel@lists.infradead.org, tinghan.shen@mediatek.com,
        konrad.dybcio@somainline.org, chun-jie.chen@mediatek.com,
        fparent@baylibre.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, wenst@chromium.org,
        kernel@collabora.com
Subject: Re: [PATCH v5 4/7] dt-bindings: clock: mediatek: Add clock driver
 bindings for MT6795
Message-ID: <20220630211002.GA3303158-robh@kernel.org>
References: <20220629110254.184213-1-angelogioacchino.delregno@collabora.com>
 <20220629110254.184213-5-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629110254.184213-5-angelogioacchino.delregno@collabora.com>
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

On Wed, 29 Jun 2022 13:02:51 +0200, AngeloGioacchino Del Regno wrote:
> Add the bindings for the clock drivers of the MediaTek Helio X10
> MT6795 SoC.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/clock/mediatek,mt6795-clock.yaml | 66 +++++++++++++++++++
>  .../clock/mediatek,mt6795-sys-clock.yaml      | 54 +++++++++++++++
>  2 files changed, 120 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt6795-clock.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt6795-sys-clock.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
