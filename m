Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CB85220E0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347175AbiEJQUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244162AbiEJQUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:20:03 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D7D24949;
        Tue, 10 May 2022 09:16:04 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-ed9a75c453so18825980fac.11;
        Tue, 10 May 2022 09:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yWEAxj3WPRQBC5FN17GwqJjtdGdcO5UU/yliiYm9s9w=;
        b=UZgtsk7ZSxD8dr4NdDtyaY4Xp9rB2uxO09ATmzXad5O0I/wigfrZrbBqQslpbvYhwb
         PTkUsTnpdqta4BpsZuMf92z3LcZRfpTMxnIYoy3ZMtls5XwJaMO294FWAC91AqixKhYW
         G5EdzDJawZSBgvj50eGFddeUQ5GDJY691CHZkvyjbNUEqlTf+e4k5Y1NlV4kRjJjqkGo
         D9XqjiYrNpGjnMbFTYeNQ/dEVLgGiMz/ks4XncHWE146dDp7bguo0gzYQAx0VRh4MmpS
         8aS7SsyWeq4lxoYWl+9/j1YBqZFC2kd3zSe0KSuPxyPrkhZkpVvMksO/j5vrCEqXDW4W
         PKug==
X-Gm-Message-State: AOAM5323sHlZTftPtqB2ERKL+sRDTugdUlUN8R/Yvz77f0C64mVXvztu
        dMYwp+5dqmvmLwqq1TBbwSoGeKaZGg==
X-Google-Smtp-Source: ABdhPJxbiyuXrcBRwIgYtVh2j/YydDKn9KG1/3/60nFKJWQvyogrwI8iViqWt51KaEpv+8ewy07nJQ==
X-Received: by 2002:a05:6870:2396:b0:ed:2873:9cf6 with SMTP id e22-20020a056870239600b000ed28739cf6mr453357oap.131.1652199363625;
        Tue, 10 May 2022 09:16:03 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bn6-20020a056820180600b0035eb4e5a6bfsm6212759oob.21.2022.05.10.09.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 09:16:03 -0700 (PDT)
Received: (nullmailer pid 2123159 invoked by uid 1000);
        Tue, 10 May 2022 16:16:02 -0000
Date:   Tue, 10 May 2022 11:16:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxim Kutnij <gtk3@inbox.ru>, Sam Shih <sam.shih@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        kernel@collabora.com, devicetree@vger.kernel.org,
        Sean Wang <sean.wang@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH v2 02/16] dt-bindings: arm64: dts: mediatek: Add
 mt8192-asurada-hayato
Message-ID: <YnqPwj5EulBgxyAH@robh.at.kernel.org>
References: <20220505194550.3094656-1-nfraprado@collabora.com>
 <20220505194550.3094656-3-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220505194550.3094656-3-nfraprado@collabora.com>
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

On Thu, 05 May 2022 15:45:36 -0400, Nícolas F. R. A. Prado wrote:
> Add binding for the Google Hayato board.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> ---
> 
> Changes in v2:
> - Added this patch
> 
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
