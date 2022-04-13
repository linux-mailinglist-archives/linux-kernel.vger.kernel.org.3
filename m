Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC9D500232
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 01:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238432AbiDMXEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 19:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiDMXEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 19:04:07 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016B9252A7;
        Wed, 13 Apr 2022 16:01:44 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-de3eda6b5dso3632071fac.0;
        Wed, 13 Apr 2022 16:01:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=txH7G85u82ckvXFFVybqBGeBeoY60AwwcMxav7vAPMs=;
        b=DQ5aVSf2IgxYSvCOPzuxy/rzlon2mhAyzHujB5sQR72zOyRHoX8f7oNAh0GFYHhA5c
         SjBNug4JayQjlaVqw1kOySnvWSLpVYauPZBeJOoCsnkix21OAm4nmHClCwmr0dFP1h1p
         6L8YRmLQGuC4SLQ58YA3DRPmDBG+rcp6j78z/EN+xMOWxp9FIBvtCnKpH6yJi/CKNJjp
         yxPWQISV1PTIcbZ9kn7yYN2XYH4Ut/nuQVFVc6zizvqLd/R2rfFpgNZuhOg3mb8tP3ts
         s9PyE1m7CqkPpVJh21kpQUU+brkk6P8jveQ1oo1fLB0iJ7+JBGTh0kVxMRuhtN8D/t7b
         S/vA==
X-Gm-Message-State: AOAM533XQCSxM3054S7yNrLE43Ak8Rqjwwk9n5jcw/Wqw7t0x7s6Wa/V
        X7GDR0IUGkMLft8GIjx2sw==
X-Google-Smtp-Source: ABdhPJz9YP5GQ32GssbCde5VKdgMKN/vXesquw2yfGhEokJ/UvibxuTxcDC4NAxtUYPVmqpjiv0C1Q==
X-Received: by 2002:a05:6870:d112:b0:e2:e609:f94c with SMTP id e18-20020a056870d11200b000e2e609f94cmr474150oac.126.1649890904328;
        Wed, 13 Apr 2022 16:01:44 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 71-20020a9d084d000000b005e969b3f0b1sm146825oty.67.2022.04.13.16.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 16:01:44 -0700 (PDT)
Received: (nullmailer pid 4099653 invoked by uid 1000);
        Wed, 13 Apr 2022 23:01:43 -0000
Date:   Wed, 13 Apr 2022 18:01:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        linux-kernel@vger.kernel.org, ryder.lee@kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        wenst@chromium.org, linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        chunfeng.yun@mediatek.com, Henry Chen <henryc.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v14 1/2] dt-bindings: pwrap: mediatek: Update pwrap
 document for mt8195
Message-ID: <YldWV4nLkXNVobXr@robh.at.kernel.org>
References: <20220411022724.11005-1-tinghan.shen@mediatek.com>
 <20220411022724.11005-2-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411022724.11005-2-tinghan.shen@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Apr 2022 10:27:23 +0800, Tinghan Shen wrote:
> From: "Zhiyong.Tao" <zhiyong.tao@mediatek.com>
> 
> Update pwrap document description for mt8195
> 
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  .../devicetree/bindings/soc/mediatek/pwrap.txt         | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
