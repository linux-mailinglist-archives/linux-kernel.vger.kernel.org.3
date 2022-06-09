Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211F5544EE2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343992AbiFIOZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343983AbiFIOYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:24:39 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCB22F1806;
        Thu,  9 Jun 2022 07:23:45 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id a10so22240075ioe.9;
        Thu, 09 Jun 2022 07:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=2euiQq6QHzcln0aEqodhVH6QsST6rRQ5WhOXirbniGc=;
        b=NvezwWLf71/tj3JJebR5XV/IxdrH06LMZKZzKH788NZTFJ1DZmoCuNLa+X7wVnuKof
         YDRhaiTWBlImpm1tci4HWQEOmhSdw6x2vf1RNQfILg+TlBLi9hN1U2PEdl1zDlqLRBx7
         XKSIbNhxS+nRJPlt7tfm1H216/aldlWkeLN/v3YxEBWYeAUNRPNuTdkRIfTyBBUhmgH9
         YVLGr0DM7NTos9uk8C+5rI0ta9/dBG+lP/wZI2s3N1ajMphaBUiLdMJJa8RvF4yZuGgs
         HHaLp2+Sf5Ct0LXLo0iJBp6m/9TufUxbRKkCfj1/Djjbk/yadVY+Wm+kfAa+R+Ss/s4H
         tSMA==
X-Gm-Message-State: AOAM531ZMmhERVTFGa5+k9mpFS0J7tQs8byk1Q+9WfoW37I9psNY/TuB
        bYbx6xH20UvgqgN4n5EjZA==
X-Google-Smtp-Source: ABdhPJx6We98HCBCkzcUJThBhFBjHm+zyDlUhxvomrFQnfPjQxOhbwjj02lQhbBm75JyPLLuRR9NHQ==
X-Received: by 2002:a05:6638:1182:b0:32e:5c70:c89c with SMTP id f2-20020a056638118200b0032e5c70c89cmr21146904jas.45.1654784624025;
        Thu, 09 Jun 2022 07:23:44 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id e16-20020a056638021000b0033195fabca4sm5974569jaq.175.2022.06.09.07.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 07:23:43 -0700 (PDT)
Received: (nullmailer pid 3738851 invoked by uid 1000);
        Thu, 09 Jun 2022 14:23:41 -0000
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     joro@8bytes.org, iommu@lists.linux-foundation.org,
        robh+dt@kernel.org, will@kernel.org,
        krzysztof.kozlowski@linaro.org, yong.wu@mediatek.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org
In-Reply-To: <20220609100802.54513-2-angelogioacchino.delregno@collabora.com>
References: <20220609100802.54513-1-angelogioacchino.delregno@collabora.com> <20220609100802.54513-2-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: iommu: mediatek: Add mediatek,infracfg phandle
Date:   Thu, 09 Jun 2022 08:23:41 -0600
Message-Id: <1654784621.700928.3738850.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Jun 2022 12:07:57 +0200, AngeloGioacchino Del Regno wrote:
> Add property "mediatek,infracfg" to let the mtk_iommu driver retrieve
> a phandle to the infracfg syscon instead of performing a per-soc
> compatible lookup in the entire devicetree and set it as a required
> property for MT2712 and MT8173.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/iommu/mediatek,iommu.yaml           | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iommu/mediatek,iommu.example.dtb: iommu@10205000: 'mediatek,infracfg' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

