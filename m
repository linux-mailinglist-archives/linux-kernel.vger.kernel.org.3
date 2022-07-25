Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66EA4580849
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 01:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237268AbiGYXdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 19:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiGYXde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 19:33:34 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BD92714C;
        Mon, 25 Jul 2022 16:33:33 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id j8-20020a4ac548000000b00435a8dd31a2so2438534ooq.5;
        Mon, 25 Jul 2022 16:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M5TkeqV3G9zxvCFod0/RzZU83U1D+6jWZKyK1kWRRpo=;
        b=Kr81rmASOUNRAp1zwCZ1DdmSr98yPJZ4P0t+gDq21nxtdONS75M2CYgRugNOiVsJLk
         xxhZEiUzK6QcK2FXMsLhgCvwT7aMq4ERBBvu42M2J81XqVQWvfTlT4caYBvgSnw5UVNf
         LX2llic2mjoE9O05xfPU4qkRzEFoGlgY+RAKtG3NqrXBcuqHCrt0bAS42pyvIsbr1RKH
         bzVByVFURg0nZA3QIeShgpp434y/wTEafFMaECIxRkaSIyI4m78hSc81LSnWJsn7Firw
         YC2BWeXCdvd3yVIphLoP2Ent7nYjKlVSnT6NaQZwZF9IHnVAGkKAmTchuj5glTg2MLYf
         f0JQ==
X-Gm-Message-State: AJIora9DK1EWbhs9IM4PTFrMLaHT6+t2tA8SG4Ar/FgbBlJIGJJsRq/K
        eVcgZBColLoIZ9M2QYFRYQ3IOnH4UA==
X-Google-Smtp-Source: AGRyM1t3ptpQtY/C56bEyrQAR2wlVNxqnBKvjmVyYxyOIFNZBDbO8RwPFSdn+bPGwqwRBfxS2l7GGQ==
X-Received: by 2002:a4a:d621:0:b0:435:d6cc:b2e1 with SMTP id n1-20020a4ad621000000b00435d6ccb2e1mr4989526oon.88.1658792012486;
        Mon, 25 Jul 2022 16:33:32 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id k23-20020a4ad117000000b004359b581401sm5375799oor.25.2022.07.25.16.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 16:33:32 -0700 (PDT)
Received: (nullmailer pid 2965235 invoked by uid 1000);
        Mon, 25 Jul 2022 23:33:30 -0000
Date:   Mon, 25 Jul 2022 17:33:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: mt8186: Add gpio-line-names
 property
Message-ID: <20220725233330.GA2965207-robh@kernel.org>
References: <20220725110702.11362-1-allen-kh.cheng@mediatek.com>
 <20220725110702.11362-2-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725110702.11362-2-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jul 2022 19:07:01 +0800, Allen-KH Cheng wrote:
> Add the 'gpio-line-names' property to mt8186-pinctrl, as this will be
> used in devicetrees to describe pin names.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
