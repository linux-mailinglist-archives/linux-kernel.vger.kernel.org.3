Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED72E4AE7D4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 04:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346304AbiBIDQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 22:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344499AbiBIDPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:15:23 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DA3C0613CC;
        Tue,  8 Feb 2022 19:15:22 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id 4so1163355oil.11;
        Tue, 08 Feb 2022 19:15:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MJCtSboYT6/FzFkykJymBzPa+HtdV+toCECownbioaY=;
        b=1+X6aJzMl/0swYIk+odDTzAIOu3z925V+i0SeSfuivgPxe+SeAb2tiOn+A3itR2etT
         1t4YOZODbPVnhOJyveQGh8VHd/Br/ZM4wlZ+Krt/UHoM5fxNJq9H4SvmJFlh1ByVpCR5
         ZWOT8f8UfvnEDcqKGCppjFHkQBAYt38VOGr0B02SiXORimFRi328S1LOkzGUzmy+XGbi
         +fLKBCpv5QyJDbVXaW1A7bR84ChtDYgPK0VHda7sGcG+eGdVtUVV2ObVwtvExMbKYjcf
         dlO6Gg0ixQ61wSoRYcf+x+ahcWiECdjkyE8lPrdGyIm0nqzWrfaTO0glyWSThuNFwQSW
         mMrw==
X-Gm-Message-State: AOAM530kPiPp2LuznW2Y4XvlAaIDfTBP3R2Brxt5lNpJ5LrV6uXOgTe9
        T6/zN2WDIvASZMxUFu+mPg==
X-Google-Smtp-Source: ABdhPJwdf+t06UGFJrNWAzD6ZQ6SffxtFCOI3Zx37S5Z0p0n4x6v109e9VJ4zIoDm5w0/CB30nKSmA==
X-Received: by 2002:a05:6808:2214:: with SMTP id bd20mr461324oib.159.1644376521985;
        Tue, 08 Feb 2022 19:15:21 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s3sm6096547otg.67.2022.02.08.19.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 19:15:21 -0800 (PST)
Received: (nullmailer pid 3560138 invoked by uid 1000);
        Wed, 09 Feb 2022 03:15:19 -0000
Date:   Tue, 8 Feb 2022 21:15:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>, devicetree@vger.kernel.org,
        Will Deacon <will@kernel.org>, libo.kang@mediatek.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        yen-chang.chen@mediatek.com, linux-arm-kernel@lists.infradead.org,
        srv_heupstream@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, youlin.pei@mediatek.com,
        yf.wang@mediatek.com, mingyuan.ma@mediatek.com,
        chengci.xu@mediatek.com, xueqi.zhang@mediatek.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        anan.sun@mediatek.com, iommu@lists.linux-foundation.org
Subject: Re: [PATCH 1/2] dt-bindings: mediatek: mt8186: Add binding for MM
 iommu
Message-ID: <YgMxxx+b77IHQIbq@robh.at.kernel.org>
References: <20220125093244.18230-1-yong.wu@mediatek.com>
 <20220125093244.18230-2-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125093244.18230-2-yong.wu@mediatek.com>
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

On Tue, 25 Jan 2022 17:32:43 +0800, Yong Wu wrote:
> Add mt8186 iommu binding. "-mm" means the iommu is for Multimedia.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../bindings/iommu/mediatek,iommu.yaml        |   4 +
>  .../dt-bindings/memory/mt8186-memory-port.h   | 217 ++++++++++++++++++
>  2 files changed, 221 insertions(+)
>  create mode 100644 include/dt-bindings/memory/mt8186-memory-port.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
