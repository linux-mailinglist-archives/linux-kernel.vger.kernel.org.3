Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679D452F5AE
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 00:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353859AbiETWbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 18:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbiETWbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 18:31:50 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37533163284;
        Fri, 20 May 2022 15:31:49 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-edf3b6b0f2so11824101fac.9;
        Fri, 20 May 2022 15:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ggCgD+ecJUNc304fvLo33dXBGBOItGeeTMTlvKmJ6V8=;
        b=Zm37sDEGL/Cx1wLBBfa2Dbm8fymYIvgHRRMsBi+TysIfyWgnGyexTqHeHRcL6MhLag
         kKjwvl55hI6V5kMpY1BonbETS/qxp0MYDOw/yAT8dYPIJLC7HbEGouu590xXhySyaO6Q
         DSeRDhpWksWi57vdVwa12eGixTfJPEosoFQK3QbF0cQEqVIPru7Gz7KpRDIsbUBH9nwe
         cpH+84Iq034QQg6ncZU3R9qkYVbCoX5jUsawFQd7NALMywLHGGrZ7Ksq0xXmJ7AICINR
         ziVUexcS8icaSU06z2z7ZerqBrgI98ZqdCYHrSs7C+/mEYDf9TFZgF6q+QGyYc971/A/
         QHmg==
X-Gm-Message-State: AOAM53132qSdv3ZldXDbP1i3nQO6GpDnk8Krbo0l+I5NdG75nUfqCnlB
        /4Fph2BFIAONt0QSNrrNPg==
X-Google-Smtp-Source: ABdhPJxOBzEWcjzqY1jgrge+hg8TP2rhGj/XCO23lR/mV1xoV5nDbiL0wG8OasuLd+XsdY+e9N694g==
X-Received: by 2002:a05:6870:f713:b0:d2:8adb:aaeb with SMTP id ej19-20020a056870f71300b000d28adbaaebmr7118602oab.111.1653085908584;
        Fri, 20 May 2022 15:31:48 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j5-20020a9d7685000000b0060afaae0e34sm690705otl.0.2022.05.20.15.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 15:31:47 -0700 (PDT)
Received: (nullmailer pid 371624 invoked by uid 1000);
        Fri, 20 May 2022 22:31:46 -0000
Date:   Fri, 20 May 2022 17:31:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Tim Chang <jia-wei.chang@mediatek.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>, hsinyi@google.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-mediatek@lists.infradead.org,
        Roger Lu <roger.lu@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: soc: mediatek: add mt8195 svs
 dt-bindings
Message-ID: <20220520223146.GA371569-robh@kernel.org>
References: <20220519060924.13493-1-jia-wei.chang@mediatek.com>
 <20220519060924.13493-4-jia-wei.chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519060924.13493-4-jia-wei.chang@mediatek.com>
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

On Thu, 19 May 2022 14:09:23 +0800, Tim Chang wrote:
> From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> 
> Add mt8195 svs compatible in dt-bindings.
> 
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
