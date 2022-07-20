Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCAE57BFB3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 23:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiGTVja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 17:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiGTVj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 17:39:27 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224E2643CD;
        Wed, 20 Jul 2022 14:39:27 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id w1so2967573ilj.9;
        Wed, 20 Jul 2022 14:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h425gcHyCJbnI4wfopzu1ynRiogGjCRkxUq0gd2HMiI=;
        b=Tnr9/r7Zedjs2S0swRNU7sd2djSJpuvYkooAq0g0otLGnodTgSSDlWRuBo2t2Kz6Mm
         8FY1I70JdV2ApckCdJmkYqaDMjxUOPUrzRcqMBrZQqqSF3/hZGK+kw6GonWTx586Z1wY
         VaQNkRTdYb02YbYxZRxIR8X0IzAyeORDDFBDPB2kMFVDIoavRNvoEIXAQCOZTmX4rqHa
         P8M8vKs0h7PUIAoil1FTJ58HeGFpCIO4hYioMsvy1Jf6wDWsEH1Nbf6Jw9jzYStrC7MQ
         0f41QspSwN197Y0k8LXRdpdvbcXjHFSf211mouj5vE9YGM6ypZfQ0r3YEqSeIl49P7yl
         Tt3A==
X-Gm-Message-State: AJIora9MGUOWZB3h4fcl0Y92blwoMZ3PErnD9Z1ttrUEtRSiDiFtZ7IS
        aY9xXkmNCEy+bw71LtTE9yqGsKjb7w==
X-Google-Smtp-Source: AGRyM1t20OnxGJS1vaExDsOK8a5XeT6fNqY65S9WpBmw3BKummPXIq/zxfCiwFS8JXomabVblpvgOA==
X-Received: by 2002:a05:6e02:2141:b0:2dc:8352:3a3a with SMTP id d1-20020a056e02214100b002dc83523a3amr20409273ilv.32.1658353166341;
        Wed, 20 Jul 2022 14:39:26 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id i3-20020a92c943000000b002dce11c89c7sm70299ilq.14.2022.07.20.14.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 14:39:26 -0700 (PDT)
Received: (nullmailer pid 4028087 invoked by uid 1000);
        Wed, 20 Jul 2022 21:39:24 -0000
Date:   Wed, 20 Jul 2022 15:39:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org, hsinyi@chromium.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH] dt-bindings: mediatek: Add #reset-cells to mt8186
 sys-clock controller
Message-ID: <20220720213924.GA4027969-robh@kernel.org>
References: <20220715110021.3127-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715110021.3127-1-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 19:00:21 +0800, Allen-KH Cheng wrote:
> MediaTek system clock controller includes reset controller and needs
> to specify the #reset-cells property.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>  .../bindings/arm/mediatek/mediatek,mt8186-sys-clock.yaml      | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
