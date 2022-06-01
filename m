Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14C253AEE4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbiFAVUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 17:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiFAVUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 17:20:36 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE82A7E0F;
        Wed,  1 Jun 2022 14:20:33 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id s188so4294221oie.4;
        Wed, 01 Jun 2022 14:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ELpqiUTUS9/MflkdXo00nljVnHKNvu4z7mxeaxEY9EY=;
        b=pgxmfF/s0IEn7umyYVMYgPJGA27MYfuEkOrMolpeGFaOxkptVbpqVe56MCae8zsn+j
         kuOaqVf7Tx5PDBId0ussL1UPjVSVPcln7qiWbzKy/Lw6JmDDqWCdzQctzJRcGO/orNLD
         a/UDDr7hJp+FS5W471jbgKChkCGDDTOP0dfJQaXvckyVzhUuZG+vHDya+vbA91ZhAr1g
         CGgBuus9xkdO4w1HQAD+NrbzQLXKyBLkhqPvCSVXeETJATynSbw+PTTTrHyQadRHIBSU
         mrqfc/+q0nzPhYILbteIuLXOd8sxOlX4MckA4HH2KRUKwMFymX9cZHvhAcYq/jEtMz/y
         LSIw==
X-Gm-Message-State: AOAM532Vc03x6z9vY50YkyRu2arV6JZzDe2L1sLmYpUuawNsDS4B/Vmn
        o4SzpozswrpHz0ys1Ussbg==
X-Google-Smtp-Source: ABdhPJzXDEUMMEXjcJlhrMRFbLzgWr3OPihQXysk4ZN96spRUhvecHfdDhmKbFwb7uSg9kt5rREemg==
X-Received: by 2002:aca:3945:0:b0:32b:3a61:35d6 with SMTP id g66-20020aca3945000000b0032b3a6135d6mr852287oia.293.1654118433226;
        Wed, 01 Jun 2022 14:20:33 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p21-20020a4ae155000000b0035eb4e5a6cbsm1435366oot.33.2022.06.01.14.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 14:20:32 -0700 (PDT)
Received: (nullmailer pid 476464 invoked by uid 1000);
        Wed, 01 Jun 2022 21:20:32 -0000
Date:   Wed, 1 Jun 2022 16:20:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Irui Wang <irui.wang@mediatek.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        maoguang.meng@mediatek.com, linux-mediatek@lists.infradead.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        kyrie wu <kyrie.wu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>, xia.jiang@mediatek.com,
        linux-media@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com
Subject: Re: [RESEND V1,1/2] media: media: jpegenc: add
 mediatek,mt8186-jpgenc compatible
Message-ID: <20220601212032.GA476431-robh@kernel.org>
References: <20220520085910.28839-1-irui.wang@mediatek.com>
 <20220520085910.28839-2-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520085910.28839-2-irui.wang@mediatek.com>
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

On Fri, 20 May 2022 16:59:09 +0800, Irui Wang wrote:
> From: kyrie wu <kyrie.wu@mediatek.com>
> 
> Add mediatek,mt8186-jpgenc compatible to binding document.
> 
> MT8186 iommu support 0~16GB iova. We separate it to four banks:
> 0~4G; 4G~8G; 8G~12G; 12G~16G.
> 
> The "dma-ranges" could be used to adjust the bank we locate.
> If we don't set this property. The default range always is 0~4G.
> 
> Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
> ---
>  .../devicetree/bindings/media/mediatek-jpeg-encoder.yaml    | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
