Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC9B50E5F5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243505AbiDYQko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243464AbiDYQkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:40:35 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A548913F04;
        Mon, 25 Apr 2022 09:37:30 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-e2fa360f6dso16652826fac.2;
        Mon, 25 Apr 2022 09:37:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BPP3GrMSZ4so9vOzeMSD29zszmPpXX3xsASpo0A7iF0=;
        b=7MdciqJzUuq+lOKksub27ejQwbBdZYPTSNpByMq1z6QcESoUP9F05bdLYp6jnIElov
         bdxiGfiQIC4pVCl/ERkExwHsmZeOo+jJsWGH4Q4o6UKIi9SlgayRAvO2xM6xOf8HpL/X
         s1V26tXyG/zngP+U2H17KWPZqO/bpdihlIOvkLyWUVrh/KqaNnwOna/LuVOXy5wbyUH7
         T8pZ+lBCBx4gQCi+oguBcdBXXGrp6njXHrBsaWdXYaM5DfkZGc7KV9Dc8n65yQiHzDYO
         ZFSdRu8eADQioOLRQyHUeLIMK13gwJKmMwCoHYwrk9QKpQZCc3zwArgCU0tapcdx4cAC
         0CCw==
X-Gm-Message-State: AOAM531Euo02HxWEHuE8ZKaUgb0MBJwo5q1X13N/y7nmmIe4TotzW48L
        FDVCxZV2qbTO/VMrm6H66ViIfbn5Kw==
X-Google-Smtp-Source: ABdhPJx0iyWeVe+xhSq5pFWOaigeARSs207qX/GcgqnGWbeYydiw00PAO/VGIYZLJcJGhSdhBf0sTA==
X-Received: by 2002:a05:6870:a928:b0:da:b3f:320a with SMTP id eq40-20020a056870a92800b000da0b3f320amr6930848oab.186.1650904649920;
        Mon, 25 Apr 2022 09:37:29 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 5-20020a9d0105000000b005fbe5093eb0sm3987968otu.54.2022.04.25.09.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 09:37:29 -0700 (PDT)
Received: (nullmailer pid 4024390 invoked by uid 1000);
        Mon, 25 Apr 2022 16:37:28 -0000
Date:   Mon, 25 Apr 2022 11:37:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>,
        Irui Wang <irui.wang@mediatek.com>
Subject: Re: [PATCH 4/4] dt-bindings: media: mtk-vcodec: Add encoder power
 domain property
Message-ID: <YmbOSHlTLRVzZOtr@robh.at.kernel.org>
References: <20220421035111.7267-1-allen-kh.cheng@mediatek.com>
 <20220421035111.7267-5-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421035111.7267-5-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 11:51:11AM +0800, Allen-KH Cheng wrote:
> From: Irui Wang <irui.wang@mediatek.com>
> 
> Add encoder power domain property
> 
> Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>  .../devicetree/bindings/media/mediatek,vcodec-encoder.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> index e7b65a91c92c..de2df6c6352c 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> @@ -41,6 +41,9 @@ properties:
>  
>    assigned-clock-parents: true
>  
> +  power-domains:
> +    maxItems: 1
> +
>    iommus:
>      minItems: 1
>      maxItems: 32
> @@ -74,6 +77,7 @@ required:
>    - iommus
>    - assigned-clocks
>    - assigned-clock-parents
> +  - power-domains

New properties can't be required as that's an ABI change unless there is 
some explanation why it is okay/necessary.

Rob
