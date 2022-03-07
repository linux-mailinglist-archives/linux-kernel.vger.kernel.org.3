Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6337E4D0BC0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 00:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343889AbiCGXK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 18:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238913AbiCGXK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 18:10:56 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42F6625C;
        Mon,  7 Mar 2022 15:10:00 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id w127so6606864oig.10;
        Mon, 07 Mar 2022 15:10:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q7OFvF8QvoaAwEulLrSHTEQKk2lZLeNunlxUwtBXEpA=;
        b=7cSxfs0AkaHTLEpIBRdjSWUmmLqOIp0becpn1crIIkMBr2v1doK/ejGQ5tJxF5jw1q
         r+9FSM0nB2Y3AHOiPmNzOsbYiv1vHumOhDho78UAJULbOzwlftkOOqNjOeOSOf7Bq3dr
         Vxk7CJ6/K6/Vndm7nssv1MsIeeQanKNLobtDKJsWPWzcNsd1O6lJwchO65cm1HZwWMi7
         nREYWTWFsNLGqameQPOUC3gucAdTwt1T3kvipp2aKdCalVsKVX+d1N0h91TU0kfnFvCs
         AaN4RKe2rNeb8NnsJP0fNWTF9k/POrDJevVm7wwODKArvQ9w+6r4K0dFb/1jWGTB9ADO
         7ehA==
X-Gm-Message-State: AOAM530oyqjz6XPnHNp3rgbGBYexEAZNwSnfv1LaUfezwoOfCiMHyxA1
        /TGIKEtUaVfMU80R9cFKGQ==
X-Google-Smtp-Source: ABdhPJx2aqOgx0F/m/kAyOQe60oiTGlU3FIxlP1JXZH8Ai0hS+wkkij5tLqAORKcRorjaDKGXB3e3Q==
X-Received: by 2002:a05:6808:11ca:b0:2d4:6861:2a9e with SMTP id p10-20020a05680811ca00b002d468612a9emr894028oiv.114.1646694600159;
        Mon, 07 Mar 2022 15:10:00 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id dy38-20020a056870c7a600b000d9b7eef08csm5547213oab.39.2022.03.07.15.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 15:09:59 -0800 (PST)
Received: (nullmailer pid 3433840 invoked by uid 1000);
        Mon, 07 Mar 2022 23:09:58 -0000
Date:   Mon, 7 Mar 2022 17:09:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org, airlied@linux.ie,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        hsinyi@chromium.org, p.zabel@pengutronix.de,
        linux-mediatek@lists.infradead.org, jassisinghbrar@gmail.com,
        chunkuang.hu@kernel.org, yongqiang.niu@mediatek.com,
        fparent@baylibre.com
Subject: Re: [RESEND V6 4/5] dt-bindings: display: mediatek: add MT8186 SoC
 binding
Message-ID: <YiaQxto4fwmRDDPi@robh.at.kernel.org>
References: <20220303065725.23384-1-rex-bc.chen@mediatek.com>
 <20220303065725.23384-5-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303065725.23384-5-rex-bc.chen@mediatek.com>
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

On Thu, 03 Mar 2022 14:57:24 +0800, Rex-BC Chen wrote:
> Add MT8186 SoC binding to AAL, CCORR, COLOR, DITHER, GAMMA, MUTEX,
> OVL, POSTMASK and RDMA.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,aal.yaml    | 4 ++++
>  .../devicetree/bindings/display/mediatek/mediatek,ccorr.yaml  | 4 ++++
>  .../devicetree/bindings/display/mediatek/mediatek,color.yaml  | 1 +
>  .../devicetree/bindings/display/mediatek/mediatek,dither.yaml | 1 +
>  .../devicetree/bindings/display/mediatek/mediatek,gamma.yaml  | 1 +
>  .../devicetree/bindings/display/mediatek/mediatek,mutex.yaml  | 1 +
>  .../devicetree/bindings/display/mediatek/mediatek,ovl-2l.yaml | 4 ++++
>  .../devicetree/bindings/display/mediatek/mediatek,ovl.yaml    | 4 ++++
>  .../bindings/display/mediatek/mediatek,postmask.yaml          | 4 ++++
>  .../devicetree/bindings/display/mediatek/mediatek,rdma.yaml   | 1 +
>  10 files changed, 25 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
