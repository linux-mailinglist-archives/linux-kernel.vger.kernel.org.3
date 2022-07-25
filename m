Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38EDD5807C2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 00:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237569AbiGYWpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 18:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237490AbiGYWpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 18:45:31 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B18255A4;
        Mon, 25 Jul 2022 15:45:27 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id s204so15197089oif.5;
        Mon, 25 Jul 2022 15:45:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=owwtlW3rOL0CNBfDOH2DnKrzgv4WQIHmvViMboW6yHk=;
        b=o7wslRPrDe5jMDxzqlE/JZbtpn16qrQHzSsYTCivvFq0M3IMwZEeQf135ieOdXG4MX
         08PKMqDOlCvQuszPyPO5yzlMB53TM5nMhJWrb2onLEGYY1Kioc2I6zr5DsedWRfOAm11
         TYQXQdK9yliUXLwvtXo94j43STTJ9F9fogVg7XVK00iMSaXfWxfbDieQuHpssHLpdMR1
         Q7/qqHNp1MI4blLlI99FlTgn7/bm17HqqaIj19n55HwBA2ImjDqiA70vsBTxVPZnJR4z
         ReW1VLf6XWQRo1sIMgboL1/Y43Q4BmwZUcOpmqs7nqVpCv3MW/WrlMUgAsIFlSOg0RAP
         KqDg==
X-Gm-Message-State: AJIora+MWI4xKMQhyiD70hAnhmypjjmh3amEo/9n0yWjfp7RTLX70VsD
        PNsv2BkAZa9jTiD+bU+zBQ==
X-Google-Smtp-Source: AGRyM1svwSsqAhx+tdPya8Gp0eQkBxcOlgC+d6J8MbW4VLKYGHrsTs/zO+0aGudl40kpceveJ48bmw==
X-Received: by 2002:a05:6808:1514:b0:33a:ab72:ffa7 with SMTP id u20-20020a056808151400b0033aab72ffa7mr10961459oiw.100.1658789125525;
        Mon, 25 Jul 2022 15:45:25 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id i6-20020aca2b06000000b0033a11fcb23bsm5317942oik.27.2022.07.25.15.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 15:45:25 -0700 (PDT)
Received: (nullmailer pid 2886877 invoked by uid 1000);
        Mon, 25 Jul 2022 22:45:21 -0000
Date:   Mon, 25 Jul 2022 16:45:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     rex-bc.chen@mediatek.com, ikjn@chromium.org, wenst@chromium.org,
        sboyd@kernel.org, marijn.suijten@somainline.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        paul.bouchara@somainline.org, p.zabel@pengutronix.de,
        linux-mediatek@lists.infradead.org, ck.hu@mediatek.com,
        bgolaszewski@baylibre.com, jason-jh.lin@mediatek.com,
        mturquette@baylibre.com, matthias.bgg@gmail.com,
        miles.chen@mediatek.com, konrad.dybcio@somainline.org,
        krzysztof.kozlowski+dt@linaro.org, tinghan.shen@mediatek.com,
        ~postmarketos/upstreaming@lists.sr.ht, sam.shih@mediatek.com,
        linux-clk@vger.kernel.org, y.oudjana@protonmail.com,
        kernel@collabora.com, robh+dt@kernel.org, fparent@baylibre.com,
        devicetree@vger.kernel.org, martin.botka@somainline.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 4/8] dt-bindings: clock: mediatek: Add clock driver
 bindings for MT6795
Message-ID: <20220725224521.GA2886831-robh@kernel.org>
References: <20220722090609.52364-1-angelogioacchino.delregno@collabora.com>
 <20220722090609.52364-5-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722090609.52364-5-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jul 2022 11:06:05 +0200, AngeloGioacchino Del Regno wrote:
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
