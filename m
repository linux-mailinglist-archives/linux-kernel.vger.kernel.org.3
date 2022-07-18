Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCAB578C8D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 23:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbiGRVPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 17:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiGRVPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 17:15:06 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CDE22BEB;
        Mon, 18 Jul 2022 14:15:03 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id e69so2834250iof.5;
        Mon, 18 Jul 2022 14:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=waGojzQJKestAFlcfSdCqvEWi/o6eYFkAoN0J4xqLlM=;
        b=LuRKu7Lp0MaU2BDhqBw6AuKFUaN8tLRCtO2tIQjGlJE8gbA7QLPLDJSy1TV4D+WODS
         Fe1JBp1yUp7EBnFVIHVWlZ8FssgpbWjuPwsw875XIQlchGvuT1bCxa+TsRU+X9HQ6P4b
         BGwiuDV9iJm9+gywjQOvIvEFKowvcRCFUAGkcyKeCsXfPmJ2prARdY3+PJHphqlLkWIq
         69qz8Le2hNZ52D70RpH/BsjmgKLh3V/rPhmStwRBTrlbd3u33Ngy6TyXPeItjmyg52ao
         k56xwwyVTBilVr1AGKdDuc/2BbEV/3oRwTeW6Xw9BFKqZ3e1jJq1GGwevnXPY9LgdrfP
         752A==
X-Gm-Message-State: AJIora98qqBdmTPE19zK0UexXArm2Ns5JKJeV5lFxDnhCtY8+hfCAsY+
        bQF/go9o1VJUFSpTngnOuMxDpDOvDA==
X-Google-Smtp-Source: AGRyM1vzkO++HsbSir7ZbCZNk8RsHLKO5mm6TyRRsK3Bu8hhHALzdY+MkTYM98ZV7iYjLMb5ueJJrQ==
X-Received: by 2002:a05:6602:131a:b0:67b:dbd5:49dd with SMTP id h26-20020a056602131a00b0067bdbd549ddmr8950312iov.1.1658178902508;
        Mon, 18 Jul 2022 14:15:02 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id x13-20020a92de0d000000b002dc06989d86sm5196511ilm.52.2022.07.18.14.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 14:15:02 -0700 (PDT)
Received: (nullmailer pid 3569024 invoked by uid 1000);
        Mon, 18 Jul 2022 21:15:00 -0000
Date:   Mon, 18 Jul 2022 15:15:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>, iommu@lists.linux.dev,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v2 03/19] dt-bindings: power: mediatek: Add bindings for
 MediaTek SCPSYS
Message-ID: <20220718211500.GA3562861-robh@kernel.org>
References: <20220714122837.20094-1-tinghan.shen@mediatek.com>
 <20220714122837.20094-4-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714122837.20094-4-tinghan.shen@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 08:28:21PM +0800, Tinghan Shen wrote:
> The System Control Processor System (SCPSYS) has several power
> management related tasks in the system. Add the bindings for it.

Please coordinate your work:

https://lore.kernel.org/linux-arm-kernel/20220718180654.GA3260460-robh@kernel.org/

> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  .../bindings/mfd/mediatek,scpsys.yaml         | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,scpsys.yaml
