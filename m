Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B40414735EF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 21:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242890AbhLMUa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 15:30:56 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:47003 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242880AbhLMUaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 15:30:55 -0500
Received: by mail-oi1-f170.google.com with SMTP id s139so24645106oie.13;
        Mon, 13 Dec 2021 12:30:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sfYJREk4LthXDmYH+mm6RPH7Unbt5mdqH4JPAcOL8jM=;
        b=soQ/j6EpJBakv/vr9wXcKPzwBzFhBuC/Dd943BvrDpLsez8lz/a59mO0+snxzB6G8f
         18kw7homy0RnpLirVSBWx0+FzXbQq9JQ/wRV8JaR2paNslCfM11POKKklfnW6SEd8Nff
         yUQZjk8h/JwojlmSawTD6hETfdjn37Rc4dgZFF3XfHIp/A5E7ZUrLPjM0DTzVQkYtQXb
         +fWwU1F/N6An0AZt0zZgd9yiUKNLC0ifzv9n9WuS7y+QVk/f8Z/KGNDKYCxSPNoi6uzm
         NOKun0koHx7rk2iy31p0WcHI4Zb5+X01E/Up02RS6YbHp1GuaIba+BWc1npLfykm7fqn
         EORQ==
X-Gm-Message-State: AOAM532MtjceSSSsJMvp71VV0qesv2GeSn1oEwz950eSRJUk16hLFWcx
        NHUMhmlGHLQVzvBVVUW5efrnhRADww==
X-Google-Smtp-Source: ABdhPJypg8D572vna64ZqsehAGwqHTe6foFXFeIhphG+rwK2thl/QHujnSj1sQrfMN3EvOBZVoRK9g==
X-Received: by 2002:aca:1a04:: with SMTP id a4mr752400oia.153.1639427454528;
        Mon, 13 Dec 2021 12:30:54 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j20sm2305218ota.76.2021.12.13.12.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 12:30:53 -0800 (PST)
Received: (nullmailer pid 1519622 invoked by uid 1000);
        Mon, 13 Dec 2021 20:30:52 -0000
Date:   Mon, 13 Dec 2021 14:30:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, Tomasz Figa <tfiga@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Joerg Roedel <joro@8bytes.org>, yi.kuo@mediatek.com,
        anan.sun@mediatek.com, Will Deacon <will@kernel.org>,
        devicetree@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        anthony.huang@mediatek.com, lc.kan@mediatek.com,
        srv_heupstream@mediatek.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, youlin.pei@mediatek.com
Subject: Re: [PATCH 1/4] dt-bindings: memory: mediatek: Correct the minItems
 of clk for larbs
Message-ID: <YbetfPEoHdyqyo8H@robh.at.kernel.org>
References: <20211203064027.14993-1-yong.wu@mediatek.com>
 <20211203064027.14993-2-yong.wu@mediatek.com>
 <1638574455.281202.1043012.nullmailer@robh.at.kernel.org>
 <5d1ebe0089acd28032b74e3a180466f418580805.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d1ebe0089acd28032b74e3a180466f418580805.camel@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 02:48:52PM +0800, Yong Wu wrote:
> On Fri, 2021-12-03 at 17:34 -0600, Rob Herring wrote:
> > On Fri, 03 Dec 2021 14:40:24 +0800, Yong Wu wrote:
> > > If a platform's larb support gals, there will be some larbs have a
> > > one
> > > more "gals" clock while the others still only need "apb"/"smi"
> > > clocks.
> > > then the minItems is 2 and the maxItems is 3.
> > > 
> > > Fixes: 27bb0e42855a ("dt-bindings: memory: mediatek: Convert SMI to
> > > DT schema")
> > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > ---
> > >  .../bindings/memory-controllers/mediatek,smi-larb.yaml          |
> > > 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > 
> > Running 'make dtbs_check' with the schema in this patch gives the
> > following warnings. Consider if they are expected or the schema is
> > incorrect. These may not be new warnings.
> > 
> > Note that it is not yet a requirement to have 0 warnings for
> > dtbs_check.
> > This will change in the future.
> > 
> > Full log is available here: 
> > https://patchwork.ozlabs.org/patch/1563127
> > 
> > 
> > larb@14016000: 'mediatek,larb-id' is a required property
> > 	arch/arm64/boot/dts/mediatek/mt8167-pumpkin.dt.yaml
> 
> I will fix this in next version. This property is not needed in mt8167.
> 
> > 
> > larb@14017000: clock-names: ['apb', 'smi'] is too short
> > 	arch/arm64/boot/dts/mediatek/mt8183-evb.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-
> > burnet.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-
> > fennel14.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-
> > sku1.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-
> > sku6.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-
> > sku16.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-
> > sku0.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-
> > sku1.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku16.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku272.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku288.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku32.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku0.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dt.yaml
> 
> Some larbs only have two clocks(apb/smi) in mt8183. thus it is
> reasonable for me. I won't fix this in next version.

You also need to adjust 'clock-names' to allow for 2 items.

Rob
