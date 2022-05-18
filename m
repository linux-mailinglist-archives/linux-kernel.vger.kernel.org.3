Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF6252C27D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 20:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241567AbiERSno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 14:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241507AbiERSnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 14:43:42 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC73F229FC7;
        Wed, 18 May 2022 11:43:41 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id m25so3769966oih.2;
        Wed, 18 May 2022 11:43:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nSo8w7W+OSVBY2zTRn/yV76t4zc61Jk0JXEwQ0qGoEY=;
        b=SHV6PYnlUN8AMBsiC0jO/VprGHwi5z6Rsr6YCjmXu+QooHFk2VlaFmk04Tq1CRJ6x1
         iFTPVQPMy3UnBLuPZUztLFghIsiOY9PiI6I4O7t+JrlbLfr5y978xPCLhXQXlng2mWs2
         0t5txWnINGr2d15/cvuq6JIackbAW760mJu5yDY/SSNAurAGTSdzyFoMNEmncz3NAiyI
         jmt0XwTNw5N6/mrrgwB+ziZ2n0aYgPGGCs++43hMaXxZRePGGNabEV6sdx5VWl0DQW9W
         OAGuJFyr0mD/uWv2PMklt5p0tyyovgaUeiKL217hRoP148tWx2Hf/SmcRrrUnTMBbNym
         iMAQ==
X-Gm-Message-State: AOAM531Iwcrt2/njF/7LmLIFoInmy+KG36hoPFdCj/X8vBIjqGYlcC4b
        osU/GNHXlXLpDoBmvfBBWQ==
X-Google-Smtp-Source: ABdhPJxURTR1dLIW0z+AO7IFoBsGn5LcndospzqQor1Bg/tjfzW1ykX2baF3rSpYYdFTb74t+ZoaaA==
X-Received: by 2002:a05:6808:f8e:b0:328:a601:a425 with SMTP id o14-20020a0568080f8e00b00328a601a425mr590558oiw.253.1652899421160;
        Wed, 18 May 2022 11:43:41 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q19-20020a4a8353000000b00333220959b9sm1265718oog.1.2022.05.18.11.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 11:43:40 -0700 (PDT)
Received: (nullmailer pid 3669786 invoked by uid 1000);
        Wed, 18 May 2022 18:43:39 -0000
Date:   Wed, 18 May 2022 13:43:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     yong.wu@mediatek.com, joro@8bytes.org, will@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 7/8] dt-bindings: iommu: mediatek: Require
 mediatek,infracfg for mt2712/8173
Message-ID: <20220518184339.GJ3302100-robh@kernel.org>
References: <20220517132107.195932-1-angelogioacchino.delregno@collabora.com>
 <20220517132107.195932-8-angelogioacchino.delregno@collabora.com>
 <20220518014143.GA2024242-robh@kernel.org>
 <4ed63c3a-ec47-5801-ab89-b7d1a597c0da@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ed63c3a-ec47-5801-ab89-b7d1a597c0da@collabora.com>
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

On Wed, May 18, 2022 at 10:14:43AM +0200, AngeloGioacchino Del Regno wrote:
> Il 18/05/22 03:41, Rob Herring ha scritto:
> > On Tue, May 17, 2022 at 03:21:06PM +0200, AngeloGioacchino Del Regno wrote:
> > > Both MT2712 and MT8173 got a mediatek,infracfg phandle: add that to
> > > the required properties for these SoCs to deprecate the old way of
> > > looking for SoC-specific infracfg compatible in the entire devicetree.
> > 
> > Wait, what? If there's only one possible node that can match, I prefer
> > the 'old way'. Until we implemented a phandle cache, searching the
> > entire tree was how phandle lookups worked too, so not any better.
> > 
> > But if this makes things more consistent,
> > 
> > Acked-by: Rob Herring <robh@kernel.org>
> 
> 
> Hello Rob,
> 
> This makes things definitely more consistent, as it's done like that on
> mtk-pm-domains and other mtk drivers as well.
> 
> The main reason why this phandle is useful, here and in other drivers, is
> that we're seeing a list of compatibles that is growing more and more, so
> you see stuff like (mockup names warning):
> 
> switch (some_model)
> case MT1000:
> 	p = "mediatek,mt1000-infracfg";
> 	break;
> case MT1001:
> 	p = "mediatek,mt1001-infracfg";
> 	break;
> case MT1002:
> 	p = "mediatek,mt1002-infracfg";
> 	break;
> .....add another 20 SoCs, replicate this switch for 4/5 drivers....

This type of property is used for poking random bits in another block 
(that's usually a collection of random bits). These interfaces don't 
tend to be that stable across many SoC generations. As there's no 
abstraction beyond perhaps what the offset is, the client side ends up 
needing to know the specifics of that block anyways. If the block is 
that stable, then perhaps it needs a common fallback compatible.

Sometimes these instances are also just places we haven't created a 
common subsystem for.

> and this is why I want the mtk_iommu driver to also get that phandle like
> some other drivers are already doing.

As I said, fine.

Rob
