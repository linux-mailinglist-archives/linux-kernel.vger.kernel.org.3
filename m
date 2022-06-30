Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B40A5625EF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 00:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiF3WQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 18:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiF3WQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 18:16:14 -0400
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1965724A;
        Thu, 30 Jun 2022 15:16:13 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id w10so298385ilj.4;
        Thu, 30 Jun 2022 15:16:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bwQzM8Z8cc5RUevl243HXV9krJjNefuoRXCjNrL2NnE=;
        b=OYzW4DEEaxCNbuZT90I/p6OJvQnLUhrd62B6qU2hdWtwh2NZP1qsLujVHOGGhRM89i
         cBbMSAcaTgdpHS73NmGgypzduaLT1hLkvu4VQTnAwk00LWa7mSxLUNrSb8Vf2PLMtkcX
         /YVci5T8plPHwuOvi/mbEBxp6bKxQkqNHcKW9mR1xVu1kmXiyuau77okw1lWR7Xv5AY8
         HJJ4gvmPXBasPsj1VX7wZHkSs3oWuQLieZFrkHNFeuzziEcc2zCvDuJgtFEIcMAzJSlF
         fSLOk4BhpbEtMNNk2zfDNPsgflvJHu+dqJcEuKY+sZrFE8sTecxn0O+jiPnG1SyNG62W
         eJNQ==
X-Gm-Message-State: AJIora9nOZtkTN7m9RdCjSyG1KuDgx9jlO0N41LKlpZad/aACGvYQCI7
        ISNf3Z9vSQTCdQWMmh4zJg==
X-Google-Smtp-Source: AGRyM1vIk+ofmEwR6kuswgAQlqMcwDrBTvWp70c3wJfdkA9jj0wzSMn+FzZ4UshCMr+WX2wnrh8qjQ==
X-Received: by 2002:a05:6e02:1b84:b0:2da:656a:ce11 with SMTP id h4-20020a056e021b8400b002da656ace11mr6680248ili.261.1656627372649;
        Thu, 30 Jun 2022 15:16:12 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id x8-20020a056638026800b00339c46a5e95sm8947669jaq.89.2022.06.30.15.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 15:16:12 -0700 (PDT)
Received: (nullmailer pid 3419102 invoked by uid 1000);
        Thu, 30 Jun 2022 22:16:09 -0000
Date:   Thu, 30 Jun 2022 16:16:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>
Cc:     angelogioacchino.delregno@collabora.com, msp@baylibre.com,
        airlied@linux.ie, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com,
        chunkuang.hu@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        ck.hu@mediatek.com, granquet@baylibre.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, wenst@chromium.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        p.zabel@pengutronix.de, jitao.shi@mediatek.com, robh+dt@kernel.org
Subject: Re: [PATCH v14 02/15] dt-bindings: mediatek,dpi: Revise mediatek
 strings to correct format
Message-ID: <20220630221609.GA3419045-robh@kernel.org>
References: <20220624030946.14961-1-rex-bc.chen@mediatek.com>
 <20220624030946.14961-3-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624030946.14961-3-rex-bc.chen@mediatek.com>
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

On Fri, 24 Jun 2022 11:09:33 +0800, Bo-Chen Chen wrote:
> Strings replacement:
> - s/mediatek/MediaTek/ in title.
> - s/Mediatek/MediaTek/ in description.
> 
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,dpi.yaml    | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
