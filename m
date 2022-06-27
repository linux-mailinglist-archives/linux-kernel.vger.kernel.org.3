Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C2255C86B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235929AbiF0Nbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbiF0NbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:31:20 -0400
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9571B6457;
        Mon, 27 Jun 2022 06:31:19 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id a16so6020032ilr.6;
        Mon, 27 Jun 2022 06:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=e0YdyNDNHfoLjY/B6VaUfC4jZi5UF0V29yd+MqAfjd8=;
        b=68AL9koxtSs/3HjE85mIUsFg5/A0Hn+SdL+g9iUkKPuwLPZL+sdoFzQv/2v+DFV4uw
         SJ3yJzv7U1A7v2yXvb5eWLOJOYnbjq7bMekNJJ6JGzGrAuZNt0Xw542+xBkCrWwNeo2y
         pHYudGulZ/Q/tWdeFICes1RvS/8Y7KTlCVI01lFfvUoL9DWdcQDJo+ZOE2n2ufStGsnK
         JJ6ErdLAjWKscog5pkUKP7Pbvc8LKhu+vmzjmZOYvgrL7PlAtTwJMwwnBeAHGPYaUlLX
         FMxyfSQr3oL5YYPvaBHoYBVhP0USVJUQ+IR1nucq71jTzWNueu/3HvxMZ9jlDA3wdDuv
         OWag==
X-Gm-Message-State: AJIora/2fz1BX9A8rGOud+aaAKEAXa7k02ucj143atu1X7IE8UBltHpg
        bklP2tpKCF9uw1bApiA0Wg==
X-Google-Smtp-Source: AGRyM1vEEEhnghUvEvoMNkCRM2MJy0M56TmHGYSJhVoccPP4WQGcqcvf8lzrpCi+otOX48sba38IeQ==
X-Received: by 2002:a92:c743:0:b0:2da:a849:511b with SMTP id y3-20020a92c743000000b002daa849511bmr124717ilp.109.1656336678835;
        Mon, 27 Jun 2022 06:31:18 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id v28-20020a02b09c000000b0032e0851ea0fsm4794533jah.10.2022.06.27.06.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 06:31:18 -0700 (PDT)
Received: (nullmailer pid 2285172 invoked by uid 1000);
        Mon, 27 Jun 2022 13:31:09 -0000
From:   Rob Herring <robh@kernel.org>
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, granquet@baylibre.com,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, matthias.bgg@gmail.com,
        dri-devel@lists.freedesktop.org, chunkuang.hu@kernel.org,
        airlied@linux.ie, linux-fbdev@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        daniel@ffwll.ch, msp@baylibre.com, wenst@chromium.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com, deller@gmx.de,
        tzimmermann@suse.de, ck.hu@mediatek.com,
        linux-arm-kernel@lists.infradead.org, mripard@kernel.org,
        jitao.shi@mediatek.com
In-Reply-To: <20220627080341.5087-2-rex-bc.chen@mediatek.com>
References: <20220627080341.5087-1-rex-bc.chen@mediatek.com> <20220627080341.5087-2-rex-bc.chen@mediatek.com>
Subject: Re: [PATCH v12 01/10] dt-bindings: mediatek,dp: Add Display Port binding
Date:   Mon, 27 Jun 2022 07:31:09 -0600
Message-Id: <1656336669.663950.2285171.nullmailer@robh.at.kernel.org>
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

On Mon, 27 Jun 2022 16:03:32 +0800, Bo-Chen Chen wrote:
> From: Markus Schneider-Pargmann <msp@baylibre.com>
> 
> This controller is present on several mediatek hardware. Currently
> mt8195 and mt8395 have this controller without a functional difference,
> so only one compatible field is added.
> 
> The controller can have two forms, as a normal display port and as an
> embedded display port.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> [Bo-Chen: Fix reviewers' comment]
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> ---
>  .../display/mediatek/mediatek,dp.yaml         | 108 ++++++++++++++++++
>  1 file changed, 108 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.example.dtb: dp_tx@1c600000: data-lanes: [[0, 1, 2, 3]] is not of type 'object'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.example.dtb: dp_tx@1c600000: data-lanes: [[0, 1, 2, 3]] is not of type 'object'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

