Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AFF53ADD6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 22:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiFAUqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 16:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiFAUpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 16:45:55 -0400
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806EF1E717E;
        Wed,  1 Jun 2022 13:35:59 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id z15so950945uad.7;
        Wed, 01 Jun 2022 13:35:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FARR/+JDA3TOjsR9cI1PcwObDHIe0n2fcG4uD8FuHbA=;
        b=XK3ZYYPEH/XCBOdzMdMknMBSe/Tt8WB2hv+EyfiMvki+1h+U/QinIb0UqqN5+PFKLC
         LcIYk1dNBzZP5kCJ8SArJk0282rJfM3L34LHUgkb1yAOL2ReYdO8VO81we5fQ6oHLpa/
         iH/49vt4krcASGWTJo1mbc0i9GNWCL6fVpiTsyMCMA8OC1nYt9zUimyU+PyrpnYgQLFF
         b11iBgmJNLOFwTnnI7k7VIZM72haMpgC+FWmxtjLG/+EBcLDUwR8Xea3B0gbjPL3rkci
         Q/gLqofPqZIRX0oq6qSrJb0+damKlhiE/Lz5WAS14YPuY0ZncboThXjLn7mr0K+9bNgm
         PK+w==
X-Gm-Message-State: AOAM532x4gHd7kJC5PlDeA55Z16SVl+g3tGfF7AwtpNEzvWA2r3gLBJP
        hFpL4n4z4GixTbjIJP8VNQtsZL/VNA==
X-Google-Smtp-Source: ABdhPJwnPjn5idt9cnZlhcCc/FKbJJnAr8Saufr1/SL3DempIkGREfg8uqcEeSJtWvqQDbhLvv5ujQ==
X-Received: by 2002:a9d:6154:0:b0:60a:f566:a450 with SMTP id c20-20020a9d6154000000b0060af566a450mr673945otk.70.1654113744200;
        Wed, 01 Jun 2022 13:02:24 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w16-20020a4aded0000000b0035eb4e5a6c0sm1333894oou.22.2022.06.01.13.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 13:02:23 -0700 (PDT)
Received: (nullmailer pid 339590 invoked by uid 1000);
        Wed, 01 Jun 2022 20:02:22 -0000
Date:   Wed, 1 Jun 2022 15:02:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-kernel@vger.kernel.org, sboyd@kernel.org,
        linux-mediatek@lists.infradead.org, marijn.suijten@somainline.org,
        wenst@chromium.org, miles.chen@mediatek.com,
        tinghan.shen@mediatek.com, jason-jh.lin@mediatek.com,
        rex-bc.chen@mediatek.com, robh+dt@kernel.org,
        mturquette@baylibre.com, fparent@baylibre.com,
        ~postmarketos/upstreaming@lists.sr.ht, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, chun-jie.chen@mediatek.com,
        phone-devel@vger.kernel.org, sam.shih@mediatek.com,
        ck.hu@mediatek.com, martin.botka@somainline.org, ikjn@chromium.org,
        devicetree@vger.kernel.org, weiyi.lu@mediatek.com,
        paul.bouchara@somainline.org, p.zabel@pengutronix.de,
        y.oudjana@protonmail.com, bgolaszewski@baylibre.com,
        matthias.bgg@gmail.com, kernel@collabora.com,
        konrad.dybcio@somainline.org
Subject: Re: [PATCH v2 2/7] dt-bindings: clock: Add MediaTek Helio X10 MT6795
 clock bindings
Message-ID: <20220601200222.GA339557-robh@kernel.org>
References: <20220518111652.223727-1-angelogioacchino.delregno@collabora.com>
 <20220518111652.223727-3-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518111652.223727-3-angelogioacchino.delregno@collabora.com>
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

On Wed, 18 May 2022 13:16:47 +0200, AngeloGioacchino Del Regno wrote:
> Add the bindings for MT6795's clock controller.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  include/dt-bindings/clock/mt6795-clk.h | 275 +++++++++++++++++++++++++
>  1 file changed, 275 insertions(+)
>  create mode 100644 include/dt-bindings/clock/mt6795-clk.h
> 

Acked-by: Rob Herring <robh@kernel.org>
