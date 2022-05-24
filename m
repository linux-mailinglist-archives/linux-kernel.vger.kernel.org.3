Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4D05320A5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbiEXCFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiEXCFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:05:47 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C71986CF;
        Mon, 23 May 2022 19:05:46 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-f16a3e0529so20706735fac.2;
        Mon, 23 May 2022 19:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dcv6C2UUSOPY4hLFgz6B6erXRgJFajWl9sQxIWWG2SI=;
        b=TuI5IvoSuX3Ii5fd7PJba111ZqMl+6NwF7CDrGzPUDtDGO1RwRDvk68IRJKOyzj5xO
         uUdUDNy77ZbDyZmzZ03PKfqTv7cGNsQpj3VRPnaJBFxWDhOOqn2Bnn4/3pueJCfOmf5Z
         pdWMlScmbwj24oJK+twxg9NQSFqvUELlYZvh5jDuy3waGOtF2LjE0QRyF2Se1/Nxh8bZ
         z8DFyk3YigJ+C5qcVQZMTCyfX3WzTT39B0Exj5BHqMEJLdTOU+iCaRZdT+tRQ9z222tN
         7pIvGjMYRyJlm4DLmhoMx+ygWWpEWmK5jvoF/dqTRVOTZmgh6oTp6AkXNeYD/fvcOn4b
         e1XA==
X-Gm-Message-State: AOAM533tC2yE1TtjMLi2/uHE4aPls9lkIfhfiBDHlV4Df2Y34dBIfjqz
        S9C/nvxjUaz4n7SGR0Km7Q==
X-Google-Smtp-Source: ABdhPJy+WQejQ6HeO+BpEljjIZUbifyIibjiumiOLLiHb9rdI1HKatwYHJVZednKlIkp91wX9c6Vlw==
X-Received: by 2002:a05:6871:87:b0:da:b3f:3208 with SMTP id u7-20020a056871008700b000da0b3f3208mr1216398oaa.184.1653357946254;
        Mon, 23 May 2022 19:05:46 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o192-20020a4a2cc9000000b0035eb4e5a6cfsm4822509ooo.37.2022.05.23.19.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 19:05:45 -0700 (PDT)
Received: (nullmailer pid 2605806 invoked by uid 1000);
        Tue, 24 May 2022 02:05:44 -0000
Date:   Mon, 23 May 2022 21:05:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Tim Chang <jia-wei.chang@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Roger Lu <roger.lu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>, hsinyi@google.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: soc: mediatek: add mt8186 svs
 dt-bindings
Message-ID: <20220524020544.GA2605761-robh@kernel.org>
References: <20220523084034.26802-1-jia-wei.chang@mediatek.com>
 <20220523084034.26802-2-jia-wei.chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523084034.26802-2-jia-wei.chang@mediatek.com>
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

On Mon, 23 May 2022 16:40:31 +0800, Tim Chang wrote:
> From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> 
> Add mt8186 svs compatible in dt-bindings and add myself as a
> co-maintainer.
> 
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
