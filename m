Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6B152AF54
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 02:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbiERArN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 20:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiERArK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 20:47:10 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F57439BB0;
        Tue, 17 May 2022 17:47:09 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id j12so942668oie.1;
        Tue, 17 May 2022 17:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0ivlprhS2h/cMofiRva12AAeDajNBcseyKIWCyP6GFM=;
        b=2TOC8YnmtUvBEg6BhN+HHW2IohzYYc2px0w3JHYL8P/gvRgy5H1WP/xJBbI7xyzJKG
         nYytWXoIMXQHqKtnyBSGMPz4bd6A+z0rcud1+K0KJrAGZHdTpsc9ILOJNEPJb/Wt4u4v
         zQP9wmo/R+EpCWM3cjySTnomNfGaAUfCA7lilo4XV1+D5cXrp55lbA7I0gY6dfcnvSQx
         XsGTcAydGfpPE3LgTtV0BQ3VJNS78ctad/ufVXgr3UfaLHELqKlD46jVu1BKDn/hkjGD
         npt/Xn2ofnXp2R05qkkkKXmm3ShvimeUbsWnwkfdy7LxSjSW0HlD62MkQ5Fjtot+cxAM
         9QJQ==
X-Gm-Message-State: AOAM530AKgXBXC1+UzqGtkE3IFnlNd1jZMsKPGW8hKMfqpBZhj7kTCoa
        sRPmqrs12JxUbYavnSY5yA==
X-Google-Smtp-Source: ABdhPJxK2fsakt9+qAEinnu8Nr0SM6/F4v16Hx09go8CdR87lPDVyRjaWRPTxV3yCRv0iS+00W8Uvw==
X-Received: by 2002:a05:6808:1525:b0:326:c179:1b1 with SMTP id u37-20020a056808152500b00326c17901b1mr11887569oiw.69.1652834828532;
        Tue, 17 May 2022 17:47:08 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w10-20020aca620a000000b00325cda1ffb9sm290734oib.56.2022.05.17.17.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 17:47:07 -0700 (PDT)
Received: (nullmailer pid 1965783 invoked by uid 1000);
        Wed, 18 May 2022 00:47:06 -0000
Date:   Tue, 17 May 2022 19:47:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        y.oudjana@protonmail.com, jason-jh.lin@mediatek.com,
        ck.hu@mediatek.com, fparent@baylibre.com, rex-bc.chen@mediatek.com,
        tinghan.shen@mediatek.com, chun-jie.chen@mediatek.com,
        weiyi.lu@mediatek.com, ikjn@chromium.org, miles.chen@mediatek.com,
        sam.shih@mediatek.com, wenst@chromium.org,
        bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        kernel@collabora.com
Subject: Re: [PATCH 0/5] MediaTek Helio X10 MT6795 - Clock drivers
Message-ID: <20220518004706.GA1950724-robh@kernel.org>
References: <20220513165050.500831-1-angelogioacchino.delregno@collabora.com>
 <7ed1b785-389f-9730-4686-bc6b85cc8f6d@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ed1b785-389f-9730-4686-bc6b85cc8f6d@collabora.com>
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

On Fri, May 13, 2022 at 06:54:49PM +0200, AngeloGioacchino Del Regno wrote:
> Il 13/05/22 18:50, AngeloGioacchino Del Regno ha scritto:
> > In an effort to give some love to the apparently forgotten MT6795 SoC,
> > I am upstreaming more components that are necessary to support platforms
> > powered by this one apart from a simple boot to serial console.
> > 
> > This (very big) series introduces system clock, multimedia clock drivers
> > (including resets) for this SoC.
> > 
> > Tested on a MT6795 Sony Xperia M5 (codename "Holly") smartphone.
> > 
> 
> I forgot to add context to the cover letter for this series, so I'm adding that
> in reply to myself.
> 
> This series depends on Chen-Yu's clocks cleanup series (clk_hw) [1] *and* on
> Rex-BC's MTK reset binding-cleanup series [2].
> 
> [1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=640122
> [2] https://patchwork.kernel.org/project/linux-mediatek/list/?series=637849

As well as the schema conversions in my tree. So I need to apply some of 
this? Provide maintainers with details on how exactly a series should 
be applied if there's a mixture of subsystems, dependencies already 
applied, and dependencies not yet applied. I'm just going to wait for 
explicit requests of what I need to apply as there's already too much 
Mediatek stuff floating around. Last merge window was a mess too.

Rob
