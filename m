Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3EA953AED1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbiFAVVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 17:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbiFAVVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 17:21:39 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AA6B8BD5;
        Wed,  1 Jun 2022 14:21:38 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id l10-20020a9d7a8a000000b0060b151de434so2143364otn.2;
        Wed, 01 Jun 2022 14:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mD6A518pLN0OGYxwYdiHrx5ULjL15DVCTZFPIr11wP4=;
        b=6cuXSp36MJq8YYHbnET6+vOwS4PUZK+IIfbEDMLg08EhifeMxONHt56e52+hhPvM2p
         JWtAeYxWk7asN4w5HQn5ZJk8X93c5Kibj1ZN00gK+kbFmYLK3UsSa9+MkS9tEsPHii1J
         QEOl9PsLul4a0AkYkMkD0kxprMsdpiXq1D8SQV1S6hQMv2fJszwyFb74KrybnYdGo2VO
         0+VaKZhQvIYUm3Sli63rblZHELFHOjH+cqRg8/ZNbEmebu3Gq+lhsiPPUBCNHC9883IM
         Hx1K0HWTNCAATdyKp8ON/ux9Tuhxt4iuJHU6nJEEktjbOV61WdGAw6rjTzBjsWFbXaBc
         1tlg==
X-Gm-Message-State: AOAM532vhT0oZXePBxX5sRg7w29FwHNqq+YeY2h22OUGx+BwUdKHlu4g
        C2RM3MDZzr8V9YexpHA16A==
X-Google-Smtp-Source: ABdhPJzPxKIFoS6v7zdVdtYI6RyvPqTBWA/y3iFw05esM5zHDiEwwCh3hh1x0yu+5RBF39jjcsqxzg==
X-Received: by 2002:a9d:69d7:0:b0:60b:cee:4cd0 with SMTP id v23-20020a9d69d7000000b0060b0cee4cd0mr751041oto.145.1654118497642;
        Wed, 01 Jun 2022 14:21:37 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c10-20020a056830314a00b0060b0b638583sm1354298ots.13.2022.06.01.14.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 14:21:37 -0700 (PDT)
Received: (nullmailer pid 478620 invoked by uid 1000);
        Wed, 01 Jun 2022 21:21:36 -0000
Date:   Wed, 1 Jun 2022 16:21:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     johnson.wang@mediatek.com, linux-kernel@vger.kernel.org,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, zhiyong.tao@mediatek.com,
        linux-mediatek@lists.infradead.org, henryc.chen@mediatek.com,
        devicetree@vger.kernel.org, lee.jones@linaro.org
Subject: Re: [PATCH 6/7] dt-bindings: mediatek: pwrap: Add a compatible for
 MT6795 Helio X10
Message-ID: <20220601212136.GA478570-robh@kernel.org>
References: <20220520124039.228314-1-angelogioacchino.delregno@collabora.com>
 <20220520124039.228314-7-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520124039.228314-7-angelogioacchino.delregno@collabora.com>
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

On Fri, 20 May 2022 14:40:38 +0200, AngeloGioacchino Del Regno wrote:
> Add a compatible for the MT6765 Helio X10 SoC's PMIC Wrapper.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/soc/mediatek/pwrap.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
